Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C34ED1A8
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674879; cv=none; b=Gzz6Zn1BbAiyFYocvpiyQeZWm+BfebYQUdGJsnTCnrEqt6aGWQbiSAvbKmOvsyLecqlV+pdu2CfAMspNqn/RjH9PegtNeCBOVW+utpR4d4t7EguhmpmuNvuPKYGscY/KKD/dG73iqCdbiUmyyMs9mLxm9KZWm040tEuxgFUNBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674879; c=relaxed/simple;
	bh=Vr2894t115FevPUdrvjjBcQBy5lB8tvCZneLRdNKDEo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AsgQOdAFC29GSXvyJSBiaCDH7yKvO0UpaaTtlquMIt23iecnJVVhH6j7NqofCWg7n004NcHBAHiAsVbcIS4vNIJsYoUCCBFpFqTYmiOqx1zYckCez9jHtgON+b1BHYVB657MaCAbG3Xshr6auLPxlcWetfF3njbNfi7HUZUJ4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuDzbLSv; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuDzbLSv"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so555853066b.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790674876; x=1791279676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmV69TDpcuDRgkFAVojSTMxZHU8FkvBwdZhxrM3ARTc=;
        b=nuDzbLSvLTVV+OdH7NHUEMx6RytCTgfjmNMJFKefwDJCo8YcLEZ02iNoEM0PIt6Nli
         +m6zS+cr4JDlgepSv4NkPGqD4Jgulrzovn8HB2/CxPQHRDqi8mBfaQb5D67rMh2FYbGR
         k4gBh7v6d+HQQ75zNL2qquGQnQTMVO+DvZSmLVVeKFe0/ukM1e3Ke44OVfv84YfjQ0xq
         dOX3wZRwlVsKiKafvAc8sSabeMCUJ5NnM1rFNaOMQXYW4pDwejLLEocagfewjRdgYpzr
         SHmibPSNxE9Z5KT72YUYSUb2/0FP5ayeJypOhRYEw4zvLfnzZLSkMVdkQxYUbc1nSUlq
         6hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674876; x=1791279676;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmV69TDpcuDRgkFAVojSTMxZHU8FkvBwdZhxrM3ARTc=;
        b=VHwiD2kl8MqsnYck94ZNdY7HCbitYRYgDDIBR22UMo+Pi6GxJcygb2uPb+bKDrK2Jo
         14gKu3aZ+mB+XG77Gy2hcL+oJOGn/uhrXZE3Yg5IqWYYr4uKo5zsoL+nrbbhcnC/uEcw
         gjc16LAhv3onMVD4SDT/davIHnWpywzqGwksuyt7koInvWvpHC1ZeSqZo66MjaXBDMs5
         fJ3fUp3B6VjXNNEJdomAkn5OC86zZU6Ocolw5nSL4tIUV+2pFSHgQPgeIwltW78hL51k
         DoSUeogM8hGKt7UDHaUQKR+9YLdT6S+gj9ibv0LYXk76pRNm1r2ZF0o+oet3Wb3wO1As
         yxkg==
X-Gm-Message-State: AFuF++nRA0CRUuOYAP7M4qIjCVmSObdFimWuJf9fspv2SsGTITRerZIL
	QZLLQij1NJwGOp5c/qsbWeIohVe+bOAuO3NPzKmSB+B00Uz1cc7wkcz8
X-Gm-Gg: AYBFou1tpJGexRhLQsfWqXXxqfkdYFc8eiawqKgnz5D4zbxZn+1iDga6+SXMd5HWJ9A
	cnMYhyR+3VijAz05E6/IRsZBKzOnJKGm+JuiqbVSpja4559qvfvAdWbEqtwUP9+DfUaIqvSKqyi
	XcOMOxL2SDvtbKZKNMyMHSIwiCLPmuqzd8FpAUcfAhcqCXtDutqVH5d5sXNlaPceaRIiE/PPLh+
	4BIGHIiKQ14pmYGEqX7CqNUd4FZpN74HmsLfktuDzNn366xv7u+8QOarwHpUlI19ZryDfmIVuKE
	6pdCcW9+7Q40+9bz2rVbAWfauhkv3tfb10sVRNPClTCbYlyEsuyYLb3NarIUmcx140sAzpalZxA
	JwDk9LTpiItUYmBn0iEQSfdv+d/+TEm75vtfm0hQFo7s2cf9//0alhAbrcLa18V5TphYpL73j/j
	AiIjRy1HKB9nJkcuzCcwPSAerZhwquz/ECgqVUdajVTl1oXh6+g7uk4h3xwpsGlADefTmHosGvE
	Ww2acgfPem4BR3/vwBXg3nPj5Cpz2X7n5bM3goWKWpX7s9+s7J/eQ==
X-Received: by 2002:a17:907:7214:b0:c25:c54d:d1a2 with SMTP id a640c23a62f3a-c2ac23c0f05mr1226287766b.18.1790674875795;
        Tue, 29 Sep 2026 02:41:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6acb8e19b41sm530871a12.4.2026.09.29.02.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 02:41:15 -0700 (PDT)
Message-ID: <21a5c1fc-b268-493c-bd61-fa0afdf98bee@gmail.com>
Date: Tue, 29 Sep 2026 10:41:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/5] t3903: test stash --index merges
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Victoria Dye <vdye@github.com>
References: <cover.1790168285.git.ben.knoble@gmail.com>
 <cover.1790425008.git.ben.knoble@gmail.com>
 <8b5ea5e6f47ee9a57df3a4d97a457d024b3dec00.1790425008.git.ben.knoble@gmail.com>
 <97f86d82-b5ec-44df-9ccf-8e6cd93e45f4@gmail.com>
 <CALnO6CCX+CvMZcOiyaFB0_nhe0wSv2-E2hx-iTbN4OvSVvNDRw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CCX+CvMZcOiyaFB0_nhe0wSv2-E2hx-iTbN4OvSVvNDRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 28/09/2026 16:55, D. Ben Knoble wrote:
> On Mon, Sep 28, 2026 at 11:44 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> The test looks good, but without the changes in patch 5 it fails and so
>> adding it here breaks running "git bisect" on this series. I'd squash
>> this into the final patch
> 
> Interesting. I thought I checked that the test passed sans patch 5,
> but I'll double check. I can't think of a reason it wouldn't offhand,
> but my thoughts on patch 5's changes have become a bit scattered.

It fails because it tries to apply a patch that looks like

@@ -1,3 +1,3 @@
  A
  B
-C
+staged

to a file that looks like

committed
B
C

and so the first context line does not match. Because the changes do not 
overlap the merge machinery is perfectly happy. As an aside when we 
clear the worktree changes from "git stash push -p" generate the patch 
with "-U1" to try and avoid problems like this.

Thanks

Phillip

> 
>> and I think we can probably replace an
>> existing "stash apply --index" tests that are not so strict with this
>> one, rather than adding a new test.
> 
> That's probably a good idea, thanks.

