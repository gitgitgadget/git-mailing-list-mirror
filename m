Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E174DE70F
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352598; cv=none; b=OTcbEZ3wzJWLnsp320UNj6bcRFDRI2qM5yrDwu/mEhVie658QmfnS0wydP4JwNCQ5AYPU0Iujog/itctSozl90l4SgSuzfZ4pCpbdUckEFgQ34o+LHmldud5GMDrf7MUS65CULvwmjPPaM/KuYeh+9fhsx06/5W7hxBbf/T2Nrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352598; c=relaxed/simple;
	bh=qKAy4qBdBlapUs3dYZRxVCVtTRYZDWrzFl/tQd4aNxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CrXdL6zICIQNAGVahMmS2g0S4mCJIyaBcNUyFK1vSy5cyKDeWLQdOlUWw+7foUs4+Xpon673mYMi/Z9+6Qa40qg5QmgR/egPAKoYryA3l1vGp/Iqx5H5G1ahm7A+Bu+OKCU5jS/WSx0U9OAYZF93drngDq5YhHuoFjnd1gaLtnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xa/aGnFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/8dvA9I; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xa/aGnFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/8dvA9I"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F26FEC01DB;
	Fri, 25 Sep 2026 12:09:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 12:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790352589; x=1790438989; bh=Pq+bWctc1o
	Hqp51M4qBqWYYt2lSWja38fzVEfmiVW4I=; b=Xa/aGnFNSmcOVRNogNeNAbHfcB
	CFQOmQ36f7+gazRckcppAx+NFjcgkWAwBnWuv94VH2nGdvFjVNjnrPIB5iXTzitD
	9NHxIycGc0WQ8Fv65eCYViUtJebnyLzEmDHuyqNzEly0WZwOXdBxCQpxTnzJR2k/
	Y7tIHGebYzgNI/Kgt3N2Ktf09usZg+mvZObYjACIzIE8CmovooUS58SPhe8YOqqG
	S72kmCTetKSafd1l3TLjhg0Zo/VwU2NBsiJdwthDgLJ5HvbKHKdcqMUUZTmoHPRd
	w75UOEHhSap+zTBcO/9EXMz0PtXyig4Pd5YpnK41M+lOqjaPs6TqKwGVOJKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790352589; x=1790438989; bh=Pq+bWctc1oHqp51M4qBqWYYt2lSWja38fzV
	EfmiVW4I=; b=H/8dvA9IWsHbcQ/CqOVFZhXzRrgIrhu1zOadU9zPB40lIf0Ehn1
	IVUuZHLtLZWoJHpwG8Yf7cPKmfpuBgFOKf3n944MXy8ZO2DLEA0Hgmea2rJ4YHSi
	+U0lUSE5nkP1pMGMYHZ767a8U1/yDiRk3qH69W4K7t519ld4F4nsbfceEUPYSZb8
	TtrBhGxc9pnh4CKn5MAD96y+eU4wXP6NVFRIHAdi8wsV3Is1ZpUKMASofTbuIOHe
	z7b+yWa1RBe1hkTBT7fHg3Fk2KK+7CiR57jnaTwjXdc4tszWePhZH3mbmZYvpY2l
	x0jXuoa46oyjz0s/UWtdBRwb/ip/PzQn3Eg==
X-ME-Sender: <xms:zJy2agihs-rthoNWL5B8JDdGRNLosJrxU_SbESzrM-EoNWGFGcQKrQ>
    <xme:zJy2agCBtxfuIk0c6kKYSxWzNxPGD-UO0h_ZdreCdPCC41uayqwX4q7z6Rf5sXudP
    jnuazy6b6uBl7Z4rIFY7g7ngnMtLG9JDg84Nfy9XHGW_KuKmx55CA>
X-ME-Received: <xmr:zJy2atH68VCW-dTsKkdzsFO45W1gbHjhQ5NIJ1VxO4YsmHEnqAWkr3R8hg6pkEWGwYvevoSaD8sE_k7pO0vN2KDywA3uD9QB--XT>
X-ME-Proxy-Cause: dmFkZTFqXDvqUf2C64si01oVHKaVNTgrukfVVsf5etOhXqwSDo9MrMCime+NMAUQbwlCew
    nr9IHznHTqARE9HRyBY5cYfZh666E7gtCOne3sy4g8COnAxt6vDYgDfB4TQ4q45Y61WRvU
    riCmtF/yaoAG+PGoOaM20UvqDCsQAKZaycpI2Y4p+SUxbi0pF8i9v8X4a3G6zq6llNHsB5
    DHcPb1Eqi3TusyQxhHaNNoosf8MyR0Alanp8U/XVwZhnXzdelOPFmkEAb8RVy1FjoiFLJj
    M5JzXHoJX3/s3JrF+IeyF5T5qw9LFgk/8sQ4hEUOwC/dMWOHFDgRAs8i8/PkQfP6aN9ni0
    SCHvNUEybAhS5UM3jQdjaKTbLRHZb/1hAfhanN74VeFHjXT/Qdyx1unF5skwOEghph6h+J
    LvbvdbHbTft5RIiKO+zHM90jOOMT+TpZkXmAVfWobYgimyblfDCAcY2lJq2sVJSbvKFlrN
    xhlgFjSHmq5cqlzei+4oqx0auk8BvdoSmVuuNu86a2MhLrNJ+TiXJkZY3rJJ45DsvSNJE/
    346GmQ8xYV5DPtDB5aEvCnp+4BUz+4IOw5Q32zFjkubYUgZ8+ypPAgH6m/5GFRzVZfk74C
    3jwfPav0+2qxMQ6gsizw07PfZeeXzd0PoexbnvJeDZDEXuEEWGo+UOIMK+Uw
X-ME-Proxy: <xmx:zJy2agKfKy5CiduWUf5x0KP-_T-4_k3n4l5YC7z7Mlop8Iwps2gnMg>
    <xmx:zJy2apm1h9gNTdsNfMU2lHJKahDi0D2kok72Ef2QDpTmhmdziegCjQ>
    <xmx:zJy2agQWkoTNQPEL34jSPuhNByuBaPZmEfAvLDlJBBBG-q84Si9sng>
    <xmx:zJy2ajILlv3PXmS7oZ0hepehu_l9xUp17aifo5DWSv1zMuEVWm_suA>
    <xmx:zZy2aspuFLkHAe2aWjf-0QCRL5Ce0bKpKCMrrX7JAKPSGZP8sQUFs48P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 12:09:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] git-contacts: allow inputting patch via stdin
In-Reply-To: <20260925-git-contacts-stdin-v4-1-9b4e4bcbb91c@brighamcampbell.com>
	(Brigham Campbell's message of "Fri, 25 Sep 2026 00:42:39 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	<20260925-git-contacts-stdin-v4-1-9b4e4bcbb91c@brighamcampbell.com>
Date: Fri, 25 Sep 2026 09:09:46 -0700
Message-ID: <xmqqy0cpwbw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

> Make git-contacts accept patch contents via stdin for better
> interoperability with other utilities. Read from stdin when the user
> passes `-` at least once:
>
> $ git contacts - <patch

OK.

> Even before this patch, git-contacts parses files first, then git
> rev-lists second, regardless of their order in argv. If we instead want
> git-contacts to parse arguments in the same order that they're passed,
> that's a change which should occur in a separate patch.

Fair enough.

We would want an update to contrib/contacts/git-contacts.adoc as
well.  Here is my attempt.  I realize that the new text implies that
we read only one patch from the standard input, but I do not know
offhand whether scan_patches() successfully reads multiple patches
concatenated together into a single stream.  If it does, we may want
to say "read patch file(s) from" instead.

The original uses <rev> in <angle brackets> to clarify that it is a
placeholder, so the added text does the same for <patch>.  The
original text does not say what the command expects of the "patch
files" it mentions, which may be worth improving and when it happens
we would say <patch> in the description to refer to one argument on
the command line.  But I left it outside the scope of this message.



 contrib/contacts/git-contacts.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/contrib/contacts/git-contacts.adoc w/contrib/contacts/git-contacts.adoc
index dd914d1261..6473e878e0 100644
--- c/contrib/contacts/git-contacts.adoc
+++ w/contrib/contacts/git-contacts.adoc
@@ -24,7 +24,8 @@ Input consists of one or more patch files or revision arguments.  A revision
 argument can be a range or a single `<rev>` which is interpreted as
 `<rev>..HEAD`, thus the same revision arguments are accepted as for
 linkgit:git-format-patch[1]. Patch files and revision arguments can be combined
-in the same invocation.
+in the same invocation.  A single dash `'-'` character in place of a <patch>
+tells the command to read a patch from the standard input.  
 
 This command can be useful for determining the list of people with whom to
 discuss proposed changes, or for finding the list of recipients to Cc: when
