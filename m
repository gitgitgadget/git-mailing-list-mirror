Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AE285CA3
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845352; cv=none; b=uL3uM4ofXxFLaaZ3rvfMDRE36QL0T8WaB0n1oXQS5yhpByFbRAwqgl85/ZeUAPWhmVl00ktfisZaPHGfKqHmLzr0iEb3AOyKi8yamFyb02K8Nikm8s49GKZezalzqS85VNXr8eEOxF5n8LIDPb5HBc+ABTBKKauAmeySmIiqkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845352; c=relaxed/simple;
	bh=Hou3qVzpbnCYqsljGVHAQZKgphN8lRkJUi1A8sXtkzo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fR5l90ME+d0+hV16kKBg7J936sHcTgwTnpZVmWNadMgn3+15xFs3ItKqVyc65cyVJ7Itz0z0eaSB2F7RacyCsXWiz5zyw8QQ0nthKNaBSRBtXWTkB5Qlx8KxDZA0HHfey4lwuU1ci2KTrmAZyGsRDE2KGBZGq80BWznYWl6lbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTd0tdGd; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTd0tdGd"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45effa36240so7050726b6e.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845349; x=1773450149; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxC7hK+BGynk4KhWdkeo8GtNvq+gwyrliT4tHbrXlGY=;
        b=jTd0tdGdAsLhuXL6yCUEsYcFsCQJz9M0v18BjGhH+bSWY2rMpuTvK9w7ZRlBQnhsuW
         Qk+Z6GK4dLB62uYwWaRnVzFtpwGXaQgVrE+apJdMC4pmbC4Si/b6ht+ewY/sdD/5+vzy
         1JYal5pmCawtxPy9GrS6iKDfrvfxVIDuY8uHcXX6unCJ3O8gH4rHozDd3Vv6fhuktZi7
         MEbtzMwdygJM+o+OAMIJxB7HuAwPhBDLzDY8U/DKMNDpjw9z0QSk2ZTXb5M/R2zbbxNC
         riGdgUp5h/W+RIUYKyVFvbZ0BTVhlXfN6Ggfyb8VFd0T2FwPcXd2i1GToPCAkFpvLgH6
         rpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845349; x=1773450149;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxC7hK+BGynk4KhWdkeo8GtNvq+gwyrliT4tHbrXlGY=;
        b=mU8G0JY2Z//b7a9YehQPgaVRTXk55KJNxw6toedtFslcMvk3gapPam1buIABFTDAPO
         KW69H4mKOZSgOnN+AjpzAWwG6TM4oGEWQZOwO+dTljUjL0dfI5IE393fVD9cI/fHRSjq
         wglkvVO/4fCFRnOf9GRpJk7/8aq8WIPIt7PwyLBckJ+XuN5xgkVWIdyhgHwJ08DDGGmc
         HeSP/KjU1RZQ68fG9j3v/ocwR4fyeqerb1B4wU3ejzZwtt9xI0bEGzgmyiVUJpSyzruq
         KP9FDCUXteVSyBOhRHNi6Ks/hfYxx7cxOUEbtUTb2kRDjDQJOcuEsIPegr0L129cTRiU
         ThMQ==
X-Gm-Message-State: AOJu0YzgDsj1/922B4PcRCBtNLHhKYz2KbJE5kDb1I/f1ESIanupBQx4
	MQmFjWnRMobxRxUMbFxDWxWKjGG9PF6Dbd1fQ8MPuuxL4O7MvvpQfqKpRavv0w==
X-Gm-Gg: ATEYQzxVjyBLqDmFE8qhydebYP1AQh4JMZs+fwQQlATLubxocvnCsLdGzY9BX9Jt/sS
	XFqyYhm2G3oQXXadI1oHu6ztKz8yQa9oBaSiP5JEh5MluoByWiOcwsjr/Mtqbe0CO93NlgeL04y
	qbnc9GNX2Xl7NYBRBmPdVqLIx/FRNDcne8uQuWfiaQrEZ+bivCYA5krR3iyjEo37E7u4GIAdFDb
	QwMqIl6c/c3te90sQ5Gj/pNQKFEpi1VnjnGwS1lzPYCuwMaSBkrnsIz+Ks7z9tSDI3rK0GP73mV
	VOSQFJPYThVZsfWltN51AdUX/O+1ZLHty1E6oG6s7D0D3hJAektCFgvwaMN3ltyIUNIw7rsf5yW
	4Wr86brsvapxfkPeMDMJFb3aYWszeuZtgKdRLVGkm2zJsCH9TV2gVSVvq9QIYcggjGHazdjmEdx
	qnhRmGoOxBHE9mnVPRnltxMsA8pA0CKyVCNL1xxA==
X-Received: by 2002:a05:6808:1710:b0:463:bef4:c9d5 with SMTP id 5614622812f47-466dca14aa5mr2212434b6e.6.1772845349404;
        Fri, 06 Mar 2026 17:02:29 -0800 (PST)
Received: from [127.0.0.1] ([172.212.169.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e61b9c24sm2829529fac.0.2026.03.06.17.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:02:28 -0800 (PST)
Message-Id: <0d3e84a088ec53368a748684268db89064632871.1772845338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 01:02:18 +0000
Subject: [PATCH 4/4] doc: note that -L supports patch formatting and pickaxe
 options
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Now that -L output flows through the standard diff pipeline,
document that patch formatting options like --word-diff,
--color-moved, --no-prefix, whitespace handling (-w, -b),
and pickaxe options (-S, -G) are supported.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index c44ba05320..aa236281b3 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -11,5 +11,9 @@
 	Patch output can be suppressed using `--no-patch`, but other diff formats
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
 	`--name-only`, `--name-status`, `--check`) are not currently implemented.
++
+	Patch formatting options such as `--word-diff`, `--color-moved`,
+	`--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
+	as are pickaxe options (`-S`, `-G`).
 +
 include::line-range-format.adoc[]
-- 
gitgitgadget
