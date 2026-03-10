Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B3B47D9
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164738; cv=none; b=SH8sIHZWVQ36NmRneFHFHGfGAFBewhjzX6x+DM33owJdHikgCRgG6oPquN3bbcIe/3Y/5/t1jCtHeltTHOPvrL/M/deMXLdUL2/F4ijuiKjSihzZDjgTUQUXvW3JMwvQ79etr/q6J1giKW9QMpKpgfXI+jUbYKd+aIDFRUi5u9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164738; c=relaxed/simple;
	bh=PXBPwV925f9l55QKh+uK7Z9lnMMFjApEJeKCtzM+gWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IphnRgEXyZGeHW/OsJrRPF7z2X4KaXV0u8FTeiA/4lHWn+jWyqGq6lLGKNE7iRwPTS/B5ZFoEGVVvQiOA+FkUZqik4VDTEg6Uj0m0BnkYcJJOifcuiyxSJsElFk2QO5PNQicoI8V8MCO1hLmtSelBSldwxKCwSFC8D0i8l0NFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNm2FDk6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNm2FDk6"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8298fad2063so3096923b3a.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164736; x=1773769536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2q2cKYNvSyN9HCrY2Mhjbx6WPVAaoaX0Et/hTET2Y0=;
        b=HNm2FDk6gD2sGz5FPtvNRbZr11z1TCsJAUsH8z0lPZdBMtckXJcfrKFnktKGbzkz+c
         Uh9L+N6OaXbVGycRxbF2HHXrGt4KAtj/WVdes9R+piDaYf6nwAJRY4h63nVXkErl/w6x
         huB1SrXjuPHFw7lCduAmh36bmumj7MUFPS2uD0GCYiaC0w1F5bFLHhyXA+HIuoMFqDxd
         8M2iw6BpLAYsIOI9GLrU7vr8uqn0juqsTqFr0T6tZi91E52lj6HeaCe7/o9RrVgfS9mN
         6MITWum9Z3aEOhWAIgYZavjf9IOb7ZYSKIlcEqyheuV5h5Sp+IP9NxT7MKkhxgAmfBRW
         56/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164736; x=1773769536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2q2cKYNvSyN9HCrY2Mhjbx6WPVAaoaX0Et/hTET2Y0=;
        b=Mj2PJ7L1RKmz5ClEE5yYSP+VS0KOxs3cdzX3dEMfsKx0cDVRDA6ZEnQHYXWvepTSh7
         wjy5Mt1aZzzfdnfpLAiLd4/PLrzqPnF3a8c0fZWKWP/kyUa9c4VhLb9JkKheilIv6lC3
         Y2KSQwKEc+pz5BFVKKVa/STVnDcEnPBmHmCcdAty6VoHaCE11BUQf7+KjhKZsKm3EmUP
         CWrznMFZzfYJIG4k0y6efmUdrQDclAxUbTIo3uwpeRWMejZFxBO8lGdUSKvswqPRBlv1
         lQppSC2YaFyYQmscO+/cyKFYUwA4h5Hm7EeNm7dEPOev6PnYN7JvAQGj9ylzuCZF5Q/Z
         C0Rg==
X-Gm-Message-State: AOJu0YyDjgI7Qp0i+3MKy6QJOfIVUgu0s14x9DyT5jZoPCSuL5CEc9m8
	0m8b0HNnrShW4rYFk8q8JTOHaQnEW5jRDFxFikeBLaODTD9J6T+fTCaIeH9dNA==
X-Gm-Gg: ATEYQzzjOk/LN26oBZvynebOJhaz3OuBZeVmAGe2wu6wLvCV/N0pRI3nSojCKWCq8BK
	LaeLVvLm5Mvz1FXhIS0mCK+/gUY0adjlOqbyw/fe/FG9njSxyH8RJWSEb8r7Q+S1+tp07yvSUrS
	ZUVR998yTlGohnDRDfNUqtdMTO6oOWly9wmO7ysGmd+5JjyW7wr70oFf13mHSSDWY4sOCOFl5M/
	uxaDGMFEXvXq05MzaDROWFWzZrhVBJTfBB2ri6gfmTh807lrKucd7UhscgUmSfAF5TXT12leVgx
	8jmLJ9LVhbLdo1dFso7m6yQ+8wJzkgzDKTWau8pD+khpXdtMMjAeNmn0tSJkc2aXONrQ8vbQYGZ
	3GV5yX47Qu8it0CpiK5FibaFClcMsBb4qn/ekEcv3gEhoY3RXmX4GNsGsdS4OTvZLL1JdIqKCMe
	TXgnaLOiW0wU2Xa5Qvfd1vrHKlefiHg8Pl5KE6wEh1OLo=
X-Received: by 2002:a05:6a00:4b53:b0:821:853f:b9c3 with SMTP id d2e1a72fcca58-829a30c203emr13907094b3a.58.1773164736252;
        Tue, 10 Mar 2026 10:45:36 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:af62:6ac0:52fa:9f8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48676besm13414023b3a.40.2026.03.10.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:45:35 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [GSOC][PATCH v2 0/2] Remove global state from editor.c
Date: Tue, 10 Mar 2026 23:10:47 +0530
Message-ID: <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reduces reliance on global states. Mainly there
are two such global states in editor.c,

* editor_program: defined in environment.c and populated during config
  parsing, but only used by editor.c via git_editor().

* the_repository: used in git_sequence_editor() to read the sequence.editor
  configuration.

In patch 1/2, localize editor_program to editor.c by introducing a helper
that allows git_default_core_config() to continue initializing the value
during initial config parsing.

In patch 2/2, remove the remaining use of the_repository in editor.c by
passing struct repository through git_sequence_editor() and its
callers. With this change, editor.c no longer requires
'USE_THE_REPOSITORY_VARIABLE' and 'environment.h' include.

Shreyansh Paliwal (2):
  editor: make editor_program local to editor.c
  editor: remove the_repository usage

 builtin/var.c        |  2 +-
 editor.c             | 19 ++++++++++++-------
 editor.h             |  6 ++++--
 environment.c        |  5 ++---
 environment.h        |  1 -
 rebase-interactive.c |  2 +-
 6 files changed, 20 insertions(+), 15 deletions(-)

---
Changes in v2:
 - removed 'environment.h' dependency from editor.c as well.

Range-diff against v1:
-:  ---------- > 1:  6f8b82fed5 editor: make editor_program local to editor.c
1:  f9ef18b77a ! 2:  5b858c7e98 editor: remove the_repository usage
    @@ Commit message
           local repository instance, so pass it down the caller.

         With no remaining global states in editor.c remove '#define
    -    USE_THE_REPOSITORY_VARIABLE'. This removes another dependency on
    -    the_repository and keeps editor code consistent with the ongoing effort to
    -    reduce global state.
    +    USE_THE_REPOSITORY_VARIABLE' and drop the dependency on 'environment.h'.
    +    This removes another dependency on the_repository and keeps editor code
    +    consistent with the ongoing effort to reduce global state.

         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

    @@ editor.c
      #include "git-compat-util.h"
      #include "abspath.h"
      #include "advice.h"
    + #include "config.h"
    + #include "editor.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "pager.h"
    + #include "path.h"
     @@ editor.c: const char *git_editor(void)
      	return editor;
      }
--
2.53.0

