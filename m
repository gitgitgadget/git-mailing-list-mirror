Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242015D5C1
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298313; cv=none; b=R0tu4GOhjx9H7/iQTDs4Om73SPFjCN1WxBD2kLYfLFc5zgvzqNtIa3bsrMBjGwL9T8jV6Nxh/PFqia3Oy8XX8NNxpV46KETop9zxD9+DjiSzCvB7N6fTVFV94YVI6MpYJnJhbd7HinSzxXsP9AwT4dgzLYDPuz2YsLFKGndZQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298313; c=relaxed/simple;
	bh=FPq5Qrivc+rWP4zz1nj51fj1pBoBs6avCQS96T7/WJs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uvhZ5LGEXvfoJ+D3eLN1/z5ngQvLVKZ5G1dFRnSYdaaBh/FMgD+X9Kaeb9ZcB6CkQT0PUgAD+5ukJ7SQZt7PF8FXVTb8h7S6wRXzGLbNXCK8n4/ynhiTF8yJjB+/9mk7f84YWqYylSsF0j4iS81+1ERZ3T8GnV0rh/hWEEfLCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDs7TaMV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDs7TaMV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso38694435e9.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728298310; x=1728903110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKow0h5YxVefaeZu3hmEq38nQxi/poFQRtfYnuOCTWo=;
        b=mDs7TaMVMfUa5XkR2KiydgOZoztoVvtF2cqH7ou35/kn2w3Ccb7VedGSTI4F/S0lMf
         yXnkAMERtB37YYPl7TMDh6e7JNjUglR1+ed0h+7ZEwfc9NV/SMdnWC4PLNRndV7Svnnv
         7U/cRLV/N9eJD8dBZ9d+kGW6xRzvjfsXUkmdaXfhHLmwV9j794yhQg/nFZy20rY3qFr3
         pfF+BEz5iSTQC6CIjdV1LeFKqN0ziOZQXqyC5GagzmSS33yXS8IDAd2Z9B9Lu0wjbUwO
         zDpRViTshwsByru6jYAAoobzRCS9eM2VfMNzO9eeUzH++cKb9wGPdIdCoX8gu1/U+UCD
         tf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298310; x=1728903110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKow0h5YxVefaeZu3hmEq38nQxi/poFQRtfYnuOCTWo=;
        b=Gl81aqImlCftBTaYm2ADsZRCKJvMbFckQ6w9ENJYZ/ed49dYsAoNJlGEH68A8CNIB7
         laOExW6yBnyGPIv17fA5vtMIz+B2VsWPl6hlOlrcKhy5Js6ltPqcNaSw4BExbxINVEkG
         zD/rlpnvwDsVdNiW+3JhAooRNJYEgt4/nbtFUcHbEuR1B33AX8wymVWAS6yiEWeReO7e
         TgHGBbhDbc9bE1X68MqZNVZJENVCD4Lo4EjEYWcOQt/VDtWQX8aCskGK2olOn9adUvBe
         ce4iTiedZIt3QLkC/GhhLauAuFM1XdYF+UZJ6E9r2gTwmUg9eE78szPctpKW2yf/N/VA
         XeCA==
X-Gm-Message-State: AOJu0YzJE+5PTcQDcQFbDr36cCMRJ7DltJQPh4GO+zpEUpoPO3F/ZARB
	N1I/ZS1nEDpq5rzioCyDLwSHgvBZrOFKtRPoX4FQMRfwq7JGNBZPPF3eZw==
X-Google-Smtp-Source: AGHT+IHLJa5M63oTkd/CLa5sbzLNhFXmwLhjpB5BHAIMgvn0GPOZ4Gk2sLf513f6s072KIXxM3McRA==
X-Received: by 2002:adf:ab14:0:b0:374:bd93:9bd4 with SMTP id ffacd0b85a97d-37d0e8e66ccmr6768878f8f.56.1728298309685;
        Mon, 07 Oct 2024 03:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05940a6sm3071344a12.1.2024.10.07.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:51:49 -0700 (PDT)
Message-Id: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
References: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 10:51:46 +0000
Subject: [PATCH v5 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes since v3:

 * Replaced the use of grep | wc -l with a simplified ! grep command to
   directly check for the absence of "NEVER" in the output. I was not able
   to add this in the second patch ( employing test_line_count() to replace
   test). I was able to come to this solution with the help of Eric and
   Patriack.

Usman Akinyemi (2):
  t3404: avoid losing exit status with focus on `git show` and `git
    cat-file`
  t3404: employing test_line_count() to replace test

 t/t3404-rebase-interactive.sh | 73 +++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 24 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v5
Pull-Request: https://github.com/git/git/pull/1805

Range-diff vs v4:

 1:  bfff7937cd2 = 1:  bfff7937cd2 t3404: avoid losing exit status with focus on `git show` and `git cat-file`
 2:  864b00997b7 ! 2:  0ce40300fa3 [Outreachy][Patch v1] t3404: employing test_line_count() to replace test
     @@ Metadata
      Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## Commit message ##
     -    [Outreachy][Patch v1] t3404: employing test_line_count() to replace test
     +    t3404: employing test_line_count() to replace test
      
          Refactor t3404 to replace instances of `test` with `test_line_count()`
          for checking line counts. This improves readability and aligns with Git's
     @@ Commit message
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
     -    removed test
     -
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'stop on conflicting pick' '
       	test_cmp expect2 file1 &&
       	test "$(git diff --name-status |
       		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
      -	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
     -+	grep -v "^#" < .git/rebase-merge/done > actual &&
     ++	grep -v "^#" < .git/rebase-merge/done >actual &&
      +	test_line_count = 4 actual &&
       	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
       '

-- 
gitgitgadget
