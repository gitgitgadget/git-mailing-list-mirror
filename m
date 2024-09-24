Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF62F870
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161736; cv=none; b=iebQh9er5H4gl8G5/IMTDH6b2dfIPCFuLT0E9y7Wf63M7RKE94iV+ONKs9hmFn78ePmaBEAGJiG/3IYqs3HReP5alcai6Sf9vPfCGbWAgs1wOlstsO46COdDj10WD+5x/rRaT5lDubpp0IcTK3Gliex8ZE9jfqGcV4H69zH0roQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161736; c=relaxed/simple;
	bh=mYlg1HZ8b+fjWs1RciTLvenZme7DwMt7O5Co/AD366Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NIM0cWn/YDC9RMLhtnT246xZGIZvx29g1xVp/816pUs0HMquw4UwkYEu9ZaNj06Oom0jxntE/J2ADKiSrx6uA0jnoBsoZ4qU2Zm85yHbcMUOpQMC39Rr/k/650KXNgQuGJ4astwNNXmcsc/9r/Cx+c+FndgVNBUMGmhN2mgnkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggdx/FKP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggdx/FKP"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso5876753e87.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727161732; x=1727766532; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWWOqz04jUpM0+yIkSY9zieYbzwVXC/7NULPOCT5tGQ=;
        b=Ggdx/FKP2lwud8Cj4TUCgZpHXtsI947moPrLNCyDEytvM8flxUKywiLWvhlWZVzLgS
         YRGIsbHkvp/j5J43fWozP/wQW/wU6q5+LWKQubhF0Bp3a9bov7e1AzWI2T9Q+T5Cv1/l
         IUauPdYS4wb6qkr+87FsW8BQAGa9xL/Z5wQnMK1hFC1u/Xdtb/Ovh2WceT2p1m0C2kY7
         UWftWr3Nepq2xkezYDSaW4d9LYZ31o/fcbp5gVocnrTd/dG2RNu8CoL2M+TQ3YoJk88S
         BugyFmywtC0WkxdZLMhNbXGVlLSGX3SZ+B1FheSeQwYO2h4UNFikffPpoR5B5umq//r1
         pHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161732; x=1727766532;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWWOqz04jUpM0+yIkSY9zieYbzwVXC/7NULPOCT5tGQ=;
        b=r4NK9NTac9KAdjnFk0jxRwtoWMbteMxn7RgzhLuNzZsvLjMtv9b9vtUdaxkMigO4xU
         zGvjpwCEbeOmT/5P9BHxiFQ/8tYijZpfKBGwFNYTMa1JPfZSss5Ka8RUTfrk27cp2qpU
         L+yiikUJL6vGFGIjN1uwgoiQCfraaHmteZYyJO8Bl27tvn0Ibr14vflxZo/2EMsbuJ7z
         dL4T3/ww9f4G+k6tV1CY22Mxn/T2MYaiY2XCfSmWRpS+XtLB1tZHCsRXycb8ZFKO1rh7
         UA3dE/yKLhiM2ybCiDXM/GPWq96s3kwPrPawwb5UVL+q7ANOcZHVZVUANuHD0P7Bo87b
         oB5Q==
X-Gm-Message-State: AOJu0Yx0FXlPHr2l5iWo1X7GE6yK3Utl8ZVcWUbYH458qwj4aAFYM9qN
	N7a/0kW53QXD3cem8/WgH9rWLpUcrnzwSMaiUnFo627pgKEveJz1ElSFpQ==
X-Google-Smtp-Source: AGHT+IF3POgJjLSpMGkLzPlFVD1y4jQ62mIMZxXRC7khsiAZscqfi4X1xNI49NZnWjs02jCXnuDM3g==
X-Received: by 2002:a05:6512:1248:b0:536:a533:c03a with SMTP id 2adb3069b0e04-536ac2e2bddmr6687865e87.17.1727161732075;
        Tue, 24 Sep 2024 00:08:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d78b1sm441748a12.87.2024.09.24.00.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:08:51 -0700 (PDT)
Message-Id: <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 07:08:47 +0000
Subject: [PATCH v5 0/3] doc: introducing synopsis para
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Josh Steadmon <steadmon@google.com>,
    Chris Torek <chris.torek@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

In the continuation of the simplification of manpage editing, the synopsis
processing that was developed for synopsis paragraph style is also applied
to all inline backquoted texts.

Refining the magic regexp took more time than expected, but this one should
really enhance writers'experience. I had to fight a bit more with
asciidoctor, due to discrepancies between version 2.0 on my laptop and the
1.5.6 used by Github actions.

The git-init and git-clone manpages are converted to this new system.

Changes since V1:

 * switch to sed for asciidoc filter and refine the regex for support under
   macOS

Changes since V2:

 * introduce the s macro to freely apply synopsis styling wherever needed,
   without formatting hassle.

Changes since V3:

 * replace s macro by direct processing of literal text at the level of
   output processors.

Changes since V4:

 * used BRE in sed filter
 * rework the processing of three dots

Jean-Noël Avila (3):
  doc: introduce a synopsis typesetting
  doc: update the guidelines to reflect the current formatting rules
  doc: apply synopsis simplification on git-clone and git-init

 Documentation/CodingGuidelines          | 58 +++++++++--------
 Documentation/asciidoc.conf             | 20 ++++++
 Documentation/asciidoctor-extensions.rb | 87 +++++++++++++++++++++++++
 Documentation/git-clone.txt             | 78 +++++++++++-----------
 Documentation/git-init.txt              | 35 +++++-----
 Documentation/urls.txt                  | 26 ++++----
 ci/install-dependencies.sh              |  1 +
 t/t0450-txt-doc-vs-help.sh              | 11 ++--
 8 files changed, 209 insertions(+), 107 deletions(-)


base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1766%2Fjnavila%2Fdoc_synopsis_para-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1766/jnavila/doc_synopsis_para-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1766

Range-diff vs v4:

 1:  c09968d7ccb ! 1:  2946cc80314 doc: introduce a synopsis typesetting
     @@ Documentation/asciidoc.conf: ifdef::backend-xhtml11[]
      +ifdef::backend-docbook[]
      +ifdef::doctype-manpage[]
      +[paradef-default]
     -+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@,\/_^\$]+\.?+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
     ++synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
      +endif::doctype-manpage[]
      +endif::backend-docbook[]
      +
      +ifdef::backend-xhtml11[]
      +[paradef-default]
     -+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@,\/_^\$]+\.?)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
     ++synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
       endif::backend-xhtml11[]
      
       ## Documentation/asciidoctor-extensions.rb ##
 2:  c48649ccd63 = 2:  06b8fff6a57 doc: update the guidelines to reflect the current formatting rules
 3:  719188da711 = 3:  a76998d6443 doc: apply synopsis simplification on git-clone and git-init

-- 
gitgitgadget
