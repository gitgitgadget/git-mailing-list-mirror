Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA719E7F9
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702063; cv=none; b=WERSJgpk9+YV+2x6S6/opzzk1SVt/w4eTZ0I1RzA106cSmOk4kt6cy0QXbJZvUfn9qB0ElEPr7WQ3VAwZmK3GGAVYPAIGzpc952KLMIPASadqM1AiTOoiU3XrFr/tSjsDq16tgO4XHIIJ9bA9tGrA0/suSeODstPiaS5pGyFVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702063; c=relaxed/simple;
	bh=oNUDdPcxI0zvAGGZKYTWtt7hnZAfH5vGIYKXUaWFYGg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TgbOiKda7UlM6GSVSXEirhjJwdaqwyjn6QOanwWJwxrLUUxHo938Q6q8aRJZwOy+fBIb9c4zmPTRFdV5Ee7kX7JJT/EbdoG58z7jv4yqYd/Ru9UhzrQcq3nv8HEPprh3hrt9Eny5VbTx6Noqy+PcVrY3ZTVjbHi/DwqQpQxPmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC92p4Nx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC92p4Nx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so25917415e9.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754702059; x=1755306859; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZgy/3/sqYcJRiFgjZ60jsmPSkYbFQkpS5w2bTmpZqI=;
        b=SC92p4NxJcVn72n3P0tWVunWTkqN4ax0kPRg+LJMHWVSCKl1c5i4u7bO4J1ohXxuYQ
         QQeTifrqc3udauonGewOktdnLuXsPUU3ETZNl86IgYGtLn0+ir10oRt5uACDLDB+dy20
         AnS5M6XB/8rKNcAKXVMnTvtSn98KUBG2DFAmrwDUPWFGyYt407haf1/CsiVybL6fFk6S
         V8u6oURMLBcGAZg89a+HG5UJcVGWuLlIFpZxqtu+ZTvtRKXFylBEoN1kgZOqBq/fY+8A
         /tOgv6kX7rmslUJV3YORhsHkhxdMc18m1LSZcwhRZX0JW0Qq5O+3rUPXCgOZImYG2lPF
         F8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754702059; x=1755306859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZgy/3/sqYcJRiFgjZ60jsmPSkYbFQkpS5w2bTmpZqI=;
        b=NJL3rNtJPjM5cURaua8HGejFnQDgxw6E8lPMbb/abDZLT5mi6tbTgOGeMyOv6hyvvR
         rPf//tDrhvVgSaTkBUu/Yuqcw6UrMz/SZnC5qJ4/GtWuxnzjJKKIYmEFV6uPHcjwn+UK
         YRuf6QNAiu74eohUPW9H5ZlAt4WesH4l7YnpS1nNShDivWooTMR63L2sdrYJNzZCKv4e
         2HuGAcDvWIidRica/tcu/STnjub1Ro/PtmIltHTdcxEvtJXHCN+/BocCC8wDyfO5ZAZo
         998G2uof5akAn38d+hPF/vmX0srBjvDPAJYAtNVsxtzqsL9RWBfGGuPubKVc8ymdJmGI
         wAkg==
X-Gm-Message-State: AOJu0Yx2rlFa1OZpBzSyOJ4YhstULhOfP6jD9l+rEvg9L0yQUGpzPDZl
	WE7/hHNTGzkGKh1ZfoNPJL5AIrEApkZAiZCRir1nwfcYTsiAbP/2g4hq15g4wA==
X-Gm-Gg: ASbGnctlYRt7eACqPrsLPJET9qUUknP+W3d6kZIQW7ZEpJDqnwyC1axGUxPw/6QrkEF
	9vlukJ21v92boiauq1yH/SrQFndNxHVzgBTYR+fxkoFE+MG2PdyHRbKWhM537b26f8AuB0KEss6
	5U+nnGTFNc5LfZ5JXOomFIRXBjopSTxohHFZYCGOfQgQJrvyPlR+8Lfplkm2eugpqjqftt5F+f9
	4y0eOUUZpfXtOeF35FVCoUDZxHvDtqDDiMmwMi41f4qP0wiP+ab7vnkPGz2uMMYPngmaeVHj7tv
	7qL1zxrLj9lZEQF2QIqWwcdcwRtlpkVyWWDDF4lSwwkKHOyeRhKc7V7arYVTMSc+1wuKM2RFMrk
	ZvexXiafx0FxMWEfed/bYruI=
X-Google-Smtp-Source: AGHT+IF18dk7OQ4nKfPXyigWA2HPc7vHlx77j2PO7YAx56eCILl24cXsmyh/nWyA20EE4rzR5mHC4Q==
X-Received: by 2002:a05:600c:310e:b0:459:dfde:3359 with SMTP id 5b1f17b1804b1-459f4fc2e3fmr39592995e9.32.1754702059366;
        Fri, 08 Aug 2025 18:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db13fc9fsm229464065e9.7.2025.08.08.18.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:14:18 -0700 (PDT)
Message-Id: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 01:14:12 +0000
Subject: [PATCH v4 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: Julia Evans <julia@jvns.ca>

Replaced git switch topic && git rebase master with git checkout topic &&
git rebase master

Also "short-cut" with "shortcut" which is the spelling used elsewhere in the
man pages

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 300 ++++++++++++++++------------------
 1 file changed, 145 insertions(+), 155 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v3:

 1:  26b742eb49f ! 1:  07a4bdb7ce5 doc: git-rebase: start with an example
     @@ Documentation/git-rebase.adoc: SYNOPSIS
      +`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
      +by running `git rebase master` while the `topic` branch is checked out.  If you
      +want to rebase `topic` while on another branch, `git rebase master topic` is a
     -+short-cut for `git switch topic && git rebase master`.
     ++shortcut for `git checkout topic && git rebase master`.
      +
      +------------
      +                  A'--B'--C' topic
 2:  249a5127904 ! 2:  061790686b9 doc: git rebase: dedup merge conflict discussion
     @@ Commit message
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-rebase.adoc ##
     -@@ Documentation/git-rebase.adoc: short-cut for `git switch topic && git rebase master`.
     +@@ Documentation/git-rebase.adoc: shortcut for `git checkout topic && git rebase master`.
           D---E---F---G master
       ------------
       
 3:  013a5044ef3 = 3:  fe9e161a51b doc: git rebase: clarify arguments syntax
 4:  c574a27412d = 4:  b37ebc8389d doc: git-rebase: move --onto explanation down
 5:  eabacd3c159 = 5:  105a65e6e71 doc: git-rebase: update discussion of internals

-- 
gitgitgadget
