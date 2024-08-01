Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5491A721D
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524346; cv=none; b=IhGYfSngmAlQcP1FVlKr1MYU6jy+kyOiYo6X/azwIf4uFbx2iKGvncVfcfswzeK31uA8ChVhKdDAlSzH71g0wOizgFONtIwT0UcH2D6IB5hMj5yjJngV8TbAXgvLmQF+30iE2b7XFaJ9wOyUM0t9iLSQZfUrFolbK/qZ6pEgywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524346; c=relaxed/simple;
	bh=OpPZmYUrsV8atXulHidvDETKj7uSyNnQvpvdemb72M0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t4Qt9dbOk7bBviWXRVKJeF2tsx5TUbdHtfNzB6IovAdR7/Eb4CZZ667Lml7C63gyIxUnFAvPT74B5TPeP3NZ/zELg048QJe+M3zPhVsFbcWoPl2qcec0LlExwetK9yUqu28uTEd2oz4mpT3W30zmp4N+a+Q5QGS7h+Eo0xOEIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPmFcbOy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPmFcbOy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso47019895e9.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524343; x=1723129143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o+6QOzkoDFstLb/LIleDf7nT5ZuJ1Y+2RugF/4LPGw=;
        b=OPmFcbOyQIuDpFerINXlIli6YkBk0J1dKD0uY+ovHcU8fREMjJIDYhV+8YnNLJRTBD
         eraigU2B8gYaPchKjMx3Lcibv/HHaQb3EOz+uiUhu3yHZspHp3B+bXbHhdnIcjnvKTnV
         WhNE3XPIxY1Q/FV7+zV8spTNN9mPzpq7Dl6DdWD/6syODAYB/qH4/6opiZZ/z7UhVb5h
         VzF6OlR6yaCjnIMOznFBpBRt+apzJVw7TrbleHW8MwEO1X34kpNgh+fEWOg0rqkOktDU
         u09+936xR+5VjeyHAesnTQA7pWcLdMBgbj38dX+s3bdbB12XZuymVSou6xBCdQ/5JODO
         b6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524343; x=1723129143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o+6QOzkoDFstLb/LIleDf7nT5ZuJ1Y+2RugF/4LPGw=;
        b=IVXBOh3yZzKVtIhcs6EusbGOZNXd7MthkvC9SwYbzM83DkrRcY0WDXtY/TteV9R2p3
         f/qF3qtTnQWC8Bh0HsadXKvlbBhbW7sFODNW5+nIl4QrfHIUSxA9nVk7XHRnPIOUtSRY
         btLoaPJEk8AcTQ5o7o5EgWiK4YL0YHMeMgf/9OoL66WAlT/65YG/NkdCAkuhaWB5rxzP
         Wjqq5HfQ5WyDLFLaGh3CJM6o+dw0zL5rPF8wT7VlUVvmYvYx90UtuHzAjSlPsew3FZvw
         gMB31Om8t20R1fUGpSj7MqOZ1csFritn1FJ+XnPObJ/TVq0QeBoWx/4PaQoBUbkccy6e
         gxgQ==
X-Gm-Message-State: AOJu0YwLfemF0jcv10WQlAuSXGTFXfPEB48P9weKvWcgW5JZ6QjBoon6
	WyiYcwEJdjyFIE9Bm0eDzeSColdntLDGjwIZTUbyxJJoMnw3dvREfCEF4A==
X-Google-Smtp-Source: AGHT+IGUToQgeUUbxgS/jqSf0Th1lWC+wKfL4vMlcsx7vVJyPPSWaZaoBX2w3D5det82WF+IfNAbWw==
X-Received: by 2002:a05:600c:35d4:b0:426:6158:962d with SMTP id 5b1f17b1804b1-428e6b81ca4mr806335e9.23.1722524342639;
        Thu, 01 Aug 2024 07:59:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac5ff2sm59443305e9.25.2024.08.01.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:59:02 -0700 (PDT)
Message-Id: <3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 14:58:54 +0000
Subject: [PATCH v2 3/3] ref-filter: populate symref from iterator
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

With a previous commit, the reference the symbolic ref points to is saved
in the ref iterator records. Instead of making a separate call to
resolve_refdup() each time, we can just populate the ref_array_item with
the value from the iterator.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 ref-filter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 39997890feb..08997e59662 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2783,7 +2783,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return ref_kind_from_refname(refname);
 }
 
-static struct ref_array_item *apply_ref_filter(const char *refname, const struct object_id *oid,
+static struct ref_array_item *apply_ref_filter(const char *refname, const char *referent, const struct object_id *oid,
 			    int flag, struct ref_filter *filter)
 {
 	struct ref_array_item *ref;
@@ -2852,6 +2852,8 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
+	if (flag & REF_ISSYMREF)
+		ref->symref = xstrdup_or_null(referent);
 
 	return ref;
 }
@@ -2865,12 +2867,12 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int filter_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
+static int filter_one(const char *refname, const char *referent, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
 
-	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	ref = apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filter);
 	if (ref)
 		ref_array_append(ref_cbdata->array, ref);
 
@@ -2900,13 +2902,13 @@ struct ref_filter_and_format_cbdata {
 	} internal;
 };
 
-static int filter_and_format_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
+static int filter_and_format_one(const char *refname, const char *referent, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
 	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
 
-	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	ref = apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filter);
 	if (!ref)
 		return 0;
 
-- 
gitgitgadget
