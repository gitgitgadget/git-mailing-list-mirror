Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62088156F45
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698020; cv=none; b=rBGiQKPtJq6Rn/xMx8UUfe5DDsECmaE1EwjrpzMm2WFB5zK6O/Br+VIVokVcTUM1DKOx2LwYsOTzRSSbxioUQzr+d9h9Fu2QhNwnfJqfe0j+UvZreXIJAenHLe9BTAtvqIpypsG8AMyod5q7rD9hsJ3GFI5M2DhuJmM0w0G8UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698020; c=relaxed/simple;
	bh=nan3WV+1EtYevF9wmrP7LvkWfS3bB3fquB1a/MbdydQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LBUMf9/Sjyvr8iOe9WoAiVpX/UWJYjNFlpAqN18NCZm5IPGl/bYHif8alaE6iG0VKhRW58CiKzz7bIy6sRdc0pf/UtaPhGW11KxgAhJetZmIpfT2jGol7pK9jRX1qKEPzpzxSm/xS2S+X0wqjFeABpk8MvpJwOMNkqrJhEeQ2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMrg7Biq; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMrg7Biq"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-50e2e0ce5f3so719219137.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698015; x=1756302815; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWFl+/GElgbhR+2wabBOuKDv8EtXRsHFP8uALPuesc4=;
        b=OMrg7Biqx5UgwdqnsJpfD+4rINTqRZAQfRODW4LxzXqiwBAP1pJwIdc2Q2WYtaTSeT
         O457ZQheBo6v1g3U7uITNA6C7mx6WHwLVSHJcI8oV+mBPGRcM7bdeF3tP9cvKAEOHOZ0
         +Mq5YSjYMwyUd0n0sytKMTFxP83wB45N3OFQ693bIqUz9sKDCRyj1JEApH8pKzlnhrz8
         EVhUbrU36tR6NI3tzxz8rLu0r5HTOtT4F8ISRvhjd0l2gHI+95HcW8Zf8QdvyzgMDj9J
         cP+Pdrd/BoEWLSvKEy6aHT/EnxIXIjjMNG/eOSYsZ2BhzQ2Gt0YPW4XwIOSRW0qwVlbf
         thTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698015; x=1756302815;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWFl+/GElgbhR+2wabBOuKDv8EtXRsHFP8uALPuesc4=;
        b=IddUxJklasKELflPIV20QlvkB46iTA6Tp6ZnTcTwVw6yExkly6Ip1BaGgH/qeZJlKe
         42KY9nM8hkoIuJ7NUvRCphB9DRvMMQ1BmFjLNGBrdsUydLFoo5rrZuDL7VkmWV9XMxpX
         gMGAZeGWGah83VcKikidpcSTuu/vsgzPutdSMVUhGT0pVnxjID7NnIN4fb8hzGVpYXSy
         n/OdcMiXNlpV9w1lkgYfE9l1bUFceZAKBpLVOHg56/mvWAAwdVy4egNj38pRbVTEW/k+
         EYXouS29VD6Ze8TEnd9j8dTkHgSdKyqTkQxM/1mF0zjDaq+QiMn/BZDzYBik1EOkoKqi
         zM7w==
X-Forwarded-Encrypted: i=1; AJvYcCUlZFRC3HTrV6TbMHEOH25IVKMVqwqwo2ouB6EzagYfxSnPU6E87/0YNEyRY+/fOoHN2ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkrJQmnF/aui6D65Qhd+b+0qXAD7hqV9R+XS0TG4OR0hAe1Ha
	90U+k4SWy1dtrzt/NxIK6b+zj69xelcMfSfF4GLcvIOff//CwZHCf8p8A8Gy52ZxTvnPAVrz57m
	xBWmdhrf9uvhTm1slh+ITlK4NZpcFgNfO5g==
X-Gm-Gg: ASbGncvIb7s+n08/E2VJa22WQoyrzj9Nayh5wHgj5rlROfJ5MvUxGtB9bKTU96XRh2G
	BX+TtKHLO13NROLRD9nD99ZnbX8Ea5A80zNnZehXYiXHOIIUQttEUBAz0vbQOyeEm5BdcQmkzZo
	MstADuNORsv9wj93Zg12ROGaqFX33LM+K+brGMfjWQbZNQPjMHBsPJ8jJzkhu1hcJ6EbwzMfUIC
	uQJrVJFezi7rXLM
X-Google-Smtp-Source: AGHT+IE9o8sGJy9HOFBFuk0LWSSWa+Yqo82w90YgXoQBWQF4wvfw4duzg+bIb+u7khJ7tg/ghtJiN/Z50/kkJE7pN8k=
X-Received: by 2002:a05:6102:94d:b0:519:534a:6c1b with SMTP id
 ada2fe7eead31-51a48c5b213mr1052758137.15.1755698015104; Wed, 20 Aug 2025
 06:53:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:53:34 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:53:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-15-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-15-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:53:34 -0700
X-Gm-Features: Ac12FXyJuuItLvMepW2NZJW9RyiJ6CGTU_6GUgsWDsCKRqGEN3QNTUbJsJ9m80g
Message-ID: <CAOLa=ZTZzomWcCObMoBtNzFzNrC-OCWuzTqkTUB5+xnJ5VoV1g@mail.gmail.com>
Subject: Re: [PATCH 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000860fcc063ccc4c78"

--000000000000860fcc063ccc4c78
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `get_all_packs()` function prepares the packfile store and then
> returns its packfiles. Refactor it to accept a packfile store instead of
> a repository to clarify its scope.
>

[snip]

Nit: From running the clang formatter, small cleanups:

diff --git a/builtin/gc.c b/builtin/gc.c
index 030d0b0c77..41433b31ed 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1424,10 +1424,9 @@ static int
incremental_repack_auto_condition(struct gc_config *cfg UNUSED)

 	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
 	     count < incremental_repack_auto_limit && p;
-	     p = p->next) {
+	     p = p->next)
 		if (!p->multi_pack_index)
 			count++;
-	}

 	return count >= incremental_repack_auto_limit;
 }
@@ -1491,13 +1490,12 @@ static off_t get_auto_pack_size(void)
 	struct repository *r = the_repository;

 	odb_reprepare(r->objects);
-	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next)
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
 			max_size = p->pack_size;
 		} else if (p->pack_size > second_largest_size)
 			second_largest_size = p->pack_size;
-	}

 	result_size = second_largest_size + 1;

diff --git a/http-backend.c b/http-backend.c
index be4d8263a5..c5779db79d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -608,16 +608,14 @@ static void get_info_packs(struct strbuf *hdr,
char *arg UNUSED)
 	size_t cnt = 0;

 	select_getanyfile(hdr);
-	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
p; p = p->next)
 		if (p->pack_local)
 			cnt++;
-	}

 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
p; p = p->next)
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
-	}
 	strbuf_addch(&buf, '\n');

 	hdr_nocache(hdr);
diff --git a/http.c b/http.c
index 16a1ab54f3..bf8711d6f8 100644
--- a/http.c
+++ b/http.c
@@ -2416,10 +2416,9 @@ static int fetch_and_setup_pack_index(struct
packed_git **packs_head,
 	 * If we already have the pack locally, no need to fetch its index or
 	 * even add it to list; we already have all of its objects.
 	 */
-	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
p; p = p->next)
 		if (hasheq(p->hash, sha1, the_repository->hash_algo))
 			return 0;
-	}

 	tmp_idx = fetch_pack_index(sha1, base_url);
 	if (!tmp_idx)

--000000000000860fcc063ccc4c78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a8df4054849074c9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbDAxd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGM4Qy80bEVwT3BrY3lpQmE0dzBDWnBsVHVpenNVVgp0Sm5jMDdEa0FT
cGhWRTBna3JvaWZoQlVpQmRabzlWOXZMTVpYQmdhMnFqSnN6RHBsYnhaVGpLQy9xZzA3RjBUCkV1
dkhOcklvQnNSa0RGWU55ay90RnA0V3dNZmI1VCsyWDhYN29MOUM0YUx5TWplSkVyc1M2WUpDWmhl
bm1aeGUKdDJhaGk0VHZLWXd2eXVZYXc0ZExBQTRGY0x5c2E0QWZsamFZemdOWGM1NWZQL293cFJy
VmVDb2xSQTJ0dUR1OApSTDBRamhxenVQREtHUGUzbGxIc2V5R1Y4YkZPcTM4a1Z4NUIrYmNQU0tO
L1R2NXNQMFoxSG82TTBrVktXL0wyCkNJQUprNnRNeXBvazhYM0NhNStQTzljSTZyamo5MjNCUFJm
MmZ5cWJvSGlHb3JldjF0ZE42aW1ncEdTMXFNVWgKeXhRYXNLTit5YmlMY09JYVZXNHo3S25Bdm9p
ZGZtZ0UyOTd4VFlxcmErcUNQTU9EUTRyM3QxZEwxbGRialhBUwo3Yzc5MExKSFRicGZpZUZJRmJy
dWhTbmsxenUzVnNLSFB0R3YrLzlXWkhSMW1BNjZzMDhKblVFNUlhUkEzRG91ClA1UFE3SnVaY3lw
YytYN0xDRFhWZzdLM2tFQjA4K0crOGY2STVtYz0KPW9hTE8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000860fcc063ccc4c78--
