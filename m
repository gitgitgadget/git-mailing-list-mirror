Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6E27E1D7
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223714; cv=none; b=sUnpgJYmVgWh+hJsVCYsizdYjD20lKKMIq5WEnnc/u4dxRnZ7fwuFNwQqPfOXB9UbHO8OQbosoh14+UatDZYggnmsge3VVwpQoQf9abtsJ2NS5Sd2cTQ4XSJA7P3M6VDILzCBtSXL6aVGM0iRsPiOGmY6YlKQFhA8urGCnuRlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223714; c=relaxed/simple;
	bh=n2kMd1FI+A6sQCiEWpWQPLKLFcht0xNS5FBHMJof+bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ul7kPSMdeSLaNktlPHRa7Qf/2IiefjiRtH41B0eQNzSHMhWHHYbSTvXx4Xn+GKc/SGa6dxaZewXVJakcDPACbmC6imf0ZS9SNbqqt2whajSgtumUNw4HqbsBwM8XxRpDqZGI64VpcqP0dzeqFUg3ogMZGbphHuFdkaw4HsDiMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEW7Xql1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEW7Xql1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42966ce6dbdso545219f8f.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761223711; x=1761828511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUDiK0EMkDjsHS0j/U8+4VgESEVxbvtfLePXxKWsYME=;
        b=KEW7Xql1xFnX12eZnrKzostz7s5/8P+S2uMPBr6N5R+w+oIofCcPHlBfGwS1GOnkJw
         jAt1fPSSWDgGq5caHv/uTevLRm/yThAvOrJ8G7dJ7R5b0jEwH2mZxbcrkbMlaig/YjnI
         IIhnaE/CZsu+a6J0i6eYjPro/iv/MAKU2pbCDkSNM6uZ6SWc++llNr/9pq8dwC01P1KU
         kF8nmu50oGaFdVgms9wYU7J+b+Z8c42jVghr11FKJDMmRNOCaJbstMf1DO2y39dYRA+v
         a8Jw3yMdQqUoaheQoIzmQltGz4HRvlNovfPECk2fdqIjwcKQR90o6vGyVd/k+zpMW3sn
         NI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761223711; x=1761828511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUDiK0EMkDjsHS0j/U8+4VgESEVxbvtfLePXxKWsYME=;
        b=inIMMIObsW5ls9OP5oXF8UYb79AcKJDvUVctgK0XykMNkvsG6QUCttG3DWqefUJ/Oj
         I1E2F/ZzIqFK7nli4nuGoNcXVLHUpFdXX/6jyShrXBhVYIrDQ8rcEj3unCnowDlcA9dC
         kS5C4raJAsn+TABklE+cw4TzKO6RPTx4TGnlklGT/7JufjYdcV9b5SYTIjaTWg+RU0Q4
         n29c+LctDg0EakKXKeJO9/hqWwPHJFDaKA3bJIR0E5/MWq0mKdu7Q2Fnw3aHBCQsXQTo
         z6wuMjRcfdm9Yu1fVmLzJD/+J0lw2EjbObM9KQs+6yWbcNjxZBjSgailyEIj8OnMUNuT
         hTLA==
X-Gm-Message-State: AOJu0Yy7AG5c0IqcSasGY8wW0oyz+D5MZWIla79uy4PBWLl6I6H0kGz1
	XtVxM+/VaZwZJayxWSy1/H/FGwo3w+4iJqzGpoP8THCRYMvRxLoG/Hnv66rMs9Mf
X-Gm-Gg: ASbGnctDMkp3bhir87H5Srlq4N52c2/UI5BM4w3feh5XtcRimGnj0MseTFEN30+mTEN
	KrdMrQCOf8tZidMFrnvgL8cGJGpt5eHG62uY0zJptWvYMEUHx1Oz2pY89bxlz0uFpRRdKSsjrDd
	i0DL2SLl5kqEIU6NX/z4ZcEvLG3b1pJHGJY6YpAMGR+Byut2qMflF5aqDzZNL8P2ayihqa7NrZ9
	CTxlH9sbtIZW0bd0O9BgXnxI9RJtn2HIYgKf+8gKyDmKAtDGxRplPFMqIEL1CLSu3JMYSNPlv2c
	38dSWXajpTIqbHa9zpiWj8G8IgGiIqcxNFD46k0XdD69eo22V5GJRxzEgFfVfesfprhiQAQyk4i
	n7NdLobATC3tofe5ACLDxjiPaLas6AWRmR62wHXxMlggzZumcaJ7ahDyJtfjcEvXeOd46Tm47kV
	o5itKxTUDXqmojC+OpV2IJZIlpRhI=
X-Google-Smtp-Source: AGHT+IG9839c/66AtKql7mfTMn+B/yvmogasC46+tx2s0GY7K+ouFeYvhsKMPnxCB0yXCd4UnSr/6g==
X-Received: by 2002:a05:6000:3107:b0:428:4034:9211 with SMTP id ffacd0b85a97d-42840349443mr12126037f8f.46.1761223710469;
        Thu, 23 Oct 2025 05:48:30 -0700 (PDT)
Received: from QueenJ-PC ([105.113.107.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e763csm3905302f8f.6.2025.10.23.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:48:30 -0700 (PDT)
From: QueenJcloud <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	QueenJcloud <qjessa662@gmail.com>
Subject: [PATCH] docs: simplify help sentence in MyFirstContribution.adoc
Date: Thu, 23 Oct 2025 13:48:01 +0100
Message-ID: <20251023124801.334-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit simplifies the help sentence in the MyFirstContribution
document to make it shorter and clearer for new contributors.

Signed-off-by: QueenJcloud <qjessa662@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 91c6296ffe..f0768bd03c 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -26,7 +26,7 @@ useful additional context:
 [[getting-help]]
 === Getting Help
 
-If you get stuck, you can ask for help on the mailing list or Git community channels listed below.
+If you get stuck, ask for help in the following places.
 
 ==== git@vger.kernel.org
 
-- 
2.51.0.573.gb660e2dcb9

