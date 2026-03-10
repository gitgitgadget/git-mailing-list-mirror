Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D512010EE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120818; cv=none; b=Q/IpzF0GY68PLMf7KEb2nsAml5km4TkRKZHgrhULQ+4V91lWfyJO7oUqw10MDa9KxZZtNHk5N4t45kHUlZSguS1HHR+QWG/Zky1Q7CY55qhkxuhKK+Hr3aa8wdmoaWFNlc68CJGZ6Xd8lHEKip0DKHDrdh6rGO+5/ktdYtgbR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120818; c=relaxed/simple;
	bh=b3OjusJYFu+K2/8Rql3fFuc0xgfCYLzwwsBV91cwbQQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hBz9VqZzaAxTUEcMr2zejc09R1QafK+wUtrVxeVxfqXOWgF/Gmus21qvy4U2hCEMo7VK5xvIetfpD5Suiez1aKeOdLTOHBAaoK9TvgdeOW7VxNtApzlalhl9S3f6if6a5m+AEeKGoNAJvZYRPwrdoFMj1bablYxYlMhDQUWuFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHbU6XWa; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHbU6XWa"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be26d11b95so11448726eec.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 22:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773120815; x=1773725615; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zLxz5McycoaUMXxJkpJwkFCby7PNVXWsRq8y3BV/yas=;
        b=BHbU6XWaardFSUGUX1h135ZZEzwbCyp31ghVg7l+B5KqRvkOFaoPHKs3ZLbCgboxaa
         ARRvYrybBrSZKuuWtCPqkPwjP3G4yDOjWmcGBeyQtOSX3MplfZkedNFoV+XFoCWmLr29
         xqn96eOuWj+bOwXL6WNGVvVZj2yTz5Y2JNRWhw95cAQB2BnaGff4uvuw0Rxd7NUgd5wd
         IkigEg1jsOoD0a/drmUou5S/PGmDDeOY8oTWFwP88IBeWR2p5AlkDey1qczxHuTKs8D+
         9mbpcEiEjOzc6zF9Z0qYjt3N0CJeeAMyxeafTNPXpWzp8vOlBO/ZDSHUpt4C2zc6K9km
         ydRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773120815; x=1773725615;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLxz5McycoaUMXxJkpJwkFCby7PNVXWsRq8y3BV/yas=;
        b=n/NlYf3Yk35lKbjJ97KAhDe6kf+wG9tDz6s4s3CUYdW8oeusbr0EIK3Hi2JEQje3C/
         YHlpR4HnweAJh5T/Osvb+ObkjahXINwB4RC1lCxp+cb5ouyAj9lagPseFq7rR0mlf07v
         M22wcAE+ZBqNMmWfn9KT91/le5WYf+2UVmz8F8/yhM6tRCM7GU/jnU5QnzHLobkEWiTJ
         bXpcxbjvYBKc2jU+yo0WsKORL3W1BNUEhIr73LXmJFqIqSzMYhyQ9cmMaXt6Wx9DTO4M
         Wat5B5FhDvkFPbpdGNwyi/cNnP2JKTjl2reiRmfP7KlSDdf+02kk7qQuhorEzLrihY3t
         /dIA==
X-Gm-Message-State: AOJu0Yzs7WXrBBAIlL3geYLOYF+z02wjpRftpf2BmBlnECp0FwF+OSco
	hc0phFQww3GryqG1NzUxTnl8UskAjeMSkF7c1AsjSIzP2ggfbkZUpcJb1GtBtw==
X-Gm-Gg: ATEYQzyLT4yRrAkgsv7xAeFCoH1JCTT1wsDn8NKyEUPWTLVHXp+xcxPReKyu61Wtrgh
	0GR/1rPaADxh7S3/ZgAs/ihOQln4sQt2NUJY1a3cPedQ1z4kyHwp54Oh/gtuaz7g/sK+aZuwppm
	xsPcIpu0EIGeBZSAV+VQjyI5BwE7MlNXmqgJ3N/4INNut7X5E+pn1Iby3GWagreao+XMZYXYCC7
	G2SO2uSI8w9vpsT8ogF+UuCZqEYwsRUFYRg4LG+K9Ohb3f+RQSOV55lFTY4aL9Ub4GqgiuSZsiy
	+HIFhKPtvX27uJc8tQmnZDJrdOaGu2F+cRyjOoWRLOb9I0Oodx2ux44blXUwmZTjjq3ZMfI0KtE
	Ay7Qk3PfnDSUQfOffspY8YPYOuo3Gvt1LjMIgTHVO7FEQEIc/MfrbAq0Ner0k/ETu6T+XTOyWJ9
	C4HAvIOnf17pSWRwg/5BLAppnG+w==
X-Received: by 2002:a05:7301:5795:b0:2be:617:2ddf with SMTP id 5a478bee46e88-2be4deaee75mr5147109eec.16.1773120814984;
        Mon, 09 Mar 2026 22:33:34 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96aa32sm11701569eec.26.2026.03.09.22.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 22:33:34 -0700 (PDT)
Message-Id: <pull.2067.git.1773120813628.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 05:33:33 +0000
Subject: [PATCH] t7605: use test_path_is_file instead of test -f
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi <mansimaanu8627@gmail.com>

From: Mansi <mansimaanu8627@gmail.com>

Replace old-style 'test -f' path checks with the modern
test_path_is_file helper in the merge_c1_to_c2_cmds block.

The helper provides clearer failure messages and is the
established convention in Git's test suite.

These instances were found using:
  grep -rn "test -[efd]" t/ --include="*.sh"

Signed-off-by: Mansi <mansimaanu8627@gmail.com>
---
    t7605: use test_path_is_file instead of test -f

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2067%2FMansiSingh17%2Ffix-t7605-test-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2067/MansiSingh17/fix-t7605-test-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2067

 t/t7605-merge-resolve.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5d56c38546..44de97a480 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -34,9 +34,9 @@ merge_c1_to_c2_cmds='
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
 	test 3 = $(git ls-tree -r HEAD | wc -l) &&
 	test 3 = $(git ls-files | wc -l)
 '

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
gitgitgadget
