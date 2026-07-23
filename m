Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14844DA53C
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812402; cv=none; b=HTlBkfE1++bFlvHCPtmYRRlOGLFGaZZSYA+ccChV43us0SbX31yU113d7qht90hxx6CotDF5ACCDin+sOl03zVEub1Ms3S0ezUxst2I+NI/RO2CmgQ2uIH5FoPj6AkpfTCWBnH0UjDnPwnf8VY77CxZ+eTdtUawMeNv9Y3YcPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812402; c=relaxed/simple;
	bh=WrLubwdvmUVv8AiNN0UuntNVd06qaZmsvUY8Obecf4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UFeKG59iP5V6zMZLVNaYtRyjDOrWuBjjOh8MfPG7Q1054xqpGj7njyW9bxALHR+/KJ17zWUsi4suUFKmSsJwcGKWdH3tgLRmbHfoU6+gYrYDJjEt6sis+TKkWB3Qb9YiZ8OgYrrQw5bmHLwewjPst5uwGbpboZ4of/dLLQQW4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NthFBOdT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NthFBOdT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so532321e87.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784812394; x=1785417194; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=NthFBOdT3mOI1Q4tk4mLkPCpk32Wz2NESrXYcVf4iIyW5Z+LJiZ375DyWcg5pyVZj6
         LULbsk4rkBkLYfXs68xU+5IqdVT+j8hJwKFVHi2Xn2t3O0xawq9Ci+vyS/5l70xNzXYE
         911/cWp5zoK9QXm033NHxTVUmokC1wTxjt9rKLi3Hv2nesX7Eo6G78lNksTmvsfxD9xZ
         tES/jrCDZuSI0cFZd5NqnxA8ikaVKMsu3x8qFj92IBU0j6ZhK2vJQ9p09i9OYpYsw1ej
         uQTFs5jCA9Mu6OQtttTmrUMAgm/vfI6lSsLThpml5m2FdqAW6fFg04ZJrh56/+aVGjCJ
         DanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812394; x=1785417194;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=Mn2a6tbkxkPk8a26fXcsNwJrgT/KBJiiCsdbgGS4ZENFkG/LpGluYF78Jg+t/JgYAi
         qGKJ2sF3KZTszPjQgS41pzzSKS2Nb1Fus5o1gGsHToCh2PKeHwqtI6+XtSPCNbssIzOQ
         5nioxhsh6Yzq4EUyWThWoYyFhA/i6VFgrRJZvW6W+HX1gukOrK71nYlpaF6xun4jYCGV
         Bgu4Fv22S9a0LRF05pzJREXtYzT8+entJAGFFaREc9hx4YxJ/1HUoH2vUT19eqWBBLta
         bzmsazD28rz5nB9iHReQMZcNhaRiDrlo2y3IAsLcfQSjWM/lZkj8iDZYICU9v5Rz/zE0
         Dgdw==
X-Gm-Message-State: AOJu0YyHXIo9nZ+Z3bhkMbEm2sBvUZqLsegQ5xwJKg4pNqKd6xNIjecY
	mrlU0U4jMzMNaJ7B7i1oY2FkpPoJe5NHWeaYbTbRBhmBZNuTqPL6juQWlVaE4Wwh
X-Gm-Gg: AR+sD10DxQcHNTtEssQi9Y62QkZtYy1uXVvr8tXApZP3Rt6fZhQ98LDCO066MVBWeMo
	2WzlxzCXSwRUeMlhJ1JldNTIUBJqBjvvCu7kbyqcDs5NOXRkUmezHlgpyJtYsDt0bJZds4FyC5C
	ZiDp+y4h6xTdoryG0fmmQhxjejKIfRcl/sndM/2gY/If/Ugmo87O2cpzATdMpZWkAij0qU92pHA
	iB0Je8UOtblZgMm/HHjg4GRllm9NMhFl5vkU+S0HlZFIUszezFQVouQvOx9+myg2H3W9hubhwCD
	qcwVpJxCpdIb1WqN5qVwRrDXiJs/vNWB0sJsZ0quH6UQy8y405lACm3qymThTTft+L8UD5PJmaV
	4JpJEfPoBJYZ4r0buWvr/XJmxgC0+3/golyvttPltLsUU77+nmR6beOLVdR1XpZx8ebWFID77Yf
	0N6HKCya+z3d/pq+8=
X-Received: by 2002:ac2:4157:0:b0:5b0:eda:de2b with SMTP id 2adb3069b0e04-5b2b2f72e46mr426545e87.50.1784812393601;
        Thu, 23 Jul 2026 06:13:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.103.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9f5361bsm999075e87.84.2026.07.23.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:13:13 -0700 (PDT)
Message-Id: <0d67da588bc86c5257ce366903ae58e171159b8b.1784812390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 13:13:09 +0000
Subject: [PATCH v2 1/2] mv: name both source and destination when rename fails
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

When "git mv" fails at the rename(2) syscall, the error is reported
with die_errno() using only the source path:

    fatal: renaming 'src' failed: No such file or directory

rename(2) returns ENOENT both when the source does not exist and when
a directory component of the destination does not exist, and errno
does not distinguish the two. Reporting only the source therefore
misleads the user in the latter case: for

    git mv a/file b/no-such-dir/file

the message blames 'a/file', which exists, and gives no hint that
'b/no-such-dir/' is the missing part.

Inspecting the paths again after the failure to determine which one is
at fault would be racy, since either could appear or disappear between
the rename(2) and the follow-up check. Instead, simply name both the
source and the destination in the message and let the reader see which
one is wrong:

    fatal: renaming 'a/file' to 'b/no-such-dir/file' failed:
    No such file or directory

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a82fc97a19..35e504484a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -549,7 +549,7 @@ remove_entry:
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
-			die_errno(_("renaming '%s' failed"), src);
+			die_errno(_("renaming '%s' to '%s' failed"), src, dst);
 		}
 		if (submodule_gitfiles[i]) {
 			if (!update_path_in_gitmodules(src, dst))
-- 
gitgitgadget

