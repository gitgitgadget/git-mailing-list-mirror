Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A493D45C5
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954693; cv=none; b=H4CXYoStoC69CNsGHhgNvsFUTDmVkBseB9DwyU+94MzAgtJsHOez9EgWa4Pb/05tG+JebRbbk52qxy0PaGAtphP1pEco5yBn1tlmeHc+VaW4Gml4+BMfmHTzse6PgQ7BZSHG0hMgAyHQeXbfjFnsRsF8ZnQhhlaVBj2rUtCFL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954693; c=relaxed/simple;
	bh=uQLJZVL9HEigD2n9CccBEDO6sFWA7MDDOj48V+YqnDQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XVWdJeqZtCd26kmhVzDJ4SrFToJW9XcC0vzNpx+3wep3BpxP0imr5JzZ/2HL+0dwzmVhDWD7rY3d988FwGW57iK0VEfpTc0MpLkkPC5uJHcxZAWnSSXhiVATc7bcHz4uOcVd9yosjaXmRiiDoFdA6k3zB04NDF9WPxxzJiGXgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHkty74a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHkty74a"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848761b5897so1039417b3a.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954684; x=1786559484; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nx5nEGJvitRLLfnypcH9mQv6qgeRnjnPA4fOZ6+KJsY=;
        b=gHkty74a/b9zo6L8BeG1MBhjb0CYRFxrleC6zy0hgowF4y9FieQqMXSk6A5sJuCjnW
         DbwonZ3hs+np8ROCsmDO0LYooMBC8CqwJTo7cL0jNcDhSXOo8YG4E77zu/hzhUwb1Wmg
         R24zLYUt6B2+1pR8omDjcLGGFiKwEiLPUqmmNycF6SVLofBBV/xIAeMpo/Ua3ZMn5Vbb
         uL2a6XqKNgNkpQLQ+MwDsnLrfFZbOXsf+Qby8GQe4d/m7H+nNclCIf6Jov1FPAz26NBi
         IcIrQ6mdDdfxTd3x/O8hXvB1G1XqY7++ZzE46kt+tT9cCj5tBFCB2pfGVVrZOod3sJF7
         e1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954684; x=1786559484;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nx5nEGJvitRLLfnypcH9mQv6qgeRnjnPA4fOZ6+KJsY=;
        b=lx407j/hFeohMf+5XzMFBQmYN+VgMJLy841hEONn8boILlP2LREBvL3ZqIGIHiiZ8p
         e7daPGDk2JIsb5NPxUhN75aYTfNZSpCXiThL8iEMcqhsHJ+RVJnjui9YAKevvVAhcgwZ
         IML/7r8b2spvi7deXwkh0f4AwhZQhx/7AkdcLsNwOEn+ULw554wYgTCk+0AXgFetZ1o4
         w77o4gbU0jW6Mg8nz77N5aK0EghRbAgt4rkiqcloABoE8RYwD6bFKKm6ft83FrpvNij/
         1pxQkiRBjg5/w2kjYQzVeBRIFjdmoYo961JwJI2bQF7C3m1s6HW3vgrcHxFvhZtqsuMU
         lj+A==
X-Gm-Message-State: AOJu0YxHOGWc+aDiCt8S/J9Nv3UZiYDc6iasf/aFLOLHz6caSH7MoQu4
	x5OAzK2Iulte93KF3Zs+MKmnmArzn2BOv2fWFUoNMD5Ml8PRmNIHs5yhvYwAzg==
X-Gm-Gg: AR+sD13pDemKWsnx65JSpwpyV7O1fi36pybIcRwQO1WXq2pFba+UWjJblTNGbbFuqnQ
	zlfcnjsgYfZOJjsRTrX9iP67YCCZGvVxbzgxZHiqYObMu40jpmpcgB0ViWf5pZp7tDtg4RQYy10
	LKYMvY7+TRmMJdWAWpLFsibrgEK/KVgfXvhFjVr9o20iFHitt9OphbS9P6hJ/0bi10GmbzXpmtC
	qLRdbBfGKpLKxRaLCOVnVQaagO7ZF8puFbxYkwMKq1olYHKqBXikJDrj5ypFeSxeaqqcWS0Wjci
	CRr/wX3QnhK6ZlMe5U139Px5yzWKx3Tf4xVKrUyWxSEM3h0ph1VRxqCTJc9omMr/NQBWMwuD6Nk
	8hzCd6RiyXqQZjgwQUlkxGdAh4estMlmjhXZA3hDhurXi1hOGMP06sriJj72HS1r3xUQNZYWot1
	Uw5IxUh5JletkYOEiiDhihmgJOqukDpQ8+I74p1ybMPIYXWQ/4B0zdvn/wYg//Y3xKlA==
X-Received: by 2002:a05:6a00:a247:b0:845:4126:222b with SMTP id d2e1a72fcca58-84f2e00ea1amr11790629b3a.28.1785954684364;
        Wed, 05 Aug 2026 11:31:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e3026d9sm1268508b3a.24.2026.08.05.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:23 -0700 (PDT)
Message-Id: <829cd82177a8e72e450d42db2af3166123c5b7c6.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:31:00 +0000
Subject: [PATCH v2 11/11] bisect: handle dup() failure when redirecting stdout
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To capture the output of each verdict command, bisect_run()
temporarily redirects stdout to a temporary file via the classic
dup(1) / dup2() pair, restoring it afterwards. The return value of
dup(1) is not checked, however. When it fails, the saved descriptor
is -1, which is then passed to close() (the issue Coverity flags),
and the matching dup2() that is meant to restore stdout also fails,
leaving the process with stdout still pointing at the temporary file
for the remainder of the run.

Treat a failed dup(1) or dup2(..., 1) as a fatal error for this bisect
step: close the temporary file descriptor, report the error via
error_errno(), and break out of the loop so the existing cleanup path
handles the rest, just as on other failure paths in this function.

Reported by Coverity as CID 1508242 ("Improper use of negative
value").

Assisted-by: Opus 4.7
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index ceb60b0626..733d28d377 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1308,7 +1308,12 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 
 		fflush(stdout);
 		saved_stdout = dup(1);
-		dup2(temporary_stdout_fd, 1);
+		if (saved_stdout < 0 ||
+		    dup2(temporary_stdout_fd, 1) < 0) {
+			res = error_errno(_("could not duplicate stdout"));
+			close(temporary_stdout_fd);
+			break;
+		}
 
 		res = bisect_state(terms, 1, &new_state);
 
-- 
gitgitgadget
