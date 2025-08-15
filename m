Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D62E5D01
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276756; cv=none; b=hnxJ9AibVvd+cQ514+DpFoXevZcqevhiTph+ESoEpJXFdqs9uTeGDIuo5hPyDlIGQQwzqTZqEBlF+SQWFC2qG82yZtS84WIUafoxWlri9VbuRkqac2p+6xTIYO6M+2heeFp6Tgn8ZHFOjN0rzqfsZcnyQqfDvQv8X8tVu3JBPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276756; c=relaxed/simple;
	bh=6TTElZk0wcQ2m9kkf3avdATQtY21Xfja5TlWfEBYVLs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FNt6naCQCm6rIxQxYB9XKWCgMVfHcwArRrWAbKqXx1up97cgFv6HhyFaXxCGYnsKswMqT53gxkvhUC3Q2vUVQ5ZtPIHJBuRdlL6BsrhMsIJAxncR9xOnHZtjWtN1VOUNxc+/NPiLzMUO6Iv2pzLUv6RcMxKlM47ZAO9/oa+N5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lytlEpRU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lytlEpRU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9e414252dso1159328f8f.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276752; x=1755881552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZppFj+FUiGgxRIDdqw/UW3Za4CN9LHDJO197Yte92G0=;
        b=lytlEpRUfDPEURtgP4k6vx1bvAk8IkcQ5x/sR+TQu/mAvLFczfTijyi0QcKSQclPtz
         zl+ngqtqG+8AnoSR8o+n6cl27vz+n2pwa4WQh6ksVq82TbcWdS9CbMh+07gbqFNAbs3i
         abNVZwz7tHxNMubyYEfo+rUiP+1DchIgsDf25JVcSj8PLVGUhacOF7+oJmRK+6lU3QeQ
         Unj8OCJSvVGlh+flWTBdLoul2KmYc5M3a8x/vHYmg9XpWts7YYTojbSfjpQ/I0Q2JTwg
         vwxpioCtT9Wg2cTIn+XQo8ZJ5AoQumr+DQkUR6jIVFDElISk2MQJXKUwZdqFMAtDNcpj
         g3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276752; x=1755881552;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZppFj+FUiGgxRIDdqw/UW3Za4CN9LHDJO197Yte92G0=;
        b=lo2mbqPuq6ZQsEwZE4xUWFdp0w3lo0dQej2+e8eehmGpJBjpNgS5rX9D4ZsLsTSPE3
         ifiZLOoAOChpqADsGUssAyfqddaydrSBLajAMv20IplYEWv5asOp3OjgHYRPbBjvEE1P
         GwajoObQUIrmV4oDbac1VQ7pekh4S0OX8vR7jcNS/3mCNp3IQQBtLzAIQk2E8EY8rcym
         xra5khcnFXHBlTmOAocmOJ2ba5XSXOPgSzyyDdIVFo2mETciYFznLZuiRUGwOuuwbJY8
         UcmVZlKXOpQK1+HW616d+S4AyanGTPBO6cRm6JHlihInSdpAJlUsJxQ+3VQj2a0t3pEv
         lAPw==
X-Gm-Message-State: AOJu0Ywc9RZterkSnxKwKkYepG7y38QWQlKTcsH6RmbTKS6JVKfexLBU
	wZsWQ8Q1htoyHHpxxwaGTOC6TzF7k8tvCZUdPC1FM+JqiilUKyMZOeeCN9hXAQ==
X-Gm-Gg: ASbGnctNXgB/lJNdNEAarbdjtFwHwX/wXGUBeohJl6nLaj8M5smICl97raQMal0dlGR
	t9eFoytnwFftFu6te1HjNZxjVZriop49ksZwN1MB0Aszn/yVUxxvrRky6uRg2Y/9Aj38rObGxOC
	/R/xQuabuCbQ2SIUGtqm4gUz+LrOUCJ7ixUuwlypbIsCzGjNPkafOBkNpHCiawlvl5T84RS9QEQ
	W5439bStSv93oq9QYyIk9U3Ch2GKUaZWbhQBQFQAcQOVYfIxeeT5Wfkvm5FYdJxUtcvrwQRtRoT
	OOXrp2blT3demk/GUuqt1aun+WXqnjyZ9FwIjw+s9XXnfAkXl0p88hEE/THaE25Qf5mvlzT8TD1
	P2fOeAsk64dkFpEbmts1HcXY=
X-Google-Smtp-Source: AGHT+IHa69XHBOZN9I0bQbBdb0eSsn1fZwZlnslfeGBtQrrCHPei8Rp9XjZa92KBeu2NOfMOOmHytg==
X-Received: by 2002:a5d:5d11:0:b0:3b8:ef61:bab7 with SMTP id ffacd0b85a97d-3bb68a16a3cmr2453135f8f.27.1755276752238;
        Fri, 15 Aug 2025 09:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c790689sm68699205e9.28.2025.08.15.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:31 -0700 (PDT)
Message-Id: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:52:25 +0000
Subject: [PATCH v8 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>

Combine point 1 and 2 in "a simplified description of what git rebase
<upstream> does:" into a shorter summary.

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 298 +++++++++++++++-------------------
 1 file changed, 133 insertions(+), 165 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v7:

 1:  e7a8fbbe53c = 1:  e7a8fbbe53c doc: git-rebase: start with an example
 2:  ad63f69918d = 2:  ad63f69918d doc: git rebase: dedup merge conflict discussion
 3:  7ee6b0afe88 = 3:  7ee6b0afe88 doc: git rebase: clarify arguments syntax
 4:  4686417b28e = 4:  4686417b28e doc: git-rebase: move --onto explanation down
 5:  79f29ad1e68 ! 5:  cb85642bb9d doc: git-rebase: update discussion of internals
     @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
      -to point at the tip of the branch before the reset.
      +Here is a simplified description of what `git rebase <upstream>` does:
      +
     -+1. Make a list of all new commits on your current branch since it branched
     -+   off from `<upstream>`. This is the same set of commits that would be shown
     -+   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
     -+   change how this list of commits is constructed.
     -+2. Check whether any of those commits contain the same changes (according to
     -+   `git patch-id`) as a commit already in `<upstream>` and remove them from
     -+   the list.
     -+3. Check out `<upstream>` with the equivalent of
     ++1. Make a list of all commits on your current branch since it branched
     ++   off from `<upstream>` that do not have an equivalent commit in
     ++   `<upstream>`.
     ++2. Check out `<upstream>` with the equivalent of
      +   `git checkout --detach <upstream>`.
     -+4. Replay the commits, one by one, in order. This is similar to running
     ++3. Replay the commits, one by one, in order. This is similar to running
      +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
      +   are handled.
     -+5. Update your branch to point to the final commit with the equivalent
     ++4. Update your branch to point to the final commit with the equivalent
      +   of `git checkout -B <branch>`.
       
       [NOTE]

-- 
gitgitgadget
