Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484191B7E1
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273514; cv=none; b=Y1rtLJ1/Y2d4RrlRwuY/fdzy3yyzMfG5thWXH51s9b6ANQZ48h3RMl9lOZGGLM+WKoyupd9CC61pLcon8V3PbX7Eo9hkjvMof5EJRX0h5dYNIV23yQUTbVBEZwShX8iOKwJXJyiJjCt28ZjqDq8nYhulC7J7vRAtobm9pSlFdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273514; c=relaxed/simple;
	bh=ZVMrJhmZ0iYeqX5s7/hJ+FD0EcG+m3KajBAqHIMbnLQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dzVXBPp0s1vQGMLm7QagILwc+8KWLIQr3cfBdAxPzhEA8pRgmwqCiruDBfzklqGcxpzhZk04r6DbDixczsXNaG1KHUKW/H0Pshgve7M4ZWu1/dwB+vzQ3AuQSrVGmmPdTbRdo0tu7j0b76sNxTUhUrA708LxNdcSJ70n0WmQrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxTM2vgW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxTM2vgW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so413857f8f.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273511; x=1706878311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Elvlj4iHgS5wE1do01iMZrviPd+cSNw5eRLk064PUQ=;
        b=BxTM2vgWx5TeLhJLW3oLIU3x4DOyPvE2mwI1Bp+ingXhbpb9v9i84lM1sVVb0rNKik
         9Yz3peRh6Ttv/MMw+9NFPasE5xRMJ1qaehztyI+JSC92YXptXW9WVMKLweepmgCcUYNs
         ZeS9svI3yvdGL5DP26WTwPJD9XMYuxijp9DMmj7FUY3UV3ovmtsEk3mn1ZUXiqig7uU7
         q+XpVwz7Qx5eGSoEJ4nEYN2bGP6iAJih6JvmETYdxBZkYwb6XeVIPrmi/CZR5oi5bTum
         D4sxybfRoJR/7RRhCY7GUPC/nW70PAOVTErVQghWyevzb24txuPDWSNScjhi92DHdERk
         JZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273511; x=1706878311;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Elvlj4iHgS5wE1do01iMZrviPd+cSNw5eRLk064PUQ=;
        b=DrLMIlvj8NU03/OZBvxOZt2UWEuLnkuGr3JztADqygrz/zSDBe1IZX//BaYYNvblOp
         1ZzJzFQwUP/Mgxza9HGIbZrLwakXtS+DqfUkSCR6v6olSMOhkKdAWEv4+p+GsxpzGmR9
         FrqFYsE/6/2wKPm3rX0/VXoKgg0b2cJq6HQ7EAFOU6/soxOFit+XZLJ2Y+iv+nj0/ZGu
         dIZ7Nz3j7iOhOOLoDdmF1U8ZKti42Oq8nTpSH4isFPWMTRjgt/EollBj35+HfSc8CmAK
         u5YOsAuFg9AsX53it8EmsfyTZXnL33aYVVFesqXy/M77VfKj8SAk/17KOqMRdRbTw/g3
         wVvg==
X-Gm-Message-State: AOJu0YyOv6WO5Vex1rxwxjteNpna56FtG4v+PoZ0Y6peaBVi1ditS29Z
	WLvmgEKvZ/ms6nT0tGYODw2mq5eLHD+CwNfHXAG8AHQPnYKtwAtYs+OPvu3o
X-Google-Smtp-Source: AGHT+IGr/0OnUxAjBrVZj79GpmYNqWis6NE7Ut0hk004hpx2bW1vJeUURmh+YMEWIAUoBi5xU6Th+g==
X-Received: by 2002:a5d:526a:0:b0:33a:d1c2:2f77 with SMTP id l10-20020a5d526a000000b0033ad1c22f77mr789998wrc.132.1706273511348;
        Fri, 26 Jan 2024 04:51:51 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b003392ae3aee8sm1207551wrq.97.2024.01.26.04.51.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 04:51:51 -0800 (PST)
Message-ID: <221f88b9-fc91-479f-8d08-f530796e2d13@gmail.com>
Date: Fri, 26 Jan 2024 13:51:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] completion: introduce __git_find_subcommand
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
In-Reply-To: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's have a function to get the current subcommand when completing
commands that follow the syntax:

    git <command> <subcommand>

As a convenience, let's allow an optional "default subcommand" to be
returned if none is found.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 916e137021..5f2e904b56 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -575,6 +575,26 @@ __gitcomp_subcommand ()
 	fi
 }
 
+# Find the current subcommand for commands that follow the syntax:
+#
+#    git <command> <subcommand>
+#
+# 1: List of possible subcommands.
+# 2: Optional subcommand to return when none is found.
+__git_find_subcommand ()
+{
+	local subcommand subcommands="$1" default_subcommand="$2"
+
+	for subcommand in $subcommands; do
+		if [ "$subcommand" = "${words[__git_cmd_idx+1]}" ]; then
+			echo $subcommand
+			return
+		fi
+	done
+
+	echo $default_subcommand
+}
+
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
-- 
2.43.0

