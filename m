Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CA3DD85F
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416287; cv=none; b=hAe2mo2/d69W+VzO+V5y5KSn1axQW6bXEEPLc/GXoZCGm7nOZnAK/V9a55E9Um9dQifiNFduJ5yK84SYfriIJjXLcF9Mjr00lJsJ6jYDtM8NzaWz6qkA1c6VCOaheTwkW60lsy6/eaW34XrpXaTI4nLmJHADO447nKaUMPw5ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416287; c=relaxed/simple;
	bh=6hy546DR6Vqe12VVsVkTa3FBm5GW9g1q6ZX1/B8vmU0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dhqIvX95NCYNq/hsg3fWVaXE4PLsxStA+ojdsjvOBiJEpeeYhvYkqZWdgR3W2Yon3kBX3Tzrj5F11dfUC22lUp6fnh2EBx1LbaXS9vGNkAnGLga3QmSlME8+IwT8I+SvjH3LFfUEk5uhbQfFfZB5Ar+pYwUqqYZWfjrIvGLMs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CteOOjHs; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CteOOjHs"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so1198573f8f.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790416284; x=1791021084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0N3A3GbQlHYcOrrSvVMrKE4Lgyp5lEG3x+ROqCflyo=;
        b=CteOOjHsFURzZ8mftQqSg4MmqWJPzmtVZW8hhPAndKFCZ6omvDfEXNiL3fLCOMFU5m
         uiT5069lhy1CNtwvTI82rujrtwP8lF3N+YUG/txkU4Im9S10vccZ/LGq5eUGt0OnHWnG
         VR0dHVCi1y34W2Cv/tWWtk/tkcsbGuuPJa/IXUxm9zP1ORgmtZfP3KHT+BGIaSTSt8QD
         O7u21AKiScArgL9LtK0n1sAX7lUlS5pQrlEFPxCb7JNNH+TNLjMqDiS8xiNDKelvo/jl
         WEVxk0iBeS2mwFbcIkNglft/zae+QbyoZdu8F9/aemcYJiJIoMef2/iFhkJ5hqyBLsXi
         i1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416284; x=1791021084;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0N3A3GbQlHYcOrrSvVMrKE4Lgyp5lEG3x+ROqCflyo=;
        b=F8XTOSW1kI6DAIr3aZ1dch9JtzKsd6iSnm4wg8Rv0kmVvYyDMIh7AdeBIv2CSfHNif
         ZA/wsHzovO7PEf5c3ZjiSQ15FPWtPssCFx9Eus/egxMwnehLFifYwyga2iteFWmA0rGu
         nnMLBa2TWLyG9wWUjKrMKvyYqREAKXJUwo7lHs4+o01wEwqLnpTXoSYVbVaESJGRW7en
         jw9JJP5Spe1EyQlQ8kR/sspv37ALdP7vcRqeRd5Lkv3JQLtz3ruR1RCc0GwFosojzzBR
         90Y3DRyYmuj4prYRlIpG0GVEg8D3ypchRETdoqjSYCasc1sHjNwKE2nWRf/yF6jQf3t6
         RxwQ==
X-Gm-Message-State: AFuF++lZBGKRZzY9zguTccuMzEVKigQ3YN0IFd258lZ2HRbxfQcfWuzW
	2v/hdlE6dyAU2RfIAwXNvtobaFFOO8xF1cKxVK9ZyP7VyE447bWXblrb
X-Gm-Gg: AYBFou1+oxH0aa1Kl9D1ozVMWTrSIWEFjSQ6MnJcj7BCsHKvfzMckp2rytdEFHT1NpM
	OR3TsrwpXiS1Dwrr7ru/OFg8oeSdmKeuaAz4ZXzWMdhz6mRKlv2CNy5lXO9GDHObqz2ise/SKn7
	7VkdA1M13H9YcbXq0FaO0TtvivLwM9bqWz6F6bp+FaeS08tV7/VoKiBx/0c94crNe0vA5coAIXI
	37+HZBN8SRmR47YsY+yp1APr70nqiq8wxleaVBVOMdSxA3IKLq/MAqNn1CT/GEj2HmjOL9Z5K6d
	GCnvfsxrUDAP3cLQ6WES07phh3I/pHpcS2HmGEiMJYhY7//FxML+5TyXAxnr9SZ/H4q3211qO46
	+SFKSZpiIg1n12Gr1AVwlMaWg2yZ2nhZ0R0j1AcA6Pzi9YxpH0ZbCJGrp9DAlc3gb7AlKBiYqQV
	NFMIUtTD7EXs5MOfodFF+RvX2IlTL5qaEGFYjYbYQemyCGcWcQU/RXm0QEZP2P57Ujn3pWV2lHI
	8T76CPxKw9c8k0UxnY3MYsOFx6qi7Ht6NGG/EM31rV1ahSmaQEr3Q==
X-Received: by 2002:a05:600c:1d29:b0:49d:797:83bf with SMTP id 5b1f17b1804b1-49fe66f3c7cmr162946025e9.21.1790416283508;
        Sat, 26 Sep 2026 02:51:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06b4d45sm125114985e9.7.2026.09.26.02.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 02:51:22 -0700 (PDT)
Message-ID: <c2bab13f-a9f1-473d-97aa-c201b2060bfd@gmail.com>
Date: Sat, 26 Sep 2026 10:51:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Adam Johnson <me@adamj.eu>, Victoria Dye <vdye@github.com>,
 Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <xmqqse2yz4y4.fsf@gitster.g>
 <CALnO6CBhoBcVjLXidvii+o_Ump_k9disW177LeSS0118t3oGKg@mail.gmail.com>
 <xmqqpky1wb76.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpky1wb76.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/09/2026 17:24, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
>> On Thu, Sep 24, 2026 at 5:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Ahh, or perhaps the trees are indeed given in a wrong order, but not
>>> in a random wrong order.  merge_ort_nonrecursive(), which is *not*
>>> the function you are using, takes head, merge, and merge_base in
>>> this order, and that order matches what you wrote.
>>>
>>> Perhaps the true culprit in this confusion is that the order in
>>> which merge_ort_nonrecursive() takes its three trees (head, merge,
>>> and common) and the order in which merge_incore_nonrecursive() takes
>>> its trees (merge_base, side1, and side2) are different, and if we
>>> fix them to match, it would make it easier to work with?
>>
>> Indeed, the confusion is that simple ;) Shamefully, we don't have
>> enough test coverage to catch that regression, so I'm very glad indeed
>> you spotted it.
>>
>>> The new test in the attached patch will fail with this step but if
>>> we revert the changes to builtin/stash.c in this step, it passes.
>>
>> Any objection to me adding this test as a preparatory patch? There's
>> no sign-off, so I don't want to mess up the DCO here.
> 
> It was written merely as an illustration and is not something I am
> proud of.  For example, creating a totally new playpen repository
> only for a single piece of test and remove the entire thing when the
> single test piece is done was done only to make sure the existing
> test that come later can never be affected.  Also the test only uses
> the most trivial case (a file is added in the stashed change, nobody
> else involved in the stash application has touched the file so there
> is nothing to "merge" in the file).  It was enough to demonstrate
> that the order of arguments given to the function was wrong, but
> we wouldn't catch problems in content-level merge with such a test.
> 
> So, I wouldn't mind if you reused that as one in a series of tests,
> but I'd prefer to see those who are move invested in the topic to
> come up with a bit more realistic scenario.

Maybe something like the test below (which I admit I haven't actually 
tested). That checks we merge the file contents and puts the changes in 
the file close enough together so that the old code would fail and has 
different contents for the three merged blobs.

test_write_lines A B C >file &&
git commit -m xxx file &&
test_write_lines A B staged >file &&
git add file &&
test_write_lines A B unstaged >file &&
git stash &&
test_write_lines committed B C >file &&
git commit -m yyy file &&
git stash pop --index &&
git show :file >actual &&
test_write_lines committed B staged >expect &&
text_cmp expect actual &&
test_write_lines committed B unstaged >expect &&
test_cmp expect file

Thanks

Phillip



