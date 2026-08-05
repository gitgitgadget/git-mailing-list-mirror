Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80D364EB6
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940014; cv=none; b=aS8+q4kUAnSzXHZFNoPYCbzCts7kbAKdiDNLiiVjgJX3lgjeEAk1uZja0ac4STLLhuDI+DzGn5YoylC4ZxX2YDeSLIxFbPahdT4JteB5EmmfM5LjUqu7XWqz0lI2FvUoJWBu7aG1JFWAg7sPZTO21O1KAV58FC+kZIIzMYUYRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940014; c=relaxed/simple;
	bh=G8sl7dzNjgylOgBZaK60IpBPczSgVPHJwVnzdpn98mk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EJi1JnhrX9mIGQ2h4ZXxzE702j75g+PUm0SFqH8rUqYW5W3tnXR72+upG4whWwqW5UJMkPMOqCUjUl1swrwisn6zWZ9XLxUZapW5au2SgNkuER2aSWnQj/m2vI1BIftnr1Q+tJ6OInVg5M9BLOGLjXSekHis9xwB1yYaTQA8G6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXV/7XaQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXV/7XaQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-527e352a167so6410661cf.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940002; x=1786544802; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YyKion8qKaZ7fDGgi6y8OS2wF/7TkO90zb+N3hqj+GI=;
        b=XXV/7XaQA5Z7rQD/8VmU6BW0t8UZk7DCW7JbKIACM5iYaeh5oKTdbCkpx911lc1Vil
         Jr6laJFhEQYEKbnxNIbfSxwAYCWNKnyMBxePuJ1aHlahZJ+gQqi2puGvS9cTpPCAP4Ug
         luiuTPb1SxmnV2/z5JO6rS/fffy6hYYS8tcgQC6ih1bfz9stsuRx7EKRC3L6dOTJaq+6
         FIDo6CDFF5qXPOgo8z3Ez/Twmoa/HiDv8mrBC2UJxstkqQPZo55nlpLNR2BHq811rvKn
         W4ySY3bq2W+IsAk200hUwAwSaMqlXGMMiNnB0W9kQX9OjDxw4zoaZr/hoWlCpJ/fL22P
         VeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940002; x=1786544802;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyKion8qKaZ7fDGgi6y8OS2wF/7TkO90zb+N3hqj+GI=;
        b=HbeB3czmEmLansQ3wSmHPVXTwe7LV5+41eeBWDgMNkaa7PWo3rN0syKI6E6Y98bWKQ
         5Y6ANsLtsRbW952uc89rSeyvDpq0SxICmFkWftGN9MiWOuKEP0ar4S3ui0zD4XRBe3Qx
         glnO0FGFzSx9oAf/W85KrW385y6vupMfIVmnLepNEYo8DfqSdExraLopwkn7qHGJotyz
         xUBqWIbRkbKk3qdS4iqwij8a3tppJNQLFBIHTqqlh/8Ld4YZ2gE/xMq5oaf/KRZ11Z+Q
         BX4bvG0BhQZzFIEZM13O53bVaef2QqWZb+a2elQWz84H7Vlabm++udTZKEzpNfqnPZqe
         NCAA==
X-Gm-Message-State: AOJu0YzD6vdjK6HvSl9yrHaFAo3QaEgXx/+sqB4ZlyktkiUu6dtEW8T0
	fdLS3yKlZy0f2UPAwOQtHPfd1CQ5SugnHr6sP7UKKJDBNTCzUw7AsRCQJ/2W2g==
X-Gm-Gg: AR+sD13YEEJOcbcvxWAOJ4kA5QsNJyGGvOYZ0kWI41BZFQj1nvLnlnfpq2OHJweDgsg
	BMNq3n2Qc6UBgu/RQFA54tdxzpzhPCxdjPqIT8vw3sxwaiLl5GfTaFJKhVkpTRAPo80reVjRgNK
	MipYcty042P/S405aXA53HyeGgZBij4p2mVSrKAPLXArPHtLI/uu3jK6YwHfsZUxC/ko9h+A9Uk
	q3M46B+ySet+u3YBc2KyS4oz3Vfi/VlOC2sYco6XDDOqaRh+TxIvNlvl5nAZiLkKfDx+LFixE18
	Z7TyqwK73ns92YAob7qSkbnAjGKIgTzjE3n5kDE2THrNi0zjfnXXk8JPlbZolRwMslK/WsCdcJv
	dQvvy+q/BVHCSZHfST0JhIntUSJuSr8huTu6lFdewJaz1dj9GGL79d2pQZV2SNELCqBRaWJWYHr
	lZ1BQ7TCFJhiwUkwzVa7E6NHECKWttH5d6fbAL6jrJJkZtSjgHu9xspD1d67qDIZQ=
X-Received: by 2002:a05:622a:2b4e:b0:51c:17cd:1fd4 with SMTP id d75a77b69052e-52ce622aad1mr69867871cf.41.1785940002172;
        Wed, 05 Aug 2026 07:26:42 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce87d2d7csm21138001cf.11.2026.08.05.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:41 -0700 (PDT)
Message-Id: <fd594ffa6cfacaf7896ab312d51d39f30d09be81.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:27 +0000
Subject: [PATCH 01/12] mingw: include the Python parts in the build
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

While Git for Windows does not _ship_ Python (in order to save on
bandwidth), MSYS2 provides very fine Python interpreters that users can
easily take advantage of, by using Git for Windows within its SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9ebd240378..8dd8acfaa5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -781,6 +781,7 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
+	NO_PYTHON =
         ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
-- 
gitgitgadget

