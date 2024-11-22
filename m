Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924414D452
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305030; cv=none; b=pJaH9BAYZ/GdOJgXp1MJr70lAjjI15aC8Z8r2M8d0GdPR849f5bAq1pFn0BKUFBuU+ppmkSuhLcQInckOoJaoNhJKm+1s0fNpAlyoJZGsWDWWwN6tEfhd4vaPTZ2htRl1ooJHVti0wFeKappL9UO9CrkisZLKH+uEJN6AIZ6veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305030; c=relaxed/simple;
	bh=n1G7BircBUoK42sbe7P8yVNmu2+ti0UN8DPuRet7fW0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oLpdhVYn030dYzTEYYCP8E27ucw9gabrAl4/6bFSqIlKScB5Ru3XAzm+5Y6hHgJG+7b7cpxQPYxrjGigpvwQyCWt1V9kiGGf6KDm7UsZR6LV8aH1fng4jDfhupyhYMzIPpr8JRBthxQUE1HYLfNgjF2vMOnOQbaWgYb6omaRiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esno/t6j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esno/t6j"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314f38d274so28706055e9.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305027; x=1732909827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY5kvNHgWqSM17OD+FB5pLV910wid+teJHraOEqrut0=;
        b=esno/t6jXeh9dFusRjbZTbwp6OdpIB0NDDggD/XPsMu7BXtLZIq77EBVKPZFpt6ciC
         vtFHPhaxgNswHtzh+L71Ue87z3tXax7NRBVTk8P8y4sg7suojpmnfn8DWgSQRKf6aqMt
         yKxO3eOpduCJxfDdfpvjSBfEmrIbGRJWrJBShOXRXQaqswhHuQ6p3/iIWf4KpTndU5ke
         T7LPiEQMBn1NluAPPPutESzKuRSOd9zccnbDvFj+a6Ot1jviAfMp3LwasVDegHoTEMP9
         F1DYFIfh68LqAbWcsldr2nwUVEkjAd7jb0LRDRMg/+M/2pq0tpSZaDviLlpYCpfLQbpB
         RA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305027; x=1732909827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY5kvNHgWqSM17OD+FB5pLV910wid+teJHraOEqrut0=;
        b=xG2XfHKm0yjh1OIieWO/Z3c2XYo2gT060cR6deQdJ/aWH5fEmtx04hyuu282ER6Ogr
         QqCyQ14kdfEPP07Bb0jSuR6vqkc9CVU/KNEgb+xOvndhUgJzXoH/ruqfEdmL6eusgdO3
         T1u85VMfsd4yVj0ewMBVwBa+DMDYo5Jrf2sKw0W2gslOGQ6gTde7rJhIHqptDEOT32tS
         eAyTBoDPqqJ6nXhudqcw2yh9XLjWojSSVyM/+c3VsxoGxODIEcfWtKDJJT9+Qn3sc15c
         bixj8sQd+NRFS0dvh3jiQhuCKRxVTA1Gzb11JxbNXowAzRZP3xSGTFTcpWDquh3OD0Yh
         8Llg==
X-Gm-Message-State: AOJu0YwKSTkEKwOgwiP14dmx2qJyO+lDV4/HNyneviQeL0FHOgpPojEZ
	yUhEq5xqCxSpultPGd3FoD3u9jbR437NcGHBQ5nrv3PQH0e84Ne5fEmP2Q==
X-Gm-Gg: ASbGncuuGDWFJREPbVUuovWN0vXiSuaYyUgc5+Yi5fFVYO3O2sw3SDn9IchvUKP5D79
	VYD5jBV2gF2UG03c+8lfbbhWiu11f3YbSCVo2qkkCX//xUq4wVsjK9GeyUKxrxewpTzNXK+9BZW
	SvU9K5RLX19HjgzwvDrsYvHpv2aVNYAlF9O9xiudRS+B0gu+8rZNWAmuIqMpVPhS8zG1Waz9dnn
	V/frCrhOwNddZ+5Ce8VM6cpShn+tGJVctChAJCix4OsFABl2Aw=
X-Google-Smtp-Source: AGHT+IHfVUP9nUu8V17gqdUAiYx1qNhI+GvyVVbyTAm0IVnmgNPgJ7l5MEuSlgPUI4OVh9LoR2jkfA==
X-Received: by 2002:a5d:47cd:0:b0:382:4be3:b2bf with SMTP id ffacd0b85a97d-38260bc6bdamr4495724f8f.45.1732305027014;
        Fri, 22 Nov 2024 11:50:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3b4asm3287524f8f.84.2024.11.22.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:50:25 -0800 (PST)
Message-Id: <6f7f553b283078ba3c81190686b150a87d901240.1732305022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Nov 2024 19:50:19 +0000
Subject: [PATCH v2 2/5] git-mergetool--lib.sh: use TOOL_MODE when erroring
 about unknown tool
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In git-mergetool--lib.sh::get_merge_tool_path, we check if the chosen
tool is valid via valid_tool and exit with an error message if not. This
error message mentions "Unknown merge tool", even if the command the
user tried was 'git difftool --tool=unknown'. Use the global 'TOOL_MODE'
variable for a more correct error message.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-mergetool--lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1ff26170ffc..269a60ea44c 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -474,7 +474,7 @@ get_merge_tool_path () {
 	merge_tool="$1"
 	if ! valid_tool "$merge_tool"
 	then
-		echo >&2 "Unknown merge tool $merge_tool"
+		echo >&2 "Unknown $TOOL_MODE tool $merge_tool"
 		exit 1
 	fi
 	if diff_mode
-- 
gitgitgadget

