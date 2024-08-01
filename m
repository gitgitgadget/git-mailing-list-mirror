Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD63A1DA
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525229; cv=none; b=uNZ/4JzpJgq+SdOTbiu4+agUJMqZwr49fgYrG7B1nRa+xbUAPU3cy84CPElIj+u27EtGwp+C2k/EqR4S+vZVwwIzGOVpK7joxYZV8riE0f52V9hB8st5WbFozysTO8od5thnKH48Tp5h3i9IpTwsbwvh/xK47wtHizKODJ2z8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525229; c=relaxed/simple;
	bh=JWA9C/w6/YEmcyu2LVLWTzQ03HSd0hXmPaEh2daC8o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvRWMc7ZjQ2RlKPgK2fx4bsVmRLUBXXsDwHBEQ0rA0OC7RpnheOpmOXOK0gdN/0YDfdh0Dgn2O5WH2VmN6qiotU+vsCTjbzHKh8LIxcrNN8CUX3keuB1WTrY2BJmaN+p5xJWsekltxvlg2s6qSH1b9Ovdc2hQtr7BDJfkafHu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUZn6Dam; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUZn6Dam"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a211a272c2so1589004a12.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525227; x=1723130027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek0KmnveNvhPA0ztSFdEjl/iAZjrx6Y6BTC+LYQIuzs=;
        b=gUZn6DamvWZrFAUB5awgOhd/1HfJoNoJL5TMKCmT6nuZ72LwxFcn6AfJ2zO++lXeME
         7oMwSXyoRPAVnrzj87bOO7pz8dz2LCs6bmKRR7rJMXVjEsF5l2NrMacJxe6GaEPr3xY1
         VP4HCLbRJgoppJ0ghjjJ7tRF2sBwynBQqG6l4o7zOWZqHBpzUhvmbL9sMbsMWgy/0hcR
         jdJ0f88PvyZntrjynp4sf5fvpkD/+1tzyYrCM2rVGu1tUAVA3AgsS0cGOk92ydTSJZhC
         0H1G3G76aOBvzTZ3qlpv2EENn+XdfHfID9Msgu/Y45f3wBZ3Gh+IB0I4nTY5R03Olh2O
         eILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525227; x=1723130027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek0KmnveNvhPA0ztSFdEjl/iAZjrx6Y6BTC+LYQIuzs=;
        b=DEEvAhwVqL9thSs7NYq/r+jorAhC8d+1Jnn4HDGxniv5AserOtb0cWRbMhc0CRFHz/
         kFWvWpszTYnOrEJEt7rvZrUV0rCbqD6BdSy6sgRc7tDdQTQ9bCx0AO13Iqu5lOI5E0JU
         dzKchrt6oejxmvLjayeyclU9OFXdEG2T8Zo8Df8aAav/89VKvJ5uD417P7KQR4F+QHRI
         SJ3bsClUMyDzCHLryQhFBrIuGlwrpUeigQChsjLD/bsK4TIkRKywWA0YQBbkmPHv5PBq
         2WtiuFaae7e7ca7rWWIUQKjMmiJVwFiMSCRT904s98kTfHJffhv0uTDlY/U38chlOxfr
         +veA==
X-Gm-Message-State: AOJu0YyaIv14tvx5kSM1cB4AIROplVDTxqdu8kiAJqYTNHs9uU0kO5KJ
	ctc/JFJaX7tzg/9bB1OIzUxTNa5h/QdC9qGBF2yb3x0DcgbYiWBKaaYb+A==
X-Google-Smtp-Source: AGHT+IFLq145MnQf5fgzTZVKHOnZ13p3jsYocdZ4qCmWmArF1BP6hZkDAdl3TEGpm7ynVbcobL0F0w==
X-Received: by 2002:a17:90a:a413:b0:2c9:75a7:5c25 with SMTP id 98e67ed59e1d1-2cff0b23d54mr2678718a91.15.1722525226975;
        Thu, 01 Aug 2024 08:13:46 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc432b16sm3449462a91.21.2024.08.01.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:13:46 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:14:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 04/11] fsck: add refs report function
Message-ID: <ZqumQthEwDjoDs6u@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

Introduce a new struct "fsck_ref_report" to contain the information we
need when reporting refs-related messages.

With the new "fsck_vreport" function, add a new function
"fsck_report_ref" to report refs-related fsck error message. Unlike
"report" function uses the exact parameters, we simply pass "struct
fsck_ref_report *report" as the parameter. This is because at current we
don't know exactly how many fields we need. By passing this parameter,
we don't need to change this function prototype when we want to add more
information into "fsck_ref_report".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 13 +++++++++++++
 fsck.h | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fsck.c b/fsck.c
index b394a9e397..ee888c1417 100644
--- a/fsck.c
+++ b/fsck.c
@@ -283,6 +283,19 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+int fsck_report_ref(struct fsck_options *options,
+		    struct fsck_ref_report *report,
+		    enum fsck_msg_id msg_id,
+		    const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_vreport(options, report, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
diff --git a/fsck.h b/fsck.h
index 303174a5d8..0918c28d0f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -138,6 +138,12 @@ struct fsck_object_report {
 	enum object_type object_type;
 };
 
+struct fsck_ref_report {
+	const char *path;
+	const struct object_id *oid;
+	const char *referent;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
@@ -216,6 +222,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
+__attribute__((format (printf, 4, 5)))
+int fsck_report_ref(struct fsck_options *options,
+		    struct fsck_ref_report *report,
+		    enum fsck_msg_id msg_id,
+		    const char *fmt, ...);
+
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
-- 
2.45.2

