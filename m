Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8D13D504
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762313; cv=none; b=bBXVba65RinKE2GI1tYZMYEcPwR0zwjveLEEXsQ+qaca6ddo4Wn0wbaedgf7TQAgiYuc0u06xdfSvXoZ6Y1WfixRiMZno3bfpQo67Lp1nc/LVlkG9HawuRk0Ef2VjJL7DYArcahqG/QU+un7Nyt0D6iavX3MAA8jTTuw/mk5KK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762313; c=relaxed/simple;
	bh=sipFw1dJc1zbv6tyF/MqIbyJnlnjC/BLxSZ5WN2aGTs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QT8luX0HcSouJKFSfEz1tPn9Itr49KFmFOm7MUPb5uwPgj4DHVn56T/3oveD+5sPRa9PUEgYjE/NrZiWFEGpEH/psYVCmnXZYqU1cAPxIBII/bx2T1WF3DPbh5Zo+johxw5wBCNboA9UgmjN+M7CYWdAuK6l4jvSFIYmz9QCf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeHsCvag; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeHsCvag"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a79fe8e6282so25363866b.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762310; x=1722367110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=KeHsCvagtTKaySFXOp/r61oqpzFK/toNXXKiJpDKqYtRnme5p7Dpm6w3tE6jNI5I3n
         s/cjXXMRTJKAcm9KzOMK9BkyMbORYeDDNoEGsOTn3KmT+vynLKssEzm/KhwPcJZ3CdQW
         dBrLyRpK2m7NL2tCxISmF3TspwQ++8cjcNos3QmNc3EfrCHwo90o9G13d9+HUbUDQ+ia
         yGMpP0NzNdcYsBCB+K6mjEkhQBgZty+6hmGA/0IpbG7q48iO07+Iy0QKNOELl18dwCGg
         1jRdMxRBIc7vHBqy0ckMUj1ZhWHhcaVfFHyFUUFd3binURHW+fsykEeACgiJ8RfNDNY1
         ccFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762310; x=1722367110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=X/SfIiPZuajmoccGVxqZPmJ1cauZRoWziPw7Oot3k/lkpi2fPiF+sFGZwuAKLiw8HO
         VbLZnWJ8F5NMI09m32FODX2j0iOTFF+eX5E3YnMwoGdxMd0XpWg4/omyfN8l+uRuq5e2
         HzAnII9eXI9MIrfE6cRRfMhW57mX75Q1JewG1VSTjiDO5lwCOiHF+qFWpWaOchE4lxcX
         +njKGuqtmAPP9pjsRQ7LglSQQeLwVpufqRO/soYWj7gKahlmRadbkE7JhgNcnRxukS1i
         u6LFVtip7SadcwmRoe4RDyJKaK8RBGoa/zK4eUh1Crq0xxBJJ3Emd0yT7+mdkuP7y/Zn
         pARQ==
X-Gm-Message-State: AOJu0Yz51Sf09A3Aoktf6cRCCFqPymdcRuTgSZKstsb76rixHdEpqAOT
	uRvDn/9spFECEb+xCN36QEAxcLjmzp8dYgaSVRqAbhbNuUQWwpz88J5LHw==
X-Google-Smtp-Source: AGHT+IH+TLo5GcyWN/0gwX6gSBqdDraRISu6/R4J87w8ALklwn3tFMvUOa9ii6F6feghE/qGyC3RWQ==
X-Received: by 2002:a17:907:3e1a:b0:a6f:53f9:7974 with SMTP id a640c23a62f3a-a7a4c43d240mr833482566b.52.1721762309790;
        Tue, 23 Jul 2024 12:18:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c91e052sm567199166b.153.2024.07.23.12.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:29 -0700 (PDT)
Message-Id: <9ce5ddadf0bb13229461d67451094a373348771e.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:19 +0000
Subject: [PATCH 1/8] git-prompt: use here-doc instead of here-string
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
Cc: Avi Halachmi <avihpit@yahoo.com>,
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

