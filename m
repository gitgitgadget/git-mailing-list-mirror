Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3712CD87
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958187; cv=none; b=sZEFNVAeyV+f3N8RQH1KMAUsx2ExH30iWUIU3kbo/2HSQh6V8OcRQ7n1LkKrAZfjtHdHZfBYxpzfUQ8MYgEXDko6+Ch8u7mSKRYMhh0aTdbJPZBF6DI+3dkxAJkkDfqvEgyPVfXemtc8HNN0JIwbHt5nh67SvvoQXIYd6oxMsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958187; c=relaxed/simple;
	bh=bwCxvoepElLQq+oFKOii2UjJqMaDu3f+YNgv/J+5MbY=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CWGEwtE8VQMRuocA5arzr/wxoJ9qvqrHswuJSE5yyyCZvHF94I06f9bSwwfN1/Uh1dE3jMZk0GtsjBdUyjHHcaWdrbThtSGHpQ1vTjhG5oU9D4yub3/1DDzJESiCqoTTsm0wQpEM5k3cSG1AxbjFLl7iIL5CeRWT/kgzJ90DIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4M4xbgj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4M4xbgj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33de6da5565so32058f8f.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708958184; x=1709562984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hxl0zTVibd4e8vSDgQWFJB+Iyv3V4P63s3OhK9D5RE8=;
        b=P4M4xbgjwxA6EgAbg9St7CA5IgkrDWF0bx8uyAyiDUDTRzlzEAUjzw7H5kdW0UkJr6
         wp44pmcCq+H29kBWhTTQn0YGRo9No2E4ydEj59YamilUWYr2uUzO8218m+OArEKTlK7c
         KZLJEvAJHLPS8lhT0GUZZ0ku2fi2jYHdB1Xu49GTalQbdLWCjyDXTIIRGpa13hsuGwH4
         af94d7o4dVEXolvPK3mynK39XEEvS8ZW7iNgLMaL6/vdYYewApGW7+WITPKJikNX7dsC
         HkMlMvoZdcmcwwbpku0utz+PN2tWYc8ZB9sM9CqX+cyW+MHbCUulL08QB5WD8nAkR0VY
         Fsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958184; x=1709562984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxl0zTVibd4e8vSDgQWFJB+Iyv3V4P63s3OhK9D5RE8=;
        b=e0/c6gPgdZU00vNVZVzNrjrf2RBJig9Z+LH77DbGbr+Vlr5fz06S/YypaB6x4roQLb
         t5VgUOa08NbG/5SkFinTDHnf2Ui7EoxAFcTwMy5++KC4Z/B9fwi/ReCgR5NF14xzG4J5
         7WfzH4biIk5hl3BXlH4tY/Y1FSZB1miD3T2hmRHW20u7K6tr1Mvi1Cjr/IQfo1QEbsfp
         C+KRObbDDJXJ0EJF1NvdVwJXHeakpH8zNqhXPawWuw8JeCbXOn65dASLnU84b93pV0Gl
         AS3uKDIFnvw0ygli/Xt2lbGaEC+OzLL/NpbVhDNBCz4JfzZq0UYMtElrQw5d7FajLet+
         f4kA==
X-Gm-Message-State: AOJu0YwTofkBtDiH49I2Ue1LLX3W4tnR2/AK+Cz05EpXSvyAGYLtBnv9
	GqgFVwTroumyQm3MnQPnYkOgZDLRgyeV9Ro+Gj3MkAhenee3k9YTzIvtShWv
X-Google-Smtp-Source: AGHT+IFilr6gf/iFlyyl0UhSnnrMnovH7pckcD/g5oRSD9KV5pYOpxiDu+NmHfj28L+7aYnVv1e1BQ==
X-Received: by 2002:a5d:664d:0:b0:33d:3f21:c38b with SMTP id f13-20020a5d664d000000b0033d3f21c38bmr4687382wrw.25.1708958183932;
        Mon, 26 Feb 2024 06:36:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020adff9ca000000b0033d1b760125sm8545548wrr.92.2024.02.26.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:36:23 -0800 (PST)
Message-ID: <pull.1674.git.1708958183225.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 14:36:23 +0000
Subject: [PATCH] Remove a bogus empty file
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This file has been added as part of 2232a88ab6b (attr: add builtin
objectmode values support, 2023-11-16) and most likely serves no
relevant purpose.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Remove a bogus empty file
    
    I happened to stumble over this today. It is a regression in v2.44.0,
    even if admittedly not a terrible one 😉

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1674%2Fdscho%2Fremove-bogus-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1674/dscho/remove-bogus-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1674

 neue | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 neue

diff --git a/neue b/neue
deleted file mode 100644
index e69de29bb2d..00000000000

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
