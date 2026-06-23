Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB73D8121
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227375; cv=none; b=JgIFD2PPuuy7SSYZjB3vOaux3ZKzdL/NTyJy8l1gOOy90Gcbe9ePqSkbdCSoZvZDDTuac/23NSikdzclP0MMv8MQ23+g2taLdofISddw1mwXHyj6IlHKSIrstIhHKdndjqK2tLiRQvwp8CFgTbJc5BAF+GVEayBpHsfwADwSDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227375; c=relaxed/simple;
	bh=jTGSRWcTEGWOZfyrKnvmd5Vv+2t0uGf27+XAK0RZTYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDmaLokArNy6sXzx3g1OedRfcD1GybqNZ84K/Yi35E2CmEX7d0HqVbOwFKeVSNJppGGw1MvgVr6GzldfGlhrRBu1pQoLvW92FOowje3amIRfyp9dO9PyVqoi0rd64cr+MIhqB2s2DZOxTGqec1UUacNRJhNS/A1dszHBKdspmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UhCv94gc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wht/5uhG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UhCv94gc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wht/5uhG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08BBB7A005B;
	Tue, 23 Jun 2026 11:09:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 23 Jun 2026 11:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782227372; x=1782313772; bh=eBPoZGGxSr
	n52zvqowaEO0XAlmdTksmcCJHV/+To36M=; b=UhCv94gcxXLp3xFqfM42OnmrBW
	C7Ox9U+oeveeRF038WvuRp1Q3N1iqRfhjJx353eCpK5t5xvc301TK+h13RzUjNxf
	0Qj1SsFw8Pg2L/43UxbZQcDER1LizGbo+fxFSDLIzd0Sexrgsn2Ow+ecGnhkPtUR
	h30lM9nEQEV7+jLGRSOf4UPOVLFJpmcrRYaGKq88w57nvtPSRGFBFH0+lb4RkJXc
	n/GXri6ZNcNUnzIMEY9tA2ynQM0WOwZmEURg/uWHo/9vqZ0FFl9shWo9Tltz4uWC
	6bYSBWnkgP+sGzhGRmBQ6Yh1OYEYc7yZoaZo4Gn8PMLHQOl26TQYGQvfwPFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782227372; x=1782313772; bh=eBPoZGGxSrn52zvqowaEO0XAlmdTksmcCJH
	V/+To36M=; b=Wht/5uhG0SjOp/Xp4WiQgVwEMF6PFi4iAizbI68hizjJmwqdbPL
	uFAMQ6A/YcldgHFt9tY8QnC/P0WJEMbf1JStfMQcJeN43PAz1ktNphRLXMYEMXsM
	CwNId38z1mo6DOUgwIPnCh8lYIK9SKfCIPat95WTtH7FOIdSgMUuUuxD3kVtNCv4
	+Wd6Lp1IfjGk9zDz+lAObvO6kPvBHyXPH9jn3U0lZeFKK1pNWnzkvz16t9CGP/j4
	L2d4MV3wugIvJgCoL/8qBIkg/wjl27jX8TvNtBdYW7FBFVp/FaEtk/8HrjbivZXe
	VR5S2yqeu/dCxTrUoGLdk+WvYIyIxiPVlFA==
X-ME-Sender: <xms:rKE6akgW4ubDMJoey6NBmKunWRDf-V2hUkzY0FtW8De_vN3u-3ajkg>
    <xme:rKE6akckehpqrq7-LoTAP03eu9x-Wm4HoIOLFhc9hu96XAK1HJdW2OYWjsuUS7_08
    7PQd49lQuPGZC08U4Cvged8tYS4yvJpdycUNZW5yB0TWnneAbul-w>
X-ME-Received: <xmr:rKE6apdEizrIN67G_sTt92QzmizzXMHggMEmBoScCsWnOn6BzaXOZldA39GzDK3ka0uwF0aqzNkgUEPrYDCz3F2s-QxF2gYWXe2afFs>
X-ME-Proxy-Cause: dmFkZTEy7ndqRdbTSy+mBm5EYSCk+tYB0alZDxBmuw+aa4KHPEiEiQDM+4IBza7xnBgOed
    nbJc/Pa4NbklZf/XEzXCd6+KiLziX0SUi4r1ORpQ7dFqMMIWiUqrvmRBw3rQOj4TFtrWcH
    sb+9gFpZeqverpkYLmr4rZNF1Kkt4ShdGcPoOY4JQYb/FVp3V05MhE8zVAsMAvSDbv00/w
    VYZecBBUsxAGzrEoJLLyoA91baEtwB/arwt1zAgTgTo6TW6+W44anevh7ePlONG4IJAfEe
    QYvSFD20Q+89/uZ+NZL+XxupYc0bAmFAijmC/K66ZwXkIHbzXhYRzdUh/KgUqCIAx9W7Sb
    nCOP2FxfJrwsnha7tn25CIzJOiaMxeSZ7ikYJiRIdl5o1ohYUZcCTrOOl79EmHQWYnasJ4
    SAGRAoaK3F76f6S3OYSGxejA19PvBBKid8Ut90YBvxIfpOf3BUBQaKYOY5+m1SmKpvhEQF
    czhFLzjWDoP+AC5OL4qSdffXhF/jwCCqierPCoGYLWGUamE3rtjSc30X+wDoLvgAm+6BRD
    iOSBCAS3ZvE0qIBOMsm7CS3Hb2IsLO03l5HpAqVF1Qce/4ePiDiGNcfGQNRg0W5mDnTfhR
    ygnfnSygo0F12YnmQzUzcN6AR8ZFddwUChw1QdWKrwm+uUjPW/NwKUTGqJDw
X-ME-Proxy: <xmx:rKE6au9h6iKC_iec8oleVK5pWtqzvLp4wuA9LnTzXA9a0U2Yp_bo4A>
    <xmx:rKE6alnofWZk2kMrqX_Vir-RS0ulv-G4K4d1sO9we25jJB3X-W7B4w>
    <xmx:rKE6ag9l-SxI6iVuw4zSGoWvYLOPMCHx4oICPK9RijlcSJ24MFxnaA>
    <xmx:rKE6ajmLotCCSbdbKCDlezHvakwXlzvF_QE3QdK4h8_t8lbnUoUPUw>
    <xmx:rKE6akdNfv65UAgcLnghGd54j6ZK26WdzDrvBiUtM8Mw6wyleer9cuSw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 11:09:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: DSAntonio08 <antonio.destefani08@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: fix strip_cr_before_lf to only remove CR
 before LF
In-Reply-To: <20260623084520.9015-1-antonio.destefani08@gmail.com>
	(DSAntonio's message of "Tue, 23 Jun 2026 10:45:20 +0200")
References: <20260623084520.9015-1-antonio.destefani08@gmail.com>
Date: Tue, 23 Jun 2026 08:09:31 -0700
Message-ID: <xmqq8q85pa38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

DSAntonio08 <antonio.destefani08@gmail.com> writes:

> The remove_cr_after() function was stripping all CR characters
> unconditionally, even lone \r not followed by \n. This is incorrect
> as only \r\n sequences (Windows line endings) should be normalized.
>
> Fix the loop condition to skip \r only when immediately followed by
> \n, and rename the function to strip_cr_before_lf to reflect its
> actual behavior. Update both call sites and their comments accordingly.
> ---

A few comments.

 - Documentation/SubmittingPatches[[sign-off]] wants you to certify
   that this patch is something you have the right to submit to this
   project.  Sign-off is missing at the end of the proposed log
   message.

 - Documentation/SubmittingPatches[[real-name]] also prefers to see
   us interacting with humans with real-sounding names, not handles.

 - When changing design decision made in a fairly ancient code, we
   would prefer to see the proposed log message says why the code is
   that way, and how and why it is safe to change it.

As to the last point, in this particular case, the NEEDSWORK comment
says "only CRs before LFs", but we must not blindly follow NEEDSWORK
comments.  They just mean "somebody may want to rethink the issues
in the future but right now we stop here and leave the code in this
shape."

So, let's see if we can continue their thinking.

  This "We should normalize CR/LF into LF but we are too lazy to
  bother" originally came from c4adea82 (Convert CR/LF to LF in tag
  signatures, 2008-07-11), and then 2f47eae2 (Split GPG interface into
  its own helper library, 2011-09-07) moved the code around to make
  the part interacting with GPG reusable.  Later when SSH signing was
  introduced in 29b31577 (ssh signing: add ssh key format and signing
  code, 2021-09-10), the "remove CR" was made into a helper function,
  and that is what remains today.

Having something like the above paragraph in the proposed commit log
message would have been very good.  Further, there might be old
discussion that led to c4adea82 where people may have discussed if
it is sensible to be lazy, which you may further want to dig down to
the root, to make sure that even back then people were aware that
touching only CRLF, not all CRs that appear at random places, was
the right thing and the code was done only due to laziness (rather
than, e.g., leaving lone CRs in the message somehow harms other
parts of the system in a way we are not realizing in this
discussion).

That would make a very good supporting material to convince readers
why the change this patch is making a good idea.

>  gpg-interface.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index dafd5371fa..87ae6503da 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -989,17 +989,13 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
>  	free(keyid_to_free);
>  	return ret;
>  }
> -
> -/*
> - * Strip CR from the line endings, in case we are on Windows.
> - * NEEDSWORK: make it trim only CRs before LFs and rename
> - */
> -static void remove_cr_after(struct strbuf *buffer, size_t offset)
> +/* Strip CR before LF from the line endings, in case we are on Windows. */
> +static void strip_cr_before_lf(struct strbuf *buffer, size_t offset)
>  {
>  	size_t i, j;
>  
>  	for (i = j = offset; i < buffer->len; i++) {
> -		if (buffer->buf[i] != '\r') {
> +		if (buffer->buf[i] != '\r' || (i + 1 < buffer->len && buffer->buf[i + 1] != '\n')) {

Please avoid making lines overly long like this.  Wrapping at a
logical break in the expression like this:

		if (buffer->buf[i] != '\r' ||
		    (i + 1 < buffer->len && buffer->buf[i + 1] != '\n')) {

would not just make the line fit in a reasonable width limit, but
makes it easier to follow.

>  			if (i != j)
>  				buffer->buf[j] = buffer->buf[i];
>  			j++;

More importantly, isn't the above slightly buggy?  If the buffer
ends with a lone CR (i.e. not followed by LF), your condition:

	if (buffer->buf[i] != '\r' || (i + 1 < buffer->len && buffer->buf[i + 1] != '\n'))

will evaluate to false because both operands of the OR are false;
the byte we are looking at is CR so the LHS off OR is false, and
because we are at the end of the buffer, so we do not have the byte
that follows ours that is not LF, which makes RHS of OR also false.
The lone trailing CR will be skipped, instead of getting copied.

If I were writing this, I would have written it more like this:

	for (i = j = offset; i < buffer->len; i++) {
		if (buffer->buf[i] == '\r' &&
		    i + 1 < buffer->len && buffer->buf[i + 1] == '\n')
			continue;
		buffer->buf[j++] = buffer->buf[i];
	}

This not only avoids the bug by keeping lone trailing CRs, but
also makes what we are special-casing stand out more clearly
(assignment is the norm, skipping is the exception), and avoids
pushing the assignment too deep in the conditional for readability.

The changes to the callers (due to function name update) below
(ellided) both looked fine.

Thanks.
