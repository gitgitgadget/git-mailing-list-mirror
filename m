Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C61FFC57
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087660; cv=none; b=tFHmFsxsZbjH7j3oDYnbBQNAMob/BZafRouWc3bPSVKwhMBbL5W632qKZriWWfYdu2c8YY5eM0lhMMMIQSCHUPlONsNmVLW1OJNS73BkcL6zbzE7fq1Dd1JZ6hNSBTrJNPMP/3klki6NkYcdRLfUKIrt3AFZUeIYkfk+jUbj4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087660; c=relaxed/simple;
	bh=fcSoBPvGCrejZsYJpnz2d4/+HB4Ipdgy7RLYdKRjtkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HctIpLHv7higlTLxCzFlw0IuDNn3OFj7V8n61x9ee+r32Q76gxBkOpv6hDPWV4z8qP+OzJ8mQd7zrSvZ2H9lTxlptJA3x6qYo2YC3VwYdkOTy4juH5ZiiA0TLgtGDLWOFzm8L4itMx1A/nYGHXDgM33MllR3cWYsnBtzyR4gK+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr1bEBvY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr1bEBvY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239aa5da08so40157395ad.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741087658; x=1741692458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6K8RYAE1UlSfAIjSbNSF8fNSpwHsSFHjKUGYAg2UA0=;
        b=Sr1bEBvYyH8T4YZHTUsZW/B8Kq+JoHRSXVwc2vaagZ6mCJ5ICBlYurAgY4OouMHvg5
         /QXqRDVoPWDjCQpgRuRYAoXgTI1LZJFgyDdHkZZNCL8EqBzASSaUQjJU9M2q+KqeCUc5
         KBYuoFd4P4uTPDffoWx+8P5VrL3F2677lVYyznrezvqMcwHPVXhFK+wlsMNAKbeWcM6q
         8J6JXWlohNVLAjdbmsBahGVWAkcEA/vsHit25keFL5fu1UxVHeYhaZNFUdah1+h38tAb
         lL8CHCcEqRQhe0XJlxcf85PGi6Q5772UuyNRn1laHvm7cKT5yp6r9YV9ecs8QXPtnzCy
         V5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087658; x=1741692458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6K8RYAE1UlSfAIjSbNSF8fNSpwHsSFHjKUGYAg2UA0=;
        b=Vn5kLD7CkNj42LoL8iaAwwCr3XQ9nO1jw68KlEW9VP5df+wkNr9KP7f+9cEarroHTZ
         ICI2tsnUzn6Zxj+GUENy0iIqIS5v/dXL2IP8dut0cQozvmZQE5V7M3PwltovGQGtJ2MV
         S9VE/+7VNJhli7UyWEij31JuT3vH69cqw9MVQKVKFPMb1+DnYEZkMv+zR+SikAisQWdG
         pyA44ME/IG8mIFjr5Htza2dH15VMLxHX76Vv90Zr7B4gXSaLcyGrHHRauzhGYLbw/ZfP
         QBylDov5Om6m9bTPnmf2uoHan1JsmYWNDD3VkmRiHji38qO9PLeefhezgdOQQrh2DNNC
         x7YA==
X-Gm-Message-State: AOJu0YymX0OHLjt8hXUcb56Oh3ZTlikwA9SxxCeVfy5WATZX83es7Kgx
	D9a/RkSf3sBjAXvWThaCGp1uw1/tgD134YrrDmO0Yzm0vHhtn22d51Y4rCD2cbA=
X-Gm-Gg: ASbGncunlq2nqQSuJOO6K+X0Y1rz7IO2/rUwRQ/pcAxjCpH5CMuPXiNfp56EjnrZ4QJ
	q+8nMWiI9PW5LMlN3hE+/z+BQ24HTX5WR+k8JL8h4Ps36xKgY+x4WpmgBl9Pp6KMAOQhhA4m3zu
	z9JkqHOKgaAj3VX5bGcFaBQe85uTvAHHyrfqIIDbVu4V7gpcWAK41b3+fdkV2XjCkrR7hlZupOT
	y76g3C8CkA9A+56Eyo6Sm5RvHjTic6UYqqSk7wZTiwUvpPDRyVW094o6RACIDpLWFKg9V0ETqx4
	jx7CYcCejaJDSaYryW4/jvgKzgFVIe+r307Ms0lPqQnJLjSIYyfPLamIcDm9BVvihresiZM98VU
	78pHqekUJFLI=
X-Google-Smtp-Source: AGHT+IGUO7SZ/rFdXsXHLI7fzxlToywj0U+lr5PgJsLzc8Di+0ug/9OglUHA93E589nM31fMn5kpig==
X-Received: by 2002:a17:903:32c8:b0:223:4a10:311b with SMTP id d9443c01a7336-22368f6cff6mr269689225ad.1.1741087658083;
        Tue, 04 Mar 2025 03:27:38 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:179:8d82:34ca:21e5:3fb5:2ef4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c7efcsm93331425ad.154.2025.03.04.03.27.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 03:27:37 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [PATCH v4 0/1] t1403: verify path exists and is a file
Date: Tue,  4 Mar 2025 16:57:27 +0530
Message-Id: <20250304112728.41228-1-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250304094153.28959-1-danimahendra0904@gmail.com>
References: <20250304094153.28959-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that if the path exists, then the path is a file using
test_path_is_file() helper function.

Thanks,
Mahendra

Mahendra Dani (1):
  t1403: verify that path exists and is a file

 t/t1403-show-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Range-diff against v3:
1:  42dd686abe ! 1:  d181f98d1a t1403: verify that path exists and is a file
    @@ Metadata
      ## Commit message ##
         t1403: verify that path exists and is a file
     
    -    test -e does not provide a nice error message when
    -    we hit test failures, so use test_path_exists() instead
    -    and verify that if the path exists then it is a file using test_path_is_file().
    +    Verify that if the path exists then it is a file using test_path_is_file().
     
         Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
     
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --verify with dangling ref' '
      	remove_object() {
      		file=$(sha1_file "$*") &&
     -		test -e "$file" &&
    -+		test_path_exists "$file" &&
     +		test_path_is_file "$file" &&
      		rm -f "$file"
      	} &&
-- 
2.39.2 (Apple Git-143)

