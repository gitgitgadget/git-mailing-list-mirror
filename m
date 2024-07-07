Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB1BF37
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720353248; cv=none; b=ZcTdFUFwIF/mHp3uz6nixM5U5crK2tYePA8RGbLeSS2dCE6rn8PvMUTZFbntKEBViq15AQmpK03Ik9QxajcoTP4XKQa6A/IUBIuGl9ybaEUCFFt2zuvMTzLJkzSlWf9SPvm8yk1FmQH51IrpnpMy1HADv0bUtiIfCtASEsADo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720353248; c=relaxed/simple;
	bh=PMGAqqgkrPu3J0TWUhGJSk7rGaJnHuxn7StwBzk/Ppg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fHSrIgoA76NePy2nT/6T0Pca7DOyQBLN3kLRJ/uQ07oQCPxR/rQJzXOgwXmufh7YXahybhDBOU/VtwFx29uTQpOZ2kmPpapXuUxNX4f7h1eFMaklhl4Uff33ZBrplQhbW5KyG0YZfxJlqGe8pJ5ab0P8MQfKmMUIjQR2MqCa1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtxJ4gzm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtxJ4gzm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4265ddc879aso7943935e9.0
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720353245; x=1720958045; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMGAqqgkrPu3J0TWUhGJSk7rGaJnHuxn7StwBzk/Ppg=;
        b=RtxJ4gzmzTQ5ZInjWehiY8FWbtSWRRxE9MK+xKTb/QviW9ibnOIv1etLKXntiyUxet
         LeNRnh0+s+4Qc0HsJoZpjPwQTmlL2ZwLANXul9V7wK2orzGwhqF2YxjO1O34xRAfKE/W
         pbr7fybJmVCW/3DMz9+DCtRQ1iSBNLreA+5wLshlVIXCY+BEYK2tdoDdQ1jp8Xqgn3J5
         Jj5cYGI3cIxgZ9cbuEK/TQ23KrWbA5Rh67RuxMpFdnVm0teUJXGEkvP3OPCtXEmRqRj5
         lXJfMew5wQ+1IXYRYnwKOkiBA61ZN+4qXhe3pDIOdpQAfbyWVuFboq2DqtMmRWLAEkjg
         44VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720353245; x=1720958045;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMGAqqgkrPu3J0TWUhGJSk7rGaJnHuxn7StwBzk/Ppg=;
        b=NGm8utsJ37ja5+5EuiFc5061a+LefcE+09pFUDSIhvdB1pOumYU6tjIIGoHU97qauX
         ZQrVM4sNyGXdPe2FMarNLvQ7gHhpAPV6/+j8clCIlsaSIipblPgOzPUbF3bpQHlMf9qs
         5qFAYpjmHVURgkEQyBJguoHLSr4s1OxpE7EAhPOhf9tLlY+0CJr84g/ahCPHNGDSYjQG
         9NpSNTCXFtzfZW9H5hm7+vaywTejeM19sfAe7iK/qTNc/IX2fNRS7kW1inge1gvPv4TQ
         +4ET4OoVmBWbVTGG27F7dqCHYvwcwPZnaaaZmOW/53nObn0c3mURG2HGi6fhQSrHUzdb
         7YpQ==
X-Gm-Message-State: AOJu0YyFEAotLZSbRcvejfL/xCOhQxhm746WzOoXvaoQ41MSJu7r8mic
	zymAMsQKqDK9Ip5jxK0haxvP34S9U20SZGsGeQp/lkZM+5i54qXcbziQOw==
X-Google-Smtp-Source: AGHT+IHkugHWX3m+ED+essG1pQwYpfKsjNwR2+6hieiMCMZ43VIPvNXtHbL/CC14OKpe/pYBfiw5Ig==
X-Received: by 2002:a5d:688e:0:b0:367:9299:46dd with SMTP id ffacd0b85a97d-3679dd29684mr5415868f8f.24.1720353244904;
        Sun, 07 Jul 2024 04:54:04 -0700 (PDT)
Received: from localhost (85-250-79-206.bb.netvision.net.il. [85.250.79.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367898c64c1sm13486519f8f.23.2024.07.07.04.54.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 04:54:04 -0700 (PDT)
Date: Sun, 7 Jul 2024 14:53:50 +0300
From: Doron Behar <doron.behar@gmail.com>
To: git@vger.kernel.org
Subject: Remove your ZSH completion in favor of the completion script
 distributed and maintained by ZSH
Message-ID: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p>
Mail-Followup-To: git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

Today I wanted to use some cool features of the ZSH tab completion
function that ZSH provides[1]. Only after half an hour of trying to
debug why something didn't work for me, I noticed that I'm not even
loading ZSH's git tab completion, but I'm loading the implementation
distributed by Git, which is undoubtedly inferior in terms of features.

ZSH completion is almost always distributed with every distribution of
ZSH, so there is no need for the two projects to maintain two completion
functions for the same program :).

[1]:
https://github.com/zsh-users/zsh/blob/zsh-5.9/Completion/Unix/Command/_git

Doron.
