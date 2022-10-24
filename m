Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A5FFA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiJXQP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiJXQPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 12:15:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10E122BC5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:02:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so16670232wrb.13
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa9VpWbTJ5lcs5o0642+BwrCyc0FRaAoqyXXjMGk3Hs=;
        b=WdahxIIvajnOnG85vUqnaesxy8/r8kUHcB+UzkGotM03iu7QquoJOHNLkRLuenexE8
         5UMahKVaTx8kVtI2s1b2mhDDGEFyLGTt/kbYrsVkdxzzrxvUkPseBVpmj1VXo9xZKjnR
         KNFfMcNlhAlFhyVWxtpMWwRE9nqY4hju5cFv7ifEBLpiZqInD6rAtmPzM01w9bI0/4nU
         sRaBWBWNP9WTK6+5YiUNu7iaomSGdCYF7DhZnKXXRDSbxzo2sl9gSi+M/JllCq/Oza9N
         hcy38cv5xA+Vc0pAOjfdDv7n4ViWHESbkQ69Y6Iz0qlT0sTVOPJyB9uGZog23ZHJTzXw
         g5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa9VpWbTJ5lcs5o0642+BwrCyc0FRaAoqyXXjMGk3Hs=;
        b=LmBizbK5bpWqdbsoq554Dms5mWN9oyep58vL9CiR/buNRwcho831yuOryfseY1dMRM
         /sOzoNHtq1P2fLEaGX1wvcbaJ8dTnDmleT5Jr2J80IJzz6joyHCUJH69sn7dTJpSqPVr
         hyCD/UVoXIOLAcreDDTUUzHc8m56InLbOcAmjwGrEWZSdDynbkiKzN/dRvImBvTsEP5T
         dJmMegvD9m6OHCvf5DJnpME3qWauHrO3Hau9Zrg6r3Rh1Wpj/HAWTnt6clJPj/XBX9ro
         BiJGTqBE4DGHLW1vKsTwyNlYboFrIk9Mjazgi3Auedkj4iIz3uifdfwO3/mfizL7BVo3
         T8Ag==
X-Gm-Message-State: ACrzQf1i6w0q83B3F/Hwv2vXSa3+FKWGuW8t6LtVX/Lrof47ZCEviKnr
        IJWWc/8+y2q4A5+zoRuY0doQatFWVps=
X-Google-Smtp-Source: AMsMyM4VYycOSVAorS1GNvA4hCl+GkNKwKn3I6833S1ju5vPw0X40Wv8hWjXkemqWCF5p8Afuk7Skw==
X-Received: by 2002:a05:6000:168c:b0:231:7950:1114 with SMTP id y12-20020a056000168c00b0023179501114mr21183104wrd.484.1666623642339;
        Mon, 24 Oct 2022 08:00:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b003b47e75b401sm8831244wmq.37.2022.10.24.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:00:41 -0700 (PDT)
Message-Id: <3aec3d2c9ca65a37a367c3a7c9081bbd4cd44ae0.1666623639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 15:00:38 +0000
Subject: [PATCH 2/2] fsck: document msg-id
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The git-config documentation lacks mention of specific <msg-id> that
are supported. While git-help --config will display a list of these options,
often developers' first instinct is to consult the git docs to find valid
config values.

Add a section under the docs for fsck.<msg-id> with the msg-ids that
git-fsck recognizes.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/config/fsck.txt |   5 ++
 Documentation/fsck-msgids.txt | 133 ++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/fsck-msgids.txt

diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 450e8c38e34..b0632075f22 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -35,6 +35,11 @@ allow new instances of the same breakages go unnoticed.
 Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
 doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
++
+The following `<msg-id>` are supported:
++
+
+include::../fsck-msgids.txt[]
 
 fsck.skipList::
 	The path to a list of object names (i.e. one unabbreviated SHA-1 per
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
new file mode 100644
index 00000000000..888fa3308b7
--- /dev/null
+++ b/Documentation/fsck-msgids.txt
@@ -0,0 +1,133 @@
+--
+`badDate`;;
+	Invalid date format in an author/committer line.
+
+`badEmail`;;
+	Invalid email format in an author/committer line.
+
+`badFilemode`;;
+	A tree contains a bad filemode entry.
+
+`badName`;;
+	An author/committer name is empty.
+
+`badObjectSha1`;;
+	An object has a bad sha1.
+
+`badParentSha1`;;
+	A commit object has a bad parent sha1.
+
+`badTagName`;;
+	A tag has an invalid format.
+
+`badTimezone`;;
+	Found an invalid time zone in an author/committer line.
+
+`badTree`;;
+	A tree cannot be parsed.
+
+`badTreeSha1`;;
+	A tree has an invalid format.
+
+`badType`;;
+	Found an invalid object type.
+
+`duplicateEntries`;;
+	A tree contains duplicate file entries.
+
+`emptyName`;;
+	A path contains an empty name.
+
+`fullPathName`;;
+	A path contains the full path starting with "/".
+
+`gitAttributesSymlink`;;
+	`.gitattributes` is a symlink.
+
+`gitignoreSymlink`;;
+	`.gitignore` is a symlink.
+
+`gitmodulesBlob`;;
+	A non-blob found at `.gitmodules`.
+
+`gitmodulesMissing`;;
+	Unable to read `.gitmodules` blob.
+
+`gitmodulesName`;;
+	A submodule name is invalid.
+
+`gitmodulesParse`;;
+	Could not parse `.gitmodules` blob.
+
+`gitmodulesLarge`;
+	`.gitmodules` blob is too large to parse.
+
+`gitmodulesPath`;;
+	`.gitmodules` path is invalid.
+
+`gitmodulesSymlink`;;
+	`.gitmodules` is a symlink.
+
+`gitmodulesUpdate`;;
+	Found an invalid submodule update setting.
+
+`gitmodulesUrl`;;
+	Found an invalid submodule url.
+
+`hasDot`;;
+	A tree contains an entry named `.`.
+
+`hasDotdot`;;
+	A tree contains an entry named `..`.
+
+`hasDotgit`;;
+	A tree contains an entry named `.git`.
+
+`mailmapSymlink`;;
+	`.mailmap` is a symlink.
+
+`missingAuthor`;;
+	Author is missing.
+
+`missingCommitter`;;
+	Committer is missing.
+
+`missingEmail`;;
+	Email is missing in an author/committer line.
+
+`missingNameBeforeEmail`;;
+	Missing space before an email in an author/committer line.
+
+`missingObject`;;
+	Missing `object` line in tag object.
+
+`missingSpaceBeforeDate`;;
+	Missing space before date in an author/committer line.
+
+`missingSpaceBeforeEmail`;;
+	Missing space before the email in author/committer line.
+
+`missingTag`;;
+	Unexpected end after `type` line in a tag object.
+
+`missingTypeEntry`;;
+	Missing `type` line in a tag object.
+
+`multipleAuthors`;;`
+	Multiple author lines found in a commit.
+
+`nulInCommit`;;
+	Found a NUL byte in the commit object body.
+
+`treeNotSorted`;;
+	A tree is not properly sorted.
+
+`unknownType`;;
+	Found an unknown object type.
+
+`zeroPaddingDate`;;
+	Found a zero padded date in an author/commiter line.
+
+`zeroPaddedFilemode`;;
+	Found a zero padded filemode in a tree.
+--
-- 
gitgitgadget
