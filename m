Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767E2C21FF
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785919; cv=none; b=YH5ddeJA+V2R+nF1zF+4+098jCsebNM3gKT/iseoX8oGe5ffwvqmxI/ikAbnLA8ByrWGSzDM53SV1MsFufyT7ojH6k0u0GuPIXUh4bDh0++jrPLxoX/2xyJy9+lVMnfvGi6p1KtQai8apMYNTyxsGZvT/7U1CGjHsz6gj95irH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785919; c=relaxed/simple;
	bh=AdStJKsH/cqSGMIgtiM9PGRFJVIj8IYwRULPkeqLRPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIhOjuJ4ZZy9w22KK4UJaJdC+WLPYtJLZos8OFglmNvEtPt/lKvlw1MbR59AJvYjzQW01fESthtrFEmC9e/KjnLQ0rNGCvzaOnq7BeZNPP8DRHZZnio+rlxZjGbE4Elv2rrB2nbMi0l/CYpwi7mxtvIV0MN6HSssHjNMxqROxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=wbQeZnUA; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wbQeZnUA"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664db84f074so2742028d50.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783785914; x=1784390714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmwKVgffy0Spaqr8E4b8xh4+4OwcmUX8OewYHYXJixE=;
        b=wbQeZnUAUdOL8WxWGeozYQmB4nLIk0i0HXpZySq7SCZKwqUjXu0+1u2qy7hLPGGbzE
         GN4lzKQPeHbSX6lj24Ne0+szqwB6/CjEF4rRjRnLwG0GuwFkW2fCL4lv9WSlZlnbIQcr
         8Vilsw1HIhQzt/f1n+8N9ZDOUn5h+bYmlApjVXpIRSOsBAK7DsMZ3hkdl//pLHAEX6CG
         9DJA9iK0Ew0epWUDJa+/K5qYnq4jjLtZIzEUbRZRIhgRuF2qqZRgV/ej7yeATgNM2B0o
         zqOJzHzg0rYvqILeZc+EsKTlk3+VYnAcdWfdzIPtiquZ+m5hP4NJiBmtLg+U2hMomuCT
         a8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785914; x=1784390714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bmwKVgffy0Spaqr8E4b8xh4+4OwcmUX8OewYHYXJixE=;
        b=NIfW81iBbhEyCUg1By14gs1J/wO4550xrtHuOnZ92biIzCfIl0ow4jdtyXCqFJdbwi
         ux87CYuOmTB9QKkpXKyO/xswMjUYVtFNYUAqraiWi1O53F2e+hQ5jCGqGjW2j7MJNjSh
         FMCrVEO0dqRtbzuVLCL14Cy8y+RoV+SWTHd8B7GhiTsaTXufWGPRGjij+T6Pb7J2px5H
         wNvChhbqYHVSMg1qmV/okom5P9rrs0XJOLZQHeo27sPuplErVKUciYxsNmyCejncEGok
         3fVYxif5dt2s+KtnaCB/uOxXkMPIRKTmSH3yMOvPfxRDdgppiPcWqa9KiLmZIcIcmPHp
         Lu+g==
X-Gm-Message-State: AOJu0Yxh2ridlF5uFJxOLrLfzi4olw4IiphtRNJCVp/WgvEhuMGM3wwD
	8KrKSs8W9GyYAMVa5j4CRSeI91dbVSYJTnJsvorxYuUwDL9qGMAgifLsEAXINj6uPP7UNrjuyfa
	lBxR+jkc=
X-Gm-Gg: AfdE7ck9vt8zMb0YYnGL7VRc5Yx8UiQQB23x1IJQgtdNcA0Km31jnwj3Ledu9iyk36C
	2QWzQck4wEmj3jCoVJUKL57T9vksiFv1I7eLd18qWf63youQ5m6rhw2u32WwtszcC0EwQYlyXBA
	cCCSlf1QwmNxrEsoflvxaEMysYHKg70gqzm1AshQoBtJh5T/euk+ec4Q19NJpUBTrTKsCAhIZxj
	2cJTVbd9MoXAGAZfvhEz7v66/Vy++92hgEJ3odfsIwxone33BxOV5+fe7WpB9lhuuI3c29q/OOW
	QBdtxCzk3WsjDodf/wle5whR6Zdgh+CqwSQERuLRDP/LXBOTPanJJMA81DxWKaDAoWzCL7wTxs6
	/SLvGvrHoZKiFzWm1MQacM3GJNKUjmkTpjPdJ7UwbQgl0XwgzJD4zyIA7PJSEHd8+Axu+SPDcsb
	eEia2LEJBqxrroCGyEc6AlSBBS58w2PCW2CEUNxCpdlxOafb+5jcDP2ojvR0tu
X-Received: by 2002:a05:690c:88b:b0:81d:bac0:88e0 with SMTP id 00721157ae682-81e9031654cmr23385067b3.72.1783785913953;
        Sat, 11 Jul 2026 09:05:13 -0700 (PDT)
Received: from avocado.meuintelbras.local ([187.10.85.73])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e950567eesm12606787b3.13.2026.07.11.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:05:12 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: git@vger.kernel.org
Cc: Marcelo Machado Lage <marcelomlage@usp.br>
Subject: [PATCH v2 0/2] t9811: reformat and modernize tests
Date: Sat, 11 Jul 2026 13:04:45 -0300
Message-Id: <20260711160447.99708-1-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702140704.65805-1-marcelomlage@usp.br>
References: <20260702140704.65805-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series reformats and modernizes the t9811 tests.
Changes since v1:
- Break long && chains into multiple lines according to how git tests are
  written nowadays. This was suggested by Patrick Steinhardt.
- Replace 'test -f' calls by more useful 'test_path_*' helpers as the
  second commit in the series.

Marcelo Machado Lage (2):
  t9811: break long && chains into multiple lines
  t9811: replace 'test -f' and '! test -f' with 'test_path_*'

 t/t9811-git-p4-label-import.sh | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  0f03c913eb t9811: break long && chains into multiple lines
1:  f319f2e6e7 ! 2:  3e590881c3 t9811: replace 'test -f' and '! test -f' with 'test_path_*'
    @@ Commit message
     
         Replace the basic shell commands 'test -f', with more modern test
         helpers 'test_path_is_file' and 'test_path_is_missing'.
    +    These modern helpers emit useful information when the corresponding
    +    tests fail, unlike 'test -f' and '! test -f'.
    +
    +    The occurrences of '! test -f filename' were replaced by
    +    'file_path_is_missing filename', a stronger guarantee equivalent to
    +    '! test -e filename'.
    +
    +    Co-authored-by: Vinicius Lira de Freitas <vinilira@usp.br>
    +    Signed-off-by: Vinicius Lira de Freitas <vinilira@usp.br>
    +    Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
     
      ## t/t9811-git-p4-label-import.sh ##
     @@ t/t9811-git-p4-label-import.sh: test_expect_success 'basic p4 labels' '
    @@ t/t9811-git-p4-label-import.sh: test_expect_success 'basic p4 labels' '
     -		! test -f f2 &&
     +		test_path_is_missing f2 &&
      		git checkout TAG_WITH\$_SHELL_CHAR &&
    --		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
    -+		test_path_is_file f1 && test_path_is_file f2 && test_path_is_file file_with_\$metachar &&
    +-		test -f f1 &&
    +-		test -f f2 &&
    +-		test -f file_with_\$metachar &&
    ++		test_path_is_file f1 &&
    ++		test_path_is_file f2 &&
    ++		test_path_is_file file_with_\$metachar &&
      
      		git show TAG_LONG_LABEL | grep -q "A Label second line"
      	)
-- 
2.34.1

