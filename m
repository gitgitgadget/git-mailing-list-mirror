Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB4339A8
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817898; cv=none; b=cUVH7tuLM2zNwx3BcQs0bGoDCq8L1VRychf3ggvj1eRxzt/uOG5vnG2BBMH8kv3T0kXOfI21wPZdbQY2wY0QDHwaCPs8EYe6q0sL/bslf6ZGYH2dthXwimF8uQ/o/nMIpnQ12J2kSzTu5FLcJuAPNqKuqhBrs7EzpMmd+Hj7C6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817898; c=relaxed/simple;
	bh=78Iz/EqulgCQclazkUb4DJ4k3U21DhomV0AycpG3n8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4y1R119bngklJBuD/E49gtow1sGVS2XUOTn9iOSMn7StrKCvRruKjeK7ZFN5UdNtq9Gfbp6dQRcQUthWikFOKCNV0jM1EiDVjWzvZKcRJzprS8OplBPFeza/OkI9ewMHWDdL2nK6lbhanupugMK+7KwLAIynsBi6rK252rhGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPawcgCH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPawcgCH"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff02b8a956so6467276.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718817895; x=1719422695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kkes1zsZQdwc6XnABsPoCG/Hwhfvy1oR2L09KiDpls=;
        b=hPawcgCH2YttwxCZTlNVPRXwkWvVgN5MdEsLhxZ1Ar4s03bJLXGhvvStJQLqg1PGD2
         Nnewhkv766i5GDRs8/jsaFIGwY7GRzf+1fvQkcZtUiRmlS7lVoNlhev8dXoz1Picx2tP
         gTJy2eqN4L81FVwNSR5ZIm2oFxh5UhsZ940nhlcDBbNXChqcWk1bPwvy6j6IAG302kNF
         etzjT54deC2adnttF68GXD7a57pzlkM6+k4IKjfyO0RkoQ51gPyMvQM08Ve/HZiJA+iG
         kYJus5d8dy4Rmzx6hjLSS9mhTIobMBdjpNW/gz7nbBvKqJX0GaRprsKxZv5OYDp9G+YP
         jCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718817895; x=1719422695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Kkes1zsZQdwc6XnABsPoCG/Hwhfvy1oR2L09KiDpls=;
        b=XFX089flEN07xdSpUBZU6bBq46LR/1ooqElNI7GuQcF1+lX0ye3xFf0epK0+ICJ9j/
         zi3FqveZ27pMBDa306+JY+3NFR2pcIAI6nCpwI821XcFZBgfNro0aqyR2zCvItFSkjbu
         wHI2KiLpsumeUGC4iAF5VmcOkbu4rL5IMvblXoiheg+UjKyuNaXSrjZeXIUlGA4R54Oy
         dWR1WO2UtDctsRPh1/GfAJSYPnb7OCoPHRifdIDZtmZHJnOPXy9IDEDms5Uy/hyRDZhH
         OevtD/dsgDMXirBmSSLPA+Cw4Lj7Ujf8Guj0GGnqNvCJ5URgRe8bNuwkDRQuLCyCsxwL
         p+mg==
X-Gm-Message-State: AOJu0YyzYif+2/u3Io0iOkyjXCjLTH40FKMCNs/GhipJ8BW+ZfXVFQWn
	4Tulxd+6VjaDWjzrH0/944tbhMepMMfnrHbExMh0I/epaseOf/k4WR7twQ==
X-Google-Smtp-Source: AGHT+IF5PHX9mLXD5vPYLWR/jFKsQVKIUx4GJvVIQRnas2KCy/D6Q5c09s4o+Amr52wLm0be4PS+uA==
X-Received: by 2002:a25:ad0c:0:b0:dfe:5a00:df5c with SMTP id 3f1490d57ef6-e02be138c72mr3807441276.18.1718817895595;
        Wed, 19 Jun 2024 10:24:55 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:3da2:1b6a:eaa9:b88f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fd334bsm66683371cf.69.2024.06.19.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:24:55 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: [PATCH v0 0/1] Teach git version --build-options about OpenSSL
Date: Wed, 19 Jun 2024 13:24:20 -0400
Message-ID: <20240619172421.33548-1-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simple series adds the OpenSSL version, if any, used during a git
build.

As an example, if built with OpenSSL 3.0, the following is appended to
the git version --build-options report:

	OpenSSL: OpenSSL 3.0.13 30 Jan 2024

Randall S. Becker (1):
  Teach git version --build-options to know about the OpenSSL version
    used.

 help.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0

