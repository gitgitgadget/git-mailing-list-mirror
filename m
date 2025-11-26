Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46B2DAFB9
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195523; cv=none; b=c7kXiVj4KTXlQrl17ZPOD9Mt/j4uEB+ICvTNMTKFBOxRLKKEYdqxzeiJuPBPHcnKtwU756NALdD9inDsN4qTKmJLtZytVNUGjbwfGXdPUBb8Z9KMolpD28Ze0Tl0wT+VVM657II9PdVcwlB3nMGUVC14R87O556pEo+07egFoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195523; c=relaxed/simple;
	bh=I6iHoTHYvNgo36u52/1YTvH7ZFaZoqwSOoHq7MgIoTQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gP1oNsnelwa3WKM1o/2K7ffoqAvOvBvZnWjlXDxAefScM5XI+4jPukTfuuB9T0k9mAtpdZI+J7B+Z5Ot9HCrmbid8mtUseseua+Ao1Nz+u69LXV2lDkQNlQZwLo9IQlhAMfVAvtvSRMhaON2DQdsri35KaLImZGwF9Tz+1j8VAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI772GRm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI772GRm"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8823d5127daso2356636d6.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764195520; x=1764800320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4Wr/E6ZKTVUi1qB7vQ90TX8yebOpDGiYnRzBR7dHp0=;
        b=GI772GRm4vj0d+UprblxWnha1XUXxzjIgJ6FVnHIHpLHZ7sZ2qCuE+3MjcQW+ovvBO
         iCYSsD5Iu18NZANktdrHHgCFpiS//RrjNbZab7OIIAQ80kjWNRbCDoX3pySIaWayAdYJ
         DcnU+C1B4CzFu26MCInHytB1zIHY6MEev9hPuXpNXKdu4T5gsr1kL9WlDN21XBPf5wLo
         sbaZYG1qaGvNdIBjU0Hamd3KfLOdF5ehqeXAIyB1NqT6evkwC2MZ4PUtley4ZRdw27+d
         8mMQDpO/P9/9tYgEyXKIofHutIsYgHToKPgZl88v571NuTSLcad0AkpkNZfDUe+S5wiF
         E61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195520; x=1764800320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4Wr/E6ZKTVUi1qB7vQ90TX8yebOpDGiYnRzBR7dHp0=;
        b=IqeBznB2vKy8+ps8LxeCLzoi/gzwnvAVUtX/kgPh+e1xZ8G4YgkAB4aBNYoleM5mbs
         hmpn3r93pbrcbTeysndSQn71ox7xC+5HFKZF+d0bj+9MwORMhA8JSQ2p9P95KmpykW0p
         d3kxVqVvxZgpVeDKgMytUuKToW/PBaPimeGeD9ZgYepgcvwZOwU32Bsl3FohfbjEq3Aw
         h8w/eQfmb0zYwfhCGxBTLfWbX2ZKo8pWJ3XSnG00VG8ecZ8nRDx9MR6RBGnDj3V12CS5
         9jyhgcePbtusOBfbaf5kNR0DsiRLy+AmmqCAK/nkrt06aqvyY3iTwLUlU8+jDja6dFJP
         i+rg==
X-Gm-Message-State: AOJu0YxgxFfWSIim6oQjf7iPDHzIAYfoQ5zrz+de2xmoRWmhT3WKzcCe
	eKTuJq32spR9Sqs1kloSSuyUjvnGT6itZF7Qjy567FtJnC5VhPKotocexY/h6ZCV
X-Gm-Gg: ASbGnct9eB2LRYIlwxJN7KwhVnXQEDCmU7soBn0Am7kzJiiXoo1H2RglOl2vs92iHaB
	OyxAclK5OIipfoGI95IAqQ8y0F9i2AiWIZvQh4Dgi1XZokEjHcKIie8Y8gHAoh//BxKSm8R9OPs
	CwZdTKkkeJjtlJZPt8l/WDOzArxRcb5SpcSRl6PCD3c71SD+nTF4sCNHxiw8mqoD5P+FiLoODT1
	oiWJ43fgDFTYMeCElpcOGPx0asB0xvMoUE5w/ppEJ8rp0k2zyHErf43yjT+syF9MvKDJRHsJemN
	KONt5wzYrGMmO2LtSNJ6NrWapRVRuWbcd4/Rn7+qpkv2oxyspqPMhCQCVa9OrsDf1qZXlHApafj
	jz/t3DvbJjIZowGy6pTa29YvoDwBOaqA93z/QM8eOByBvZU6K1MtYd2DjCmzlT7JoINV4wtjbaW
	izHcfcAYz/vuQ=
X-Google-Smtp-Source: AGHT+IFYBqn6oN0SHFv1nPOnseEnehZaurXz1WTrh72J3+USmAFwYK+BqAmwXA/ajibcQ3/Nfx9meg==
X-Received: by 2002:ad4:5f0b:0:b0:87c:2c76:62a2 with SMTP id 6a1803df08f44-8847c57dc9amr308537296d6.64.1764195520135;
        Wed, 26 Nov 2025 14:18:40 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e599ac9sm155002116d6.49.2025.11.26.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:18:39 -0800 (PST)
Message-Id: <a4ad8f80d062cd9fc62db69c21625eb286f4ebb8.1764195516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 22:18:32 +0000
Subject: [PATCH 1/5] scalar: annotate config file with "set by scalar"
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

A repo may have config options set by 'scalar clone' or 'scalar
register' and then updated by 'scalar reconfigure'. It can be helpful to
point out which of those options were set by the latest scalar
recommendations.

Add "# set by scalar" to the end of each config option to assist users
in identifying why these config options were set in their repo.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          | 16 +++++++++++++---
 t/t9210-scalar.sh |  3 +++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/scalar.c b/scalar.c
index f754311627..431b631585 100644
--- a/scalar.c
+++ b/scalar.c
@@ -19,6 +19,7 @@
 #include "help.h"
 #include "setup.h"
 #include "trace2.h"
+#include "path.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
@@ -99,16 +100,20 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 {
 	char *value = NULL;
 	int res;
+	char *file = repo_git_path(the_repository, "config");
 
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = repo_config_set_gently(the_repository, config->key, config->value);
+		res = repo_config_set_multivar_in_file_gently(the_repository, file, config->key,
+							      config->value, NULL,
+							      " # set by scalar", 0);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;
 	}
 
+	free(file);
 	free(value);
 	return res;
 }
@@ -195,13 +200,18 @@ static int set_recommended_config(int reconfigure)
 	 * for multiple values.
 	 */
 	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
+		char *file = repo_git_path(the_repository, "config");
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "created");
-		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
+		if (repo_config_set_multivar_in_file_gently(the_repository, file,
+						    "log.excludeDecoration",
 						    "refs/prefetch/*",
-						    CONFIG_REGEX_NONE, 0))
+						    CONFIG_REGEX_NONE,
+						    " # set by scalar",
+						    0))
 			return error(_("could not configure "
 				       "log.excludeDecoration"));
+		free(file);
 	} else {
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "exists");
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index bd6f0c40d2..43c210a23d 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -210,6 +210,9 @@ test_expect_success 'scalar reconfigure' '
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
 	test true = "$(git -C one/src config core.preloadIndex)" &&
+	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
+	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
+
 	test_subcommand git maintenance start <reconfigure &&
 	test_subcommand ! git maintenance unregister --force <reconfigure &&
 
-- 
gitgitgadget

