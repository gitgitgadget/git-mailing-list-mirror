Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6B19DF74
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727660; cv=none; b=Q9ZJbP6qBVSqRGeWxI9PMbAu79OWKB4rA7GB9Z2zYCHwMX46GG5fJ1EtVgtMkwP+8UeJyNqOQBiMQT8UVt6Cx81hPXIsM5eseguMN5DS3naRpZT83rUknwlzM/Zc02vVtvrMAvmucXaaSJmQHT3ElD1vdqUgmC93INkhjbkvYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727660; c=relaxed/simple;
	bh=sipFw1dJc1zbv6tyF/MqIbyJnlnjC/BLxSZ5WN2aGTs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r2JZ3Q3VE81xNWSCssDQhDSCsga+AujsCZvJ6VwnvrHAMeqGz3hBrgygKZ/jEIPW9VeibFJO3YGboaKJDfzV7rijYohi69YTxwWJB3sdB4ffmixx69LLc5aGgJTs2YriHzcY5D15ueTX0XhsPuCMgn1x9vYi42YUAdp1DglsHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4x4N2IM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4x4N2IM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42816ca782dso6022605e9.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727656; x=1724332456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=M4x4N2IM/BC9HG+0qT9+ydLJuL+vUfek8xPTNnb32HpPzYii49Rk992BPqh70EnOEg
         vjLcZHWNtY85DZDpsCvdZwV6HFofVysHzK5ZrLSAaBtXJg6yRcJLhFmZcWMJLEX5aAaQ
         HPjGUloK+mS2JJy0tN0aLfbu2N8Kl+7VAQcvp1nBgc/FJQtz4+wWC/KxlFri7jRnyOOp
         mriz/9KgaW5st46FO8Af+TklCo36EGl8WDODe3jfkAaHHCWOSDgtG0FVnuSKNFzVV5hN
         9OcAfatIwhp6K3WMdJSXy28Ix1JqNkCzU1GsypfpdnjbFsCTsC5qVeKC2QFFURgrbfYt
         ic+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727656; x=1724332456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=oIPSo5UFuOdLTQ/ERfuGDzHg4CDl/0XtgVhZ67TUmjjxqN3nFxY4lsG+6s6qciFYTE
         0XOBtl+d2VKlleeRdoukxqCHi/ppY/lsJ+qYZwMNIGCv6s1hGkmRpWDTkQUr9pwGMdFE
         aEA6nZZIlLDoIEaJuVAsvixtccPLOwZABtKm/As/PBI5lxZPLN2oIhG9Jq+t9VvFppqr
         sFht1ZXuBrVYHw+SMDw/eeF9RW8ZsVe3oWKB9djk2XTqzAByClIOZr68aBrdJg6LxUqF
         RDIKWg1KimYXqfG8Vrd1CpvTuoymk5AKGmcso2t936/43Y7P407smLlilNRcqz9inNAS
         8dIg==
X-Gm-Message-State: AOJu0YyM8oYtSWBdKzRJh4xnmyFI2gsypVHg5bcAIMwb0cV9Yzwnv1jh
	4oh3t3265ZZ2tyON3mnG/nO+TJhUIg8Kl6JMPWfJK9rKJsjp8RybHT3TRA==
X-Google-Smtp-Source: AGHT+IFjIWNi6YwkXeyswpS3VrlGdpzjoEszcKrHNck4Zb9EuL4nd+eHMrAWNI0dSAeYVMBu4D024A==
X-Received: by 2002:a5d:456d:0:b0:368:3717:10aa with SMTP id ffacd0b85a97d-37177761400mr3684985f8f.11.1723727656029;
        Thu, 15 Aug 2024 06:14:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a57asm1532642f8f.2.2024.08.15.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:15 -0700 (PDT)
Message-Id: <9ce5ddadf0bb13229461d67451094a373348771e.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:06 +0000
Subject: [PATCH v2 1/8] git-prompt: use here-doc instead of here-string
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

Here-documend is standard, and works in all shells.

Both here-string and here-doc add final newline, which is important
in this case, because $output is without final newline, but we do
want "read" to succeed on the last line as well.

Shells which support here-string:
- bash, zsh, mksh, ksh93, yash (non-posix-mode).

shells which don't, and got fixed:
- ash-derivatives (dash, free/net bsd sh, busybox-ash).
- pdksh, openbsd sh.
- All Schily Bourne shell variants.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5330e769a72..ebf2e30d684 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -137,7 +137,9 @@ __git_ps1_show_upstream ()
 			upstream_type=svn+git # default upstream type is SVN if available, else git
 			;;
 		esac
-	done <<< "$output"
+	done <<-OUTPUT
+		$output
+	OUTPUT
 
 	# parse configuration values
 	local option
-- 
gitgitgadget

