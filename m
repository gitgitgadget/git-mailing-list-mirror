Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291913DDC6
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762314; cv=none; b=RfMVcBCELitMjsBqjDND/ve+BQzmPOWwQRS72DndCb9amDhRjHF5CBivguV7tMMeF765HpYn5NN7Fj1nP9m/HGSt7LpgZ7V4ajSuow/LALZvgD2XDVV985R/PD/OyR54BzAo8Uni9VnsPA1NaAsOogwiwYIs0LAQTzzwEsgJXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762314; c=relaxed/simple;
	bh=ojdFj7S60jmoC+C2m8pZbW+czfbmTXiMY6jQCTm6I0Q=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cBQvQlXNvIi45XFogXWQF5Z+5ZZHy0pGJnvxmsEUR7nT+Xoo5OlA4FrTxfwssevJ33Qemzxl3oKRi5btMbbwz4AMdI6/1JZkJ8FAwY13Vx+k0UGZL6M+uJhJW7EjuPfvHtTobGBnxTGi8c3GnNX0UKdWjZjJNjT+RuGYHvPdcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYfLMQzY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYfLMQzY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so116853266b.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762309; x=1722367109; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5jdOmHNq3gqNy5Z30oDfmSBLLts+s59Ti0GSyiBwW+I=;
        b=jYfLMQzYL/d6QNvJ1xcMJsOScEt1sQ+PoqPmhW2dlmZ0sFSasevk8mm+EDfb0y/urn
         0WHSNV4xabwa23k8pc09BYztzQw0a7GyBnwNhUWBM0PxeH0HUaxWckIog/LMpfq062q2
         88jZiGHBOlBH6e8cWEU7Y7oux0g3/mOD3oISkbVRRD1dqDUsICtJ2sJSOcWjZkQEjKw3
         5+l7WNizQUkb0WzkViUaa9GXdO1h59n9M7FyXXml50BF0f7JRhC6abGWYRvYQoEyDvoz
         6hh36NFr7ZcKuGfnN7DeWVTeWIY0V5oHh1omA0RI+0vq5f9n4O4wVliV644aOPGUoTor
         to2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762309; x=1722367109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jdOmHNq3gqNy5Z30oDfmSBLLts+s59Ti0GSyiBwW+I=;
        b=HF1Cw+CsggR6t5pit7MGAGE4g+Xs/i7t38Gh6qTnrFuvO7v1auc+LqtgIgafozGSAT
         x6f85W7+8ae/dQhbyjh3m8joeI/rRV5cZGAbqikrI3OTzf96GxmN6F/+cz8zRMnMqcTH
         TeEVMQ+MfdPhGBQ+4RbmWgVJmQP1ZEe3oDeg7ifAWi/HVXnGwF5BkFHLstXD75FWv7ur
         alTkzeFtHLJOvMNTsMrw/x8JWMUr+mpq0MPm72s69yWHS7A75zaFAalIJlrELqVkt4GX
         d/Hm++4P40YZ1QM+Q6yt43BMyO+2seLAkyV0EcxcDOsxLOJTBOm/PlP3P+uoN3yM0yd+
         wBtg==
X-Gm-Message-State: AOJu0YyVKKXKIN/GBrmx1EzJHb9LZKGAK/K8SSWOFlYjotl57IfbvMch
	4VVJV1enlgyClFc8GuK/Z2MQSeJHt2XIyXJMNa2xnl4oRRp/OBC3pLRglw==
X-Google-Smtp-Source: AGHT+IEvmFhfAZRVwvZuEBn6VIY6B9Hx7vKIFe7csI1qIUACLOiZV2Q9p3f5HUxG97cH9uOCeIPanw==
X-Received: by 2002:a17:907:9403:b0:a7a:a33e:47c1 with SMTP id a640c23a62f3a-a7aa33e4d35mr143780866b.69.1721762308933;
        Tue, 23 Jul 2024 12:18:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa5b165c9sm46992266b.210.2024.07.23.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:27 -0700 (PDT)
Message-Id: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:18 +0000
Subject: [PATCH 0/8] git-prompt: support more shells
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
Cc: Avi Halachmi <avihpit@yahoo.com>

Before this patchset only bash and zsh were supported.

After this patchset, the following shells work: bash, zsh, dash (since at
least 0.5.8), free/net bsd sh, busybox-ash, mksh, openbsd sh, pdksh(!),
Schily extended Bourne sh (bosh), yash.

The code should now be almost posix-compliant, with one big exception
("local" variables in functions) which is not simple to fix.

Shells which don't work, likely only due to missing "local": ksh93[u+m],
Schily minimal posix Bourne sh (pbosh), yash-posix-mode.

Most changes are trivial, like changing [[...]] to [...], with one exception
(git-prompt: don't use shell arrays) which changes few lines.

Tested with and without colors, with diversions from upstream, in git-svn
repos, and more, but I'm not considering it full coverage.

 * avih

Avi Halachmi (:avih) (8):
  git-prompt: use here-doc instead of here-string
  git-prompt: fix uninitialized variable
  git-prompt: don't use shell arrays
  git-prompt: replace [[...]] with standard code
  git-prompt: add some missing quotes
  git-prompt: add fallback for shells without $'...'
  git-prompt: ta-da! document usage in other shells
  git-prompt: support custom 0-width PS1 markers

 contrib/completion/git-prompt.sh | 196 +++++++++++++++++++++----------
 1 file changed, 131 insertions(+), 65 deletions(-)


base-commit: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1750%2Favih%2Fprompt-compat-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1750/avih/prompt-compat-v1
Pull-Request: https://github.com/git/git/pull/1750
-- 
gitgitgadget
