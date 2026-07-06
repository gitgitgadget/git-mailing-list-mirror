Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F633A9E9
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345218; cv=none; b=rDBSSzQRfUPuef6vShhfcM2alFzz+D91CJhhepeIdsCDgN9LoxPKY7/kAWrCY0S0oX+mL4nZgJjI9EPFH/+tw+T9YhO89esdDs+JVoHzSBkYoZqadCA6rKljgn2tQ1mJNJchs7NMrjjNW2+twaY5yo172g7ebJj5kH/oN11SEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345218; c=relaxed/simple;
	bh=g6PgOL72u93wYIDk86A3OUBTNnYxJL5v8Ao4L9rGVJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm97o70wE1NTkT+Tg3Wdrs+IW7S28xjt4ZVOYKn/5DilJ/aAz0JXepXtQ/DnxwSJZr6rUk+R+M7QXuOV9rQPf8S00kAhMxjhzC+ZTCs9WPr6sPeJxGfzouhDTHan7DsUERivR/ov/xWRs++/SYcuUpC7M72a3wo+zng/sz7eOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rl8oIzBx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl8oIzBx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c7902f47so18250535e9.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345215; x=1783950015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc5gb7we6fbCx+nAKmBppxSGApkzstOQaTzQeOLAQ40=;
        b=rl8oIzBxrq7Ow/k9EuLX61oYlPV3FrPtsG05uJ3KSsXQ9+Amjxx8c9CBDC8rMvLL2M
         ISWkH6ZdUmO9PfYqlYnOgAhdi6QS6FQEeXeiGvOcYr33ZgP1OePqN0FzyEovf7BNMnWa
         7eLV4a76t4uZxIhJYXvwcN2O9UOYCd8tHu+umG7fnF2lVfTFfi9PoqdMvkoDdYit8mDz
         FZBzNz1L3CBuGhge516mDFdw9WMZb6lWathVNzXnlVL0vEeCMVY0vSBXhbpxh6G+EmAZ
         0Uw4qY3U/FOcSBeMb1ofvCH37x48e9vcz6airtIQEHuvqQpLxCJb8eSvP44VLffXV9jT
         oIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345215; x=1783950015;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc5gb7we6fbCx+nAKmBppxSGApkzstOQaTzQeOLAQ40=;
        b=oNnZS4WtEFRjDsgfds8wLvJrEsRbK5u0pZfyDGJaAcVFqJNV889iGyqVltn3Zq2bqV
         1BsPsEMZeI/I/sm06rMNch2KNqHM/rsMvS0mBPxhz2i9REsaZvlAOnd4ebk1Xba7p5RN
         T09ifppSFuayP1oNr9IPDQo4P7N3t9dolSUsPLpbnLcTiOI3yRdqRAMSWbaoc1TFKx8P
         2c9s4RPEEM2B+h5gW9d7WT8EV9v3TfShtupWMnkcJ3sf12iTbYIOLfzSilccio7sUu9Z
         N8u/HYYlahu6xtsp8LuLRkGuYlFY8hjGJ/zkvz58GacgkHxiI2D6geZgpOnAwSlOA7Tq
         wQ3g==
X-Gm-Message-State: AOJu0Yz/LjCFpKXdaVgFaPlFlH3P8Q4yKOjfHVEDP0xeUQbnwkoRy1nY
	40d/2YK0UwZXO2cUnrgUwDFsBQpzSnYyfn0N5n83sLfv6XFhnZE6eFZz
X-Gm-Gg: AfdE7cn0/PYAp0cfSqwuNLWEHULHNcBH0bK6b56oydjsCf0i78B7rYao1oDFxcRMx7E
	Gr70D4Va7OQNARZUQgn5hgFr8cx2YkAUDxN/pZNEOWNkyBEFSkuRIWbn7bI32/6SOR/t7XHeVcE
	L1nZBxBmsstL+z3vjQtIguTS+9GGeGuVsKoD1G0WZImFbEEMwuLnSXmq6BnOPiI0feorHPE7lcI
	blKvNt+grUcEUw4pkW79pXdYHQitsJQODekTBiPGEABcLdhIyzRcLG0TboM5hJg1uf4FXGsOy3O
	cRXgtRtweV4G/1fSq1BV1Ehgq0slJy7GgcQVH7DaRNl017Rf3R1bAz62+YCMtC+A5docUkb2mvL
	PgmKBDlwmTJHJF74ojgFLa3+XGHv0+OGCEaU9up8yoaWp385mJ9Jqx7iwu/RcOmJsM73R1pQtpo
	Cay4mYgWLd7Vvmjancq2rwqHu5psydQd3wnz+2z5PNwYDd1bMiXoi5Lxu/jUZZPNnVyY16t7YKd
	Hlsmg==
X-Received: by 2002:a05:600c:c16e:b0:490:bd66:e523 with SMTP id 5b1f17b1804b1-493df06e90amr5897945e9.20.1783345214894;
        Mon, 06 Jul 2026 06:40:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm424848905e9.15.2026.07.06.06.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:40:14 -0700 (PDT)
Message-ID: <5d112698-75be-4b44-a3d9-8b6ecb4924de@gmail.com>
Date: Mon, 6 Jul 2026 14:40:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/11] sequencer: simplify pick_one_commit()
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Junio C Hamano <gitster@pobox.com>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <f51751fa3ec1545b7304b869d91d21b055218755.1782833268.git.phillip.wood@dunelm.org.uk>
 <akuMQ45aQejRcQ_Y@ugly.lan>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <akuMQ45aQejRcQ_Y@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/07/2026 12:06, Oswald Buddenhagen wrote:
> On Tue, Jun 30, 2026 at 04:28:58PM +0100, Phillip Wood wrote:
>> +++ b/sequencer.c
>> @@ -4981,14 +4983,13 @@ static int pick_one_commit(struct repository *r,
>>         }
>>         return error_with_patch(r, commit,
>>                     arg, item->arg_len, opts, res, !res);
>> -    }
>> -    if (is_rebase_i(opts) && !res)
>> +    } else if (!res) {
>>
> because of this ...
> 
>>         record_in_rewritten(&item->commit->object.oid,
>>                     peek_command(todo_list, 1));
>> -    if (res && is_fixup(item->command)) {
>> +    } else if (res && is_fixup(item->command)) {
>>
> .. the res conditional is pointless here.
> 
>>         return error_failed_squash(r, item->commit, opts,
>>                        item->arg_len, arg);
>> -    } else if (res && is_rebase_i(opts)) {
>> +    } else if (res) {
>>
> and here as well.

I meant to add a comment about that to the commit message. I 
deliberately left them alone so that when we convert them to use the 
enum it is clear that these arms are handling cases with conflicts.

Thanks

Phillip

