Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73614831D
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886768; cv=none; b=OxzEs74CGhqccCrTAlaCt1CeNSjXkKp1/NtS4q0g5QKZomk7gpC7uvrcSSK4p1wxALQpJIoYWKWdZQ4sqsmHzH3SaFLZ+YzR5J4Ta9lbMcw9DoQvJ5r+pZZDjQh/0bz7QgZS9RZ9v9ZzdNwRxsVspY11ylq9D6KtV5w0Ns5vC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886768; c=relaxed/simple;
	bh=PeWD7Xzsyt+Jh9Nqsn4TpYWX2egoJFqBtWAUMS9nZWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sbrJ5jU6+P0a3GuJM6Kygw/olv3HKvV43qBBP8LiS/8sRYiDj6QqG65jjhftSpmhBAY7fj9PhCQtuUmGjxnlM2fzsyGmMM9kPkgxTWDXZOjJ72FY4dNtHXDJQfa3bdmb0XQVn1eYms/py4b9D4MCZOcPAJbBH6ItvXY2rEILOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV+u69nP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV+u69nP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so1419140f8f.1
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886764; x=1724491564; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=PV+u69nPyI+dao45hDjCJjNoHMDrGe2tBKCtf4zjIqKTkNZR8IGERNFE4mNwl1hlUi
         ylC1nqYd3MkmfHK2QriTG1ilcsIjJXKDWhm16dBTj7TNT4XL3R8V++LGQNAwjeXhJn6Z
         zOEkfKvDWmMMfjj3dQQ+pvFyPvRZQPc9zzpZ1sm+Mz5YucMWZVQ7X/3x1rJpnsNdaknB
         er4KsjEyt3qVxzDeoKpQ7Zney378Zd8bC/yx8fgj33EzjR3KJaQ01YZlSOYoBlnGBbWP
         ZqtYqYNzvruZV8ivu+T73/X2LzTTIkjSvc9miXZfVn10MaEmP64Ck0NIr8/Uv2hluBcn
         Y30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886764; x=1724491564;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=Zj6WKFnMhRfSvsOIiUKEvwi4m2cSI1JDUmDBWX/lsBfM4E/xkKn/72Qb80mKMwedm0
         z0XECesoRe8oz7IM1DTJvtGxxO9MTM61Y3tNQUHPS79muM6FMKbFqdFRGM1WTELSclGM
         DdbsresJEhFqMp+wLzX7M2ImF6gCwLt2G9HyY055BP1AW5uPtt1yARJPQu9P6MflgP7W
         DFN9/qMjKY99wPN9DbTkh7jKrsdUgsAUqVpLYnSFdyMo9WrA+EfRHX7r9Ozos/nmhNzR
         rXqgXH4VWLbrfoRmPsKF9hGZX9vhzRGC6s+u9yGazzx2EH5eQ84dn2+PS+eM2h9howiI
         4JsA==
X-Gm-Message-State: AOJu0YwKtOzGeN2Zn7zxEDbxlI4FTk+FX3i44XciRz61XjQ2Nv8hOhgf
	Cc8HIr6mfwMbJFvJRurb4n558g1vSGBwgYy+f3JvuNOfFJb/jVNt8pb6ag==
X-Google-Smtp-Source: AGHT+IHnpl7IIWCEXgubz87Orj9DemIiK2m+Qw4jbvpYOKftE4fp4/fk//2DkYFV2bcmcb0uc/C9og==
X-Received: by 2002:a5d:424e:0:b0:371:9366:6d8d with SMTP id ffacd0b85a97d-37194328b5amr3445376f8f.19.1723886764285;
        Sat, 17 Aug 2024 02:26:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aacf9sm5419978f8f.102.2024.08.17.02.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:03 -0700 (PDT)
Message-Id: <680ecb524040c64f886c4e484a64f0d17b512e27.1723886760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:54 +0000
Subject: [PATCH v3 2/8] git-prompt: fix uninitialized variable
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

First use is in the form:  local var; ...; var=$var$whatever...

If the variable was unset (as bash and others do after "local x"),
then it would error if set -u is in effect.

Also, many shells inherit the existing value after "local var"
without init, but in this case it's unlikely to have a prior value.

Now we initialize it.

(local var= is enough, but local var="" is the custom in this file)

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index ebf2e30d684..4cc2cf91bb6 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -116,7 +116,7 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote svn_url_pattern count n
+	local svn_remote svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
 
 	svn_remote=()
-- 
gitgitgadget

