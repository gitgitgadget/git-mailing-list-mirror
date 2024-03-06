Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89712A50
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685525; cv=none; b=LzaY1LKBNUBkFeLobczdN8U+lB1i/M7x1gT++DHkXJMcf4+eoG+P9jqbEmw4Nrsg8DttPr8vTauktHzjlxo64xOkEyHlaNl5Ha0lPYhPJ6p5ThdclHoV2W0aKZrvRdBy1eArNZGDmkGmuSR2U1puSPjSMyO1hFux3XJdpog3q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685525; c=relaxed/simple;
	bh=dnb0CVQkIAQKCD+HWqtUWAKSAMpiNQDlFG0R6zwgrrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvViiCmc+wK4ogkeWXGmMGCNvpIbNa7+cF+4XXCRSqw+cnUlW4BHUgNiUnLPlW8vxu8MOwy+4duWcJJARwoueF0TrF45YuS2pCTCwjc+PwwQUQ7C1Evg/0KvWg8eXh2SKG7aUvr3IdKU9/ck0Nf/aTBvAWBtCaYjqcjHB2d31LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8AD0M8y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8AD0M8y"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e162b1b71so1140638f8f.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709685522; x=1710290322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMlSXh6c/jHnl0uqFvp2gp7NApyGsPlcMbFD7wTB+FY=;
        b=A8AD0M8y2LxqMDytSV9rQMGeeO3zWRG5IMnDD1D9WtRb4p2DlPnVDhzn6VXOykpx83
         LTB72Kxlfc42zpJmFt9nWg1Q7MGZllrpTF0hbDKBXsokhmlVUD6e22wK9w144svHEG9T
         P0Q5DKQ3rPLZigTq+hf3H5Hdxgm87AGxCJH3o6r8Yjk76CYyopoLuL3nrDYq/M6nklME
         5r1VJUe8+zwEJxSXjAH9iWLqTfvC73TnMAVs6o+zUIfTPqzrYdkFyUqxFJMVouULDdol
         rLyyjG2wHYy46RRz0eqmQPaS9JKqezTqZ+H12YgRw14FlrtKN7kkYdm4BY+ZAn+uGc6R
         MAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685522; x=1710290322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMlSXh6c/jHnl0uqFvp2gp7NApyGsPlcMbFD7wTB+FY=;
        b=TN+KRL4ttREtb2Ja/vNBv4f0gfq5p4yCXcMCKJSlQds2oViPot3E9lqNQMgaI/sKPZ
         TJNQ1mywrxu19xLAlSKgNI8WQfbkYMsd+5SAzhcVrItif/dfC0kEEoXne+ci0iXNQ+HT
         X7rXr4hCXVGbaj/rADCHhqSKOaLos5B3svkTP2ztOUZNA9suBgUEl0WliAbPQgXTHFmn
         PF7e3qWtFi5PqGnEblQWlfFN93nKGJ2WTfAq6f0jRgaveuAQDOpQ+wIIBZSCy68jhdNF
         IeunyHqnW931iY8504WiSsFqBMpp50LkxVoxKP+X6oD4GT4kVfcys7rHNO8aIsV8aG06
         FeMQ==
X-Gm-Message-State: AOJu0Yx0E18Qfq0mQb2TQHCX/q59NxZTH7pMlAyZwgcQnrk6+XJ6aRzN
	GZvEx79TWMso7CIzHutfhyyTEk8xQ+byStYdz1tgwfEZ82uOVLDM
X-Google-Smtp-Source: AGHT+IEnrVtSta2mNGtRR2u1/7eCi4272j553QMrzY91NDbMEYLxyo5vXPofvo3Q6OUBP64KvyafeA==
X-Received: by 2002:adf:ce88:0:b0:33d:ac70:2e09 with SMTP id r8-20020adfce88000000b0033dac702e09mr9363820wrn.59.1709685521702;
        Tue, 05 Mar 2024 16:38:41 -0800 (PST)
Received: from gmail.com (59.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.59])
        by smtp.gmail.com with ESMTPSA id dp14-20020a0560000c8e00b0033d8ce120f2sm16110303wrb.95.2024.03.05.16.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 16:38:41 -0800 (PST)
Message-ID: <f3e41a51-a173-444b-bde9-216147cd667a@gmail.com>
Date: Wed, 6 Mar 2024 01:38:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] t/annotate-tests.sh: avoid redundant use of cat
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-5-dev+git@drbeat.li> <xmqqplw8xqio.fsf@gitster.g>
 <bdae6d2d-af56-4bc0-a000-5cf2ef44cd44@gmail.com> <xmqq7cigxl1o.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq7cigxl1o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Mar 05, 2024 at 04:26:27PM -0800, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > On Tue, Mar 05, 2024 at 02:28:15PM -0800, Junio C Hamano wrote:
> >> "Beat Bolli" <bb@drbeat.li> writes:
> >> 
> >> > Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> >> > ---
> >> >  t/annotate-tests.sh | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> >> > index 5e21e84f3884..87572459e4b8 100644
> >> > --- a/t/annotate-tests.sh
> >> > +++ b/t/annotate-tests.sh
> >> > @@ -532,7 +532,7 @@ test_expect_success 'blame -L :funcname with userdiff driver' '
> >> >  		"$(cat file.template)" &&
> >> >  	test_commit --author "B <B@test.git>" \
> >> >  		"change" "$fortran_file" \
> >> > -		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
> >> > +		"$(sed -e s/ChangeMe/IWasChanged/ file.template)" &&
> >> 
> >> Obviously correct, but 
> >> 
> >> 		"$(sed -e s/ChangeMe/IWasChanged/ <file.template)" &&
> >> 
> >> might be a more faithful conversion (when "sed" looks at its ARGV[],
> >> it did not find anything before, and it would not find anything
> >> after this patch).
> >
> > Good point.  Thank you for being careful.
> 
> Heh, I actually consider it the most irrelevant one among my
> comments.  I actally do not think there is a way tell if your "sed"
> invocation is reading from one of the files listed on the command
> line, or reading from the standard input, from your sed script,
> unlike say Perl that has access to @ARGV.  Certainly a simple s/A/B/
> would not care.
> 
> Compared to that, rewriting $(cat file | wc -l) to $(wc -l <file)
> does matter, which was done in [05/22].

Yeah, that is needed; faithfulness is appreciated.
