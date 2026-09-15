Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917735CB60
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446566; cv=none; b=IFY4J+FH7gwLTR0gDxtwoKuAo7cYn3wYNgZRTzkQ5dt5BFfU2WSMXIApbjR+vHCksdcs5XAJ1LkCBqbFhTZBNPN0sp4gN1tpUN4CAdbYHHleOydlfU/HRnyqzRb26iVM1kYl5OK+wl+1A6d/Ui0qfi5B/t1mPo4YvW3RMEBALyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446566; c=relaxed/simple;
	bh=y+ijGfaTUu2K4R1SpD6eK48na5muKTHxQwqu5ZQvJrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Da6iMoeCtSMkA+ll2DKNsPLw8nxJGaKxmvSmJUnd7DML/5pO+Xy4JP8ENwt5tGLYIsn7y1GwIid03hAE+0cmOmJUipYA2EkjFdVayUMJLfLtg7MoULX0294onCAXb2OEE/6CyBjm27/ZP2wwfpc8PYU3iuNlXVxVyX0oznlrBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XTu9t328; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKFqfZ+g; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XTu9t328";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKFqfZ+g"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C4FB21D000AF;
	Tue, 15 Sep 2026 00:29:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 15 Sep 2026 00:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789446563; x=1789532963; bh=HSgGQGXJJQ
	1uJ6JFG539nWLWY0fZIa7HNl7lFCj2k9I=; b=XTu9t328PHI9+wLV/cMghetglw
	TDw7wVJmnhFzYxi3X+5uawkPay7kyXg7ohFWeYq2maITob54CLFqzGww1hgqMpnL
	FuDRiVEUdmW3qkTN7guOEz9yGIXLzz8wwuVpTFO8zQjvZAoDy0ukiYizj54yW3u/
	JXDZx3wgSIrHa0/7TU/iMV9aD/sxyompWFItuZvxm60dVE1NUhGsje4Q0WIWfwFy
	6UaRV7uXndzBQMfdV2IAt5UssLA82++TEb3cAIxvDj+jVRa0whTciWjuztkmDv8m
	AbqZGKOGPpWnLJBk3Ul3H0mA/6bqyIHolmv/7bmRUulQ37hfNC4GNQ3sHp4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789446563; x=1789532963; bh=HSgGQGXJJQ1uJ6JFG539nWLWY0fZIa7HNl7
	lFCj2k9I=; b=MKFqfZ+gvcTbXQ2sfhfPjYPhwF8+qoL2PomomQP5iflAzTovb4C
	n4eBi/8fVwPMyHPR1qggOY4/tFNWjspRh5AL7dZxDZ5NRTgmBmnF0KPGda57orrv
	7nMFOsePYTJ24gwJx4SIbIhldbT/w+wGSyaiXKdgbwFXUY6BzxEAAHB0Xtrn70oV
	8cvFHYitIIUDtz/THCNoAXQoyG2etqbV33WTAuR9XYzHWtGfur4hUHXEjkFIlRcT
	pmzcIt8jnFoD3XmQcM4vVyCICvTdiP0oi/Oa6cu9sQIYa3RvD1UuEOWOj4Uep+fx
	w8YYQhHPC3ONpomMSETJZTwTLLZBcaoovZQ==
X-ME-Sender: <xms:o8moamFcK66sbAe8Dtc9gPzAJdSUrxcAF-koR4aTyB6Jgi2mB93wMQ>
    <xme:o8moauU7EMjdxwrmjSXC7tXgqONI6tMr86ZELYG-DlehK2rnPhc6IrQGScIN6pe4f
    dc6J6yhNlfZeYZHrKX-sCfUjgBkHlPLPb_fn2B7k9HnjkbkiYV9ikk>
X-ME-Received: <xmr:o8moalJMv__q1hMLsIe9-VYzICpqQzbzs9G8M6NFPwyBa7CgCUvv39P9_RuJ-FNJ2xlHz4rdhmHltnO_gCcayScagkFTEWrnRUFK>
X-ME-Proxy-Cause: dmFkZTFRWZF3XlYCsReGUkdbu1T3v+rg1oup5MXCfbqHYW/ANfFRNNcWQsoaTDPAnMwXmt
    DA3MWx2cZLNMedZry4do4XW/4PNRsAzlXC2rk/OKkJ/PhQgLYhfXzp6IXqhi1hdM5+/fXZ
    wKzv5DtCJxG6WtI7S7u9PXqoftECRdlzJG0MTNG1wE0R2ExAhEPAQqVWC9qyni2rRQziI/
    qvDQcf40PN/pbkQCj+f1NZwOWDkSo0H126whAz8A60HrCkjoUyEkbtTOwmTU3NMmtjZgV1
    DHL2Ccr7XxEAxRaiBWD5DzFVcRS/HbzBy8ATLyztrxJbfPvBNDlEHywrNw0JkRK4P1LaVi
    msuSIQK126j+yi4sdRRYgQs9VY+MQk7YoS+EdqxDknU82LyIh+IGvwt9wnoxLclcerjEUA
    DgA30P/mQX7tY86wdKct3LKq/lpEm1ND+gAb6GeJ/WvlIRGaz6aguok6KoqIDpthXo9MKM
    juDI5aAiR+ZrJyxXEH0KwxehMgwdLo4/onIe6Pjjzvl6Tqd5wrZM3wSK0C5gz2s73EdpX4
    Wpbmp4niSXu8cWyWBh6wBZclrXAiaw/AII4oqPlbvT4/Toca7VyUaeaZYscsT+I+BIctSK
    GpPia+nY+Mvy+CY6HFNtjRjmScDYS0VEPRCtAAydHWOuXdmyjdGVdeV8TGjQ
X-ME-Proxy: <xmx:o8moau84vRMjBFh0rGuVbRjnUPIX5h1kywVZuG94UL6OKZAFmjPZig>
    <xmx:o8moaoItTdQt-R0Ob_dI8b-Dvn7kda3sSadxqxSWDywp-cojGu7gkA>
    <xmx:o8moajl6LbqpuQjlJBNGq40yMINnrm3mSRuVV1ZQrPPQZdeXzB6AEg>
    <xmx:o8moasNTo8O3JHOYW0rBifCAiREqocuQZ9J2f81PRTMOTf_8GP5UvQ>
    <xmx:o8moasMMhvNrsLdxDxoAAODoIbMJ2YT_i1fpIvfUYApzQUDq4FCpCkBu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 00:29:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] git-contacts: allow inputting patch via stdin
In-Reply-To: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	(Brigham Campbell's message of "Mon, 14 Sep 2026 20:43:13 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
Date: Mon, 14 Sep 2026 21:29:21 -0700
Message-ID: <xmqqbj9z2l3y.fsf@gitster.g>
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
> interoperability with other utilities. Read from stdin under the
> following circumstances:
>
> * stdin is not a terminal
> * argv is empty
>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Patrick Steinhardt <ps@pks.im>

It is unusual for these trailers to be here for this project.

> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---

> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> index 85ad732fc0..52f6fbd044 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -158,7 +158,7 @@ sub mailmap_contacts {
>  	return \%mapped;
>  }
>  
> -if (!@ARGV) {
> +if (!@ARGV && -t STDIN) {
>  	die "No input revisions or patch files\n";
>  }
>  
> @@ -178,6 +178,9 @@ for (@files) {
>  if (@rev_args) {
>  	scan_rev_args(\%sources, \@rev_args)
>  }
> +if (!@ARGV) {
> +	scan_patches(\%sources, undef, \*STDIN);
> +}

Immediately before this hunk, there is

for (@files) {
	scan_patch_file(\%sources, $_);
}

where both @rev_args and @files are derived from @ARGV.  In fact,
once @ARGV is sifted into @rev_args and @files, nobody uses @ARGV
afterwards.  @ARGV is used only to decide which things to work on
and how, and the decision is recorded in variables with more
meaningful names than @ARGV.  After we are done with @ARGV, the
actions are carried out using variables with more meaningful names.

It would be nicer if you followed the pattern by doing something
like the attached patch instead.

By the way, there is a comment at the beginning of the file that
says:

    # List people who might be interested in a patch.  Useful as the argument to
    # git-send-email --cc-cmd option, and in other situations.
    #
    # Usage: git contacts <file | rev-list option> ...

We'd probably need to update that part of the file as well.

 contrib/contacts/git-contacts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git c/contrib/contacts/git-contacts w/contrib/contacts/git-contacts
index 85ad732fc0..f9e225b8b2 100755
--- c/contrib/contacts/git-contacts
+++ w/contrib/contacts/git-contacts
@@ -158,11 +158,15 @@ sub mailmap_contacts {
 	return \%mapped;
 }
 
-if (!@ARGV) {
-	die "No input revisions or patch files\n";
+my (@files, @rev_args, $read_from_stdin);
+
+if (!@ARGV)
+	if (-t STDIN) {
+		die "No input revisions or patch files\n";
+	}
+	$read_from_stdin = 1;
 }
 
-my (@files, @rev_args);
 for (@ARGV) {
 	if (-e) {
 		push @files, $_;
@@ -178,6 +182,9 @@ for (@files) {
 if (@rev_args) {
 	scan_rev_args(\%sources, \@rev_args)
 }
+if ($read_from_stdin) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 
 my $toplevel = `git rev-parse --show-toplevel`;
 chomp $toplevel;
