Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63A3502B0
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476306; cv=none; b=l0vkzWTxNm+8ehz2suI5ddOGzsYiVRV4s+oAPcokyItK6K5IqfSi55lUrxcq7s7LHdT+c79U8xmwv+mlEGoIkApfALSb9CnmFzC8YFp2N70CE9OM//FF2Zl/h2GcZRnnMi3Qi1ckU1AUxG6uFFRsxHLcJcEoNu9X26lQQrUgYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476306; c=relaxed/simple;
	bh=06/kKTS5YmjSSKtosb3i0rUxWXc2wyzZsOxVB7OpMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJfuBA3jkSHRkSGdh4nzBFA5y8zrUrf0Rl1T7/kVfTHmLKgAtwodLLYz62oKGKxI6BTThcfzkKvyj5an78iCWh7xwWLqNQcksSJ3mnGea5tVRfg7UcxqAGT/0GGllfpROAzipfuBrk/pNYnSlLnOvyRRiJWVRtD7CJxYqi/Ynug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Foo0j0i+; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foo0j0i+"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-435a11957f6so2430850f8f.0
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 06:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770476305; x=1771081105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3eptUq5JFs58Dte7Vgr/OraKcsGVF9KbykBQ+tQ1fFY=;
        b=Foo0j0i+4e6eGF8BsivbwND6kkI5BsdWje+QMliOu6NMu8kyYh9xjVMewMO/MasDjN
         bXt/HWxmVqZS1m0wp2ZYBj/UJSZmzNKzGFZvILkN2gXZwMSefBg4UZF9kzplSHNs8eDT
         6EJY/ngYMamJeT7ZfH1Q3TT3BbPm3K3pNQILr6drLwFa18p0lRToFVfJWE3OOhwn03ge
         obBaQVfv5gOaxJeF9jWVq09GvDkV/cewjtjHm+WuY55Hc2lQpFgJrUmY2agamfI8U/qK
         YzD3bp86B5ReAC8rOd7Us3/rv8Kx/SW7cR5Q1F+67CVX2dJ06PCgvLcXg8w0E0oz4yZU
         pxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476305; x=1771081105;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eptUq5JFs58Dte7Vgr/OraKcsGVF9KbykBQ+tQ1fFY=;
        b=EZ+Yga2aGsJIPFZ6JSv8FhvdQvM08i6Dsk62aZmzSpYdoR0Xt32wzhDB7bpCIcK/o9
         1KunY7zwpAFg7r9X1h4qWFEP1rWnG8HXglnLxD3vxZWy9t0VfS9KR1oJkz4yG/7j89dR
         +pY3BW6EzNbZ86pc4GCvj+/zKxkDoggd/s1naxSx3K2bthuA0dWspRhtTsbDmqXbbc3B
         sHh+5vMaHdRI1tF/FbsoS20yQN6IubcQfcBbHxlrG4OSeolrIkhqahig2PYJubkIcv6A
         OjVkTRJOIX5xG4GwpE3RF7hj6o18xHrW3ozVzQGyBVxw406ag9hw+6KZTRh7erLnfAIW
         I9sQ==
X-Gm-Message-State: AOJu0YwfeHNFUxYddmucxI4109BeyqY/gZEeKfb+ZbmK+W72H+opPrOy
	QHp4QlQRIACyUY/HQ5mejMXyRN6zjLZmpssFh+8G5JOLB9NxuoHMSenCAoJXWQo4
X-Gm-Gg: AZuq6aIR7U9GLVEDhM/Nx9W/V5YdzeV/gKKmqwGJ1AnH7C15Db7fkxNvOiGMVnMOyV7
	LhuwZNA7jJ1jlEcgsXZjCtlHfBVu7iB8B6swXVKWjkUJoXMYpY3irz5QcTBtPkFlfM4ZcVopMMb
	8cXQLJlOLEtUFFFbmLAQW+uPkIFU9P8lR1NiHgFm35XPIr7p5w15tVCLNZsNu7Ur7T5bwp/6B5E
	MJEy13DuP+vxPa9aMFyyxn2gzfV9r11eUi7d6SSCRmIN1YhXyTCHu4ilkby39H9GhMnjWreKiwx
	9AsUrQQjKNlau4unyfidS0ovxPiHATcNc1D2ZTu254l2HVWvBUKrLIGtI8QaZqmQFRkB1yZ6lcE
	9BPMvsecHuFtoop4wN/iIHuSq4HFfgapP2hTWYjtSx02G4Gx9X1N8cUlhqDLNF7H5ZBZw+qH1xq
	SfOnxJNzs7MCWzi1M=
X-Received: by 2002:a5d:6304:0:b0:436:3155:86da with SMTP id ffacd0b85a97d-4363155874emr3525260f8f.27.1770476304795;
        Sat, 07 Feb 2026 06:58:24 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm13780317f8f.11.2026.02.07.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 06:58:24 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] templates: detect messages that contain a separator line
Date: Sat,  7 Feb 2026 14:58:02 +0000
Message-ID: <83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1770476279.git.phillip.wood@dunelm.org.uk>
References: <20260206090358.GA2761602@coredump.intra.peff.net> <cover.1770476279.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Messages that contain "---" separator lines will be truncated by
"git am". This often surprises users so add a check to the sample
"commit-msg" hook to reject such messages. As it's conceivable that
someone is using "---" as their comment string we delete any commented
lines before checking for a separator. The trailing ".*" when matching
commented lines ensures that if the comment string ends with a "$"
it is not treated as an anchor.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 templates/hooks/commit-msg.sample | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/templates/hooks/commit-msg.sample b/templates/hooks/commit-msg.sample
index 099cc58c303..c7a9db88cb9 100755
--- a/templates/hooks/commit-msg.sample
+++ b/templates/hooks/commit-msg.sample
@@ -39,9 +39,16 @@ comment_re="$(
 		}'
 )"
 line="$(sed -n -e "/^${comment_re} -\{8,\} >8 -\{8,\}\$/q
+		   /^${comment_re}.*/d
+		   /^---\$/{p;q;}
 		   /^diff -/{p;q;}
 		   /^Index: /{p;q;}" "$1")"
-if test -n "$line"
+if test "$line" = "---"
+then
+	echo >&2 "Message contains a '---' separator line that will confuse"
+	echo >&2 "'git am'. To fix this indent the '---' line."
+	ret=1
+elif test -n "$line"
 then
 	echo >&2 "Message contains a diff that will confuse 'git am'."
 	echo >&2 "To fix this indent the diff."
-- 
2.52.0.362.g884e03848a9

