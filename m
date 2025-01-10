Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04620966B
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549682; cv=none; b=ow5kgze323svnFxQHxuralt6/UNfYievuasgLPVxIHR+FAIn9u5IE4CvAyrjRnZMd7GgQvbLBFOCshLCTaOlO6w0WXTu+HjoNeXVf2my01Eth0Z2efgbrhodiiYvx+VWZIuiyo8X+cFOizuSURsHgegWiAa6GWvB3AR5fak1Z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549682; c=relaxed/simple;
	bh=POPsz87LnORtw0TzYQZ5Ykk8cLNE/gueDFeYIn94VG8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hZSvrrVBRUWZgTRCv8cWNRKafQ+FYLEA6bafqlGo+FKqt2gaehga8VXmQ/LYnknQuRpuFHGOBELsl/IQRsp7qOMR2l25UJ0tdeYSylEhDvTVvfxrX2JrevIxNaFZ2TVS/fZ304YZg6SbBJ7frcr0/IIQdMafMQ+Bizo/a+ZmUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrDnSnAa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrDnSnAa"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a88ba968aso2249115f8f.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 14:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736549679; x=1737154479; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvESLbr5OUY4dCVsxqmZaCxBzGTHDQmALWl8Usu2DtY=;
        b=MrDnSnAaCGYh0hUdMXBXCJoRWnWTF+nDv3ZKxUkNghU9x854EtwFzBIS1DnE6z127R
         iWqX1T5jWQqrcmOX2YkmiFpo4Zj7NjfHyQioe82kZQO0cYJ2lTYvZ8TJyk6jtb8a1KNN
         BovgDZWr/QclOPV397b0FHkNwCLxwnRE9wRACqhERdpeXxk1mYzFTintHRkcTWMuUuU0
         aqPdA5/Hu2UA2eubUxF/iH9b3CnqTbCvvSaGKww3sArQZavNNkrM38g6SimE7IPdveeb
         8QoQg3SZYsL9T1lYI9AhA+SsGQ8fVXHxaF43DqlQujkYRjDXAjRyxNE0O+ZxqpOF2cEa
         IoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549679; x=1737154479;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvESLbr5OUY4dCVsxqmZaCxBzGTHDQmALWl8Usu2DtY=;
        b=MKPr4GRGufs8iwsKuYkkG0MePqiXJAukXLFw2Ww52eEb5ybOzgm8xHO9TrqheZgAon
         Nx/deJUnjSE3M0UepZujvzrb9xrn3hyiB4TndLXiFKRDRSDl48CvMQSujTevnz1HPbTi
         uIVU1N3F8CGzcHJrsD9UQBgZVUK31Md7sJLjCrnI6/KrHaBpkD5sX5P4ZOTSoTLlh9hj
         fxNVzGTZSFLHobmGavXE64dsbkHOUfWjv+JA/RhpJqa7Sn6Icwnk69ax52krxruijbhX
         5A+8tnQnvKwpopt6dER66ysSmmvXdyWdC5FJs5U976FTgPghG7BPGUou637YTNC1/zIn
         iibw==
X-Gm-Message-State: AOJu0YyQ2RhGr5GxwLKdiiQl4QmfSZxLyis4dwSp03BGD7OHRetM4YzU
	dEEtxFIVJRMLQkEdDTv4jTpIuzPn1yklOSAXv4LbcJIWD5PkSeu2U3oB7Q==
X-Gm-Gg: ASbGncseAdZKybLvV9unDhM+Z8PmVHxqdWgvFx0M8mFmt6sUtfVJZawC5Kkp223JNoe
	kbNH0V2pzoEVhiDCvuWh4YfUkbYGzSwMHkqVrMD1WnmtU1ZtUbdw2LQkxNYwBIbOBx3v6G8LOLf
	5oIUrzSwc38nUqmai6vv1fzmDeTp0D7ZS9eZCrBi2rGGlSZQL1Lb8L2UUtAaKnnTzAp7mUtLuVi
	O4i4HnI42T9WwVc+QDam4DDwguA/XrPUapnqUVj60gkcz6mzmpM2EhvNQ==
X-Google-Smtp-Source: AGHT+IF75wA+FRWg2WcvM7XA2r8FKHMCUFVysb57RJMlB/XLA57mCs04Xdp52lcfUhowZO2TDjxljA==
X-Received: by 2002:a5d:5f82:0:b0:385:fc00:f5e1 with SMTP id ffacd0b85a97d-38a872fbcfamr11137003f8f.9.1736549678869;
        Fri, 10 Jan 2025 14:54:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38bd0dsm5610009f8f.45.2025.01.10.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:54:38 -0800 (PST)
Message-Id: <pull.1851.v2.git.1736549677.gitgitgadget@gmail.com>
In-Reply-To: <pull.1851.git.1736458019921.gitgitgadget@gmail.com>
References: <pull.1851.git.1736458019921.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 22:54:35 +0000
Subject: [PATCH v2 0/2] docs: discuss caching personal access tokens
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
Cc: M Hickford <mirth.hickford@gmail.com>

CC: sandals@crustytoothpaste.net CC: derrickstolee@github.com CC:
stolee@gmail.com CC: Johannes.Schindelin@gmx.de CC: peff@peff.net cc:
rsbecker@nexbridge.com

Patch v2 adds a list of popular credential helpers.

M Hickford (2):
  docs: list popular credential helpers
  docs: discuss caching personal access tokens

 Documentation/git-credential-cache.txt | 17 +++++++++++
 Documentation/gitcredentials.txt       | 41 ++++++++++++++++++--------
 2 files changed, 46 insertions(+), 12 deletions(-)


base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1851%2Fhickford%2Fcache-pat-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1851/hickford/cache-pat-docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1851

Range-diff vs v1:

 -:  ----------- > 1:  097eb0e8776 docs: list popular credential helpers
 1:  1980f6a5aa7 ! 2:  ac8c5e1b552 docs: discuss caching personal access tokens
     @@ Documentation/git-credential-cache.txt: variable (this example increases the cac
      +To avoid frequently regenerating personal access tokens, configure a
      +credential helper with persistent storage. Alternatively, configure an
      +OAuth credential helper to generate credentials automatically. See
     -+linkgit:gitcredentials[7].
     ++linkgit:gitcredentials[7], sections "Available helpers" and "OAuth".
      +
       GIT
       ---

-- 
gitgitgadget
