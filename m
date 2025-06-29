Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2535959
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171261; cv=none; b=EQ+8GA9/qlw4T+mln95LlCbvSb1GNCQuu4TCD8wPxfvjhG+nxGi7458FEO0BaI601bbzuS6FJx80m8kj+fUQ23ar4ka0rZiFsgbcRUWm5Kke3/lu1ESbEEwWYNzzueOyG2U9PIKLMYVHWSAeBXXcNNiWOAOcn3kOd1zi9B4Wo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171261; c=relaxed/simple;
	bh=w2LTWHVPB1RiNgnrtmD3m+U7v603alREs0VJISX+TPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+F+OuWEawYJ74/cpzqXyg6v7TxgyGijNr+MhsqCF2x0uBLrZblh4cM0eGcr/qttuHyIJToN+WXSYECxH5GSakM6APiTOl8hQwBBIjQHv450qi/oMQwefx1Xl7Ny0Ie4z2aJxcehqotobi0NdTrtRkcm5m+Wn1+n5syaUhCow+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M09JBGz4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M09JBGz4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313a188174fso3604881a91.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171258; x=1751776058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTx73d6QIx7SMdZx4m81X/qTdilvsbdSXGU6FvrDOw4=;
        b=M09JBGz4fIv5MLHtqXu2zHg9sFZ2YWuQ2ATQjx/LiByWPE2+sWnDA+MW6wBgz3E+pF
         27XOOotUmMW214z8bwR7OoEIj6DbcXoqLOk9qy4Q73/zZHJVOiRdLUfqxCxvn1noTjlZ
         gvhcLA4RhSeKR895SU9RpI2VhvVfGTAB0fQx6Tbr3x2ThW8/FM2Q6syMf+fTQl0N+vu+
         Ulcg0LvzymJ3c+N3Odeh/xK1CfEc4r+BVPG3TDt+r44PK8S0OMnt2ofdUB++sVXwkqqG
         kYz88qUb+4FdzUmfyFpSzYckG+7N9B5gZUtV6jZZ8piwhtlKg6Yi1k3J4gfVyxac2KZo
         K8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171258; x=1751776058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTx73d6QIx7SMdZx4m81X/qTdilvsbdSXGU6FvrDOw4=;
        b=lkyMz9mfIQ9LVXUvUlqbwVeKojEKtTKZLWD1U79Jr9DWfzIbtARO2PsSjln5mbNxUM
         boKuV1DkKzkQOFY1rczL/yuoerAlbW8mvdQXkJCZh5FJE3GbBFwWrQixatKSWWc/vlpc
         wrJlVNpjWSsimgbXMTGougHWck8hrLbVtccK4L+1c9z55IHBHjBHteVsnRn3Nyg/s8no
         hre4wSaHNZQ2NxC+4kHQ2Pm0CHw1pckhW7x/XH2cc3Gi0v76FoX+s3F+7IszQQX2qQIC
         CCgbyjVbziPWlKkcoPPeHlidy8RbDJ5cIzXuw9O7ej3Tw9lnlRM/vph7ds5JtjcQea8V
         LPAQ==
X-Gm-Message-State: AOJu0YzhpFIuTvpOAYXusz923P5lf2xce2l7AAze62kagOvYqVSRQuFg
	BHSAt6WFLjIG3gGKCiPdGOJ6+7SY1DZ0zoiElZEkQprgd7zYtxtPvFVVnIYZLw==
X-Gm-Gg: ASbGnctTBNp0mhPoJobwue+iqiNWdQ5CgWXRsF+GHewWDfpr07/ym/g29Gah8eXMtZU
	rovR+MgN/H87kGPp7OGa8rl29b70W3mZ8HQOsZbL0CGQomY4RzkCIOWU5WVOUnUcGgRk4vsej3P
	jAEKusxf4Y6LQAdVANKlem2BElfWpn/4Ow0Df6BfIKq8I6feJSrim+uE3wjTllv2DFqj2rHOCt2
	GUBYlGUXV8mMcVlZx4lQy8XO39pS/0feByu8reIvpiNNlY+1mExUtxt2SoqsBYq+omrJQmT68f7
	gSDXBbu4JJDtDwiqK09rwAxOifm7GtD+r9AJGVH+51VlmE1QsOJraTSCnA==
X-Google-Smtp-Source: AGHT+IHW2NfGSiMLaLK5+XFz4O2QPmOiVzqTnAZLK6GK44dVaowCmjPECukrWHt5jngO3HNpX44iDw==
X-Received: by 2002:a17:90b:3d0d:b0:30e:e9f1:8447 with SMTP id 98e67ed59e1d1-316d69a9ea8mr16259798a91.4.1751171257931;
        Sat, 28 Jun 2025 21:27:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b82c6sm50913655ad.174.2025.06.28.21.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:27:37 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:27:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/8] string-list: remove unused "insert_at" parameter from
 add_entry
Message-ID: <aGDAxQKvqecRqG7U@ArchLinux>
References: <aGDAZ6a0-PyXXGmK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGDAZ6a0-PyXXGmK@ArchLinux>

In "add_entry", we accept "insert_at" parameter which must be either -1
(auto) or between 0 and `list->nr` inclusive. Any other value is
invalid. When caller specify any invalid "insert_at" value, we won't
check the range and move the element, which would definitely cause the
trouble.

However, we only use "add_entry" in "string_list_insert" function and we
always pass the "-1" for "insert_at" parameter. So, we never use this
parameter to insert element in a user specified position.

And we should know why there is such code path in the first place. We
used to have another function "string_list_insert_at_index()", which
uses the extra "insert_at" parameter. And in f8c4ab611a (string_list:
remove string_list_insert_at_index() from its API, 2014-11-24), we
remove this function but we don't clean all the code path.

Let's simply delete this parameter as we'd better use "strmap" for such
functionality.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/string-list.c b/string-list.c
index 801ece0cba..8540c29bc9 100644
--- a/string-list.c
+++ b/string-list.c
@@ -41,10 +41,10 @@ static int get_entry_index(const struct string_list *list, const char *string,
 }
 
 /* returns -1-index if already exists */
-static int add_entry(int insert_at, struct string_list *list, const char *string)
+static int add_entry(struct string_list *list, const char *string)
 {
 	int exact_match = 0;
-	int index = insert_at != -1 ? insert_at : get_entry_index(list, string, &exact_match);
+	int index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
 		return -1 - index;
@@ -63,7 +63,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	int index = add_entry(-1, list, string);
+	int index = add_entry(list, string);
 
 	if (index < 0)
 		index = -1 - index;
-- 
2.50.0

