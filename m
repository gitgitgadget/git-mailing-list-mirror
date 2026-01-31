Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34954352C39
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886089; cv=none; b=o14oag/Hn3pv0k0iUiIXn0Btjm7X4ST6OPTLTARqODp08+rwQPzk+rqSV9xWkW+9spPMOrBh5tpQWcj76sNzElGbmmUeO7rC9O33JjG+GBnEG8lDH8lOCU11uRZevEu2y8huiaUDRD6idKIE3Kz0MUAhjyp+eAFGW1nIQai0c0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886089; c=relaxed/simple;
	bh=/QNR9NErllVWjhI99PFU/2dL/YRadH05267s/yEDgOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkJp1BCQclpP72JNLFsv3rxBhRjSvfYSu5lu1xExsRcxNlG4ECurCeHVxGK2vvulLVB+7AE54AXaqsuwprIhNYfaNblgc4/3sEaAZa9jgkn5ZisISFylHNWbD5H/S3i9pdfyhyLhgG6a3vOtnxKctOlHJpyrUxvSbmRoBQytvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HET8NpSR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HET8NpSR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c648bc907ebso1932542a12.3
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 11:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886087; x=1770490887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJEsqK91ES9957pfKWN3oCbf0YbYyW1zgyQW4P6Kxwk=;
        b=HET8NpSRETgPUFTAoVJbHjNtOojRZY0CNkS3hBPQTzg62omV7+g8MXAwzCzQYDbovJ
         1dMUi4ig2Z4v/gx9O0cwg0QzgKqAjhKkX8vd+87DfPky1BwRhNwjKy/BsHJbGy1w1ods
         oupHPrzm4lfdq+dPK8RRRN7GFPsMYyxy3PWG815hV4eO061/quol95d7Yzx+iX7KoCDW
         xvCG5pFxva1mumw1KJSqw6Jnph3Yj6kpmYw+bw1Ek21HlMJJ/c9Ka5oF4gXhb3pRh1Pc
         nBOKqj1OwzHR+YJSUrhF3LCqFYHYHKv3EcUo1O0GZSP9qonZIuofSL/GoUueGsZQec6F
         Ri5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886087; x=1770490887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJEsqK91ES9957pfKWN3oCbf0YbYyW1zgyQW4P6Kxwk=;
        b=ikGlUU59wxYarQGDfl0++PG6LEUuBrFoT5UKLGVWnodY8sCXs495XCVTmYvMuegPwJ
         4c2smaM7pKaCqTrikDOVHcWmIvozXnq7+qD+1SVBrvjvXrXaTc66PCnqBqbrJkaq6/pf
         25vaFPf9S2RXTElD7ZC7G9f9tJewlo8kz45ziyPi+EZNkWR5OtTtQzCJG4HhitPdgd62
         fvts9uryJcFoPtXMIu8kQwvRYI5tLIBEzwy9AApKqwscRWFj9hMNj2YT8Ka6aXUXqzQO
         pKtVTkj24vq4Nyk2OFmYFPhAup3mvqjoCT+8d8gKwlvmjyuWx56eWGBHLaI9dZHYkllG
         ixoQ==
X-Gm-Message-State: AOJu0Yx50DL1X7rpVc8oj6RjLkOWfM/FNH2QwDzwzNeS7dJFhyEPsQYb
	oBgFkCHR9mol/Lr8fJjVlWRMNPDD0+qhmeaIFB8cbnUDDSeY4u+/lvd9el+iXg==
X-Gm-Gg: AZuq6aKYVg+LhWYJNz5pgptapXXYf7lGOhKTGgzDak5P1DidRKBBqUCSx/Gh9u2tQE5
	B8hsD/gVFtiQ0jzZvlAF09B+N5U2Hm2gwGsZK3nktBg8C38H9Vgmx/aigb7VSk6WZDkh18Gyt8b
	wU2cG6SOZMGtLdZXdD4F/Yw25ROzIZ1g+sBwwJr7GDcDzsyGZdGQdtqcAHAtBbgucrNVEYgJ+V0
	jvt/fGiawu6j8b8qAfm+oobIWmzDTPQxL6Nr708z+YW0hVUuGYMiyR1vB7+G2alV4aep3/6aleo
	pbg5bBHR9hlMybiabxPq9UgMX6HsC6prC3DHz4/Hjxp/Mm/5Sqc7eNybdbrg50eQwOcDpx9+QXK
	VgaXALDfyb/uSo4e5UTnKw9O1jCBoXk34P2AfRnvErnnRQXwxSlVAtDjKd0U0/eQC4r610L4JCI
	4/TaBAwiVP0DiL2rWdel1A7PoAoUKrUgvka0VGn/qmK8G+t3Fwn4RlQLE=
X-Received: by 2002:a05:6a20:3d88:b0:35f:5fc4:d885 with SMTP id adf61e73a8af0-392dfff8f54mr5780939637.9.1769886086663;
        Sat, 31 Jan 2026 11:01:26 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:c36:249a:cab4:59a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb419sm11151747a91.1.2026.01.31.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 11:01:26 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 0/3] wt-status: reduce reliance on global state
Date: Sun,  1 Feb 2026 00:27:36 +0530
Message-ID: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In wt-status.c code still relies on some global variables, including
the_repository and the_hash_algo, even in cases where a repository
instance is already available via struct wt_status or struct worktree.

In patch 1/3, replace direct uses of the_repository with repository
instances already available in local structs.

In patch 2/3, update function parameters and calls to pass struct
repository or struct wt_status explicitly where no local repository
access was available.

In patch 3/3, replace remaining uses of the global the_hash_algo with the
hash algorithm stored in the respective repository instance.

These changes remove all direct uses of the_repository and
the_hash_algo from wt-status.c and reduce its dependence on global state.

Shreyansh Paliwal (3):
  wt-status: replace uses of the_repository with local repository
    instances
  wt-status: pass struct repository and wt_status through function
    parameters
  wt-status: use hash_algo from local repository instead of global
    the_hash_algo

 wt-status.c | 76 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

-- 
2.52.0
