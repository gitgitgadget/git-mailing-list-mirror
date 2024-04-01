Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3B55C3C
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004621; cv=none; b=jMtDWuF0vrxJ2mHCiI6p7/nNVlsvExOLjwTfrkUA8PCzkSii1mMAqNcgjEcRdeQWso1WbcXLiCT10cBUKgzABMyVmtGMQwpuTcq++Jhv7lZIBfDNHcZfdcS2Jo62zTXoZCBhKK4A8PyMZUtgQMTr8pjBHdvVinHOdusaC05CzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004621; c=relaxed/simple;
	bh=HIcPH7yi939dulEydhZn1birjEbFBjtrwcoekPHPbdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbL1o2enrHNa1T385AYDFlepNI9ZP6UIlYoBL5FWn4goeaelZp57Hsy4yFw7Z2y6nWdcg+vUu96dePZEvwiHKC57nVImsXly2E1VdBrJS0qwB9NxZx7uCugr3jwTVYtKSsYLde/OUBVfkU1bWtWCUztfnmoUHoDP4oCmJFAEjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maANIpwh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maANIpwh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343620589easo7964f8f.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004618; x=1712609418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPEn0wIigilgJK1ue9BsNO7Z6O+9QU1kn9jJ7NumSzM=;
        b=maANIpwh3LbnYmcww9R46Zd2O20VCjUa7HxN/tWdVxKIri35DS+v65LVSM7gh3jEpz
         O5ay/BCdydQm9TR7iyZMT7oMrU2mkfeVA8OZCCZDHj1LMkxgc7CHFJ0czpu2knMWO03e
         25eP09VKmD0mBuCHVka0rwieaVk96/iiqJfZsT3aVsxdvqAe9vVmGLoqBUtWs1vFcGX1
         cpLF+hT9ZTtv5GaSrg4UJ84MCdhfKXAKEfcLOHiHUvgtUpAcov/pnTBW9lXnzrmcZRdQ
         VpqRNTBIGOF0YPD9BKpLDc6Yc4rFhEEpwN0j2BGdlav3lMKRnBSFpiGDHw37KBLD7uJa
         lZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004618; x=1712609418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPEn0wIigilgJK1ue9BsNO7Z6O+9QU1kn9jJ7NumSzM=;
        b=vfLePZIJvSMsEWjkjDawKAuOC7QQ6kabe5JZMYS/numxQjDWo5Bfu0EwJ98k5P2syh
         wKPSVoFwdYL8f00lgTPJ2aLUYdFlzxqRsBYqTxmyT21vJe+CGkKafynmkqiPs845PRWc
         WHeI92V3zE1VWKA3WQf5SnH0c1fFozFDVVsrasVe0tqh38XEb/rMrMNNMBBvEtIqGwYc
         /k2xTdoI3rQna7yPBUunIJOCCcZ5vXIYG7XgXTHuthnOiWYgWf3blKKPahrQ/5XaxtW6
         293wtc6J7ZIBFPU/6Mk06sdu+24EVZepqZVq65SFxgxa/oyaHpnHDTeWggCrwAgTN084
         aOfA==
X-Gm-Message-State: AOJu0Yyacbb4CMDmTAEhprdPly9GnetDYhpe/FI3sxFE5ghT7vzur3lR
	1wVseW1GOsE8b1Qds8njYatsjn3xMEUpC2XQ9s3WD/i3ZMf1OFO4
X-Google-Smtp-Source: AGHT+IH1994+VjqwKIKXY+fP450Z5vBLmhn6Uy9HuxGATHC/lxksShOV1hjghmXliqiu3FlIFQzwbQ==
X-Received: by 2002:adf:cc10:0:b0:341:e369:c60a with SMTP id x16-20020adfcc10000000b00341e369c60amr6438408wrh.2.1712004618300;
        Mon, 01 Apr 2024 13:50:18 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4bc2000000b0033e7e9c8657sm12398445wrt.45.2024.04.01.13.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 13:50:17 -0700 (PDT)
Message-ID: <b71785c5-b93e-41aa-86c1-d05703365240@gmail.com>
Date: Mon, 1 Apr 2024 22:50:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: omit trailing whitespace
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq4jcooddp.fsf@gitster.g>
 <fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
 <4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com> <xmqqcyraj3z7.fsf@gitster.g>
 <0f43cd7b-a366-4ec2-9577-93708e21f2ff@gmail.com>
 <3e35b731-333e-4b46-9c0c-089b5c47fe99@gmail.com> <xmqqo7auf3h5.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqo7auf3h5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Mar 31, 2024 at 03:20:22PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> > > and move the "hint" literal to the args, to ease the translation work:
> >> > > -               fprintf(stderr, _("%shint:%s%.*s%s\n"),
> >> > > +               fprintf(stderr, "%s%s:%s%.*s%s\n",
> >> > >                         advise_get_color(ADVICE_COLOR_HINT),
> >> > > +                       _("hint"),
> >> > >                         (np == cp) ? "" : " ",
> >> > >                         (int)(np - cp), cp,
> >> > >                         advise_get_color(ADVICE_COLOR_RESET));
> >> > 
> >> > It is not guaranteed that any and all languages want to use a colon
> >> > immediately after translation of "hint"; the current message string
> >> > with or without my patch allows translators adjust that part to the
> >> > target language, but your version will force them to always use only
> >> > a colon there.  Is that an improvement?  I somehow do not think so.
> >> 
> >> I was just thinking if leaving the format open to the translation is a
> >> sane option.  Maybe we can move the colon to the literal in the args,
> >> too.
> >
> > Just for the record, zh_CN (Chinese) and zh_TW (Traditional Chinese)
> > do not use ':' on its translation, but '：'
> >
> > So, if we go the way I proposed we'll need to move the ':' too.  I
> > still think it's an improvement.  But, optional to this series.
> 
> It is making it even worse.
> 
> Giving larger unit to work with to translators is usually a better
> for i18n than chopping a single logical message into multiple pieces
> and paste them together in the code, as your untranslated
> format-string (e.g., "%s%s:%s%.*s%s\n" we see above) will force the
> word order in the final output.
> 
> I think the patch at the beginning of the thread is more than
> serviceable, but if we wanted to improve on it, we should go in the
> opposite direction, e.g.
> 
> 	if (np == cp)
> 		fprintf(stderr, _("%shint:%s\n"),
> 			advise_get_color(ADVICE_COLOR_HINT),
> 			advise_get_color(ADVICE_COLOR_RESET));
> 	else
> 		fprintf(stderr, _("%shint: %.*s%s\n"),
> 			advise_get_color(ADVICE_COLOR_HINT),
> 			(int)(np - cp), cp,
> 			advise_get_color(ADVICE_COLOR_RESET));
> 
> to give translators flexibility to choose what kind of space to use
> (including "none") after "hint:".

diff --git a/advice.c b/advice.c
index a18bfe776f..a625316725 100644
--- a/advice.c
+++ b/advice.c
@@ -104,9 +104,9 @@ static void vadvise(const char *advice, int display_instructions,

        for (cp = buf.buf; *cp; cp = np) {
                np = strchrnul(cp, '\n');
-               fprintf(stderr, _("%shint:%s%.*s%s\n"),
+               fprintf(stderr, "%s%s%s%.*s%s\n",
                        advise_get_color(ADVICE_COLOR_HINT),
-                       (np == cp) ? "" : " ",
+                       (np == cp) ? _("hint:") : _("hint: "),
                        (int)(np - cp), cp,
                        advise_get_color(ADVICE_COLOR_RESET));
                if (*np)

;)

> 
> I am not going to do that, though, until/unless somebody complains
> and says "there is no inter-word spaces and it is more customary not
> to have a space after the translation of 'hint:' in my language".
