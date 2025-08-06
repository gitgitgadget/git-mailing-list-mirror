Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAB81F09A8
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456026; cv=none; b=qe0cz5ocEkqQsBO0ggW0q1+dXyDuwERR7D3gmsPNAtfxxa/i2+63gAtke4endSnU7D93q8VYcrw5lHG04SCUKF1bWSVwXJLenvk9qDiEYWajM5kVv6Cvf+qB6KQd3YG//l0T68rgKcW/iZNcnuManXQ1KgFkcvclUUJ/VnYYOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456026; c=relaxed/simple;
	bh=VBzOjKuu0XERfdW1a0nPwFNP3O5tsNgOCfgC2jdYwcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kja8w2NhuK7p5qIVyZkCIsCkTlUWUuLyNbNHuIOWSo2j7GRiLd7OK8YvBVNZaEqipTMD4BvKeJ+85Pmc32oIg+e6pFyVepDFNrtGg3mmOkQiWyLDSMYG0mNpLmwyuJBFigbZFnEKX6pRn2ReVKTJ86nnIgroAUFDuUZVa1qR01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUn4HEKI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUn4HEKI"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73de140046eso509799b3a.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754456024; x=1755060824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJCWndp+whV/KX1tXDtQO44AP4hwUzIvz72zgMZDKx8=;
        b=iUn4HEKIVP1VgugB/fjRL1pU6xwDq2O0qaY52ebBqEsMhVMKBhnSHXUJGfscP687Rq
         Y4zrEnMqiui8I6J4XCEe5qYAe6UBNNH134dbY+iVW07OYgUvO5ED5Ve736JB5mCcwBds
         pWwa8zv/9ZsdvGvzoZbbrj0XVA1xfg6fVK/Pm0XjgF5Fe4+vr5B8f5B1thv+WwxZC2Ga
         uSePI4wW/dJoxzraHKveb9V/ILIF9cmZSjQWXLvwUYYGp31vB26f5wrbTdLtkI8uFWuz
         Jb0Dgr7MpPgJqUbA9OQbOaZlWZ2tlXf5/oqJ0GswTbS/iq+Jpwn5Ct+lq5/z7lQPnKFk
         agXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456024; x=1755060824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJCWndp+whV/KX1tXDtQO44AP4hwUzIvz72zgMZDKx8=;
        b=RBMTnpDNaSqVQYWC0z2D87VxQNpnPWsI2zV65fPtZfvXE+GqRVhvMNPQt9nkku/YJe
         K6dlg63sJdySlwXvzt7C07YllsJ3rL5/vlfBeZefTOVLRY046SYw/YGtuF8AjYbmbcO+
         cl5z9H5le3Ag/nva48aMzQRZ8wbIz2/h/d7Eb/X145aDaFURUrw8m3UV3HTiM47+QI7G
         0Mq6237FFp44GvLGCNDZLrHVypDAsYFYA3D8j0nnGBf5gUqbQavRPOIQeHJDFg1FSY3E
         vfcE73lrXZ+ps5Hbe/4qh+x00wH8PQHLNEUPQF5pnrVsPCh5nZZHOIishVbTocXQWreY
         qQxg==
X-Gm-Message-State: AOJu0YwMjZLDgR6J7NK7dxD33FF4ebUt2tqn8XlfvK4k4X+j1IiSgKa+
	tieV85BiYmsWji+ZbU4oUZqD1r5FHbY8qp1pC9TGF1WYgkUamuE00u/ve+XtWw==
X-Gm-Gg: ASbGncvuznVe5lr9hXYdzsFnGBqbiaMuICn3ck7/dHzly54tay+ZYj9c2qy20us0wt/
	CsACDg+doDTtlbjnFUeEiyYRs14/cVFeq28NcfTOJrj4HrZAQhZJ7lPHQGEXjpU2XcWUcpAidj8
	Gxh8/La3St7Kpog8I5MLt7oFS2bCC+byh/ORDlBm5+vHjEFAkUtglcXK3QV/OI3E/oQTlOMqMOM
	MX7NMhVaGNPseWNPMT9JTqc6xh3p+oIuo6A3XOQvR9z/rkelUaoj6Pya+J0/v814lyYgCLVGOC7
	8xopguMDv7JOqa4J5u3Kuz8d5iF/EM6Q3HLw5QSqLi8POVXEgNbMhSLdFpzLYnbdFRjcP5136kJ
	5WOCsWWThZN1vknT6NYkLY5rwgOLpGBo=
X-Google-Smtp-Source: AGHT+IEmVnMEzkODjjzDKJIIJIbNJ/JNHslr1Kvwdq+nvZiNhhSApW5DJ3y4sQoE/W07ljFifPrCnQ==
X-Received: by 2002:a05:6a00:ccd:b0:76b:df37:76a7 with SMTP id d2e1a72fcca58-76c29a980eemr869143b3a.0.1754456024263;
        Tue, 05 Aug 2025 21:53:44 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:7ec2:c6ff:fe46:ef9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf8f12c95sm7890180b3a.2.2025.08.05.21.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 21:53:43 -0700 (PDT)
Date: Tue, 5 Aug 2025 21:53:42 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <938dfb8d4e37ef962c811d6e0f32122a2522deb5.1754455931.git.liu.denton@gmail.com>
References: <cover.1754375026.git.liu.denton@gmail.com>
 <cover.1754455931.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754455931.git.liu.denton@gmail.com>

When "git push <remote> <src>:<dst>" does not spell out the
destination side of the ref fully, and when <src> is not given
as a reference but an object name, the code tries to give advice
messages based on the type of that object.

The type is determined by calling odb_read_object_info() and
signalled by its return value.  The code however reported a
programming error with BUG() when this function said that there
is no such object, which happens when the object name is given
as a full hexadecimal (if the object name is given as a partial
hexadecimal or an non-existing ref, the function would have died
without returning, so this BUG() wouldn't have triggered).  This
is wrong.  It is an ordinary end-user mistake to give an object
name that does not exist and treated as such.

An example of the error message produced is as follows:

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c              | 4 ++--
 t/t5516-fetch-push.sh | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index e965f022f1..465e0ea0eb 100644
--- a/remote.c
+++ b/remote.c
@@ -1218,8 +1218,8 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
 	} else {
-		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
-		    matched_src_name, type);
+		advise(_("The <src> part of the refspec ('%s') is an object ID that doesn't exist.\n"),
+		       matched_src_name);
 	}
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8eddf3e40d..46926e7bbd 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -471,6 +471,11 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 	test_must_fail git push testrepo main^:branch
 '
 
+test_expect_success 'push ref expression with non-existent oid src' '
+	mk_test testrepo &&
+	test_must_fail git push testrepo $(test_oid 001):branch
+'
+
 for head in HEAD @
 do
 
-- 
2.50.1

