Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA021487DC
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275339; cv=none; b=l4dKaOuYYJo/l7zl7xl0e3OPRkiPfwGwyV6C2oCNlKor86Ji+ty1MI/8p1dm0viAx2C5+xEVrBKo9/sutp4/3iE9gTY7Ll6Oyi4mS7T89pYqYqmqfRJasZLX71aY7+7rMBNFaQJ749Bw95coVtNaGP1MUV0Dc3BbimgEqxxSvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275339; c=relaxed/simple;
	bh=GCJGsKxxX3NGYUs5q/0QQpSD14cbbeE+CX6DU3GwC/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mCxWJchWHY5KdvDwc79L+LQnGOYTIeoPdrXFFMHXJ+2YROdb0BDfnklTHxuRu7kC8PqMh//30JFvFCTRG7yPqEhNCuBbYGdtEfYtBl56ZILXkASrJ8M41JNu7OzHb6DKRdwkktnW9QlkTA1rMlx69+0ttypRY+N8VFNcCNzgsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLIpBrlD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLIpBrlD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so33299295e9.3
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731275336; x=1731880136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcM2fAoYMq2uMJ+Uaq6QjwY/9wErdxXDZ1t1hspBIuc=;
        b=cLIpBrlDVQ2xzfuv8D49xZv3VcU9aUd+b/LQBVK3d0m0Wwyzd2wtwtKn+DVJi5NKhk
         G4xLOOHfOi5gYjEnqfSedbfkJcetfBtVluOb5gbt6BPfjI88VxK3LtiBNMuSkmVLX2ne
         yWMnFR2uZgRG1VzBtyMWYBk/zi6fgSkGWH2Lsu3Ds8wqm3FMQPXdOCrDSMGLX6lfinvP
         WxCzrmPhEp4MRtIYTXWin9OVJerm7/6bMFvyMHkVeNcp2a1MQSgVzw5hk3TPmK1wCEzO
         1AqsOkvSTlHHuChK+11NNhv2L6prcSDz9XqDCHDU1V3ovq+WaLfoKVmUTlE1JqPu1fQP
         hZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731275336; x=1731880136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcM2fAoYMq2uMJ+Uaq6QjwY/9wErdxXDZ1t1hspBIuc=;
        b=uwNzKoSu/v9tyrT+N7YYOgfKtBJBN7BREaDLKymBomleD/UQRoNHmsyKIwEltFMI0R
         9l4bjHTnzIoL5s7v5SMJwrGaPHvD6BOAxA+EXcL3wLFgpprau/EyA0Y0+Gt73krC2Or0
         Cbfvj6CDmFbJwAcytni+HRYx7DWSLZubRT9L2RCv55qFNlx+df0vAuaGoGIqwQPzh5cM
         lVtuQGvxp51V4RRnyyPNrDOG9QdesypnoGEsgGe6GYQSWdzvLWnUl1Rxr0oatVvShgxJ
         BaAuQ6K+f86te3XlogQxTOG+K51rKt2N8d8wQj7xlt5WNSZh7a/SJ5s/jGC+sDPrtVmC
         8PKA==
X-Forwarded-Encrypted: i=1; AJvYcCWquhYbG6ajKM7N6Z4aLZIdYu4lp+8EtXAkyJqvM/CWUJxFcEvpP/+T7bB/mUI/LaZyBvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nsrA+o1MTLjPIexwm8+HiFWkZvj1S4rLhiCWLDqAsSS1q/RF
	38YD3OTbFWto8biE2LgIKv2zjvLHzcxP6soJlut6a2+fv6ybAPsLbI7Umw==
X-Google-Smtp-Source: AGHT+IHrh8554+VL5f6RHgJ8Lqo17Fk2Ee7Pwvn0rAw8oIv4Rhq2JiYjs/8j2pF5/SpEuJB+rjr04g==
X-Received: by 2002:a5d:6d01:0:b0:37d:4e56:9a2a with SMTP id ffacd0b85a97d-381f1885822mr6802343f8f.40.1731275335471;
        Sun, 10 Nov 2024 13:48:55 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970f68sm11336312f8f.11.2024.11.10.13.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:48:54 -0800 (PST)
Message-ID: <b1cf41c5-ec47-43e2-8a99-3f5faba4d261@gmail.com>
Date: Sun, 10 Nov 2024 22:48:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Memory leak fixes (pt.10, final)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <cover.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:10:14PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this is the last part of my series of memory leak fixes. This series
> goes a bit further than past series:
> 
>   - Patches 1 to 16 plug remaining memory leaks exposed by our test
>     suite.
> 
>   - Patches 17 to 21 remove the last remaining `UNLEAK()` annotations
>     and ultimately remove the macro itself.
> 
>   - Patch 22 works around a bug in the leak sanitizer itself.
> 
>   - Patches 23 and 24 drop annotations where leak-free tests pass with
>     the leak sanitizer.
> 
>   - Patches 25 and 26 unconditionally enable leak checking in all newly
>     added tests and then drop the `TEST_PASSES_SANITIZE_LEAK`
>     annotation.

Hi Patrick.

Thanks for working on this.

It's been a while since 956d2e4639 (tests: add a test mode for SANITIZE=leak,
run it in CI, 2021-09-23).  This series marks certainly another milestone.

I have left a few comments, none of them important.  The series looks
good to me.  Just in case you re-roll, while reading the series I
spotted some nits:

diff --git a/bisect.c b/bisect.c
index 518be70aa3..0e804086cb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -641,7 +641,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
                        else if (previous)
                                result = previous;
                        else
-                               result =  list;
+                               result = list;
                        break;
                }
                previous = cur;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9e069e2742..096f96b9c4 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -248,9 +248,9 @@ int cmd_init_db(int argc,
        }
 
        flags |= INIT_DB_EXIST_OK;
-       ret =  init_db(git_dir, real_git_dir, template_dir, hash_algo,
-                      ref_storage_format, initial_branch,
-                      init_shared_repository, flags);
+       ret = init_db(git_dir, real_git_dir, template_dir, hash_algo,
+                     ref_storage_format, initial_branch,
+                     init_shared_repository, flags);
 
        free(template_dir_to_free);
        free(real_git_dir_to_free);


> 
> So once this series lands, the expectation is that any newly added test
> needs to be leak free by default. We still have an escape hatch in the
> form of the SANITIZE_LEAK prerequisite, but patch authors are expected
> to provide good arguments why their test cannot be made leak free.
> 
> This series is built on top of 8f8d6eee53 (The seventh batch,
> 2024-11-01) with ps/leakfixes-part-9 at c810549be1
> (list-objects-filter-options: work around reported leak on error,
> 2024-11-05) merged into it.
> 
> The series has some trivial conflicts with the removed test annotations
> when merging with `seen`. There are two topics in-flight that introduce
> new memory leaks (ds/path-walk and cc/promisor-remote-capability), both
> of which are fixed by the below patch. I've sent a message in response
> to the individual commits that introduce the leaks.
> 
> Thanks!
> 
> Patrick
