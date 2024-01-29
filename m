Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2B64CF0
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534887; cv=none; b=LaqjfATiOm51amswd3+IoCxCJGIkoghEwJ6SsSKVZaq6tZaAJTxeqpUcOs8ezqDqtW0jV/nSXcloKGqlz7sSIwEFUPTeCj+lWclbL9RWa1MknEKm6fwayVSOjKQt5moEpEK09T4dvtHdjBOp/LsjWCYaeWd4qbeM6SoHLsVwT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534887; c=relaxed/simple;
	bh=jmQ+WN23EkkVM9iQqj6WHXWw4/sPATitjK9mJUMfx9w=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q9r3Z/NkOYxYDEn9Brb0d+Hq4Oi/7jzBW/1YPBgNRQnQL+D5XJTm7rWfmjWC6AxHzH3cWibOd0ALrtfN4hxIdmfAkpDn6fu30NUarlAACD0dAF1LecmbVKx0g9CkoJSmKHH6zg7lqHHLsWqjPNrvLLuzbSo1msH/SGQKDeOYy0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM17VU4S; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM17VU4S"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5110ef21c76so1621198e87.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534884; x=1707139684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg2LOnSM8N8SirdtORIo8kfxEcqU8PjKgYdzleHCPlQ=;
        b=HM17VU4SNclStz31aBEBYt0CnTwX+n4FAoMF/bGlzOcztmUIMkbf/oj1wpDTe40lOx
         4WB3uPnjXLHvllNyWK1tcREvzMk1hMuGdt3KE0cdK/n4vH1UTsCifDqFcEFMLBzK/2vA
         RyTPnV9bpUt5BfFTH+svS6NDc8i3suOXSbHCxFbtE0HTmSE+sVz0IA7+AEmTD936wXPR
         j6oHqbdi+K0kpMlHxpKkQqjTddz1zjlvnn08DFDb+Wogb2IV8QFtdTmDwvz/UmqW+rZS
         LHBdL0A1Q8ncbr/jU350qMHhVzQtHGpqbzVyqJ0Zh+cO2WhIJRYbMduv5YfQdD7rptQ4
         0kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534884; x=1707139684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg2LOnSM8N8SirdtORIo8kfxEcqU8PjKgYdzleHCPlQ=;
        b=nSF6RM28Im8kGu1+40Up+pJrZT5JVc5Glsyn8RvYX0j96ERqS1Sh7euOKK/HW1TaB9
         NVun3J0XgFb/CE5QbTk4fkG86sMc1inDOyl7ZdmH90EqJObJE6HDH/QmqYmUXE16D2IQ
         I5vnlRyOC4QW0tm6GNh23LKBxN/w6RRYHoTiuAVhi8TYRZ2MyyCPHtCePs9+YLzsgozv
         5VmKqOfD0XqJ2wP5voiFXaXZ7vNyr2Sjyjs3opveH02Wn28pZcTGLwel2PKGZGr3ZqMh
         EdyL4kAPvEI4tSLalqy1R5aaT8Dg5IWeUQ89bjNCdaXyNqNQWpKFrIRSr8kJ5ZqGCU0i
         VFKw==
X-Gm-Message-State: AOJu0YzUWy9EwS6tn/lyIJ6AgOicT7Dc1dotbX73GDCZUp9AIsNBvEX0
	izRrwtH8GyF0mgeE1t+sUuEry9UP/Oqfc7joQKUD7fce7OzXa47iZA5sGdtd
X-Google-Smtp-Source: AGHT+IFyNKwZQ8usJid3CRC7Q+qljiLsn9DQd/d6vJc1g0b+qtdNDNnni8NO1SThyCYNeWXeFU16Jw==
X-Received: by 2002:a05:6512:2356:b0:510:2582:5591 with SMTP id p22-20020a056512235600b0051025825591mr4374275lfu.25.1706534883468;
        Mon, 29 Jan 2024 05:28:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fa6-20020a05600c518600b0040ee8765901sm8380490wmb.43.2024.01.29.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:28:03 -0800 (PST)
Message-ID: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:27:56 +0000
Subject: [PATCH v2 0/5] completion: remove hardcoded config variable names
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>

Changes since v1:

 * Corrected my email in PATCH 2/5 (sorry for the noise)

v1: This series removes hardcoded config variable names in the
__git_complete_config_variable_name function, partly by adding a new mode to
'git help'. It also adds completion for 'submodule.*' config variables,
which were previously missing.

I think it makes sense to do that in the same series since it's closely
related, and splitting it would result in textual conflicts between both
series if one does not build on top of the other, but I'm open to other
suggestions.

Thanks,

Philippe.

Philippe Blain (5):
  completion: add space after config variable names also in Bash 3
  completion: complete 'submodule.*' config variables
  completion: add and use
    __git_compute_first_level_config_vars_for_section
  builtin/help: add --config-all-for-completion
  completion: add an use
    __git_compute_second_level_config_vars_for_section

 builtin/help.c                         |  7 ++
 contrib/completion/git-completion.bash | 90 +++++++++++++-------------
 t/t9902-completion.sh                  | 21 ++++++
 3 files changed, 74 insertions(+), 44 deletions(-)


base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1660%2Fphil-blain%2Fcompletion-submodule-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1660/phil-blain/completion-submodule-config-v2
Pull-Request: https://github.com/git/git/pull/1660

Range-diff vs v1:

 1:  837d92a6c27 = 1:  837d92a6c27 completion: add space after config variable names also in Bash 3
 2:  2dd3085f8d8 ! 2:  426374ff9b3 completion: complete 'submodule.*' config variables
     @@
       ## Metadata ##
     -Author: Philippe Blain <philippe.blain@canada.ca>
     +Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
          completion: complete 'submodule.*' config variables
 3:  dd9395bda32 = 3:  838aabf2858 completion: add and use __git_compute_first_level_config_vars_for_section
 4:  3e83f21eb4e = 4:  d442a039b27 builtin/help: add --config-all-for-completion
 5:  b41844cd86e = 5:  a2e792c911e completion: add an use __git_compute_second_level_config_vars_for_section

-- 
gitgitgadget
