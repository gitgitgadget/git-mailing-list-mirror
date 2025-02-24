Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0C1624D3
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407292; cv=none; b=INSiHYy+z4d4NqBshLM468P0ghUiJyz6i35u27CZn4rBnUolZCEkpKqT5C5wvXYevbG4LblwzLuKf3rcBBSQNs1vJZT9IclSQq8aRLG5cc9ad2L0B8dFcEMuf97cnGwMg5UAzWE+3nuoxEyC2mNNB6yIF0O8xDd2Njwmcgt4PVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407292; c=relaxed/simple;
	bh=0obbN3ADOZ6mqzLpV0JzABa/dElqDd1yVN6h/cGMOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA5ltejjueVVhnJn/OuTR6LaBMXFdJw/FN7pEtTxUyuHaDWMh4cBsfoq77LuKXEuTBKFCnDMhOtlEdtBQNj8qceus8U+ygmr7bo41hnLGQVQahlz3GyvSfSnWyO3MfiNz1zetTWJS3bmW7oAVjLC9e2kGVNdSklDZJcySMgx3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5ILWm5R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ILWm5R"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so3304527f8f.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407288; x=1741012088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32+I3UefI6ZtOoJRbviGG8HXb04GXibeUata31nYEqU=;
        b=U5ILWm5Rk5iqbMzUtGpoiD0JD1zZej0S7gi7Uqpt1uIZTFM9OpfT5tZBt2w5SZizYV
         o5tiAv/r/+LA+CQMinOMdFyDvjmmv5rTpcIL27oD8xD0dM4xsyIFao+5stp8qJ62H3ln
         fi5Bpe5BGsVN8nVeSBb8fmS6prU6rlAcnmrSez/GWJxUaGBkNNirgQfBz63ZdJi9IF6O
         olB0sY7bLVeXNE0WHv9W9mBvdAJMFdsF9BvMz4UyJxJgD6ONjQxmmhCrPjYqPBi9wATO
         ahPCPHmVYrC97NbvrfiO6RH7BKrsCgtdZiRj/e79bz2YNGmQ1LpJYag/Uwe1wte1ScyS
         twXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407288; x=1741012088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32+I3UefI6ZtOoJRbviGG8HXb04GXibeUata31nYEqU=;
        b=D5LVKMdwxAfCW1nTOUC8s7hVakLCfHvf6bv2VbI+HQptGJLUaVdkD0neiIt4jZTrof
         CiBM0/tv6VkdSzih4U+3UYU5AdG00vXpK1ZdvQmV/x9059Wf5Y4kJ1Dn6fWbJBDE9nIj
         EOHHa7wxQdoJJKc4Ic7CDnaIchf3DAz+S5F0mXwLUxTqfJs6ZszuRAPXQDXXmxuVg6Kk
         0BydbhIgaNEFPIAAVKFKfsXxb7CUx8aB82lrpI6Y77fAHWk/7AI8O0MssAMgKbV4F1tt
         nnZXG2B93dCjTPnflqhk8+kkJyGHcrJWxL08rZ+98zbBlEHaea/YuleVzxDzYFOBhvJ5
         zQWg==
X-Gm-Message-State: AOJu0YzCXkPDPr9i8bbE7of+15R1GjZlB2mJCAh8iodmtFUKLNDzGYlx
	knCoV+VoZSpvQu6z4YhtW/PSmdNETnKW7o6POEhEPI0skTJI7mY2Ijx+gw==
X-Gm-Gg: ASbGncuXGq3RJSgthqUMFBCQFII79HwDblqc37sqzybzzYiHt6Aruuq+Bt5nHad7kEx
	6LSEsKILwULTYbvAkHYVunQ+lM2QtQmnPfC6Eba1iMeVCKuk1yofHFJO2aNDV7l3OiPfAdMvKMn
	feSB0xmiGjnaoQHpf9xfMIgj28+4MKY4ia/7f9McIJ637KpfHeEVlT6hWC+VRgtDSyncoGSqrAW
	4BAfr2UuInxGsm4DqJci9LQbvLa3c+0vJ8vFFRru/EAOubV2CUXmdzKGj7oSn9rJWJd8xWDPkmo
	cCB0Ket/0wPoD6bLCATKXICIQZ/zbLZXRdMd5aAStP23PYJeAqnf6PauxaTt
X-Google-Smtp-Source: AGHT+IEcHSjggb7+rqEVsTwwW4IS7+Gt/eqtP0PbgSPhEupkq+DG5oM/l0b2cgChWcfzd3FU1ny04Q==
X-Received: by 2002:a5d:5f50:0:b0:38d:dfdc:52b6 with SMTP id ffacd0b85a97d-38f7082601cmr9210989f8f.37.1740407288288;
        Mon, 24 Feb 2025 06:28:08 -0800 (PST)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:29b9:ffdd:d750:1ffc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm31713125f8f.73.2025.02.24.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:28:07 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/6] git-fast-export.txt: clarify why 'verbatim' may not be a good idea
Date: Mon, 24 Feb 2025 15:27:42 +0100
Message-ID: <20250224142744.279643-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.401.g48e0d4203c
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-export.adoc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index ab9a315fa9..1b19f17b78 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -29,15 +29,19 @@ OPTIONS
 
 --signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
-	after the export can change the tag names (which can also happen
-	when excluding revisions) the signatures will not match.
+	after the export (or during the export, such as excluding
+	revisions) can change the hashes being signed, the signatures
+	may become invalid.
 +
 When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
 exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
-they will be exported, but you will see a warning.
+they will be exported, but you will see a warning.  'verbatim' and
+'warn-verbatim' should only be used if you know that no
+transformation affecting tags will be performed, or if you do not
+care that the resulting tag will have an invalid signature.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
-- 
2.48.1.401.g48e0d4203c

