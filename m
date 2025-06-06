Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57D126C17
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223618; cv=none; b=IZGDmhMcj1BKaLkLn0SNq8tHDfB4jQYdEzsrHilm6tCWCGxOpG1DGvtEKN66cQr1vQiDyv4L0Rmct/43vsxAhnzJePc0xqMWFZMhLJud6DbkUbUhR6myQf2wM2GQMRqak1IXC4ecazyO7ixLXIx8kbp+ovnGrJg5H6O/Cr0KiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223618; c=relaxed/simple;
	bh=jTpXLthGWAX27GqtjZiWrR0mrbO2GGXNk8s7iczHtWg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DrmPXLRyXJ+AobwTFb/aVlNKemykj0zjIB1CQo76PteGyAY4YfLFjCvoNXVfvyuxNCfW8c/GpnjL5fe5cXY0HRLzoQT18vHNYEv0U70LTIzGYJ9JiBHkcyXy6PH8futdMNjjaT9jFlpeSYkbUz9Se42lEQlHpoua8nKSozhladQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbUbvWeM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbUbvWeM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a528243636so1361540f8f.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749223615; x=1749828415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+ndM/swQX5St8/nTYvVlRPKfm7Dl6OC9VSCTkARmtk=;
        b=IbUbvWeMSPczXgPPy6//h2RZ503/jRNXWC2HAzNstd6t6klbH1y3GzA/ZjLI9/ddLp
         fBYygPQHuq9ANI+g17rMST4AG0b3/gFXyvNnmtB4QJNN4ROuLsFxxv0OpFfpj4vxhrtq
         43NSNQN9D+wjZedrA3I3RAVWGi6whgrnpVM1gHmyxRj/jQeXl5FOzsrUdfsVwKUviUNZ
         5i0do9wH7kY/efyZRFo2ZpkA0DUhamtX4KGioi2ZrsMbU2YL7Hu2VxT2YlcUOf9cYF5+
         M3puDOW57tCLL7ShjhAEvqXGBbHjqWGAA3C/BQeAjOXRB9vrE66Ghz9inbCRsep+a984
         mkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749223615; x=1749828415;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ndM/swQX5St8/nTYvVlRPKfm7Dl6OC9VSCTkARmtk=;
        b=hdjl520J0Q5SVof7decyAvuMEGrM+xi4VpTgcfKw2PqnTH2oqn004LcA+xUXZoiXOt
         K0cJ897WQzGnD0C0di+YtuaAhcuFKUYaI/rxJVvpP5qBWYI8AHa7n8HhUS8ibZQRsgsv
         YzAM2aZ7x+SzIkCByJUWDEbWOnMi/zwhsB+JFfW2ZzBjyJTqoOrYQ9N/x0Jlp8Z6sLPv
         gMDEAmbeD9QpsmvYsE7BkTzbedAIK4IdMaqaeQgmvu34GdsnRYJIkHZdYtP5s47yml6K
         F78r7uaVCfxCULbPphrfr0wVzytC/9AaPymdBb/rfIQMglKAncxUWaq4QsICDGCcc1Os
         BPZQ==
X-Gm-Message-State: AOJu0YzlgeP6U7s5NRSpj2ux5LA9CSerka1GiTrGk2t8EfyUz+jNteEh
	L1Li+8+0EpkLuwzCQhcmnnpPnoAmvr0cLQIpc+4AW/d5mSei0TKsjkRn
X-Gm-Gg: ASbGnctXL5qD9ggg7WFvpKkiX2bAzUIJXFyqflNtnx0+F+Uv4q/jOmsydLroodRm2jc
	vEfoIk/A3fGSJK8MDm8EkOaLWkxTUie2v686S+UT7kCgUZrtuHWbuFx2Medu1qGtjTmkzdn5eae
	+6gHBwGWqLIMj/8oLNT+hj6jnjitksoFoA0Vgsn6fJ6v1ELArwHjL//2rYxJTgsd6BSvZaySweB
	uHKVucjbUrDz6/diMdJWUw7kUCRpmnf6TpJiwChAbYbFe4eG0qrqsCo/C186H3YRfdlxqp7dKw0
	XSxzGHrniEiSChL2jT3okTrVzfhqMgnbeo9K9VhmPCPG8tczu5hfdKSwKCK/9iby4hUlsNY8XHQ
	hx2u1QoiboFqFnxZRVNQUjPaWOqbHv/aETYEC7Q==
X-Google-Smtp-Source: AGHT+IGxJFUpL+y6aJfw48B1kxe1ikavJTAIdDf+UA8Y13ygZzkGFbnADDpJtHgBGrc3uSyP6yjtUg==
X-Received: by 2002:a5d:4650:0:b0:3a5:39be:c926 with SMTP id ffacd0b85a97d-3a539bec932mr291306f8f.32.1749223614374;
        Fri, 06 Jun 2025 08:26:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452669ada25sm25914775e9.0.2025.06.06.08.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:26:53 -0700 (PDT)
Message-ID: <ffafdfe8-7754-4aa7-b2bc-ef85452f8afb@gmail.com>
Date: Fri, 6 Jun 2025 16:26:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] stash: allow "git stash -p <pathspec>" to assume
 push again
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1747733203.git.phillip.wood@dunelm.org.uk>
 <2cd67f5cd85af03ae99a2760a76e9df5a7edfd95.1747733203.git.phillip.wood@dunelm.org.uk>
 <CAN0heSpGtLW8B-wtoMgW7gunMMeVTL1jhk8xN1LBbeeG4f1Fxw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAN0heSpGtLW8B-wtoMgW7gunMMeVTL1jhk8xN1LBbeeG4f1Fxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin

On 06/06/2025 12:31, Martin Ågren wrote:
> On Tue, 20 May 2025 at 11:27, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> +test_expect_success 'stash -p <pathspec> stash and restores the file' '
>> +       cat file >expect-file &&
>> +       echo changed-file >file &&
>> +       echo changed-other-file >other-file &&
>> +       echo a | git stash -p file &&
>> +       test_cmp expect-file file &&
>> +       echo changed-other-file >expect &&
>> +       test_cmp expect other-file &&
>> +       git stash pop &&
>> +       test_cmp expect other-file &&
>> +       echo changed-file >expect &&
>> +       test_cmp expect file
>> +'
> 
> This only exercises the patch machinery fairly trivially: all hunks are
> added. The implementation under test could miss `-p` completely and
> behave as `git stash push -- file` or some variant of it, and this test
> would continue to pass. (Confirmed by editing the test to not use `-p`
> and seeing it run successfully.)
> 
> It might be worthwhile to set up some more elaborate scenario where you
> pick only some hunks, e.g., this (whitespace-damaged) diff:

I avoided doing this because we already have tests that check "git stash 
push -p" works correctly when staging a selection of hunks and so I 
didn't think it was worth the extra complexity here when I was only 
interested it whether we parsed '-p' correctly. However you're right 
that the test passes if we ignore '-p' completely so I agree it is worth 
changing it. I'll send a re-roll.

Thanks for your thoughtful review

Phillip

> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index d24559a328..3b28504126 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1178,16 +1178,19 @@ test_expect_success 'stash -- <pathspec>
> stashes and restores the file' '
>   '
> 
> test_expect_success 'stash -p <pathspec> stash and restores the file' '
> -       cat file >expect-file &&
> -       echo changed-file >file &&
> +       test_write_lines b c >file &&
> +       git commit -m "a few lines" -- file &&
> +       test_write_lines a b c d >file &&
> +       test_write_lines b c d >expect-file &&
>         echo changed-other-file >other-file &&
> -       echo a | git stash -p file &&
> +       test_write_lines s y n | git stash -p file &&
>         test_cmp expect-file file &&
>         echo changed-other-file >expect &&
>         test_cmp expect other-file &&
> +       test_write_lines b c >file &&
>         git stash pop &&
>         test_cmp expect other-file &&
> -       echo changed-file >expect &&
> +       test_write_lines a b c >expect &&
>         test_cmp expect file
>   '
> 
> 
> Martin

