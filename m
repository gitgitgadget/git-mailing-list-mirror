Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFF3B42F9
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889480; cv=none; b=LoeWpnHHLEYxcU5Uf7cOlQv3FICo0/lq0v1cv3H9YEHImEwOXFdVozScUjSpJwshJBKDh4e+ks+aDW5sC2pQxvcSMiopqZZaHbW0dKX8QGMfO+VmzTYhV9r9c84ViXvX0JNanyT9vCIuLe8FuI9U6A05XBN5sOr3znQtZxuGxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889480; c=relaxed/simple;
	bh=DMCw3sBDajv3ZHeK83NBz2ewBUNE6DK9WPOuhCwb0f4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SSFuAkC/PAk6Hij46N3/m7IFJts8qhKyrdiFjqxFslaexdSk3N8v6GwW3JDvdajjp54ZuxBmzW5X0YJkjuEpxuOtW3P5tK5PxMywpem8Ch5zpY84sneL5DkLlkh31Yppktoh0LW3HeAFWSkDAa4Lk1+hJMahXeu8B/2tIDZ+hx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHZOcHKF; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHZOcHKF"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51a1fe8f578so1994321cf.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889478; x=1783494278; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4WZXcMgh/PxoxPuKiz5qV/70WlivjvVfa5dacNmLqU=;
        b=DHZOcHKFwGXcuSqLn9Y1+Qg4MbOJyX48ZR1QKW+r/0j7L62JHyOD7e4swe5zdManrD
         NCVomEfYucwS0UJP2tAwIv71QdKqExSotXdrP0GVjDq2AF5xCKbNQ+26PqUH0kthzRYG
         rKI/wwFGiSEGYbKrJFpdqW0m+A1H5omn9ghHIYPExRJVy8zd8dOrNoKkhYFr0xSq80+f
         8n8aImmFSqc9Q7IS+c0MZkOAU6Fx3UUPfDq0UJWhPCceIe+r1mK7Ettt1QsVryXTdpXF
         R0CQ4jBF1b6ytri6c/PU7FvMD5o+3l/eXUBf6GIWUXVBO7MFuElDyiZvwKq6uNYM6bin
         KZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889478; x=1783494278;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4WZXcMgh/PxoxPuKiz5qV/70WlivjvVfa5dacNmLqU=;
        b=gglXJIk/lFbe/QA67SXUINEtwIyI22MFkRx+AbZ/9R5q2CWAvTVb2thw99vst0QgzO
         NCHe6EqTXhtU8GLXHTqSka0KlYVyUPKkaquCvnn2me8VQGAitMKQV04zpiIDoa7VEVIE
         PEryPMXF3icPaqb1g4reh3Su+dpiqJQP+dSPkA/MNb4t7z+OLP2ITMMzEXgSwoQy4QGU
         NRb1BxgLgYIyWN3o30iQE0BhO5qbTLevrIEL80st18ckFQsTu9/28RCeBwaWUC/SC7m3
         js3JoTSeKKUPQzsX/AZ81zNny1QpefxmfIo2ajqcaA2JBwpJR3BwCae8nMqFaRBV/NyA
         6Quw==
X-Gm-Message-State: AOJu0YyFMgIkwGLgfE/t8SWmpDP6vyhGsXKJxW17JXGYwySEVt6SZUxu
	zP2Wg2osFqsOkN7TXANtCg55W2cmq4axeVYGmRnFTCSkkRQiOYIsT/C8YDal1A==
X-Gm-Gg: AfdE7cm4Ienzz4N2xxWAggTeey4pUXZtW9QsjeLk7BzcX0IOUeLRU/OJ9nEJ+yhQ9Hj
	hkAi86306ejNy7mbLB/b/Qvu1h2FNjXWBDK8TwpmPVvLZ4HehfrfZdlEBD7KJ+qfvM9F+DCiNl2
	5xeVdUWzpgQ0+FPLKPf1O6yUvOPXdFSzq1CAzWGylN06qUGg4MWb9bkOajw24bEcxAAyR7PefYr
	ow3gCBJ55CxAB1kX+AA7798nzj7QWMW4baQ39ueu4MPoI0+/7qv2oSO7Q5pBVY270VhF3OTOdkz
	bRB5SDrog6RowqDnaqalKMNMzFXFUuwg6Ub73Kwh6dQj3iHy2kVbIAzz34SoYxmqxM9PO+/KrU2
	OLoNwP9x5ZfRHa3ZqsESy2zmQ7WXJsHg6f/CXcLjmjBwgt91e43NOUsEqRFZ8DpyqM7RkSTIUvE
	a+2547o3AQLPFyfiD4
X-Received: by 2002:a05:622a:1dcd:b0:517:92a6:fcd5 with SMTP id d75a77b69052e-51c26a78362mr5845951cf.18.1782889478304;
        Wed, 01 Jul 2026 00:04:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a265efsm39042951cf.27.2026.07.01.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:37 -0700 (PDT)
Message-Id: <a770d9708d806ed6a7334a0db053ad94c51a892e.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:21 +0000
Subject: [PATCH 03/13] download_https_uri_to_file(): do not leak fd upon
 failure
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

When the `git-remote-https` command fails, we do not want to leak
`child_out`.

Pointed out by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 3b2e347288..34fa452e76 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -378,7 +378,7 @@ cleanup:
 	if (child_in)
 		fclose(child_in);
 	if (finish_command(&cp))
-		return 1;
+		result = 1;
 	if (child_out)
 		fclose(child_out);
 	return result;
-- 
gitgitgadget

