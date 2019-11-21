Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6250C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8773B206D7
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="r9fPf4DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUXnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:43:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45626 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:43:43 -0500
Received: by mail-io1-f65.google.com with SMTP id v17so5650855iol.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=po50d/+PGTItEkZHNdwC7TjJ8MhLqtgY0lUktJXGxhQ=;
        b=r9fPf4DQDtt9k/On3KUJz/bHgW9ZeLPOIBF4ghBApdQJ0TCdb2x3g8IGLD9NwGZpwC
         PNmIVMsDweSfqcN7UVeBadlIwR54fCESxiy+5h2jlk0zHP+f+DLB4ysUE/OHl7he5iqB
         /1txoG++mJE1k9RvELI43XI0LDkNNh4BoX79PFWZcWX4kTJu+fSQTPg9QPn1FVlFst31
         UjMTD8B4pdr8BP+UTnFnLIu3jggeSoQvjtYyVxtjA5dd3GUVPw89fOHvVW7TSyrFSQ2o
         Vh02pWcvD2QwhMOrvk9jjifCx/s4ug6zICQH+ucTUEW8XOtZFadV+w23fN4rPbzuk9+u
         kHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=po50d/+PGTItEkZHNdwC7TjJ8MhLqtgY0lUktJXGxhQ=;
        b=ehHnRt2ChNclrtLy9UKAxgMN7JMJ6CBrVS2PCsNRdXXrY/2SsI8zZg5WUS0jptgxD9
         ac1SBfq7X2tz/zhIVLeNCv1/Gfe/0yJKBrls3wsQuqUXgzFWua6rqJB5PQdMV71JaPWK
         ovKQmBl5dg3j4G4OQgSFvw48RpEPJzygnrIn157l60cwuwyyNhyhYZxALyYj5EUv0CTr
         pY9YLPDu2UsATqUL2eq6d2UJZQ5U+AlCgf4zyUh+rD3+FEs33KDBmuDCd19hoB/OYacv
         Ye5bSTxlXe4z7k9OOyKVWwGeTJKskJLWjFg2ttwWsSkiRUMoreiECtAyYMBnTphsTkxz
         kpqg==
X-Gm-Message-State: APjAAAXED+t08eMog8pNJu89z6sVXT84pk3hJt8J4/+zprtXV2+hKOg8
        Vhv1BNwo6s56ZjkFdb3JrvBSoJHgPVs=
X-Google-Smtp-Source: APXvYqzsd4ak7dnTArLGzfCjA5LxEY0luJlb0D7Q3UpBnsxoqySqsnFTBjS9vARqzgV2313AawEbEA==
X-Received: by 2002:a5e:c301:: with SMTP id a1mr6885663iok.14.1574379821982;
        Thu, 21 Nov 2019 15:43:41 -0800 (PST)
Received: from localhost ([182.232.28.41])
        by smtp.gmail.com with ESMTPSA id g3sm4609173pfo.82.2019.11.21.15.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:43:41 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v3 0/2] gpg-interface: fix search for primary key fingerprint
Date:   Thu, 21 Nov 2019 23:43:34 +0000
Message-Id: <20191121234336.26300-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116215850.3919-1-hji@dyntopia.com>
References: <20191116215850.3919-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the process of implementing signature verification for git
clone, I decided to refactor/unify the code for commit and merge
verification to make it reusable during clones.

This lead me to discover that git requires merge signatures to be
trusted (as opposed to TRUST_UNKNOWN or TRUST_NEVER).  This is unlike
the behavior of verify-tag and verify-commit.

So, I figured that I'd make the minimum trust level configurable to make
the behavior of merge/commit/tag consistent.  And while doing so, I
noticed that parse_gpg_output() in gpg-interface.c assumes that the
VALIDSIG status line has a field with a fingerprint for the primary key;
but that is only the case for OpenPGP signatures [1].

The consequence of that assumption is that the subsequent status line is
interpreted as the primary fingerprint for X509 signatures.  I'm not
sure if the order is hardcoded in GnuPG, but in my testing the TRUST_
status line always came after VALIDSIG -- and that breaks the config
option to set a minimum trust level (not part of this patch):

,----
| $ git log -n1 --format="primary key: %GP" signed-x509
| gpgsm: Signature made 2019-11-16 14:13:09 using certificate ID 0xFA23FD65
| gpgsm: Good signature from "/CN=C O Mitter/O=Example/SN=C O/GN=Mitter"
| gpgsm:                 aka "committer@example.com"
| primary key: TRUST_FULLY 0 shell
`----

As per suggestion from Hamano, I also introduced a helper function,
replace_cstring().  I wasn't sure whether to add it in a separate commit
or not, but the kind folks in #git-devel suggested I do.

[1]: https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS

Hans Jerry Illikainen (2):
  gpg-interface: refactor the free-and-xmemdupz pattern
  gpg-interface: limit search for primary key fingerprint

 gpg-interface.c | 45 ++++++++++++++++++++++++++++++++-------------
 t/t4202-log.sh  | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 13 deletions(-)

--
2.24.0.157.gba9f894af8
