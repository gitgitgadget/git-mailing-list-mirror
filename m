Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767A30566C
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608573; cv=none; b=iEtE6NVTUhiY6tui/jRgkYWlUEyRXg4bzO71epWmBcUVNIkLUTE894tya1Y3bBeb/nxFe5tQQimEl19HmIEjNAPmukeyRxfpi1+dACmImCsD1Iqdw9dYy1dBEhkC3/Cz07rCYZuTN1wt5VXIXgzqcX7ruS4A9vxG4xau7uIitMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608573; c=relaxed/simple;
	bh=pQ/8fcQl+rsy3bZuzti3Mf4s90XGUCYCPAQM4Jel3s0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tMsLwsHJmsqX+gKj5YNsFUpTTp2YTUkA93hHk+qfGG00v6A5zPTLeO3Kx9/GAxiBxPQpj4S6kyjhrnU06EiULC6/3SL7dDJvtCtUynBF4gx4JfTb2KRBZt0NnZoPLgoGI2auBBc2es2DFEXZbwbrryC2NfUJ/TN4FzXcqwgfQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i/6in/6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ut09SrWE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i/6in/6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ut09SrWE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DFEF5EC01CE;
	Sat,  1 Aug 2026 14:22:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 01 Aug 2026 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785608570; x=1785694970; bh=EtQZ01Qty2
	Je4PFAkavNTsDVKW/Br80nM124TbwSLNM=; b=i/6in/6nTmbkdO6Oc7508dT/1K
	vtgxNncR4e+cY75zd6lZ1ixEmjOAV+NDsO76TjLPcdU8yrEoo8ajrxO4PMhFGeBb
	B4dkgc35VobiJPkqe5hiWIJhHrXmV4a0oM9JKBnR/B9m5rjxqnzkMDz7fdt4Vv6L
	Nd+gwTdRugdOD7cxCAacPxqgTzTc44/0XkK6E+q5DURX8en/lyWgeaj8JR4t93y9
	bjFk0a6Q8v5TBWFekzMHKO4Sus7wMomiL9eLMsP2UE1g6sabXOCgbUNqIikGMAzP
	VwVhJVIO0DliwBlrD4Vg3OMnVSMwypU1aNWDclGCW0dpfmkF/4ZBWJmnyLFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785608570; x=1785694970; bh=EtQZ01Qty2Je4PFAkavNTsDVKW/Br80nM12
	4TbwSLNM=; b=Ut09SrWE71Hq7vpitKehq4jERnnZn8cqF9o6YAH78hFOvhIiZ3U
	KffkcLVhu/7as9Ek//4DjkpbkZOimTfjBGxBlAkTP2DzflesnHtqwPAHbL/oKxOJ
	I0huA7WzsM/t44PKVk4NbKpa1aiXtGv+q2iweI55PP0VBkDwnAvMrk0Kqyt9g65B
	4SvLsOBUlYvY6hULtGFQaY1t9RFo4p0XXBCLXAkRLfK29rTf49CnUOnGVzP4DR87
	6K0rbrV3cWxB2EOxjTao2VPx+xDkq9Li8BIzsajkLCRyLCbwjGxhKLBEiOWPEjRA
	1dmcNfDRVJtwLUhRNEYq+zrSFhA2F4I4Z7g==
X-ME-Sender: <xms:ejluatnrZNcA5kT0gyaUwFOA3hgI39Sg1t81yEL6HPQzHiYmFnDb8Q>
    <xme:ejluav0hGF90U_cDUlVuH473GEz0tAjoy1yEHTDMsfFrDjahAw8ySjZxFiRemT0ml
    wnPg8MNTDas97AIhNg9MBJmz-2Wfr7QBjZL_NmDzO-c7gXR7Hs>
X-ME-Received: <xmr:ejluaorU9VQvqqg0c7hlbnpMU6LjELe7QM1VIDnpqHc4hUOE2myZKOFqkPda7BIrE1a9G0HOvBxsecDRcRwqqJsvkfzX5lVt0w>
X-ME-Proxy-Cause: dmFkZTGTndu+LuOBuZ0ldizrwUJQBMSG4s9mDPPPyM8FSjDMHfWvNw2SDfV2gAV7nR89xV
    +ZUU3gboSrZ2qx89C4uQL6m07d6jtPzFzSnOIu1gvhvq5KQqPq1stLp5ZLXe3V0VWrUi6n
    ZqYvQeH6z8w05hmU2z35e+YRxUB/b0iSxUIIYCvwu+66tD/FHi+hcN7e23xi8gfvnZ7mEb
    zq5N1tPrK1LJ3NUujFP3dXK4T21KLymHg5qev2Ye5WYI3mIvEfSyEAxG60KCQKY/lNirF2
    v5kVxhN1N7pohYJVKruN09qBz4SSoiHlls7HH3IKMLiQ0qSnUqB1foLdZswhenCX7mu8O2
    kk/4Dc+zUu2cLUoNcl6MVuoacq8yFDPSHeQ8avx7kFO9PAIuK3J3bHQ4XpNuS/xInEZ3zw
    R4CUiKT11BhF/4/v2obwjcYv1aFzuZYXZPc50xQ5BMv467Zg5mH5ZSbraCbO+9nThYDSsv
    Gvq6mnEepNxTA4oZMxUsTZ1o/qMX91cqxAgOU4BGYYWFlf409zQ8hqcFLTI3Wogls499eg
    YQu3UQVXA/FpYMnwDEVpAt18J4RpeY1w4ZK+awmnen78SvVJ53aatEMK64C+VY62Gt+0VE
    ePtq2VxE5dxbtVNr9/D4PL3BmRKB91CNJaSrIRcEpHYsWHWV8xs8EafUzWFQ
X-ME-Proxy: <xmx:ejluaseI933ik5xD5sIk9ATIoakLvksx7VmLhNENmNzDr5Wi9uvNjA>
    <xmx:ejluano8_V3QviBJtrKf4mi-dexhCMuML6XeoVb5f0HKTrco1-2qCg>
    <xmx:ejluatGpNmS5_Pw-MrC8QaTHw_ZJqoagkgkD_2la5sOgn3Zbe2vSNQ>
    <xmx:ejluansnbxoJulGqzPqGiGowtwAA5TX6pgQWXl_0D1WQeJAPTjRWYA>
    <xmx:ejluauoNEDmdq6ofvFcoWrcpeyloPp1tIe2uSes-y7prWaSXvU8d5Ibb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 14:22:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Git 3.0: restrict hex object IDs to lowercase only
In-Reply-To: <20260801144527.GF2041176@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 1 Aug 2026 10:45:27 -0400")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<xmqqjyqclwf9.fsf@gitster.g>
	<amu_rzanuYc_2lww@fruit.crustytoothpaste.net>
	<20260801144527.GF2041176@coredump.intra.peff.net>
Date: Sat, 01 Aug 2026 11:22:49 -0700
Message-ID: <xmqqfr0x8zuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Now there's a parallel history of otherwise identical commits. I think
> this is mostly "if it hurts don't do it", but we generally try to avoid
> multiple representations of the same data within the object model.

True.  Already almost an empty rebase that delays the clock by 1
seconds is a perfectly normal thing, and the way we treat such a
parallel history with the original would be the same as such an
uppercase parallel history, so I do not think it is a huge issue.

A tree object hierarchy consists fully of binary links, so we are
OK.  Only the top-level object name within a commit/tag may have
multiple representation of the same tree objects.

'git diff COMMIT-A COMMIT-B' would notice that they record the same
tree without opening two tree objects, even if these two commits
record a normal tree and uppercase equivalent tree, as diff_tree()
layer will be called with the binary representation of the tree
object names.

As Brian alluded to in his discussion starter message, we normalize
the case by going binary in many places (we cannot unfortunately say
"in strategic places"), and these are such cases.

> I think only commits and tags are subject to this (because the tree
> hashes are binary). I don't know if you'd be able to stumble into this
> accidentally with most Git commands. We don't intentionally normalize
> case anywhere, but I think most code will round-trip through a binary
> hash at some point (so "git commit-tree 1234ABCD" would incidentally
> normalize the case).

