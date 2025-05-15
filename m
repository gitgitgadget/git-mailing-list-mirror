Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4F29ACC8
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313158; cv=none; b=mJrNpHqfjPR0oXWdM9m7UztkXUH8ob/w4e154M5tILzSXPT1UY5guLVV+Nxw+t5b5mcQluOd3IxTFY2W5ngajmvlhu2/WtfhlZrtEAQ6zL0guAUyLxknCYQHSltPNib/lfc3D/3nu5JWEtsom8B2i1BZBvJf9BJ62itc4NR+lo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313158; c=relaxed/simple;
	bh=X9Hg+6xutcqOraSqGt4+A8V//Ox5lCoR3N9OH+0jD2M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rMc881HauiZbo/QEg94EejDT0U+AGv4MKEGjZK1vK/M1P+cHHRj8y5/UPNp1d5Xs8T/65RwArOzIgxF6fPQ/kE9iD3x0ftTVmRcFgHQNsu9Mhzg3/vh/8FlUc2L/ceman5/1Sl9EhpL1ipGTW7gSqx3eZbGVKyd6tk/zmIsQqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwRaApwU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwRaApwU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf848528aso7480125e9.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313155; x=1747917955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNIBmt2wPkZw+QSZvZaZSXVmqhKb71upoYMFNuiTPtQ=;
        b=AwRaApwUeI3+NiJ6XePWzztGBI22mNvvSIqH1pgB0J5xvyYeS4DBDaRb5IIOsjlGdD
         oJ7V/71ubP410oojm6yJK22hvkpC4h9h/8H29+6Sk7f/Ba+CL+W/6/1GjY3WA5jcaV4O
         ClvarsYPz+vFEdEmMc3zf7J56VJGKloyb4aU7pXMxUCrUFqofUiawqSXgM6O180+LleJ
         lfpG+sBoalOJ17dtBuYxun8uKDD65XZucS6B8uqkWQ/bk5N4eBAc4mNgElQOWcntZImH
         6VuVRmVXPjq7hNxOr2DvfSCWZz+t9EYyWFWa387ZQ5LHwcB8Op6Njlt5Gqpv7mcud/2A
         Zr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313155; x=1747917955;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNIBmt2wPkZw+QSZvZaZSXVmqhKb71upoYMFNuiTPtQ=;
        b=IvtyErc8qGsSDxaI4eEMk+z+cDZZUrf6EW+KA6/NFIiISoZBs0vplbM+lEv+Cp+wDd
         aGfHycZMh/kjFkPsQZUvepSQWInq2HRWaHg4CvTFbVJmDCsRM2jcoNLQMZd5BEaGKbSr
         Oy5zZlKM7v+YqPnQwJtGW8IJcFru6ssk+oZxkOyB/lqe299kAupYzBoVrnil/LH0XOcJ
         5zZyEnvzjrdWD+e244LIQT3t6tfzGWi1NIGFS81hCqxvT9D8XQgV5jMOylIL/oL3soBm
         cvE0EZ0Y4KwN/xdggcn1UdGypr2jm/Fh4tf3XRGVnADIdJznnmGCoX+KSajD/1F8SelO
         Su+w==
X-Gm-Message-State: AOJu0YzvlQUd4JZbbMYRrel4tIrZb2wqtf4LCKkcjAzigX3JIrb1E9U1
	XkKXHQOxYT4Vl3OLBXbXx1fdEb3cIcQLHkj/5hiU8wyGwO3hk3OmS6Vs+g==
X-Gm-Gg: ASbGncv+NF7b9LzR7OLl7GYV9sNjUM3uHNPKZSPKVYcKt0HfhmUq2PesmgFCHWF4NXO
	jKlgZkTaZ22gQBvxg1M3gNg8jKSuVv6jRbWB4zHQYd73HKn70gt5Rr+5/szeviNISLKs07CMuvG
	uvI6a3277nsRjPdL0t7w8RXEGRXxLeXgnSlTQ5mW8L09FZYz6fdE6SzWoOUGHzyBsndKS6WnMGq
	XKkHh99JZUtge+VEWdbZk90OTs61JUX2saoeUf4EoiPpVVBhlLDVnEZuXvNMk1AMrHNC7d/GKRn
	YrH2CdVvRlOard0vm12/oCNcHPdeHN5QQzygoRB46TOs4NjwaS4Wwhj2+lWv4Fo=
X-Google-Smtp-Source: AGHT+IGZDNWnSG09LVL5At8ubYWWDyju27UAByoCnLTB7GKN7k/iSg/H3DJLF5c7QMeg3uer+gwqmw==
X-Received: by 2002:adf:ffc9:0:b0:3a3:4b8a:8cf6 with SMTP id ffacd0b85a97d-3a34b8a8d92mr4553409f8f.57.1747313154676;
        Thu, 15 May 2025 05:45:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de0b2sm23025561f8f.19.2025.05.15.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:53 -0700 (PDT)
Message-Id: <137f6c45af74c718e7acf0e3a569633291dcbc43.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:38 +0000
Subject: [PATCH 13/14] test-tool repository: check return value of
 `lookup_commit()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On the off-chance that it's NULL...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-repository.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 63c37de33d22..05417d8f43dc 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -27,6 +27,8 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 	repo_set_hash_algo(the_repository, hash_algo_by_ptr(r.hash_algo));
 
 	c = lookup_commit(&r, commit_oid);
+	if (!c)
+		die("Could not look up %s", oid_to_hex(commit_oid));
 
 	if (!parse_commit_in_graph(&r, c))
 		die("Couldn't parse commit");
-- 
gitgitgadget

