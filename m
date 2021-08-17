Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF3C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A646B60F41
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhHQSvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhHQSvX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Aug 2021 14:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629226248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bfkCq+NfWN/obMVyar1qwXTPKd3hlWrHoBz9x8DaCIo=;
        b=S/KqDjKQnM9BlFM5uTFTzESwF1OjIC1ldVK0BsD7ud4Y6b+jR3k/FWsrIncTviRwDG+J9S
        /9ZgpCrRDOx84IQbydjFlrn7rILvZIQ6trKclUG553mikn1aWJyqu7CruZs7xn4VathmmA
        w0bJ+AGHVoQSe6Ci47dEWrhnTWu1nAQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-e6JdjxF7NKaaZZiO8M7dLQ-1; Tue, 17 Aug 2021 14:50:47 -0400
X-MC-Unique: e6JdjxF7NKaaZZiO8M7dLQ-1
Received: by mail-pj1-f71.google.com with SMTP id v9-20020a17090a7c09b02901778a2a8fd6so3337664pjf.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=bfkCq+NfWN/obMVyar1qwXTPKd3hlWrHoBz9x8DaCIo=;
        b=FeqZ42XuArNr7VL70TyUPJjc/SRLUIHCJe8n9o7PqB9JaY/ZXLG0XpjWnCxighoUmE
         L8r7OGMeyL1c/Dtzw1hf3MhEsT92l39IWB9nnU54f/vZZMJVF/egH4voZy/KmLrpySmj
         U3pgQygnExF/P5XUrKIvYSQ0EHWKFfIlGN5IZED/8r8BrEMk2VNrV6mJEu1Qg97hBRYg
         X1BD3NV/YezP/b4USfF6uWQiBfXrfgG/+4XjMwPvyZOs6Ptr+dNTFNQsyfrGuMmWb1HM
         2quEOsP6aCkyzggKAZ+b92ptP+GDk5cXJfPQ6nnS0L4gfGcr08nhLeHoWpSn0C2py1BI
         4VRg==
X-Gm-Message-State: AOAM5327b1CJMZX7fO3KmHguZTBkxIAOnE5w70OIm7oW6OabL07HL/2P
        tFITXGhc7j/3P7NMWt6b1W2k+vPGxYOTHFOKLyVWehHazRLkpe/l+/UYGwK7F+zPPpqq2EtWCFs
        1GyDKd9P4wp5HlYnR/KkeVbKbIhFyaOuG/XFP1BFrLuqUGq83zQCNMs1tuJp4yxs=
X-Received: by 2002:aa7:8484:0:b029:3e0:805e:9f67 with SMTP id u4-20020aa784840000b02903e0805e9f67mr5076465pfn.73.1629226245921;
        Tue, 17 Aug 2021 11:50:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygybjJ4ev8SHgS1EVIUfJP05exqW6wJNvF9TteGVTRkX7QvcCQ0atWdv9EptmoAdTiT5ysuQ==
X-Received: by 2002:aa7:8484:0:b029:3e0:805e:9f67 with SMTP id u4-20020aa784840000b02903e0805e9f67mr5076447pfn.73.1629226245586;
        Tue, 17 Aug 2021 11:50:45 -0700 (PDT)
Received: from xps13k.happyassassin.net ([184.71.189.90])
        by smtp.gmail.com with ESMTPSA id p17sm2778994pjg.54.2021.08.17.11.50.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:50:45 -0700 (PDT)
Message-ID: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com>
Subject: git format-patch produces invalid patch if the commit adds an empty
 file?
From:   Adam Williamson <awilliam@redhat.com>
To:     git@vger.kernel.org
Date:   Tue, 17 Aug 2021 11:50:42 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 (3.41.1-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks! So I ran into an odd issue with git today. I'm kinda
surprised I can't find any prior discussion of it, but oh well. The
situation is this: I ran git format-patch on a commit that adds three
empty files to a repository - this commit:
https://github.com/mesonbuild/meson/commit/5c87167a34c6ed703444af180fffd8a45a7928ee
the relevant lines from the patch file it produced look like this:

===

diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt
new file mode 100644
index 000000000..e69de29bb
diff --git a/test cases/common/56 array methods/b.txt b/test cases/common/56 array methods/b.txt
new file mode 100644
index 000000000..e69de29bb
diff --git a/test cases/common/56 array methods/c.txt b/test cases/common/56 array methods/c.txt
new file mode 100644
index 000000000..e69de29bb

===

but `patch` actually chokes on that (when called in an RPM package build):

===

+ /usr/bin/cat /home/adamw/build/meson/0001-interpreter-Fix-list-contains-for-Holders-fixes-9020.patch
+ /usr/bin/patch -p1 -s --fuzz=0 --no-backup-if-mismatch -f
The text leading up to this was:
--------------------------
|diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt
|new file mode 100644
|index 000000000..e69de29bb
--------------------------
No file to patch.  Skipping patch.
The text leading up to this was:
--------------------------
|diff --git a/test cases/common/56 array methods/b.txt b/test cases/common/56 array methods/b.txt
|new file mode 100644
|index 000000000..e69de29bb
--------------------------
No file to patch.  Skipping patch.
The text leading up to this was:
--------------------------
|diff --git a/test cases/common/56 array methods/c.txt b/test cases/common/56 array methods/c.txt
|new file mode 100644
|index 000000000..e69de29bb
--------------------------
No file to patch.  Skipping patch.

===

To make the patch apply cleanly, I had to hand-edit it to add "---" and
"+++" lines, like this:

===

diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt
new file mode 100644
index 000000000..e69de29bb
--- /dev/null
+++ b/test cases/common/56 array methods/a.txt
diff --git a/test cases/common/56 array methods/b.txt b/test cases/common/56 array methods/b.txt
new file mode 100644
index 000000000..e69de29bb
--- /dev/null
+++ b/test cases/common/56 array methods/b.txt
diff --git a/test cases/common/56 array methods/c.txt b/test cases/common/56 array methods/c.txt
new file mode 100644
index 000000000..e69de29bb
--- /dev/null
+++ b/test cases/common/56 array methods/c.txt

===

This is with git-2.32.0-1.fc35.1.x86_64 in Fedora Rawhide.

I'm not subscribed to the list, so please CC me directly on any replies. Thanks!
-- 
Adam Williamson
Fedora QA
IRC: adamw | Twitter: adamw_ha
https://www.happyassassin.net


