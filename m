Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603B1B4257
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914419; cv=none; b=i26CvakrW8vynSy8u5FlNyj+jdk5HlgRsbfE1ZYpoJ7MMTA0QsSoPpH450OheC7z6+6ctPIGa4XsutyugkFELOSMDUCmgdS+msbhcINOrNQk7eIdSQ/WvzQWRsmQpLcG4l0Efsww3CINTsB2gP1X9pEqqrQ09gIPL8EULh82Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914419; c=relaxed/simple;
	bh=HaJ4JcbEhLxmMFoDHrZhgrNoJ3vzABI6b9FOxtO3iJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KOVY3gcgQzCURZGjimMXooAih2dOUOfR9mpX6vxJL6ssGsXJ90pblxmG+OYk3AF1IqujW+mCP+irwGug6o7Hc7QdTrSLjZUuupXU2X1uDEL76W2oBEtSD+dqS0OVy14hjjOIA5GMOeQhXal6Dadw9tGppsQABv/1zoZDHvYb9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkQ3eizL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkQ3eizL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a51481a598so1934097f8f.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914415; x=1752519215; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqDZ0wf9fncq0amelGhfsdDnKvlaDzOdS3s/s40yok8=;
        b=BkQ3eizLroT0GUlISah5bltxdiMDah3OiE0yia7xMFt5u2IAy1bfK0lNBpoMkZvWYU
         KMO6JsWQuRat/7bhrv4Zi4NP6KMIjI4f4hE0knKv7FwUJI+Iee9KbF0mp+Kbkz3FtV+Z
         TWcLerOHF2xsxdKA81n1I5wi72jZHu1qTKC37q2mcIBtQZKuWIgx95wAEeztaBzFoAOM
         E68aigc/Uax9ffwWYxdQFP25wX8bdevrMFHccSMaMP62lRsLgSGR/Jx7vwy+iimM+37W
         VvH/bZtHRrscKjJU4T60hg59aqQsBd9bOrBx6CpMr7laKvGpiyQFA3/HP7lJrb4OQjsm
         WAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914415; x=1752519215;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqDZ0wf9fncq0amelGhfsdDnKvlaDzOdS3s/s40yok8=;
        b=tVfVl0AvN/CO15QfQ7q1nXrrxqPEKCg1vFFGyjlQgtfuXZNbc3Ptdwhz6mTrdu8Aqw
         ca+BAUXmgQdTg1mVtJLzA2TxVouA3AyCELyC63abPykwDmtYjOV6nLG8GEgZZv9qPpk8
         /GiIzd8x9zCb9l1W6vo+dy14MSW9cIc0M5zEynNRyaZ+hmJfq4ML7gXBHM/hxXzGBG1P
         gU59iUKQtfoDYaYzgWyo+MgwQZadByO4jVaccrZsGV2M3UMLKQ39df6+H9R1oycDnk0t
         28oMYWqBH7QFZw0TpexE02RgyNoq6TGQEX9gVB5HmRdyTk0K/9rxSLjiU7v0CA9gsulw
         zjdw==
X-Gm-Message-State: AOJu0YwARVFUY33/gGQ4bsF/W6mgFRAh2WMRuUMBZ9gXjUx48vhp7Pwk
	lxOTOp6yMHuWLCwzi1vfZ5IIwP0hlckvbbhmlCnRsQxtrRO2dfJMEU3u9XJAwA==
X-Gm-Gg: ASbGncvqhTXvGGMITpWqCEvuu4MOaJotH6fhQE80zzHOgP1zphYyt5z3YKvUmMqXdqn
	pcfbG8r2cCkkhwHeU09S0UXdmfQb+wGTRsnl2ByInWGKiKJ5l+AAf9fWAiRuSTPHfIFoO3iPCbw
	f4tcJx6o5daVfW9vvJV97W6yhZV3xyp2Uc91K32whBgQOHuz228H13ZIQWN+Wl5nNuIVQQ/eDmB
	rnDACqwQZAPuEXcBdlEUKkLEl+i6805s95yg0oPx8nCkfo823ythJZsNP7BcgvYc4vBUafCNyUh
	QWu90OgHHHj1FHzW+Cc6pany17rptbnpRm3gLV2MSAfl3+8PKEneOCh8kschzYE=
X-Google-Smtp-Source: AGHT+IGy2c45YADILHvNtR74wna28wV/SyfFlJT+72Tkz2eD99xL5W/g1LujAA3ZH4RWIeN37HuG0A==
X-Received: by 2002:a05:6000:24c8:b0:3a5:1c70:5677 with SMTP id ffacd0b85a97d-3b497011a0amr11156309f8f.7.1751914414833;
        Mon, 07 Jul 2025 11:53:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472259842sm11044796f8f.72.2025.07.07.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:34 -0700 (PDT)
Message-Id: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:23 +0000
Subject: [PATCH v3 0/9] doc: convert git log man page to new synopsis format
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This series converts the man page of git log to the synopsis format style.
Git log is the second largest manpage after git config, which makes the
changes quite large.

A special note about the log format description which required escaping the
synopsis processing of parentheses.

Changes since V1:

 * rework the grammar style when refering to plural placeholders . The text
   is more descriptive and does not rely on puns. Puns may be difficult to
   understand and to translate.
 * change commit message to reflect the conversion of inline description of
   several option to a list.

Jean-Noël Avila (9):
  doc: convert git-log to new documentation format
  doc: git-log convert rev-list-description  to new doc format
  doc: git-log: convert line range options to new doc format
  doc: git-log: convert line range format to new doc format
  doc: git-log: convert rev list options to new doc format
  doc: git-log: convert pretty options to new doc format
  doc: git-log: convert pretty formats to new doc format
  doc: git-log: convert diff options to new doc format
  doc: git-log: convert log config to new doc format

 Documentation/asciidoc.conf.in             |   2 +-
 Documentation/asciidoctor-extensions.rb.in |   4 +-
 Documentation/config/log.adoc              |  47 +--
 Documentation/diff-options.adoc            |  40 ++-
 Documentation/git-log.adoc                 |  86 ++---
 Documentation/line-range-format.adoc       |  26 +-
 Documentation/line-range-options.adoc      |  10 +-
 Documentation/pretty-formats.adoc          | 283 +++++++--------
 Documentation/pretty-options.adoc          |  71 ++--
 Documentation/rev-list-description.adoc    |   6 +-
 Documentation/rev-list-options.adoc        | 390 ++++++++++-----------
 11 files changed, 493 insertions(+), 472 deletions(-)


base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1933%2Fjnavila%2Fdoc_git_log-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1933/jnavila/doc_git_log-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1933

Range-diff vs v2:

  1:  f2b69588195 =  1:  10ea4ad1cbe doc: convert git-log to new documentation format
  2:  1f6c951726b =  2:  9b52a62204c doc: git-log convert rev-list-description  to new doc format
  3:  7bab515e136 =  3:  b0b229082ce doc: git-log: convert line range options to new doc format
  4:  384a7d23563 =  4:  a4ac3ea5306 doc: git-log: convert line range format to new doc format
  5:  c2e857105d4 =  5:  1eb897ee9ad doc: git-log: convert rev list options to new doc format
  6:  01835272c2e !  6:  b860561069d doc: git-log: convert pretty options to new doc format
     @@ Documentation/pretty-options.adoc
       +
       See the "PRETTY FORMATS" section for some additional details for each
      -format.  When '=<format>' part is omitted, it defaults to 'medium'.
     -+format.  When `=<format>` part is omitted, it defaults to `medium.
     ++format.  When `=<format>` part is omitted, it defaults to `medium`.
       +
      -Note: you can specify the default pretty format in the repository
      +NOTE: you can specify the default pretty format in the repository
  7:  d5490f7d868 =  7:  0d461544c9d doc: git-log: convert pretty formats to new doc format
  8:  c2346eb580c =  8:  207fc49a201 doc: git-log: convert diff options to new doc format
  9:  b12b8294b86 =  9:  b51d3621964 doc: git-log: convert log config to new doc format

-- 
gitgitgadget
