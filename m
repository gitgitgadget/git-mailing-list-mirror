Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2F1E481
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070998; cv=none; b=M/TxYHiZ56t+eZ6+VwYhs11Ukl8SJlddW2z/LyryKG6FDFDG4oxl/9SXAGSsz/mSaQ4pmpt1PZ2LjHX3/N6/BRNSRkuhCTD9JjKTJX4/eyULRozigk3IoifS9ZbMRt2rExiBjjvwuijqbNmAIw8+d/W1JDGQecS8d7ooxo6Y1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070998; c=relaxed/simple;
	bh=RCTa1JA2LutTKTKeVEnH6U60RmeOd5mzpU6LRNM3Gpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtM7NYFxrVkhOeP3aK8pK9QaVRGasfkb1xPxrDIk/e8ZwotuPrVIgCKl0oCkd+2rzTtt7TXXVa61MqSOuExVoVkz67yNkhDyc7o4eFI7XrVF2AkCyvEjajUfv3vI9RTrXsVSI3B45Qqr00v4LYNDxd8mBi1H7KZmeIpgBgWz/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8TkXgJh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8TkXgJh"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51321e71673so3816847e87.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710070995; x=1710675795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY/Lwx2GaOQzcZKDAt07yl6l07qQLUTetE/PglOjDJI=;
        b=T8TkXgJhTIpJ+IGB4M1p89aW5nNhQv7/H+mkgW9lqTGCzNZO7vzCMG39xPhuontpOX
         v9p2KjnLtY6h9JP+A6V91wsHzKeQOjQcANWkQLWql8lbKmBxMq0amW7qqHlbSRaDIHVG
         JYF0xsBgYREFnCzyq5bDORKGU+5fsQU/yvUGKDEuvi44dkYrmzO01MsLjN1ZoH6KRYz6
         hTflvEBJ+DkXKrJwlYupWUUq8T6b2bkjEeZ/9fG87MfV6wj3hdsTpquHMiZmYLJ+TQyK
         UFODqciIF5FeKe5HQbxtBgmd4Yd+4mSdqZXrEiV17VXm8JhYL952sVrjy8sW63zuRWwt
         f5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710070995; x=1710675795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pY/Lwx2GaOQzcZKDAt07yl6l07qQLUTetE/PglOjDJI=;
        b=t0OZqxaRuZOyTz1ge6MGbd0MvkFSbwpSm6WJB5ubV88DFAiWOE5EJ5lQuF5jEdXUdJ
         5AApgGyP+LyyDlb2ls74qxeR58URuAXZNYKLzOpP1oUSPbLLf7LfB45/15+gPE9qvaye
         /WXFyn4stMsu7s41CCW+XEguXL0PdVJfQ3tNvXpnfYf1aQIEPecat1uVU1FFjYRQch0U
         VV6gcNQgCNvIHnvOfC+TA0h4/BKY2kIOahM53IzeshFtUFVSv7v4yOo5Y3tmcZkgHlou
         LHSwYTFxB1489gQ3r2NTMX+69xfMdKvFXC9BSPUkJ3ns31Q/WqgxbiFrZXfTAXXgFsGy
         7H0A==
X-Gm-Message-State: AOJu0Ywis3bjf9sDpzNCU7egayYWxrxwhiAnBKnyrc90Sehb/UxhrH0K
	RtskWJgQ3f9w1WjMo2l2Ff7Ft1cTuAzdBPcpJC2JSfvEim6COe3y
X-Google-Smtp-Source: AGHT+IF1Cn5C6uJJ3hjPneemjYLzzzb87mnU/VvhA/dd77A5/WiHjspRA3OXIh91Xuj3ha9EfXVDjw==
X-Received: by 2002:ac2:4d09:0:b0:513:1c35:a23a with SMTP id r9-20020ac24d09000000b005131c35a23amr2081376lfi.11.1710070994596;
        Sun, 10 Mar 2024 04:43:14 -0700 (PDT)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id dx7-20020a0565122c0700b0051321139817sm643995lfb.47.2024.03.10.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 04:43:14 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][PATCH v4 0/1] microproject: use test_path_is_* functions in test scripts 
Date: Sun, 10 Mar 2024 12:43:10 +0100
Message-Id: <20240310114311.598681-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
References: <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Following previous discussions[1][2][3][4], this patch is submitted as a microproject
for the application to the GSOC.

Thanks,
Vincenzo

Changes in V2:
* Fixed commit message[2].
Changes in V3:
* Fixed commit message[3].
Changes in V4:
* Fixed commit message[4].

[1] https://lore.kernel.org/git/xmqqy1bo5k5h.fsf@gitster.g/
[2] https://lore.kernel.org/git/20240219172214.7644-1-vincenzo.mezzela@gmail.com/
[3] https://lore.kernel.org/git/ZeWVB5uKLONfp6cO@tanuki/
[4] https://lore.kernel.org/git/xmqqcys9oedq.fsf@gitster.g/

Vincenzo Mezzela (1):
  t7301: use test_path_is_(missing|file)

 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

-- 
2.34.1

