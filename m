Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC0352FBB
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718657; cv=none; b=KCse1kErTaMH+jk9yRbWuBHmEYojfGxZdcjAZwZOE6unpwa741Bb9CQ9g9YLmN8Ag2XcFN1xvDiHPSHxe3yfPxKUyjmM4xpgaL03kK4nlRKexQFbVcPOpWFcR27gukCwFY5TjIhm87l8zlT8YrVTyKPVvn1WRHzibgE5JWFL5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718657; c=relaxed/simple;
	bh=ZYQiIyK2WlzLItNnYvr6/niNZKcUQFJtt+5pojauI/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tQZxfoJdUl5O68+xV8clsy5jNQw6jSTgFyQKG7bWAqTEAGDRH23g2/j4Iry9xg16uQ/bb9cIrUhnwfctKebx9R3oYAo1cYKtemoobTy9kMmFeNQpLskjVC7ZcnpsSWy9CH1kCVcUC8ppPIw6JcUU1InMmtEEzL8Qhk7tmK0fySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI/Hh2aI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI/Hh2aI"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-436263e31abso3830101f8f.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770718655; x=1771323455; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bb9W8kL4SEnFD0aZQK9wAX7+qOzyW9Df53rb7BRL0lc=;
        b=EI/Hh2aIZdbN6vzxagCC79RheNXZUCf4kvFs+H7b7Bznkj0Fn6wVlT6ys+ENaAValz
         yqQhJ6ybsAw2zK4VtIJxbhghMQHyfhXZCK3C5aBEEVBeGVbZHhTu4xGaJl2mL5pJnIXr
         XvG0V/ncdlBC2C/YAn7QNMhvApxh0ZqKiKJJabWUjRgPErghoFm/yT8Mz1JuLAJiUBe/
         QGfOLSnrkYLDXZufaeskmE7la47BlonjHeg3blbp/kIDthA9WtRyc5d8fNMtglvUrCo0
         y3DWIB+x6si9fFAfX+Qgn504ALsPA8fzeW7W66fC1AcWR/jrLymHI8jXIStl1CPdvAx2
         CYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718655; x=1771323455;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb9W8kL4SEnFD0aZQK9wAX7+qOzyW9Df53rb7BRL0lc=;
        b=qE10pNBojKoQdXEBtY++6VDPg8sygC/WS3ZttEYfhM657gBSILvEbgqztt/WoT8BBg
         C+OefDcsVY6+n+7eDJWI9tcOBxZjsEZINv+rc+C5/rXDHpGhZ2IFbYhysvQ/C/p3Cm+j
         yvkMeVbnT/hUrDG0HJ34E3ZL8ftAzTHYvd3iHMm9RijbOqoCfdPXu+Jg5t+nzofipvpi
         7jEPEYnMqfb9jcbwdTYOaKa+W1UsnnXYQ3HGIEaXADmjnPHiMQyOtFHOWEsxwD4kI/+i
         zyGU0YFTsnkYOI8h520E8bmZeLuUkBGlkvI5BFzPfmszImU8xkAK89GNl24wieoxGHNC
         jKtA==
X-Forwarded-Encrypted: i=1; AJvYcCXhuLWWKNX2Gzss2J6dyPvU1wPc3zCvvJP3sr/xiE1kk7D6iPrY6V/YzAEOqY1Xufusixg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLLSE3R03ghtQEaYqLiC7+R59IsdnfnkMMTsp157u7oXg2ca8
	AZG2rHBRymEZaKZSQrOyfv0mpI5Y9445AW4gG1iKLtXMTmXfVfdM4RBD
X-Gm-Gg: AZuq6aKrdZlCFBBSWne04gmFoSHIkCdARTkNm4/FI5gMIe69BakJHe4L2duxY/AGbae
	dtwnhtXxkv3s+jcQMB+WaMyziSNar83DO0tXhNdRJR0bSHFThLnfIrK8KRje9cUPowwv02945cx
	dzE6c/elF5Lgw2/KDE/4kca9WZ18/rWNlpUQjUQ4KcKTq4dZfcx5Oc4QRsjr10otm885m+96gFF
	7Wa32Qb9VT3LXhT66Q43N0MuZTOixI/4h7uMCPTW+PLtd8oAdWh4bpacZegExKZ+Cr7eCRgP107
	dJncdnbPwYBs9kKnSArtZ0UJ3a0WEohZi3mYxyGJOQZHtqwRtIH20Z1cboeivAfK+JoN9U11mS0
	nLhqk+BKw5qTjKAnAbGAZoKOPpOPJbiDP4nIVKlLEI8aJaSgbGvVQevp+mBh+1iTCf3v9im+EsZ
	lI5gIR6W82KZfYCKiX
X-Received: by 2002:a05:6000:186b:b0:436:317b:f3bd with SMTP id ffacd0b85a97d-4377a57c769mr2377079f8f.33.1770718654554;
        Tue, 10 Feb 2026 02:17:34 -0800 (PST)
Received: from ubuntu ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bcdfcsm35351192f8f.10.2026.02.10.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:17:34 -0800 (PST)
Date: Tue, 10 Feb 2026 11:17:21 +0100
From: Bello Caleb Olamide <belkid98@gmail.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com,
	christian.couder@gmail.com, usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
Message-ID: <aYsEpvFwCSHb5DYO@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is how I implemented the suggestion

diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index fb8b8787a4..59bbb849d1 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -10,6 +10,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	struct commit_graph *g;
 
+	memset(the_repository, 0, sizeof(*the_repository));
 	initialize_repository(the_repository);
 
 	/*
diff --git a/repository.c b/repository.c
index c7e75215ac..0af40b016e 100644
--- a/repository.c
+++ b/repository.c
@@ -50,13 +50,27 @@ static void set_default_hash_algo(struct repository *repo)
 	repo_set_hash_algo(repo, algo);
 }
 
+struct repo_config_values *repo_config_values(struct repository *repo)
+{
+	if (repo != the_repository)
+		BUG("trying to read config from wrong repository instance");
+	if(!repo->initialized)
+		BUG("config values from uninitialized repository");
+	return &repo->config_values_private_;
+}
+
 void initialize_repository(struct repository *repo)
 {
+	if (repo->initialized)
+		BUG("repository initialized already");
+	repo->initialized = true;
+
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
+	repo_config_values_init(repo_config_values(repo));
 
 	/*
 	 * When a command runs inside a repository, it learns what

Some of the tests that fail are related to the submodule and a
couple output is shown below

./t7412-submodule-absorbgitdirs.sh  -i -v
...
Initialized empty Git repository in /home/ubuntu/Code/open_source/git/t/trash directory.t7412-submodule-absorbgitdirs/sub1/.git/
[master (root-commit) 50e526b] first
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 first.t
BUG: repository.c:56: trying to read config from wrong repository instance
Aborted (core dumped)
not ok 1 - setup a real submodule
#
# cwd="$(pwd)" &&
# git init sub1 &&
# test_commit -C sub1 first &&
# git submodule add ./sub1 &&
# test_tick &&
# git commit -m superproject
#
1..1

./t4027-diff-submodule.sh  -i -v
...
Initialized empty Git repository in /home/ubuntu/Code/open_source/git/t/trash directory.t4027-diff-submodule/sub/.git/
[master (root-commit) 4431e0b] submodule
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 world
BUG: repository.c:56: trying to read config from wrong repository instance
Aborted (core dumped)
not ok 1 - setup
#
# test_tick &&
# test_create_repo sub &&
# (
# cd sub &&
# echo hello >world &&
# git add world &&
# git commit -m submodule
# ) &&
#
# test_tick &&
# echo frotz >nitfol &&
# git add nitfol sub &&
# git commit -m superproject &&
#
# (
# cd sub &&
# echo goodbye >world &&
# git add world &&
# git commit -m "submodule #2"
# ) &&
#
# git -C sub rev-list HEAD >revs &&
# set x $(cat revs) &&
# echo ":160000 160000 $3 $ZERO_OID M sub" >expect &&
# subtip=$3 subprev=$2
#
1..1

Thanks
