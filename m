Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A019E964
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279242; cv=none; b=Nh3K0e6abX5AHuYpW3ulHAzRLAC/WX3BVErAESf+qkOKE0skvuodnopd3wV41VHqilk2051QjJRC2l0SaBhq/c8Jjl6KyBkW5FKTmW5McNLSdPUFOmXxnb5VPPFqvS5psDucpiSyv+u1KPfrZTuSrjBaGYa9MgnAkK2BSbQsBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279242; c=relaxed/simple;
	bh=PJYEIfddQAtq2BkN6B6ybEu0BD3QtdNUBKoO7wZKyDw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FYNugnhlYYL8yf9QbU9HulAdZnyLLp49xjeq+GdkV/FCJ65OxdWMTakthatcG7NZI8o9QxnGs5MATg5iCATuT4wSV+NAmCk4hS3rsf4aBdfpl8TqFQVqpo9UJLcXd+lZfmrMHfk5uFRW2xaa/JFySSOZn+DtVBLDN06HFX/2zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSHAmBLl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSHAmBLl"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a81bd549eso347187966b.3
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279238; x=1725884038; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mswh4cxwq3WB/mJarJM51mk1dwIcMPTrJt9r7G5g2TU=;
        b=VSHAmBLlW8voqnMiz6VjptPDVNmHlstznbGSco5vzuydDplDHR+XchZ/U5xbI+o/uI
         GQTXhOplqcoweWcBShUcjqPCd2eSynbBtzc2+MdLAqhNandiyhCEMF3vOZUCfpudlUTh
         DJtcLV5qMR6UERJ6wMvroEKnH4bys+bnlfL3JumsKnfODvEPJiZ/QUZbKwJCMjGpxzJI
         YlI/X9qwOVyfu4dbJLItJfXxl+BntQJoX8nko1nndhteTFQnF0w4g+W+zxTJNa5w2hnR
         xHV86qCn8kztA7+pEggTmqAef/IQNqm/4VDzx9AjnMA1FH2XFxOLwGD1UFqXTMR4RBK8
         /UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279238; x=1725884038;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mswh4cxwq3WB/mJarJM51mk1dwIcMPTrJt9r7G5g2TU=;
        b=GpNHY9leoqqFkgOy9h5DkEvbFHleV4Hp0Y0tyYTcrDo94QqUDcL+Llp1WPa1R9E+EO
         WrF1Yt3AsjmI/L1uGerx43Essmy0U8xu21JlsU7cjKdq5RZIW7GsjQGRGdwxEEE0kBhN
         ZkHQRmjimoOQel6kA3Cb3vK6S0wtTCD7JN2VeNB1UVosuoY4lYBGKWrlk7JzfoEfENgo
         Jhmp01/fGq1Fhr1zGsIGJVPze02dfhjcu45PVWFzPxmeJU6+NBKx1RFKn2YQFPJVNDWw
         dn4/zYr+wElFrzILXj1QGK9+Zbi7OrPCfFbQKnHTauAuw6XE7taQJ3HBbCkb12EupzOx
         nt6Q==
X-Gm-Message-State: AOJu0YxJvrMn/IWu0zkYHfN1HJcWkrQF7AxqXu5GvxUJ+/JuZmarQ7xW
	i6bwh8Rn8j5QKPyMGqRuVhxlkkgYWspmotKUy2/KpkVwVXDTP9oECuk9XA==
X-Google-Smtp-Source: AGHT+IFAAWLyD54KwTjUgVBnwpE6mO5BP8jSQTrvkc131XKzA1BT79Bb0FkvSc/0xPU0a+tVZoXpvg==
X-Received: by 2002:a17:906:6a20:b0:a86:7f9f:9222 with SMTP id a640c23a62f3a-a897fad296amr976658566b.67.1725279237937;
        Mon, 02 Sep 2024 05:13:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989215cb5sm549073066b.191.2024.09.02.05.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:13:57 -0700 (PDT)
Message-Id: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Sep 2024 12:13:52 +0000
Subject: [PATCH 0/4] Support server option from configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    blanet <bupt_xingxin@163.com>

Currently, server options for Git protocol v2 can only be specified via the
command line option "--server-option ", which is inconvenient for users who
want to specify a list of default options.

This patch series introduces a new multi-valued configuration,
fetch.serverOption, to specify default server options. Designed similarly to
push.pushOption:

 1. Server options set in lower-priority configuration files (e.g.,
    /etc/gitconfig or $HOME/.gitconfig) can be overridden or unset in more
    specific repository configurations using an empty string.
 2. Command-line specified server options take precedence over those from
    the configuration.

All commands involving server options, including git-fetch, git-clone,
git-ls-remote, and git-pull, have been updated to recognize the new
configuration.

Xing Xin (4):
  transport: add parse_transport_option() method
  builtin/fetch.c: add fetch.serverOption configuration
  builtin/clone.c: recognize fetch.serverOption configuration
  builtin/ls-remote.c: recognize fetch.serverOption configuration

 Documentation/config/fetch.txt  | 29 ++++++++++
 Documentation/fetch-options.txt |  3 ++
 Documentation/git-clone.txt     |  3 ++
 Documentation/git-ls-remote.txt |  3 ++
 builtin/clone.c                 | 22 +++++---
 builtin/fetch.c                 | 31 ++++++++---
 builtin/ls-remote.c             | 32 ++++++++++--
 builtin/push.c                  |  6 +--
 t/t5702-protocol-v2.sh          | 93 ++++++++++++++++++++++++++++-----
 transport.c                     |  8 +++
 transport.h                     |  3 ++
 11 files changed, 196 insertions(+), 37 deletions(-)


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1776%2Fblanet%2Fxx%2Fadd-server-option-from-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1776/blanet/xx/add-server-option-from-config-v1
Pull-Request: https://github.com/git/git/pull/1776
-- 
gitgitgadget
