Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0A65C
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072798; cv=none; b=dd8HrclU0NpadXl3HJ9RxrezPyXSUOik3t0CZRDltJ5t9AJINhQuzW7cETS79iREDJPqykfHn0KK+GSCxxLRWbAQoQ2FvO97Xg1idANulLKcpiL9v6dsrDBUimJ4G6OFQTyKOArC9N+IvwcVpeTUdj9HqZO/FaZetkZhyKI3EPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072798; c=relaxed/simple;
	bh=ZZ/yQUiswgTBVTIcRnb8RtDuaTrMSK3uLX+Zwkprcs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMMofikZmJ4Ous83E56FUF3FW/znnocwy3X3InWWZ+rWkZrIBCVM7XAAzzqU0cRZ+ySXFTCjU6E62wSKhXxwm89bJX/bePwS8ZZ01X2kLbeXn3tv7RnfsRwbFyHbNvje1MGhlBFVcWDTwRMCtr0Qgfda1f/qgDIQaJ4IbPd5SUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V3GL43mx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V3GL43mx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB2A61F3C5A;
	Thu, 21 Mar 2024 21:59:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZZ/yQUiswgTBVTIcRnb8RtDuaTrMSK3uLX+Zwk
	prcs0=; b=V3GL43mxfU0IE3+i6ku+mdFqLzXcMuv45an+G4/b+/5wuo52Hod488
	Z9kdZWCdppMl46P7Wup10lx737zwzUY+RBBU8bxt+t9CUoTUBGe9g6En82k9p9zp
	Idxp3bQJP48ZtK+F1l4KDqYpC3tvQECoKVfj7jDMAPx1M3h3w1VBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D27D71F3C59;
	Thu, 21 Mar 2024 21:59:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 076901F3C58;
	Thu, 21 Mar 2024 21:59:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>,  <phillip.wood123@gmail.com>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <17bef197ac874ae6.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Fri, 22 Mar 2024 01:22:22 +0000")
References: <17bef197ac874ae6.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 18:59:52 -0700
Message-ID: <xmqqcyrn58mf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E03EE6DC-E7EF-11EE-B421-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

> Yes, I suspect you are right. I think the cover letter would be a good
> start at the very least. Would you welcome a patch to
> 'Documentation/SubmittingPatches' that adds a new expectation for this,
> or do you think this would be best handled yourself? I am interested in
> contributing but, as I'm sure you've noticed, I'm also quite new to the
> project =)

I'd prefer to start with a much less official "experimental" launch
of such a new workflow, instead of adding an unproven idea as if it
is a new hard requirement to the SubmittingPatches document.  If it
works well, we can write it down later.

But even a soft launch needs some way to advertise it to the target
audience, and the SubmittingPatches document is the only sensible
place to do so.  So, perhaps do something like this?  I dunno.

------- >8 ------------- >8 ------------- >8 -------
Subject: SubmittingPatches: release-notes entry experiment

It has been the maintainer's task to prepare the description of each
topic listed in the "What's cooking" report.  The description is
automatically picked up from the "What's cooking" report and used in
the commit log message of the merge commit when the topic is merged
into integration branches.  These commit log messges of the merge
commits are then propagated to the release notes.

The original author of a topic may be in the best position to write
the initial description of a topic, but we so far lacked a formal
channel for the author to tell what description to use.  The usual
procedure has been to see the topic described in "What's cooking"
report, and then either complain about inaccurate explanation and/or
offer a rewrite.

Let's try an experiment to optionally let the author propose the one
paragraph description when the topic is submitted.  Pick the cover
letter as the logical place to do so, and describe an experimental
workflow in the SubmittingPatches document.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 [for what's cooking]
 * An experimental procedure for a topic author to propose the topic
   description to be used in "What's cooking" report and in the
   release notes have been added to the SubmittingPatches document.

 Documentation/SubmittingPatches | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e734a3f0f1..05e15b9436 100644
--- i/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -459,6 +459,17 @@ an explanation of changes between each iteration can be kept in
 Git-notes and inserted automatically following the three-dash
 line via `git format-patch --notes`.
 
+[[a-paragraph-summary]]
+
+*This is EXPERIMENTAL*.  When sending a topic, you can propose one
+paragraph summary that appears in the "What's cooking" report when it
+is picked up to explain the topic.  If you choose to do so, please
+write 2-5 lines of a paragraph that will fit well in our release notes
+(see Documentation/RelNotes/* directory for examples), and put it in
+the cover letter, clearly marked as such.  For a single-patch series,
+use the space between the three-dash line and the diffstat, as
+described earlier.
+
 [[attachment]]
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
