Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C603148317
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886767; cv=none; b=TTeVuy7IWZ0R3OImRgigBuuqig9xmYRPNGdNPTeZuec39exqvSybh+oTbL945etbNGEIRnIPre87zgSkTxZZO3ghVxmK0atEPiyrAIE9QGreHFEyz47HLQ7WVZvvJ+nO7n9biwp46NQhv0qLnUK1SZKrMMZEjhfAI7uTu8Lp7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886767; c=relaxed/simple;
	bh=sipFw1dJc1zbv6tyF/MqIbyJnlnjC/BLxSZ5WN2aGTs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fxqNGpHwR9NlE44V6CEA6OEJO4ZtpBi2N+h5mQFsZ6cH9ANPB5ylx1uHl9UBNOMExI2+dRsUnjVeEGlpxcgTmwOmeEMYcCnVwP03rvMqukh1fPkZvxNXZAL8jX5C8lSItPQ78Dy394OvtG0LsiBnxCn3eQ6m7VvFEOI69aGyKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRyBC33Y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRyBC33Y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so20040125e9.0
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886763; x=1724491563; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=nRyBC33YhUqXSvQwnRHQr08Or3kvzP0iT4KkT+dtGsyF2tJziGmj4XEohpY0QFiYjn
         +T323GKBi//vtHRb7e0BPEeizRkUYXSaENf3AIRfdl6k8Iu5kehRnBI22iGYokuqiG9G
         pbCMSEBld6peKlObCK/Jizim9c0mK/rZbeRJdtU1WB1X3SPaHsiILu9wjf67MbXlasaq
         JjK6aavnqPDYGUAjAViMokTam8b7dPaFa/mYKnexU1ib20pVUwDoej31x6Uy9UsobqZT
         EFaK6w6EYj6BZgcluTcGGF07sjxC9gAWGyc5hyL2tLiF2Mxnfior8jGB4ejYbc0GlHCu
         xHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886763; x=1724491563;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=MTMC51VXa79ZoV3dCjN4DF7Hcb+JRrWd1hR6r58C3kToIZxS8cNYExBIUD+Dqlgv+l
         B0gvv/arkdB1ZqA9Y4vEQ3MlpKTyFoYloku/FYO4UyVv3qaQ0vIlt+c+ONiKvQed7h4Z
         iw9DukTvFqxIXzYeYv42KQGN7z846yyy4f+M5/2xNrocgeRbEWiyXIStVUiIH2LG8qrK
         d69C8INZLjl2qBA6eFkfllhiVM6/oMXkEDwnwkdLe/oS1sLu1qK0ynnpjvBHPS7oqvVO
         DxOXGIDAzJBjMfn4IYfX1vPauy4XVB1AsnOjE27cfjW48NP2M6lMLjBPrvWXP7crSAmh
         vNIg==
X-Gm-Message-State: AOJu0YyVnK6Orz+guGYnhx5GMdd9QhpTSrkvsB6qutkpvhVF4BRqhUWO
	7SIPV04Hk2BswCPqUBnAIfSDK/FmzQpq2MXuepR7yUVJYXLoYLEw/2MpAQ==
X-Google-Smtp-Source: AGHT+IHk/t3c6xlORAIaMIB/QG5YmStoCryfdxaP5oJUNKbu9+Nsm5YACEWd1zq2shHgGfKpIw3cmw==
X-Received: by 2002:a05:600c:1897:b0:42a:a6aa:4135 with SMTP id 5b1f17b1804b1-42aa6aa45f2mr24732695e9.20.1723886762962;
        Sat, 17 Aug 2024 02:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6586c4sm45112555e9.24.2024.08.17.02.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:02 -0700 (PDT)
Message-Id: <9ce5ddadf0bb13229461d67451094a373348771e.1723886760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:53 +0000
Subject: [PATCH v3 1/8] git-prompt: use here-doc instead of here-string
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
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

