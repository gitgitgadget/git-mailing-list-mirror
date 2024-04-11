Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC8481C2
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878346; cv=none; b=UQiMcGVb0ydjlMZ4sbSbk1oWbZUBzZN2oDQfJGgY+YkFL1OR4ksI0ne3/bDASKYVunj3a6cLxL9P2k9JSE2VzG9ZxxKC9N7Yj/2kFW/8YMumNS6eLM5DFNnreF6Oy6K+e/Rr6jIXeeJSzShtpCKc3aZh8/PIDMfOr7AwV3uwLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878346; c=relaxed/simple;
	bh=x4PnA19b2SZv51C9P3CaUJoIARINCb/W5YcbwcbDD4s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Jcq98v9v+4AndDLkFi+ezt85ne761LR6ATK3CsVUBu3Mmz9to55a4XOV5/EV9XBRhkbFCWlhLCoWmPSZ2GIyUXn6uLtmAc/fx6L8i/r4u3evvP67xkK2t1ongtIU9QeL8aJHERTr9R+dgZj8zb1pvM38iWNv/tQiXrKxjDssLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn+Gecjr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn+Gecjr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-417d092f2ffso2866835e9.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878343; x=1713483143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACzd8EiOpJ1sn1V47sERPLxEfhI941PTgUhJpQEy3Co=;
        b=Gn+Gecjrh74vBZ5+4svPurbG49mYvQcFoJ3rWAW9sEAVCpRMyV1sBBtgJfhIfQSYr4
         pW3QTI+0W5yIYQXJAawmRGy9Xih6NW5ez+cdfA5e82pQdhWQzou1RqtR3YyrUBfw2rLM
         kvSkNhc43tswkwLZSNjfuAcToUDY8bbY3SLsEEDj4SVx6lsnF5WEYRTLlD+UhuMo1co/
         OvUIs72gogneScgrs12FltcH7Pb7Suf0GgEZcjud8VlvtOUfNrItgpiMl5tFQOTOUJBe
         tcdiGccZaygMzCsQHpevWxOHRInwRzLogWHf7kbujflgj3KqR2mbIpNjZCGuikavTLBC
         APoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878343; x=1713483143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACzd8EiOpJ1sn1V47sERPLxEfhI941PTgUhJpQEy3Co=;
        b=Fh/M3hiZ6mMF306rk0B8mVNE2DVL2Nc2NGNJ3XLkcn0QHDR7UfdHCdtKEhULlBgGMC
         UxUJV48zQH8FXS/aqpFiOnkmSM5/+sF5NX8rb+YUnBnNx04vXp2CRrYJlqIvA/P6inzt
         3s12MmodeXqp0Zc8DxAS+ySfacseUM17CdEA8UFNdH0n4Pa7FzoRryRM/YFIEjDSiQ9D
         tHgECQWADt8yTLUhq2T2Zy/uq2VoAPXD/vFRS/mv19MsuMClngzSA/B84LZ07PPwkRPe
         SxO9XLJJ8xd9HYQuw+zr6/MlS8Lasg3VKqMJJEtoxngWGgYmCUFuwpCkXqTr9p3o/kj8
         fUJQ==
X-Gm-Message-State: AOJu0YzCeYzu+Q8nozTnUo1hoMN18ZfF6GAXnOgwpRqx3y0uZsfwWhHD
	ZMwlFMh4AzuIvd8BEF0JseDimGtWv/ccSrSLbmM3TOMuzpr7Y+CJ0Pqi6w==
X-Google-Smtp-Source: AGHT+IFJbUM2JGIM5QqiJpVBImFhDR+PNPuVujcfhkefTSrCzVJXOVXNggGx7zgHPhAyT2Mt9xUVyw==
X-Received: by 2002:a5d:584a:0:b0:346:301d:8908 with SMTP id i10-20020a5d584a000000b00346301d8908mr803935wrf.49.1712878343265;
        Thu, 11 Apr 2024 16:32:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15-20020adfb34f000000b00346e8931f6dsm1127690wrd.117.2024.04.11.16.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:22 -0700 (PDT)
Message-Id: <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:13 +0000
Subject: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Use a dash ("git-contacts", not "git contacts") because the script
is not a core builtin command that is compiled into the `git` binary.
This also puts the script on one line, which should make it easier to
grep for with a loose search query, such as

    $ git grep git.contacts Documentation

. Also add a footnote to describe where the script could actually be
located, to help readers who may not be familiar with such "contrib"
scripts (and how they are not accessible with the usual "git
<subcommand>" syntax).

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f17..8b6e4bf0300 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -493,9 +493,16 @@ security relevant should not be submitted to the public mailing list
 mentioned below, but should instead be sent privately to the Git
 Security mailing list{security-ml-ref}.
 
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
+part of the core `git` binary and must be called separately. Consult your +
+package manager to determine where it is located. For example&#44; on Ubuntu-based +
+systems it could be installed under +
+`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
+with `perl ...` if it does not have the executable bit set.]
+
 Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git
-contacts` command in `contrib/contacts/` can help to
+people who are involved in the area you are touching (the `git-contacts`
+script in `contrib/contacts/`{contrib-scripts} can help to
 identify them), to solicit comments and reviews.  Also, when you made
 trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
-- 
gitgitgadget

