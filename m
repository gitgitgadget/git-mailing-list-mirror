Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F618383A5
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863934; cv=none; b=fRnhXJL5uYoaZf07usgBM4BFZFwCg2lA1BgFXEa7I4j2J0dvugu/YVFZYmadrLvNc9zBpUbSGi6Q+z2qc1eVy32EYmANT7yaJlSbQDj9H16DGyhef1223wMeGN1vd+bkj9csh3aOuTdmXB2vOtkjidlejJWN4MzUSMjNfVtXrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863934; c=relaxed/simple;
	bh=C5QhANnCEFdy+/t6umzJjpbUhfkqfHeppJ0oA/Tfw/I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=avQHkjWrXf68/usWlrLhHd8shUubeqk60A0WHxqqb3AiT8cJtdEVPYHLPDyB1wPIxZFS94uu1+BLd4ISYjHV4FZW0TlHUV1uNazupiNYgclkVDb2pmboYn39C1N2paGgbegnZZvOoulAoeSKCQffv3mKOf0tcXOaz6wvzYWzivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckL1IPmr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckL1IPmr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso8099825e9.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738863930; x=1739468730; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhDly7iMc9pjxMekS5V1p1ZkFQxUeJPhnRBgkNr7STg=;
        b=ckL1IPmr0q6fRhR7kMEUb8a6+VF2gS8KXMRHutW7aSGDnoiCuJy/hu/M59W7xj/USf
         plqnyZfynglElt0U0gdRsNIvB73z0xxE8W1AcxZ4z/vJb7TyHFMCER+E2scSf3mK2h1Y
         bcLelEo+fzexjP4VzbZSAfGhNMRldMMReQb0VdlB2SOzaj+T6FuWynUb3/uPdo5XLl8Y
         SWT5CBwvpN+xSJxZP+GwVIV1CstKsfsbvc0C682xqswPDs50Bgwpk+E6psKQihp/PrCM
         k6wEVzmrDoluqJx0D/xczkS34QN0cHL2H8WlRg2KkXb0Jdbv4XTPY2CdCR+E50O5a+cB
         2k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863930; x=1739468730;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhDly7iMc9pjxMekS5V1p1ZkFQxUeJPhnRBgkNr7STg=;
        b=cInmDlAaD6FFfwL22Zf0oIqBkCYplSkLei9RgKPVmg6/1OkVYiYtyy2qvfpfuFp6Va
         7LqSnR4pI32+o9ijkhdNwoJ3VzWCft7vgIFLwTxZt+7U2JyBnuvpet86wfwrgTCN4fAT
         /7bph7c5zDBB9EhsqO/cqZuM83mcZfHhzjKwF2jFOp9iZGj7Ot9gznMc2hYyTCj3S09p
         Sx+jbPCVhsotbVq/QQzaK8Qf/PoYS5uvHoKwxOi7T6qQIj3EUlday6H3k0ZzKiyr6UsR
         hxAePwBH1jz39jOjlns0D72KsGvXI47LwYUqV+8+2V1HYMmtbrneHJadpdU06ptjYqLX
         3xEg==
X-Gm-Message-State: AOJu0YxH5CeXeqsyqJqgnfc/2zyQ2ehWXUF84JMK0VI9KYFj+PYwbWe6
	ec7g3M9E52xVyBtuLKtDYMj0Oq/CjKABiBGduSlkc1T29HT2oMrVrCwwDA==
X-Gm-Gg: ASbGncvMZnvghPcz9KE2hD0UunLlhUHjE/VXj9SuIh6Gt85SbkwLfbCEdi+Vrtv7EOI
	6ndH03VB9EuZxWUb4LLvxmGnzysgKvwZL+aJV2H0loVVP51DgA4hWD+FYkOsCz0iGz2MfDmtZtv
	Pz2OGj9OyH8hAWpqQ6r+xRX46CTfwMAbM3xPD2ra61ePnXT4ztCW/I/MYkSqMt7+eYuOPSCVyWH
	V71xFndFZs01vTNZ3l5Z9pbpgsq5sydy7tXX/juiP5yaD2vsz6wMOEZ3gxnQDEMGwp8SQo28afU
	oEsa2opptzutLEXB
X-Google-Smtp-Source: AGHT+IFoZSBzMDsAhHBdmrtojjumAP+5AjUvVwCqBm55owDk0pgMIuOpS1FKRSDU8ogRI4JxWSHrYA==
X-Received: by 2002:a05:600c:3b0f:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-4392498e806mr3199265e9.12.1738863929963;
        Thu, 06 Feb 2025 09:45:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ff64sm25577655e9.9.2025.02.06.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:45:29 -0800 (PST)
Message-Id: <pull.1885.v2.git.git.1738863927849.gitgitgadget@gmail.com>
In-Reply-To: <pull.1885.git.git.1738790425046.gitgitgadget@gmail.com>
References: <pull.1885.git.git.1738790425046.gitgitgadget@gmail.com>
From: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Feb 2025 17:45:27 +0000
Subject: [PATCH v2] doc: documentation for http.uploadarchive config option
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
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
    Jeff King <peff@peff.net>,
    Piotr Szlazak <piotr.szlazak@gmail.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>

From: Piotr Szlazak <piotr.szlazak@gmail.com>

In Git v2.44.0 support for 'git archive' over HTTP protocol
was added, but it was nowhere documented how it should be
enabled in git-http-backend.

Add missing documentation.

Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
---
    doc: documentation for http.uploadarchive config option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1885%2Fpszlazak%2Fdocument-http-uploadarchive-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1885/pszlazak/document-http-uploadarchive-v2
Pull-Request: https://github.com/git/git/pull/1885

Range-diff vs v1:

 1:  4a5465d0329 ! 1:  ace5e71729c doc: documentation for http.uploadarchive config option
     @@ Commit message
          In Git v2.44.0 support for 'git archive' over HTTP protocol
          was added, but it was nowhere documented how it should be
          enabled in git-http-backend.
     -    This commit adds needed information.
     +
     +    Add missing documentation.
      
          Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
      


 Documentation/git-http-backend.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f37ddaded82..1dea4268520 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -56,6 +56,10 @@ http.receivepack::
 	disabled by setting this item to `false`, or enabled for all
 	users, including anonymous users, by setting it to `true`.
 
+http.uploadarchive::
+	This serves 'git archive' clients for remote archive over HTTP/HTTPS
+	protocols. It is disabled by default. It only works in protocol v2.
+
 URL TRANSLATION
 ---------------
 To determine the location of the repository on disk, 'git http-backend'

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
-- 
gitgitgadget
