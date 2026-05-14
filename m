Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F710405E7
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774792; cv=none; b=kbj7EJ82TsxwqoH/2KctgVaoqph4pIsZMa/5KW4IiTjfRT1K0oqS8iKiH25yxMWprPkZ5fPulFIr96KPnCVXhUe2u4AUi58diLcoKFxSq4Z9epAho0nh1R3F5bDV/w1t+/1DOH0I7FdcFveLMsqPqfUEgTbWXXW2BsMAMquIg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774792; c=relaxed/simple;
	bh=LybwtU9LDM8u6hLJ9PLo7A3CB+YG/Bmq+5Wd8BwQ1Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMboIW7HdCpyaycVf8EJS8wglRYPwl5chlA4BBqZqxstfSdTxL+KkuCwyTu8yt9pyKChktWyb2NtQtwhKg+Qova4/HxWCvkEVHYFHcFafPbSxRSwtlfA5ZpBAGHaNyHui/m1H37x/2Oi+AHtf19qYcEOLNROCNfddHHtf2iYfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LoYPCV6I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krbP7Lmw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LoYPCV6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krbP7Lmw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F49FEC0176;
	Thu, 14 May 2026 12:06:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 14 May 2026 12:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778774789; x=1778861189; bh=a9dT81+l5r
	sjrL7Mz307eykLPGaj+M6AmdQ9wJLzAVs=; b=LoYPCV6I1ly1fUtgSXxL3xzi0T
	ZjlMZSAoGULxR7iOsAv2bvVB+60m+WCXjU+3xYGiVGOg9B3+a9gXWqZ/NPKnQUFC
	yu0rfGKyBEm1czBtuj4Xh0/1chWakOQTaI7we4cA5/jP31iHzqwCud3M0KadXdau
	0SzTSOX9/vBimyMX4mkC6f6Vae1fTdurRc19JQhcaS+biaL8DAD6XBp/V22SsFuO
	3J+kYX5IefEK/uHNbAA5bBX50/D7LH1q/hMEKgzpOhStMBEXQbNwXkMaTyMVdyXi
	JOgFin+5+k+jTr8atoZwI+aOIJm5Dzu8zC3LVCJDQiyvPlx1NGaoeXpMvjDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778774789; x=1778861189; bh=a9dT81+l5rsjrL7Mz307eykLPGaj+M6AmdQ
	9wJLzAVs=; b=krbP7LmwsRATvIc4w3VF0pV1FImHCe2lzEosIU/8ZY/eYalavDv
	NBal9ictS+JZp2DeDNol+zY3Ndcu53m78UVnHMebgNzw7WPSTeqQGzqnBenQFV5l
	GT5sIDrP+uCo8Ie9TSM5iMerzBfdhzqTg6imqTqvMSGzgpqvtDDipOPgjatoFkpx
	cQOG5c3D3FFWMTkNhPEM8/lR//bqNsUMCzIS/PpqGhArA5nzAGAm55Wdhxr9wVMO
	jL71IMEZMR1TVVc+13OB/Q5Ao1lSPRZaK5BA4SDwcw+96a6Pc0iH5+tZumE+HE3p
	zlnHLditrEO1habiwF4CWJpkjqsCFeqITdg==
X-ME-Sender: <xms:BfMFamLUTfKVAawjvy6eoGZlti3ifPlxSk_AI_54CaWfNiDBUsjMuA>
    <xme:BfMFalI6ekEfIlzKFS0wypSkrxTc7MYka_PcaAaejJephh9SgN0_2kn_o6-Cde-Z7
    eSoySApWjAtNSXoTopNX5reIcd2OtKIRAMJCJfJDmTTifIsRnlbZg>
X-ME-Received: <xmr:BfMFaruO8v4AfEZWpAU0iuSf0SLdZ3PdfrKOZmPMLDLiwQRTvFSYziFbA6YJB6-9zbfoeoywZY-i7WrqeRwHJz8SFabBqAcKDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfkgffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetueeftdekkeeijeejhfehudegkeffjedtudeiiefhleeffedvkeduhedt
    gffhudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepth
    grrghhohhlsehuthhurdhfihdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BfMFaqTVBhGeup_svYVSms0Lty_lcXfFV3QTkEr4diGLSoNYVJPtPw>
    <xmx:BfMFapOESzyHX_gTSuHmLQhx9Nc_Po0TYIznLCYTplBVD69vg6E3Dg>
    <xmx:BfMFanbSXYUUVu6LxLogQ_BNvCrC7awZ8qmQ6NUZRDkLQ4YzdwmlHw>
    <xmx:BfMFaryzu_QvCS9Lx53eJs_rylzOh6fM_CFQbU5nse6oCGJPYpPQ8w>
    <xmx:BfMFajNDewTBgocBqFy8giTM0entZC-hpQTCS1wk2a6fEeiIVwb2rcsS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 12:06:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] approxidate: make "specials" respect fixed
 day-of-month
In-Reply-To: <20260514115520.6660-4-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 14 May 2026 14:55:19 +0300")
References: <20260512145430.13212-1-taahol@utu.fi>
	<20260514115520.6660-1-taahol@utu.fi>
	<20260514115520.6660-4-taahol@utu.fi>
Importance: high
Date: Fri, 15 May 2026 01:06:27 +0900
Message-ID: <xmqqse7uf01o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> The special approxidate time formats, "noon" and "tea" differ from
> "12pm" and "5pm" by having the feature of wrapping to the previous day
> if the current time is before those hours:
>
> 	now  -> 2026-05-13 11:00:00 +0000
>
> 	12pm -> 2026-05-13 12:00:00 +0000
> 	5pm  -> 2026-05-13 17:00:00 +0000
>
> 	noon -> 2026-05-12 12:00:00 +0000
> 	tea  -> 2026-05-12 17:00:00 +0000
>
> However, that logic carries too far.  Even when the date is specified,
> the behavior of the "specials" depends on the current time.  Assuming
> the same time as above, we get:
>
> 	today at noon -> 2026-05-12 12:00:00 +0000 (should be 13 May)
> 	13 May at tea -> 2026-05-12 17:00:00 +0000
>
> or, using an example mentioned in date-formats.adoc:
>
> 	last Friday at noon -> 2026-05-07 12:00:00 +0000 (should be 8 May)
>
> The quirk seems to be rather old.  Already in 2006, Linus Torvalds
> remarked that the date yielded by "one year ago yesterday at tea-time"
> was "just silly and not even correct".  Indeed, even today it gives:
>
> 	One year ago yesterday at tea-time -> 2025-05-11 17:00:00 +0000
> 	  (should be 12 May)
>
> Let's fix all of those with a simple patch.  Check whether we already
> have a specified day-of-month in `tm->tm_mday` and make `date_time()`
> stick to it.  Ensure the correct behavior with relevant tests.


I find this vastly easier to follow the reasoning, compared to the
previous iteration.  Very nicely done.



>
> Links:
>   1. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>
> Notes:
>     > Again, this may be just me, but I happen to find the version of
>     > comment in Peff's review on the earlier iteration of this series
>     > much easier to understand.
>     >
>     
>     Thanks, applied.
>
>  date.c          | 6 +++++-
>  t/t0006-date.sh | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 412aca6dc4..73879d202c 100644
> --- a/date.c
> +++ b/date.c
> @@ -1132,7 +1132,11 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
>  
>  static void date_time(struct tm *tm, struct tm *now, int hour)
>  {
> -	if (tm->tm_hour < hour)
> +	/*
> +	 * If we do not yet have a specified day, we'll use the most recent
> +	 * version of "hour" relative to now.  But that may be yesterday.
> +	 */
> +	if (tm->tm_mday < 0 && tm->tm_hour < hour)
>  		update_tm(tm, now, 24*60*60);
>  	tm->tm_hour = hour;
>  	tm->tm_min = 0;
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index c7667bade2..d800cb30fe 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -208,8 +208,12 @@ check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
>  check_approxidate '3:00' '2009-08-30 03:00:00'
>  check_approxidate '15:00' '2009-08-30 15:00:00'
>  check_approxidate 'noon today' '2009-08-30 12:00:00'
> +check_approxidate 'today at noon' '2009-08-30 12:00:00' '-12 hours'
>  check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
> +check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
> +check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' '-12 hours'
>  check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
> +check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' '-12 hours'
>  check_approxidate '10am noon' '2009-08-29 12:00:00'
>  check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
>  check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'
