Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA013E8AF
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822227; cv=none; b=kp2MhfG/7xaRiHiR2mhitaJ6MBfxvahtFEbs2pauisMJPAgrqLEWKd0LbFtylROPCUs99pm+do5E39rmhziSAZSxsYGhqBhtv63dEGFFmOGwrcqyq7b4FdPFxNxJMyxtYtozrQORPihMS7CT2T2/XhnUvXZQnbuRNS2tDJjXc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822227; c=relaxed/simple;
	bh=Z7a5wNA5uGRPzO6GQa8qKJ2hl/FIt5HpCD9TeArzVmg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=fFfXYn7jFK3cyMl4HDfz0VJN7ikNlEu87AFDuW+B7n3Z3q86Rai0k5VhHjmAttL4to8LSy+4wTF0Ta/X+lHfkzaXvUk5pUGvPC3kh90epkbiWJlG4LU5xNn9Qc941zQ1zG+mRVtcBs8I1cAtpRwRaZU+evlWNw8WN8d0Ghu0LPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc1ULbmp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc1ULbmp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346406a5fb9so1740601f8f.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712822223; x=1713427023; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv649HuwmE5PbEV4ELBDJyuR7L3S5Oq1U+rIurqQehg=;
        b=Wc1ULbmpOReVBohaLC3YFLIamA/K2XRHBMZ2oqHx+xBHdCX1CSE1qknjqICuviwcks
         ZL04XYB7vre59XQzP81CXReKRHYS1h/DczEm6rLI6d1sT7X6TET9bywLOGFb2GwHnlOI
         YYHDfhYk5HEG8hqDFasFk1/VJuED9IB/BXJ5zKVkcnVCIGwN84puUPudPvhyMVt7N2Iu
         Zzxo3hZMV1JKx7/+PXbYUPLUVHQ6k/gjIkWfzTvlCkztJRZr+rcTsUiFXsIyEnRKNPS/
         iP30P4xjnMoSAJrGAKeJewTCkQf1TaLAqeyMdBAJdq8Xj+omMpqCQFLx7JnzKjCm0M85
         ra8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712822223; x=1713427023;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv649HuwmE5PbEV4ELBDJyuR7L3S5Oq1U+rIurqQehg=;
        b=FxQMNQDW3gQN6U8Xu1b84J8NYf6stVzY61qRqB3l3EvwnYjb3X4BciS0D33xGqqYci
         m7necOyFz89IIKUAzMYETmMeVniHqoxqzy17d2314sVtpt03SBFEP9FQP8xfQPHllxw9
         gqIAj9lAmhqA5n3HuyhTdyFSGxnjvMXJ9lm05MRqC2BxA9cyIkM9jVmt/jpKIPCgpEqP
         6ioGZXKpm2R4b50tooKSpMoGl0R17KJRxBW9863fEdaEApuyAepPJkKd42gG0bUTx/dH
         I6tDkdFbIrA8pWGWPNGYlUp/zhGwJiB2JQV1UzFFyEM9XTfkiEqsPAF6B89SlydkY8BT
         5fIg==
X-Gm-Message-State: AOJu0YwLqgZVgIT/Ty8MgEiw8vh7PTQhDz+IZ9N2pAKyKuKOasMX6fzF
	n2EP/tORZuo2r6tXjCW2spY/9jOsryK57Gd6wlyftMXXgyE70X+ZmxpHBQ==
X-Google-Smtp-Source: AGHT+IFw43rnaeWUQcMO/jVEIz81ROQaO1L4JqGtwfnIomy3JfmYbTfXEpebDIa/UmeMkBo5BLJUDQ==
X-Received: by 2002:adf:e944:0:b0:341:8c29:20c6 with SMTP id m4-20020adfe944000000b003418c2920c6mr3508368wrn.50.1712822223031;
        Thu, 11 Apr 2024 00:57:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19-20020a5d6e53000000b0034349225fbcsm1127697wrz.114.2024.04.11.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:57:02 -0700 (PDT)
Message-Id: <pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
In-Reply-To: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 07:56:59 +0000
Subject: [PATCH v2 0/2] Fix the inconsistency in the description of the namespace option's parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?= <ttdlyu@163.com>

Since the parameter of the --namespace option can contain path separators \
and can be correctly parsed, I believe that --namespace=<name> in the
SYNOPSIS section should be changed to --namespace=<path> to match the
description in the OPTIONS section.

秃头灯笼鱼 (2):
  doc: git.txt-Fix inconsistency param description
  doc: git.txt-Change "--user-formats" to "--user-interfaces"

 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 5216f8f5c4089ec29ce49afa147434c23e0f0163
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1669%2Fttdly%2Fdoc%2Fgit.txt-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1669/ttdly/doc/git.txt-v2
Pull-Request: https://github.com/git/git/pull/1669

Range-diff vs v1:

 1:  28a5625f32c = 1:  28a5625f32c doc: git.txt-Fix inconsistency param description
 -:  ----------- > 2:  af548abd004 doc: git.txt-Change "--user-formats" to "--user-interfaces"

-- 
gitgitgadget
