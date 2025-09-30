Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18561173
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246775; cv=none; b=NJo0bcBt4G2APhDo2/Xflr4msDnT92SRmzUUS8kp/Voydo5K4pxAh/lkUhSpxUKTXJ2+faeym7EVpPCgPu99ZQJRoWFxXV9SKXyUt8NFSHeMZsXlp3rb5zpdpfiKpjqTxMvr5todHX+zkY3qpufmVgWNg4eUJXJYT7dNnLrVGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246775; c=relaxed/simple;
	bh=nMSwQHWhQZfZVm2F+Xk5lkGYQK8VVPziec1ap6iTyv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxQ9MUFDKPErrPBgtRkgfjj8Rel+3QEzMr87CheDJsY9e8KRWo9srs41sFHMt3q3QjZ66CCgO9xMb0+scFTJ0C9dtGlkrtC5FwcCqpygRzCfFnEQRAaUmJSXCyAYKFLtxhOY9r73iodT+MmsXtsqahnoxe4piSX/UGVZBIFBnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KYwMucFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSD7Q3wq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KYwMucFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSD7Q3wq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FAEF14000E2;
	Tue, 30 Sep 2025 11:39:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 11:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759246772; x=1759333172; bh=KClNkYlcAf
	NRgQO1zFdE3tIh5l0QGBDW3I2olj4fQqI=; b=KYwMucFT40YdIRNpqfkkfB/mPJ
	MSJVaMINxtTsfusSQbFZ2pkjk2wP/nJzPfNL0kzdfm6kGca2oLaRi3cdzTTa+qeY
	r+4WvnbZn5py1YvR6RbYaeX62qqRZ52q+sNftr/5u/EoTmpBQ6t2kbIUyHpIQD8N
	DSXmqeebv+ao91XdlVMYQnuOoLqSFEROYlwKDOxQPirFEgqs0kk7xB9Jgs3TzWsY
	rhFnju2lgPJedLheXSQ+NDJx/7cQvul/7d2myqSXmNOt84RGgSMdgBwRNSKmctuN
	pjlRmvhGPVEtsZZg3hhaXI1kCrxbq6onYKW8Bhqxp0KwTQRnf9n0HfLji0yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759246772; x=1759333172; bh=KClNkYlcAfNRgQO1zFdE3tIh5l0QGBDW3I2
	olj4fQqI=; b=gSD7Q3wqElCNCIQPL+R4P41HHkz4oDvz/1BxlYyMHD+AqfgRlaj
	vara9/gXso+yk4IkC0OserYBg21rRc+xm0a+KmLI8HTY4Mf50/qgWTiB7xY1/JtG
	sySemrJ2a/oGT3QWjRaFVtnc3dQkl59PnvXpcf5pEaciHj2U74EsCB3JGmT8fMQI
	jDPGRyuToQZUD+kseWLjwuQH/cnBTy6+Ja/QJRx2FazNxfL7DGgquXjVYdJGiHOt
	L2LijlzdhLxKYgsiu00cVFA7ZTe6esr3E+nnHNDoAB/VvYIm/NsnX2WQgK4cSwJl
	HhSjh212Qn+mMxhoSjWxhX4T/OnvBMSe4wQ==
X-ME-Sender: <xms:s_nbaGQ0LLTno_k69lpI0p9e11MWdAlNTsMhlqHOZ4querHxp1rWtw>
    <xme:s_nbaCznQtXoN8k8M27Lg0Nu3L0jAAZ3wilOUXMdQFc57T8GGC8qTxbZ0swrEXcSa
    0qJOWx_UOpCKfYeZxwnREaPW1VF8lUwEcm5O7py4ZjuIr10qhZDtg>
X-ME-Received: <xmr:s_nbaI0DqJsB1PhTKzs2sfyUa3Z4uoo1-DxGfWRYQa_Suw9A5q7hO79cnUiFrCVU_G9sRdto1c8ZnrZmRl4LORoBepRWtUwWs-Gy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgi
    druggvpdhrtghpthhtoheprhgrvhhisehprhgvvhgrshdrughkpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:s_nbaA4_1p58tyveHbLuAFh6XY3FkFsE_dAxVhUbxNsNmMEPd2lu_g>
    <xmx:s_nbaLWiCBB-Ps83M9oZ4Lo6bLSylDHZvrSP6juFZNOBAU9h5Qd8rA>
    <xmx:s_nbaPAyTtniu4nf5nTyIEekVO6xgRGqxZhmthTKIgMl9QcZcfxEDA>
    <xmx:s_nbaK5jOmUxwAb7FbDKjZ5rTi0F7yuWE1UQ8xZz8RM3Wd-F1JgoUA>
    <xmx:tPnbaIdjgI4xvUVynHyVFv8vMlI27dnqLfBoD6ddidanL9IEGRwzYssl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 11:39:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>,  git@vger.kernel.org
Subject: Re: customizing "cherry picked from commit abcd" comment
In-Reply-To: <aNus0ulSTb4rAYdF@ugly.lan> (Oswald Buddenhagen's message of
	"Tue, 30 Sep 2025 12:11:30 +0200")
References: <87v7l18nnt.fsf@prevas.dk> <aNus0ulSTb4rAYdF@ugly.lan>
Date: Tue, 30 Sep 2025 08:39:29 -0700
Message-ID: <xmqq5xd054r2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> i sometimes customize this pseudo-footer as well, but it's usually
> things like "(partially cherry-picked ...)" or "(... from
> <repo>/<sha1>)", etc.

That does sound a sensible thing to do, assuming that the original
commit is public.  See below for a backstory why it is only a commit
object name and nothing else.

> your particular use case would imo be better addressed by implementing
> bi-directional linking between picked commits via a standardized
> git-notes namespace.

A nice property of notes is that they can be added after the fact
and can be mde bidirectional, so in a workflow allows adopting this
great suggestion, it is a very sensible thing to do.

> the pseudo-trailer is really just a hack in the first place, and
> afaict that status quo results from an ideological commitment against
> cherry-picks during the early history of git. but it's really kinda
> silly that subversion and perforce have better tracking of
> cherry-picks to this date, even when it's their only way to do merges.

I do not know what "an ideological commitment" refers to in this
context, but if I recall correctly, the reason why I originally
added the "cherry picked from" message in 48313592 (Redo "revert"
using three-way merge machinery., 2005-08-27) was because of
end-user requests, and given that the linux-kernel was pretty much
the only large customer back then, I suspect it came from there.

The intention was for the original commit to be also be public and
in the same project (e.g., you cherry-pick a commit from the main
branch developing towards the next great version, down to a
maintenance branch for the previous release), which made the commit
object name alone an sufficient identifier (also, this way predated
the invention of "git show -s --format=reference", so it is really
a dry hexadecimal object name and nothing else).

Initially, the feature to add the message was enabled by default.
Without passing an option, you always got the message in the
cherry-picked result.

Later, it was found that people ended up many commits with "cherry
picked from" messages that refer to commit objects that are not
available anywhere, because they cherry-pick across their private
branches while developing their patches, and the practice started
littering the public commits with these "useless" (because they do
not point at any commits that are part of anybody's official
history) references to the original commits they were cherry-picked
from.  And this made us turn the feature off by default, adding the
message only when the user explicitly asks to do so.

