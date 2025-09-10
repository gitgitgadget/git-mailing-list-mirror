Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75031D749
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527104; cv=none; b=Hu/PH7YZxK2DLA8Ph3UOJNMPFSFVBiQqC5LdAkvQPD2zomzfbYaCdlMM++JDU3xHPfBx5sycXD+FiH9ag5h6lQzSiukwEzI7rWOEvxCxNx/ItbhrfmPjb4ZyN857ru1LaZBiPCdcCZgiHK4QQlcXkiV3DsFnvwBMqduv+ujrKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527104; c=relaxed/simple;
	bh=XMfJS1+k1WdQv9a8FCMdvIEpCb7IGjcRbdlqAgGSmn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjXslXO8h6TGpBFKysMitVXGf59lAleAMFNwkNp9RfIYbC8EdFF+V972fXrOp/7SM4s9d98VDh8N+zLvMOvreafoCsZ6m2YQonixtgW/4LnFBPd1/JlVyCbgnf+6wHuHI7JhMEtdPZ30JInFgOsh2tpPuSC0/GqBNlvb3uzLxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnIVSGsO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnIVSGsO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77269d19280so6649367b3a.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757527102; x=1758131902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uV02E+TXe9vkko0dZbKRA6UMnpftthbPecL2oSHaww4=;
        b=UnIVSGsOdzCy1v3/q97FZvDFLz9LvAd2CZLiST9rapwMirkAo59ppmiAbj6ishaqPo
         aEJKVyBj+a/VPysfr8Xg1/PJZzjAanSpHXRUwFO0zCQKxSiwDdZqMwjNERFkm52pOG/7
         xcHMDhYY68qUry4Sft+oh0BtpkkgOnnEhw8z7UdZDBnT3nRyYE7v3SIwEV4NiBDRKGkM
         k4qOj3dlWCywTV1rnWTuqJKb6L9k5fzNaeD8FiydRQMJZgEN3TinOUvKO/a9SVWx6Lin
         f33CHl2WRzqJk7mI5ge3/V8MJ+ik1dhTtcbKE8VROjNJb415rS5hwKiaSjrvgvJOqz0s
         AkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757527102; x=1758131902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV02E+TXe9vkko0dZbKRA6UMnpftthbPecL2oSHaww4=;
        b=iNGn62BuyY0j3Iw2jYKohxBvBPtUQvpoaThN+op+xNAS//S3w1Tu7304YiVQxGHGZN
         OcbD+Wifx/iplFDtJmJwvdeTEYU6qkExgZVD0Zw0J4oifgGPLv6o5OYWHTmp9jfjbU6n
         DhbXpXvV/9nbreo+sf1ik5i7ads0xoP2rbQ9pj1Fvqe/9ahTd+AHztlGdMLv0cYLFKCj
         tDJLT7Jz4+biQgTkyGKrlNykpMaJgACJcqnOTFqk4pjbLu7HeAxjvkKIC3d5rsFu28ma
         aUcvF42IuAtZCW3Oatilrbx8GiImCnJ4mFLwGwo9TTSz3/LkQPl/hdnbp6m4u3B8JWH/
         dhEg==
X-Gm-Message-State: AOJu0YwPSUysripcbp1kISmZ9Dl3NT64+gcY2818Bl2u5YLu7E5FGL0p
	DwJucQozuqy4JAUud0EC7pGHBziZAt7E5qLXRy0Z3b/R/mWGLyrR8cGq
X-Gm-Gg: ASbGncu+zOJIsip0VjscfSP6X1/A+vAUQneMbINomJgqh9KbfzoJvqTK/Zvb0YRfkG4
	XPgn/dWc3QiTkdNiMziXdFgd8rqloXCdA7Pazghx12Amm0zg5z4bteW/ntj6fHkl5W9P5S02gie
	yRLSCHEFzBwEgLi/N14VZ6l2/I22lYdYjypVVoIcRoSpbX12Z2837FCP2Q2t2lm60YXseLNo4Pu
	Qhet7NSIBVEAzaqBKKFiQrSTmEfb7IXnU6y2954ImhvzBs0a5kt6CymmFMMozWM8Q+P7k9HX9ua
	sXN45kGzub82JAX9cguj/VHq1yGvnlefoPy3L/mnJuYfjO/uCGZwIpV9qdIVQAlaEM27DNscXyV
	KCqXpU13IMuVp2z9hYJ3MNgMCusppCwzymXmXpTiAiNxufeABpixu4KzDT8QLH6ZImYE1qA77HP
	o29RPJRF67aETyjESCPZJHb+s=
X-Google-Smtp-Source: AGHT+IFdLLboJOPdkv+k31njizmQ3Kgo/m1ailmC7C2uomNK+eJog+k/i3+fDyz37IjNmtiAEjkFKQ==
X-Received: by 2002:a17:903:2b05:b0:24e:81d2:cfe2 with SMTP id d9443c01a7336-2516f04ffeamr233067585ad.7.1757527102252;
        Wed, 10 Sep 2025 10:58:22 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:9da:149a:656d:6410? ([2406:7400:56:7e97:9da:149a:656d:6410])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422de1sm33875115ad.25.2025.09.10.10.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 10:58:21 -0700 (PDT)
Message-ID: <aa4d5d0d-3c13-4381-8194-2b0c178b3cca@gmail.com>
Date: Wed, 10 Sep 2025 23:28:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] replay: add --update-refs option
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>,
 John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-2-siddharthasthana31@gmail.com>
 <CABPp-BEmOor3CLAY6y50DuGR1K7WYu+PVsXXWOOaofXzJpavMg@mail.gmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BEmOor3CLAY6y50DuGR1K7WYu+PVsXXWOOaofXzJpavMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/09/25 13:02, Elijah Newren wrote:
> On Sun, Sep 7, 2025 at 9:36 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
> [...]


Hi Elijah,


>> Option validation ensures --update-refs cannot be used with the existing
>> --update option, and --batch can only be used with --update-refs.
> There is no existing --update option.


You're right, poor wording in my commit message. Both options are new in 
this series.


>
> [...]
>> +       int update_directly = 0;
>> +       int update_refs_flag = 0;
>> +       int batch_mode = 0;
> Why are we adding three kinds of updates?  You covered two in the
> commit message, but mostly only motivated one, and then added three?


That's fair criticism. I was trying to cover all bases but ended up with 
confusing options. The three were:
- --update: individual ref updates (like piping to update-ref --stdin)
- --update-refs: atomic transactions
- --batch: allow partial failures with --update-refs

But as Patrick pointed out, individual updates are inefficient and 
everyone seems to prefer simpler options.


>
>> +               OPT_BOOL(0, "update", &update_directly,
>> +                        N_("update branches directly instead of outputting update commands")),
>> +               OPT_BOOL(0, "update-refs", &update_refs_flag,
>> +                        N_("update branches using ref transactions")),
>> +               OPT_BOOL(0, "batch", &batch_mode,
>> +                        N_("allow partial ref updates in batch mode")),
> Three modes and I can't figure out how update_directly differs from
> the others from the description.  Is it different?


Yes, update_directly calls refs_update_ref() for each ref individually, 
while update_refs_flag uses ref transactions. But Patrick's performance 
concerns make me think we should drop the individual approach entirely.


>
> Also, --batch seems like a funny name since update-refs is also
> updating refs in a batch.  I'd suggest coming up with a new name...but
> is there clamor for it?  You mostly motivated the atomic updates, and
> I think it might be better to just implement those and then add more
> flags later if needed.
>
>> @@ -399,6 +461,7 @@ int cmd_replay(int argc,
>>
>>          init_basic_merge_options(&merge_opt, repo);
>>          memset(&result, 0, sizeof(result));
>> +       result.clean = 1;  /* Assume clean until proven otherwise */
> I don't understand why this change is needed or helpful.  I don't
> think it changes behavior looking at the existing code, but to me,
> result is supposed to be the result of a merge operation, not an
> input, and should not be set other than being cleared initially by the
> caller.  The comment feels slightly misleading to me, as well.  So,
> I'm surprised by this change and would like to hear the motivation
> behind it; could you clarify?  Did I miss something about how you
> depend on this being set even if the list of commits to replay is
> empty or something?


You caught an error in my logic. I was trying to handle the case where 
no commits are replayed (empty range), but you are right - result should 
only be set by merge operations. The existing code already handles empty 
ranges correctly by never entering the replay loop. I will remove this 
line in v2.


>
>> -                               printf("update %s %s %s\n",
>> -                                      decoration->name,
>> -                                      oid_to_hex(&last_commit->object.oid),
>> -                                      oid_to_hex(&commit->object.oid));
>> +                               if (update_directly) {
>> +                                       if (update_ref_direct(repo, decoration->name,
>> +                                                            &last_commit->object.oid,
>> +                                                            &commit->object.oid) < 0) {
>> +                                               ret = -1;
>> +                                               goto cleanup;
>> +                                       }
>> +                               } else if (transaction) {
>> +                                       if (add_ref_to_transaction(transaction, decoration->name,
>> +                                                                  &last_commit->object.oid,
>> +                                                                  &commit->object.oid,
>> +                                                                  &transaction_err) < 0) {
>> +                                               ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
>> +                                               goto cleanup;
>> +                                       }
>> +                               } else {
>> +                                       printf("update %s %s %s\n",
>> +                                              decoration->name,
>> +                                              oid_to_hex(&last_commit->object.oid),
>> +                                              oid_to_hex(&commit->object.oid));
>> +                               }
> Who would want the update_ref_direct() branch of code here?  Can we
> just toss it?


Given the performance concerns and the confusion it is causing, yes. 
Let's toss it and focus on the transaction-based approach.

Based on all the feedback, I am thinking of simplifying to:
- Default: update refs atomically using transactions
- --output-commands: print update commands (for the traditional pipeline 
workflow)
- --allow-partial: allow some ref updates to succeed while others fail

This addresses your point about making the better behavior default while 
still supporting existing workflows.

Thanks,
Siddharth


