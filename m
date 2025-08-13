Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D061A9F8D
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090722; cv=none; b=cIkj0vpcFQewLpFRqaIuiW7et3Z4YBQ46gmE7N51Zh0O4IMkKuRErM8C8G0WUrIT3Y/jBlpBgDZKS/yAdDIlydmCs1Dcpj13OlOiEHK/93oRmSnLAWt7V7x+lZV0QnUpwkDPG8zyycBBKpI7z/VXqYxtv7C4u11cnu35q8p0hrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090722; c=relaxed/simple;
	bh=ll2W+YgAsi2uWZ9rrKCoKUe4FNarDm2Y6moUFsltES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Mfqk/vp1Ma5l3p4tbo857VnRvYgRgmuH5kawDyb5JExwa7y/HcBFqyaDKW+EEMs112DjB9xiaJgl3BMDugqxqxRjd26dDHt6j1bXIq95VSMVfLD88y/otKYinqnBO3Y2uCOcPSE/HBuNq83Q8SvRc07mWM1SrFAIMQCa06TbY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7mRO4e4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7mRO4e4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so4069851f8f.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090719; x=1755695519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EkXLx0xHlxAizOUvbyv0FFHyNCc07LHiDSgRwOhZhvo=;
        b=X7mRO4e4MFn14z1y2NVqqDAIqrQVhhZSVBuUv/bOJZBNSKRVJBaTdNvD1erDZzv8o1
         9Y4M5bp6mOM2cw0nRW61ETRYND3EzZJV/JYQDMgdr5q7+ywyULymvV7G5NNTdhnHw57l
         pvKNaY1SL7jiP4B6hPDdJUn+OSL88HXqPJAUoqQuspJsuXhdlNDUHBHA47CNHhPLJoSA
         ICKdSi53UiGdNwhQaFV4fXqcetm3tP7J6FQg4SjyGzZt3k5JtAClJ6ubOE6ncSmBwvLv
         rbWzTYxUxxiVlEC7q1dNB3ypPi8JkXLosXbKDybUu9HnUDhnQUK4Ve3VJkq2pBXOokXl
         /2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090719; x=1755695519;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkXLx0xHlxAizOUvbyv0FFHyNCc07LHiDSgRwOhZhvo=;
        b=jO4iX9F06K2c9QCo3C9b8GmtjrNs+rfVZPuobQtWrO7KL7tnxGdQYvapGuEDgrtyLC
         anxf1gWjN46tg3J9/q6TPRHAynFTpakABMCyI23H7AjbJAoE/nszdVttA9jc2RHeRfxr
         J1unrjQDPNr4F3CP5trywEXHYeEjqm//C2rTksiUiFYs/6pkHG+yOE6o+Zi05ruvloje
         vO0c/r2HUVbvxXuxQ03BUBpnhAontwX/5fCwViDqsFOcDkGmWU0RKAh6PX0d2PfsgnpU
         cuy0djVug3xCalgAS2+0ZIgC+WiF7l68E2W1fenLigCD8AVtztZekdurr9wvWC5FWrgV
         Tdzw==
X-Gm-Message-State: AOJu0YycKX41kDleEgrkanNqZc5Pr+0crTHXYbf5qHNyaKp/yQXlq/+o
	9+lbmwZmDFVjeXgSPVFYRxTfrqp9NjjJuVkB/QEyq9N+JwniREl6jPxe8PL9UQ==
X-Gm-Gg: ASbGncsQx0AeJHYV9QKcUupRz1Xc88cwTGYMQDkObpGHeAuqzrc4nJIXVFd+rKXjDYl
	HEADNPLf67VfrS6L2ADlXVALubArX2hGRsAhXl73rpBw2+xQybWWK9pOMmSN861BDEaIhH+7xUi
	PTaTC9c3eYXSeSwe2M71MvtZMkHrpodzzQkIKd/QXhEkHinrYDNQNHjznSzwf9R7QWsFpRj1UFu
	TLqLESFwIVz/AEJLRVd52WZZnOZ1j7bv2c0R+L2LvBPBKuZkuKWcPYa6zMsA91klMgzK3erXyY+
	TivHBfzSz56NkCXX+4UEmQb/UynpJ+xDcUVapSxjUq/lMrR/SrIJBBHiM+pDSHyL2lR8rVtdyPM
	yULbGgCpnE1kEcM5ZD/3dO+UBE3Peh5mHL/KS3AjC4xnHq5W1K2d9SMppliQZ2aMBjgY8eI98nQ
	GDPAfdb/80XSk3QQIHO1KOYQ==
X-Google-Smtp-Source: AGHT+IGXTGNHktWATOXEAgjA2rLPVNyz/zI9q0UNOe6K4unx60NVicnQ8A6FERCHyUysj3pwbRUrNg==
X-Received: by 2002:a05:6000:22c5:b0:3b7:899c:e87c with SMTP id ffacd0b85a97d-3b917d1ed40mr2181943f8f.2.1755090718557;
        Wed, 13 Aug 2025 06:11:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm48005623f8f.44.2025.08.13.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:11:58 -0700 (PDT)
Message-ID: <626efd2e-0396-45a3-9a12-29bb8cbfc173@gmail.com>
Date: Wed, 13 Aug 2025 14:11:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: =?UTF-8?Q?Re=3A_git_diff_shows_twice_=E2=80=9C=5C_No_newline_at_end?=
 =?UTF-8?Q?_of_file=E2=80=9D_-_no_need_for_repetition?=
To: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>
References: <1b0d634286da16f32cd9faf541ee28c811d6c83f.camel@aegee.org>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <1b0d634286da16f32cd9faf541ee28c811d6c83f.camel@aegee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 08:20, Дилян Палаузов wrote:
> Hello,
> 
> when a file, which does not end in a new line, is modified, git diff shows twice the text “\ No newline at end of file”. As this piece of the file is not modified, I think git diff should print it once.  In the example below the first “\ No newline at end of file” should be skipped.

The "\ No newline at end of file" applies to the line that precedes it. 
Removing the first instance in your example would mean the the newline 
at the end of the file had been removed when the line was changed. The 
output of git matches what GNU diff shows for incomplete lines.

Thanks

Phillip


> I am using git 2.50.0.
> 
> As a matter of fact github also shows this information twice - https://github.com/alex-shpak/hugo-book/pull/755/files - which I find is bad.
> 
> Greetings
>    Дилян
> 
> $ git diff
> diff --git a/layouts/_partials/docs/toc-show.html b/layouts/_partials/docs/toc-show.html
> index 21122a1..c243ae5 100644
> --- a/layouts/_partials/docs/toc-show.html
> +++ b/layouts/_partials/docs/toc-show.html
> @@ -2,4 +2,4 @@
>     and
>       (default .Site.Params.BookToC .Params.BookToC)
>       (not (eq .TableOfContents "<nav id=\"TableOfContents\"></nav>"))
> -) }}
> \ No newline at end of file
> +}}
> \ No newline at end of file
> 

