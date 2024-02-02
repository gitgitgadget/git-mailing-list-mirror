Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BD1474C5
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897100; cv=none; b=Dj5NUC2TPy0ug1NZpC5AnNu1DLmm9d3CrBcCz9xoieImx4Igm6NwhnVx47wTa3cNKHPLCxv25Q3QAQVgp5VDa3hKQ36zH6u9ugQ0HjIqOuE0eYOJhod1pvEjR+x2EEEmEDqHtnXBLoVEqJw9OOOPAdUqHyUGmXqSAr/rj+yw6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897100; c=relaxed/simple;
	bh=5WLJ19Jn7SCsxU6xxOKL8P4KS/T8tNDLbajwNeG553U=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JpS0T6OkxqCt46jIoHz7NPd/41XABv8YdKItPvtsoESZL6NX+Y2Zx6hQIoWLC873Lsrww+olbhDJGNXxlP1CGP2YH3gNaMJ7eR6u9L+jRd89A5PWFkR7uKxmIECTL8bspcAYfjPBuuP5GqsuRJ0aAzD79jpGmYAFpYztIic3TEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn8g5o5Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn8g5o5Q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so20847485e9.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706897096; x=1707501896; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRlp1PnaPvlImtNlgOqKzUBLzHh4/D0Hkc1bPIcvhXA=;
        b=Mn8g5o5QuCxx1I4CrOIpOPWhYyJy1w1SLClS3yQ3EGwN0r10YXsY5bsMecvkHWbClp
         wE99hsNDMDfqJdUhNbvCqa2nZMIUWDna/+ZK1DsP2gwE1bBORN3n9V+XcyD1zUt2tzxB
         RZAcu7W0qF6LNGgsRVIBzTw/dRJUYcO8H4Klyh4PpBS87y+CGXqsI2YTJ7mQZ2TUYFJa
         dyy+JhWdgUlo9bEHMDlET1hYcyQsJcALGpro51Tekh7FAPUxQsSoD1zZPU+F8uGFsGdQ
         JTy7Xhp+5ELG6YxyKcplmZcKnce6q8PlwTLDyoiYfuJSDxWcimZ6ESp6/wkYc7PLCkME
         AZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897096; x=1707501896;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRlp1PnaPvlImtNlgOqKzUBLzHh4/D0Hkc1bPIcvhXA=;
        b=WgA4zgMMZlgHfLtdBOqBUhrJbxQLZDvFSizJOHV0NppohJFrGhJoxT17AbtsKK1vhY
         szTktBIQ9f4qf4quTS1sdcpQiakk0q6zDSYd1HLyzbfIuMRo4nG9vFK3lp/+H9/9w4RV
         sg5wbQfC9tXJkSzOtMjj/ocKSzbKH+1ASP3SUFiig0qr3H66SRjdvTMm/1iRXGQXISw7
         qkFCSNzHMT5ZsFVZX+7Tw5hZPr+sEcPVaAnT9OUU2Yvc3YtzjHNy/DS4fCkpT+7h28ij
         shXroWHivtqCWZQjrVXbCGdQRjD8XiP78dJMYba25xr6wGo7/Cpe1WuOxNbiM2fzrMcL
         d3IQ==
X-Gm-Message-State: AOJu0YxuZxCu/9DRKtXezugJStYMgWbS65P6iZvipjnKffmMnQQzpjsH
	WAvnsaafozm8IBbDe/oQeDeML2tRPSLWGW5dGde3+RB9VBEynChPMmDpL/SE
X-Google-Smtp-Source: AGHT+IHUqszhlFQqu5S+Zb/ZjHD0FRIinczopD/adONI4Wr9sLZ7LeRAPK2C3V1vPSYxYzj+7U2UBA==
X-Received: by 2002:adf:fd45:0:b0:33b:d78:35f4 with SMTP id h5-20020adffd45000000b0033b0d7835f4mr2136933wrs.60.1706897096021;
        Fri, 02 Feb 2024 10:04:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b0033ae593e830sm2406680wrw.23.2024.02.02.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:04:55 -0800 (PST)
Message-ID: <pull.1649.git.1706897095273.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Feb 2024 18:04:54 +0000
Subject: [PATCH] sparse-index: pass string length to index_file_exists()
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

The call to index_file_exists() in the loop in expand_to_path() passes
the wrong string length.  Let's fix that.

The loop in expand_to_path() searches the name-hash for each
sub-directory prefix in the provided pathname. That is, by searching
for "dir1/" then "dir1/dir2/" then "dir1/dir2/dir3/" and so on until
it finds a cache-entry representing a sparse directory.

The code creates "strbuf path_mutable" to contain the working pathname
and modifies the buffer in-place by temporarily replacing the character
following each successive "/" with NUL for the duration of the call to
index_file_exists().

It does not update the strbuf.len during this substitution.

Pass the patched length of the prefix path instead.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
    sparse-index: pass string length to index_file_exists()
    
    The call to index_file_exists() in the loop in expand_to_path() passes
    the wrong string length. Let's fix that.
    
    The loop in expand_to_path() searches the name-hash for each
    sub-directory prefix in the provided pathname. That is, by searching for
    "dir1/" then "dir1/dir2/" then "dir1/dir2/dir3/" and so on until it
    finds a cache-entry representing a sparse directory.
    
    The code creates "strbuf path_mutable" to contain the working pathname
    and modifies the buffer in-place by temporarily replacing the character
    following each successive "/" with NUL for the duration of the call to
    index_file_exists().
    
    It does not update the strbuf.len during this substitution.
    
    Pass the patched length of the prefix path instead.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1649%2Fjeffhostetler%2Fsparse-index-string-length-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1649/jeffhostetler/sparse-index-string-length-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1649

 sparse-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 1fdb07a9e69..093708f6220 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -579,8 +579,9 @@ void expand_to_path(struct index_state *istate,
 		replace++;
 		temp = *replace;
 		*replace = '\0';
+		substr_len = replace - path_mutable.buf;
 		if (index_file_exists(istate, path_mutable.buf,
-				      path_mutable.len, icase)) {
+				      substr_len, icase)) {
 			/*
 			 * We found a parent directory in the name-hash
 			 * hashtable, because only sparse directory entries
@@ -593,7 +594,6 @@ void expand_to_path(struct index_state *istate,
 		}
 
 		*replace = temp;
-		substr_len = replace - path_mutable.buf;
 	}
 
 cleanup:

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
gitgitgadget
