Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6854199386
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914932; cv=none; b=hCj3Qsv/VLkzmNoUBBFOpK1C1Y9qS351w3YQqzE7JXeMjX43sYO4WFiFck7XDWB2K3p1O9eEZY7JKtCfZEba0NaY+9YpTBO/GM/5Eat9Jl/vTbpVYow9hCyynFIuX/QwtoTZ8F/3Wkbj8nOfojiOjlgN/8BdNTx5eIc15yXFGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914932; c=relaxed/simple;
	bh=pPYAm3uGn6ixfYhjj/V0deVdvbf1YDXWGAAYQskx94E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hzGIUrFws2UTNfnvpBco9pX88/2iEO0BcIGezKDdRJwBFrdJevsfCT3rf9gIiRLwk1PBPkCmjj4ZCZINqyCW8KrbkdmkWpR3zmj6c8Vg5243L3LvljuxI78ag69DWNE+Eq+WuIdMZBTaWxiSJvwMzi3VTEhG8nEu2pU1L84AYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpQO8rEM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpQO8rEM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so5472095e9.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721914929; x=1722519729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYVxhHsgqDUkhbt83/SWx9mN+bv6OrLKUaaRuiT2v94=;
        b=kpQO8rEMKSsIuGxZgvSARGMXc6CKRZJ9RLWYAgt5S7/Sn21WSmii6LA3ymRhs6NaQV
         0FNaLurwULwwP9dyhcF+a26Np6AK2E8rwPoi6Up4a8m5ADfY3M49sC/aHe2hSBYQsXAU
         Q8xJl35VWgbJ4BNhIWoDSCriBFTPhqwd3d3PcGiayfoiDAft5/RY9uXao8HKXcpaiW0u
         bKNHPeRlJmdpxSf/bMC3PbbQ6KGtw8kXah2zimEicmaPJkx1GJr3mJHUIHkN1qtB93Pf
         qdi9MiR3uIQdtkdM3+GCf5MDxu8NTpC+jG4l9G3xe3I53cntmoO0ouJnVFyLmW3LsuPd
         8k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721914929; x=1722519729;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYVxhHsgqDUkhbt83/SWx9mN+bv6OrLKUaaRuiT2v94=;
        b=nb1+oyVqqshGMGsXUlnHKA+jYzOo07UCWNQoP7gRvNMxuo/wjnOYJB4rhNDWx4Fqwu
         AfSOaDw0phSNBjvTFx1u4/jaGQlI3Ytt0vC55dBFt0sRSCM7wxM6zZxSZE+iyeP7u9Pv
         mUO229+1qqnH9DrWaOgTLVRGct8OK7+hRn0GlZ8sx2CSaVvQF97Qb76acY63YM2FiyfM
         3UOMPCIzoKx9asvINna4k9KNupoB7n8j4ombVm2k5m8kUA9tWneHZZwiIfMQ6zmFamOQ
         sYQSKOyTclXCoqSKPYX0JYp/E3LnTbErRTd2avxepkfRhnHix0S6H/jypzy9juWFk1Vz
         WbTQ==
X-Gm-Message-State: AOJu0YwLNV/x0U9h5A03/8O3/vBmPdpuSM8RCc1bJHKhwW8umVsCJ1e6
	BMbs4dpro7j/+wYzGt23VaiES8PV345xw7ZMc/ZuxymtVr4sblyXnEVDAw==
X-Google-Smtp-Source: AGHT+IEyS1t/Gw6XMpkyGDn9LuRPMdD0HGPKVGPLR+YwfotcIPpYdbCKQq9ERutUNhrTOV4Rqjs92w==
X-Received: by 2002:a05:600c:5126:b0:428:29e:67cc with SMTP id 5b1f17b1804b1-42803b09634mr24615035e9.10.1721914928619;
        Thu, 25 Jul 2024 06:42:08 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6084sm79225765e9.31.2024.07.25.06.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:42:08 -0700 (PDT)
Message-ID: <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Date: Thu, 25 Jul 2024 15:42:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 0/4] squash fixups in rj/add-p-pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
 <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
Content-Language: en-US
In-Reply-To: <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here is the series that squashes the fixups in rj/add-p-pager.

I don't have a strong preference for this over what's already in
rj/add-p-pager, but let's go through the changes Phillip has suggested,
even if it's just to archive them in the list.  

Thanks.

Rubén Justo (4):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  add-patch: render hunks through the pager

 add-patch.c                | 18 +++++++++++---
 pager.c                    | 48 ++++++++++++++++++++++++++++++++++----
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 48 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 8 deletions(-)

Range-diff:
1:  5fdfd2f3bd = 1:  9f358c6d69 add-patch: test for 'p' command
2:  506f457e48 = 2:  f45a7ca9b2 pager: do not close fd 2 unnecessarily
3:  b29c59e3d2 ! 3:  9d7a50e531 pager: introduce wait_for_pager
    @@ Commit message
         In the interactive commands (i.e.: add -p) we want to use the pager for
         some output, while maintaining the interaction with the user.
     
    -    Modify the pager machinery so that we can use setup_pager and, once
    +    Modify the pager machinery so that we can use `setup_pager()` and, once
         we've finished sending the desired output for the pager, wait for the
    -    pager termination using a new function wait_for_pager.   Make this
    +    pager termination using a new function `wait_for_pager()`.  Make this
         function reset the pager machinery before returning.
     
    +    One specific point to note is that we avoid forking the pager in
    +    `setup_pager()` if the configured pager is an empty string [*1*] or
    +    simply "cat" [*2*].  In these cases, `setup_pager()` does nothing and
    +    therefore `wait_for_pager()` should not be called.
    +
    +    We could modify `setup_pager()` to return an indication of these
    +    situations, so we could avoid calling `wait_for_pager()`.
    +
    +    However, let's avoid transferring that responsibility to the caller and
    +    instead treat the call to `wait_for_pager()` as a no-op when we know we
    +    haven't forked the pager.
    +
    +       1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
    +                       2006-04-16)
    +
    +       2.- caef71a535 (Do not fork PAGER=cat, 2006-04-16)
    +
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## pager.c ##
     @@ pager.c: int pager_use_color = 1;
    @@ pager.c: static void wait_for_pager_atexit(void)
     +
     +void wait_for_pager(void)
     +{
    ++	if (old_fd1 == -1)
    ++		return;
    ++
     +	finish_pager();
     +	sigchain_pop_common();
     +	unsetenv("GIT_PAGER_IN_USE");
4:  6bc52a5543 ! 4:  6f4990c0d4 add-patch: render hunks through the pager
    @@ Commit message
         this limit.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## add-patch.c ##
     @@
    @@ t/t3701-add-interactive.sh: test_expect_success 'print again the hunk' '
     +	test_when_finished "rm -f huge_file; git reset" &&
     +	printf "\n%2500000s" Y >huge_file &&
     +	git add -N huge_file &&
    -+	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
    ++	test_write_lines P q | (
    ++		GIT_PAGER="head -n 1" &&
    ++		export GIT_PAGER &&
    ++		test_terminal git add -p
    ++	)
     +'
     +
      test_expect_success 'split hunk "add -p (edit)"' '
5:  b7637a9f21 < -:  ---------- t3701: avoid one-shot export for shell functions
6:  4b53ff8c0e < -:  ---------- pager: make wait_for_pager a no-op for "cat"

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
-- 
2.46.0.rc0.4.g6f4990c0d4
