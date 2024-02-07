Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6B7993B
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314601; cv=none; b=JoFd+JBuB3fk6cTWhU/pthsDhFqpqpPEJCh1lSLx4ZjhtV07ZL9P2tbtpQAuqQYIE4UgyuuQoTS8pssxDilCdARkhNvcO6qOT4EZLmT2zz95hcaTzWU5EUx52sSJvSj0AakS5dCfTWgk3X0vIGkkRcggvGGQ3WhkLLvVdLshDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314601; c=relaxed/simple;
	bh=sEVW4NzqlaFDDoiTORxS/nvegE0tH5dkxrVzFfZwWxA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y36sbILvGQkUYdLZhZUkUBiTAVaOnJPOPQKyUDklEjnc3+k5jdn0y7jO1nHBRZFwPvq5AwbDSKYad+SMu+5freNlnKRedCrIkyQnL1vybHYNk32//DWkg7EaT83k7V5Qtae/1Q8r/qFvaHgeRmUvVkzbCh8XBB3yv8PEtRPlyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehN/eGtV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehN/eGtV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so5783145e9.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707314598; x=1707919398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAal/f1k+vJBjbkd4queQJhq7lFqgctaTv09WtExjCk=;
        b=ehN/eGtV9iOKKRondS+NRAUmkZSWtWW5AELvimkWjGxqef7hG69OuyEnFY45BhejAH
         ozqYwOQ90T+Ty8Bt2l9QGAgPH0HM8q/ErrKhAjcKc+BHMI0iqGaW+Mz6q3EtmyY8PA3t
         pcLU6ziSBYOuG46ZBC6LO29ZawSb9yHAISpJODK8ivRDdQrW3mGOuUnK+s67ePKkiIUs
         DPGDkh4L8oahGS84wGmh0dzZlBXOQcDkrCv+pIBe0tMwHBR9WOkcXCm41PdAFuObOAQo
         vUky36baxc57rpMlx/VmyDPusomCOFwdyjvl3jSn8Gik88OhXZkdzCIZgylO0Ob+Erdk
         E+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707314598; x=1707919398;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAal/f1k+vJBjbkd4queQJhq7lFqgctaTv09WtExjCk=;
        b=ICRVmH3l38qep14GhiG1hL81Ptj0GoNzMxnSfMx4Yo/luUmmDPPQRERxAoWX6Q2yqh
         nqXr198mybWqllbT1UYYEV/knqHIqiroROa+dfesjIku1tx4AZyDA6/I+hfzCRqxpFKA
         Ntg7nCYf4CIT+6+odmcjFjhEqI0V4T2Jh1CgYWrkdnlCneTGISdMYG9uQMjTrO80eb1Z
         KT14ZTwl0Z6knXkUVmF5Pz6o2cyjMW8hwv4aoLfc82/Fq9SeidZnxEQVyacIDaJg9mrN
         C8XYvJiK1Ed5xBgS3GuPH45eQys5j1W/Z7WntGtMLU1dIfQgpLnso8EP9Mix8nHsC7gg
         emwA==
X-Gm-Message-State: AOJu0Yw1/YnZC+BXjH3pmB2qDX1LNWN6WcxJc+rppllQ+U8DU+cj1q55
	HDMf0ZjVc3nz5HFBhkwx2qX2pZLnLX0a1pHa+GQDxoKWLSZeu8+y
X-Google-Smtp-Source: AGHT+IG5rwTpwAtEGqSdqe0FgbFV/hhZpWYILh7nZP6xRd6ERtxYkQ8cP/cAmmS2GEej0z78cFXEjw==
X-Received: by 2002:a05:600c:3581:b0:40f:de6a:2a27 with SMTP id p1-20020a05600c358100b0040fde6a2a27mr4303036wmq.40.1707314598273;
        Wed, 07 Feb 2024 06:03:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeu6Ffv5ie+4nbWj1YzZV/Fun7z/WcCYHz3VfhKCLXPtel30Dj6NnjfkVVOpfeXOa4YJK1Dr7C5r+t/xwFqdlgqP0JN2J6b+RPfKXeXYwyI2QJZQNSUo662cNzqr4tzDN6mEXRREYxHeT5Q73TiEXbUg==
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id ay3-20020a05600c1e0300b0040ef718cf81sm2325547wmb.28.2024.02.07.06.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:03:17 -0800 (PST)
Message-ID: <4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
Date: Wed, 7 Feb 2024 14:03:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Jonathan Nieder <jrnieder@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
 <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
 <xmqqy1bymru0.fsf@gitster.g>
 <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
 <xmqqcytal01i.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcytal01i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2024 03:54, Junio C Hamano wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
> 
>> On 06/02/2024 00:09, Junio C Hamano wrote:
> Perhaps it is a good idea to squash them together as a single bugfix
> patch?

I think so, I'm not sure we want to add a new test file just for this
either. Having the test in a separate file was handy for debugging but
I think something like the diff below would suffice though I wouldn't
object to checking the author of the cherry-picked commit

Best Wishes

Phillip

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c5f30554c6..84a92d6da0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -153,6 +153,18 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
  	git rebase --continue
  '
  
+test_expect_success 'cherry-pick works with rebase --exec' '
+	test_when_finished "git cherry-pick --abort; \
+			    git rebase --abort; \
+			    git checkout primary" &&
+	echo "exec git cherry-pick G" >todo &&
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i D D
+	) &&
+	test_cmp_rev G CHERRY_PICK_HEAD
+'
+
  test_expect_success 'rebase -x with empty command fails' '
  	test_when_finished "git rebase --abort ||:" &&
  	test_must_fail env git rebase -x "" @ 2>actual &&
