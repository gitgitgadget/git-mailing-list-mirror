Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BC1FECAE
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087417; cv=none; b=SjzMBkrT6iFi9NZ3NFTawoYOb8H8ED6grkDhiYH80AGcqMlD3bRU0bN9r2FzaN4MHMZ0ICq9W+TcNRVhNY0Z5jtj5MteWYSktLRZMgoAl5XPZELPcg4R4/S6tWXp2vhGN2LuvbmH7qYWkk9tTUqg6QrHwiQ4teMFbX9wYa03Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087417; c=relaxed/simple;
	bh=VyRg7XG4eJ/2jm4O6JREZq/U0rnPdRbKv5rysm+jZ3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0RcX7Um1nsoxwuUj1YQXIoO3+uPIFoNS/NUJBIfBG7U2nytL/AMNfExfLxnt/2Avl8Pj3XlmSIPNhjoO1UQUfY53lkZ098mMFEcAv2uHuoF3c6A/CvgiO8ejKnCnBgOPsEUigKPkk3iU1+kSZtEKzJ/ljM/XPkyv9DGDWVScTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feCd/JwL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feCd/JwL"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234daaf269so79875855ad.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741087414; x=1741692214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrhOq8fa54EFptgaqw2C+HSDonO+PnvlmyNCYWinxZQ=;
        b=feCd/JwLBRHuTaq21ismo1T7gXQc0UfzC8YnX/wj6BpFIBQXofPMlBNLr77uETczLL
         cmY9aOCGv1CBnCOClH1WaRLBrYcPE5K9GVbsK5+yk/CyUUPBIw5O+1UCEieGR+ogQLDS
         pRbEY9kj3dcYdr1g2nyI0giayTMmcxBVJupMTUn67HpvOtHy0Bb8diGxpOs3gAhCDVYE
         uUq+Tg+h7Gb+To4aaLMWm3ips9xUvDZpho5j5oTUT/eVf3rOHiBMP1tnBmjQtojR9GKm
         ClhRUiXw3fZ81mHKozDhxD7oPnDAtVHvEbjGXm7CmNLhvnKkUCMMAEUCUgV5snMJU7en
         xxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087414; x=1741692214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrhOq8fa54EFptgaqw2C+HSDonO+PnvlmyNCYWinxZQ=;
        b=a3Rl9Dvy6rgFQNfOREj7Ar5LnUPOjzVE5YNcKVewFaHwUWvHtLRkHzuvCEYjk89lRr
         I7wcu8onsqKa1IcxwAHSgVuFhNE8DThzOi+GT6v9A6fwXkbJ5ymp0WgtbRZy2AbkiThV
         7lhORRr4jaAMrTT6siJXoRjTLh5aSnKl4JKJNItViRwt1iRxuoWK6oad6KJDFhrPdCFl
         vtIjD7CGfkMBGX0fLdKYqCUk7o/2RxUHZPGzKwNe4MJn9t405ilAkXVntZFxcRCiRXv2
         +w1f2awq7mU2b00kKNJA2DyApg9/kCXcfBa8G/m9PezwteBTcxuO7KWZRC6Qd6LLXJ/9
         K+Mw==
X-Gm-Message-State: AOJu0YwKEhEdW0IDfHAVdVwRYEg1Ye9XKRyeCHcirmYvopYsLH2LwDxs
	zqnERO00XTSVuMIQho0F0VCRUWCXqXVsG3ETVijvNzEF/stQgF0E+ATQPgwRs9k=
X-Gm-Gg: ASbGncsSchdj82o26xLIkVimGSiCg9YvtYnfWjI9p1A8T0BWKx1o7QqW++pdi4wP61I
	VKDPBsg0WdhxK5qLfAHTO9cr82CRe+2WlltuEP42NAp31yVFeas4rH4E76FVzLyRnmOcAQU8ScD
	T2G6l5YR3kDujFBafjAn3f5w3pP3iuT5q8SSHUHHvF5/VhBUYX2NZQCgfca80ddFYzavANTMzHR
	nZv+mh377yXJLg+3CCn9bjJo2J3GajpYpY+Mht4t8iKDeqE1QAoHMUJy+iNy33BtKZHZOzLrJOh
	KNyLOFuQp2fPz3aDd8D4MPDamJAOS8bshbxjEToKJhJD52C6xelnGjmJpzjlnyd6atDwxvYfpX5
	Ghh7BJ8TSH70=
X-Google-Smtp-Source: AGHT+IGA+R9tpKyVivz97Ghg2i+dKq/6t0qYqiuG2EFNg15JSp/X9RizJhex5VQumbdHzJDbpTywzw==
X-Received: by 2002:a05:6a00:2e23:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-7364cde5ec6mr11943387b3a.10.1741087414353;
        Tue, 04 Mar 2025 03:23:34 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:179:8d82:34ca:21e5:3fb5:2ef4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73667e0c9e5sm2388792b3a.14.2025.03.04.03.23.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 03:23:33 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [PATCH v4 0/1] t1403: verify path exists and is a file
Date: Tue,  4 Mar 2025 16:53:22 +0530
Message-Id: <20250304112323.40139-1-danimahendra0904@gmail.com>
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

