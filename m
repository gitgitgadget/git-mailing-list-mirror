Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D147144D1E
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720912399; cv=none; b=mlJGxrxd1RE/4miU/sHWYG3hQluVGNAjmBIEqnL/x3M1tUaiTGN7K7uexY76rak3BuTsNQsljpGumeltEGFo8NvEbQ9KNcaHPQ58laEM3fql1DbOxUuU6MNq9Mr4IknV1tkHEkt6R1PL5iCgS0eOI7Is99iTvhGA/KIfoQD6als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720912399; c=relaxed/simple;
	bh=9HqwbV8/QGSl2Ln07kHD9kDvfRv5JNmHihrt72bTYd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHzkX3FzhHlI6g+7UDS6oGWqCX4bx/Q4ZB1ovVseGr6cpKxyJ9DU7IJkHeeoIsw0GVOIM3yDctI70XBcE0eYWnbXhC1jTAGs9iuTlpNG84JC/8LPd6k5Hgv4BbZMK3CNQWnUcv73DwHi9uPnOKQ3vZy0/wODmh7/EfuZmhwr1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3RMjOJk; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3RMjOJk"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d853e31de8so1812292b6e.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720912397; x=1721517197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIq2+LuysO2pmQ2T/VIjgNJ58k8xy3bzn2WBZHaQ6Us=;
        b=T3RMjOJkx5e+QSYvHegr0p7ToNdu6+V75HTp3oCXNQFuGM9Xd3ak0NbKwaUc7jkqXY
         99aAMw2dmeBOd8t2BY2egrzNPkrZdQd3bMcQVHZwsY63vhGsollIF9eeD9r7t511dzG6
         E0NRw0iQm+937PS5ux4UyjJ/KsaW8QeEeW/WdfmU9geF0PuQLfpGQNrOw0l8aJeXPt5c
         yC3E7048GwLmhKZAB1NE8woIZbpO0+JQN7E08FED46COJTHsZ20b+4FfgEuvzI7LnUKi
         DUPMkFYrkf+on91mW33dUqrpzmUpYvMYUTShqevpBEb5XkKE8FL/FMRo8KrF9Zo7u2no
         ktrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720912397; x=1721517197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIq2+LuysO2pmQ2T/VIjgNJ58k8xy3bzn2WBZHaQ6Us=;
        b=AvfW9BpXxxsdrd8KsxfOuv6ZFhqosl6LyIz9J9FVFMQU6/t7Rd9IcbQhVA8jUsAKBS
         cQUzxqbxE0CJhpiFiRIV0I7sj7wlzVGv+hPLt+PSnc/8Nxkpf5c7sTDjAzowwfJAP1fe
         CDLPeTMlhVWkqDHKU4m01s4lwRF7FkgabnkA6EHi8XXE3/G/fA0amOfv7mmefE+Hrr8Z
         01GeiFWpFYwSztHAvsxVW2Oz/3lwfylQ0CRNLiHtGwK3vvMVGdJj8dYpGN9cR8JGutpd
         nDmKvDmcJZsgOLqkwCDMMCSP6AgEDLPp5OA+OpyVl7F1DRpvkJIOEuf2v1QjvoPHAblC
         4JaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrkYscYbA5lOPBsk0wIsH8koMLShgX4uUYlNXYBknDW6/DAqC70gV+dUvDKCH66XC3eg6TeI5Hn0QiCZ0PQ3ryCvYH
X-Gm-Message-State: AOJu0Yx8qVSVtcTGdjdWsYw8VJ3dnmhdwUra6ZJ9hl2IBRSR32dYvep0
	VduZQzWMD8ZMS5phXwScvnBehH0CnrT8+R83t3q4q0HlSMMjO+LL
X-Google-Smtp-Source: AGHT+IF2kxuIUh1zVTdt9h8ajlm50WEThmR5v+9J904HHDxYmZT9r5WaGWPklWQ+/Bw/9UyunaioIA==
X-Received: by 2002:a05:6808:6098:b0:3da:a2bf:23b7 with SMTP id 5614622812f47-3daa2bf2eb9mr8634772b6e.28.1720912396987;
        Sat, 13 Jul 2024 16:13:16 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7e4bcsm1691411b3a.117.2024.07.13.16.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 16:13:16 -0700 (PDT)
Message-ID: <2ebcbe5e-a673-40ae-8326-65280dd6b18f@gmail.com>
Date: Sun, 14 Jul 2024 08:13:13 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
 <803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
 <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
 <9a2feb36-f8c4-4ea6-91a6-a3a24f359a6e@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <9a2feb36-f8c4-4ea6-91a6-a3a24f359a6e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Jul 13, 2024 at 02:17:49PM +0100, phillip.wood123@gmail.com wrote:
> On 12/07/2024 17:24, Rubén Justo wrote:
> > On Fri, Jul 12, 2024 at 02:26:22PM +0100, Phillip Wood wrote:
> > 
> > > > +test_expect_success TTY 'P does not break if pager ends unexpectly' '
> > > > +	test_when_finished "rm -f huge_file; git reset" &&
> > > > +	printf "%2500000s" Y >huge_file &&
> > > > +	git add -N huge_file &&
> > > > +	cat >expect <<-EOF &&
> > > > +	<GREEN>+<RESET><GREEN>22<RESET>
> > > > +	<GREEN>+<RESET><GREEN>23<RESET>
> > > > +	<GREEN>+<RESET><GREEN>24<RESET>
> > > > +	 30<RESET>
> > > > +	 40<RESET>
> > > > +	 50<RESET>
> > > > +	<BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET>
> > > > +	EOF
> > > > +	test_write_lines P |
> > > > +	(
> > > > +		GIT_PAGER="head -1" &&
> > > > +		export GIT_PAGER &&
> > > > +		test_terminal git add -p >actual
> > > > +	) &&
> > > > +	tail -n 7 <actual | test_decode_color >actual.trimmed &&
> > > > +	test_cmp expect actual.trimmed
> > > > +'
> > > 
> > > What is huge_file doing and what happens to the single line of pager output?
> > 
> [...]
> 
> I'm still confused why we don't
> see any output from the pager - shouldn't the pager print the hunk header as
> it does in the example below?

In the test above, we would need to use "tail -n 18" to capture the
header of the hunk.

In the test below, the "q" allows "tail -n 3" to capture it. 

> > test_expect_success TTY 'P does not break if pager ends unexpectedly' '
> > 	test_when_finished "rm -f huge_file; git reset" &&
> > 	printf "%2500000s\nfrotz\n" Y >huge_file &&
> > 	git add -N huge_file &&
> > 	cat >expect <<-EOF &&
> > 	<GREEN>+<RESET><GREEN>frotz<RESET>
> > 	<BOLD;BLUE>(1/1) Stage addition [y,n,q,a,d,e,p,?]? <RESET><CYAN>@@ -0,0 +1,2 @@<RESET>
> > 	<BOLD;BLUE>(1/1) Stage addition [y,n,q,a,d,e,p,?]? <RESET>
> > 	EOF
> > 	test_write_lines P q |
> > 	(
> > 		GIT_PAGER="head -1" &&
> > 		export GIT_PAGER &&
> > 		test_terminal git add -p >actual
> > 	) &&
> > 	tail -n 3 <actual | test_decode_color >actual.trimmed &&
> > 	test_cmp expect actual.trimmed
> > '

I wonder if the following would be desirable: 

--- a/add-patch.c
+++ b/add-patch.c
@@@ -1519,8 -1519,8 +1519,10 @@@ static int patch_update_file(struct add
  		if (*s->s.reset_color)
  			fputs(s->s.reset_color, stdout);
  		fflush(stdout);
--		if (read_single_character(s) == EOF)
++		if (read_single_character(s) == EOF) {
++			quit = 1;
  			break;
++		}
  
  		if (!s->answer.len)
  			continue;
