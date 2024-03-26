Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF37763E6
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463878; cv=none; b=oQJ1TH4h3/S0KTTfzis9kLIfZj50LsBNaakM4YR5/3w1IcK1rKib/IZCkcxhUScD9pBdQTeZ14BQb016rMQsEPGKW7GopjpCZCG5I0pNCkQhCmYn10ApILs5mAMTsgJJjQIF0+OO92LvygieGC9ra7brdB1GRkg5ovKyT15/m7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463878; c=relaxed/simple;
	bh=+iykMfMAEQDyEKqhOxmCCBkdJUSUos3UWpAV2RfY5pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXdXxDAHVe0JjzKumS7OgtSr4gv2mhIuO+7BHakl1ebbxEUFIGhLefZoc5LaKz6o6KhSEcOARyIaierriqP4vTlSmBlnQdKnm08nTdFs04G/u3/O5MhJFOFnOTrcWYBQGfXRAn7HoSvx7WHMYTuWeGsQmJh9+4n5LdvAz06P7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdtrPs/h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdtrPs/h"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so6551874a12.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711463870; x=1712068670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqxkJv9VryzAnDpGGiTGOV8gqUsj7H9ScfXNSy82g1A=;
        b=mdtrPs/hD7Z67rQ4msQSYzFBR2HqAE0ah4CIjNPGq8K4HiqTRcfls0QJyHTwXwVT1u
         kYtrhHD7CeDsz8S2F1/CNp3BByQtbZFhEWKNz7nuJhkWNogEzcSjzHmT7p21kheWZdT2
         Q5bSrVX6i1OKkhlKRfwW82J2XDoYuF3DFA3zMFnQ/f8kKOd6XS46+aW0IqqdbL9ti9Sv
         9k7O95s9n79GztxYAMSVm0Z9vklIz8oyU4OZv5rusrreC2CArhSyAQS/xYC3tqsKGy7g
         wjyarO6Nkabkrq5K/o/dg0/B7ClK6qa/qm0NIu8fvAyIJjWPNQsZOUp3nDgkpJcqmvwn
         rIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711463870; x=1712068670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqxkJv9VryzAnDpGGiTGOV8gqUsj7H9ScfXNSy82g1A=;
        b=EMcGahwo6d5HUeobSKtpV8SIppfgQ2z2p77+6GbwXICic/3ucV3xOdmO9BCPwS+bsa
         N+fIT7vLWL0RDbP8zmoYvNrD95OSV4rJpAUJlcyNcO04XsJw9OOrh09qyl33jQroJFWz
         i30utmkNZDFo0Y+BaP8JzhkD5lEhg+jtXa2mrewkyCqAXqkuur+LofLtzJoiT+YfknI+
         a0p7+7m3fVTZsTMn+4snk3sOLvpORD1OVYXHJbrj7GEMdzkzPblaNHKBZGMqu6p7oYzw
         Ug1Iror/NbRipkgU5QHrmDzAAgzNFLj8cAqTX/PA31UFaHaBxvoqMuRX+63ckPiTD0o9
         p+wA==
X-Forwarded-Encrypted: i=1; AJvYcCXXB1ixiW8JzOXVX4dxMO/0RXk1DGgFzrcnKY4O+n6DMG+Wyiu/ck0yAOzEaHuX2j9UJwx+jTepfrgcHbzpE3JrrKQz
X-Gm-Message-State: AOJu0Yy/weoiqc/99w4qLLsl3XBxyem/8Zrok1QbfLFzIMooYZbjM59o
	pVn/QCetxtldJfJyFhgYwa/vZ4WV3N9vE9fMHzWLfBz0cWaGHNWs
X-Google-Smtp-Source: AGHT+IFiV85yrb+/LkeftLEeHmaeJaXkE1m7m/lPZ8seiWrjwlaoWXNW5llf1rCh5z0cN34r1tkT7Q==
X-Received: by 2002:a17:907:d2a:b0:a47:f286:d9f8 with SMTP id gn42-20020a1709070d2a00b00a47f286d9f8mr5317879ejc.43.1711463870344;
        Tue, 26 Mar 2024 07:37:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090663ca00b00a4a33cfe593sm2445834ejk.39.2024.03.26.07.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:37:50 -0700 (PDT)
Message-ID: <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
Date: Tue, 26 Mar 2024 14:37:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] improve interactive-patch
Content-Language: en-US
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 26/03/2024 00:15, Rubén Justo wrote:
> Let's reduce the verbosity in the interactive-patch process, in order to
> make it less confusing.

I think this is a good idea, I've left a few comments on the patches.

Best Wishes

Phillip

> Rubén Justo (2):
>    add-patch: introduce 'p' in interactive-patch
>    add-patch: do not print hunks repeatedly
> 
>   Documentation/git-add.txt  |  1 +
>   add-patch.c                | 20 +++++++++++++++-----
>   t/t3701-add-interactive.sh | 22 +++++++++++-----------
>   3 files changed, 27 insertions(+), 16 deletions(-)
> 
> Range-diff against v1:
> 1:  48a2c63b78 ! 1:  5e319f439d add-patch: introduce 'p' in interactive-patch
>      @@ Commit message
>       
>           Signed-off-by: Rubén Justo <rjusto@gmail.com>
>       
>      + ## Documentation/git-add.txt ##
>      +@@ Documentation/git-add.txt: patch::
>      +        K - leave this hunk undecided, see previous hunk
>      +        s - split the current hunk into smaller hunks
>      +        e - manually edit the current hunk
>      ++       p - print again the current hunk
>      +        ? - print help
>      + +
>      + After deciding the fate for all hunks, if there is any hunk
>      +
>        ## add-patch.c ##
>       @@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
>           "/ - search for a hunk matching the given regex\n"
>      @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
>        				goto soft_increment;
>        			}
>       +		} else if (s->answer.buf[0] == 'p') {
>      -+			/* nothing to do */
>      ++			/* nothing special is needed */
>        		} else {
>        			const char *p = _(help_patch_remainder), *eol = p;
>        
> 2:  1730493096 ! 2:  1177bfeae4 add-patch: do not print hunks repeatedly
>      @@ Commit message
>               g - select a hunk to go to
>               / - search for a hunk matching the given regex
>               e - manually edit the current hunk
>      +        p - print again the current hunk
>               ? - print help
>               @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>                static int patch_update_file(struct add_p_state *s,
>      @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
>        				goto soft_increment;
>        			}
>        		} else if (s->answer.buf[0] == 'p') {
>      --			/* nothing to do */
>      +-			/* nothing special is needed */
>       +			prev_hunk_index = -1;
>        		} else {
>        			const char *p = _(help_patch_remainder), *eol = p;
