Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC2C46467
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbiDGRaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbiDGR1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 13:27:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758C100A64
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 10:23:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f18so7233893edc.5
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=c8KZywB8tHWpouuWq9rQfQJGUZw7nHEOuaJ8VP8S7a4=;
        b=QTt0/sa4UP5LurDlzCMNwnI4JxouSCywKGpkEW6jtAb416/KHT5OsTs+4FvR/J+OxA
         mm+RX5gEmmjhmOa2hJzYguUHD6FVG/hPFGqI1k4y3PCNMAQuxLeMG8nPnZ/DIW2AzQ8I
         Jdw0QCfpQ/u4bxAN2Z5qRG2hlEYGYIZsvUryLiT42ri1sQZ0PYurHJk6IRstqGwpmvi4
         eCbM6cy+Buh6xpsx2dlkjhZfGHjfSAwLKVAf+8Uubwo7lGuuEbRiDcLdZJC2ZU97usTV
         rX4jszAfHvKlBakC3saJ6FDb5fYPyo8Jrbc38mMoPkUykK9HiZtSeSwZFSU1HHDsCQDO
         VlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=c8KZywB8tHWpouuWq9rQfQJGUZw7nHEOuaJ8VP8S7a4=;
        b=BFV/RwRD75eP5pw+VieBjpQAA+X06iRiUZ1trG4+bqD4oFs1a/uKDjVZ4QQXMBNVFh
         mzmoWrn4TULG7lklj74veegO7IOz1p6X25e4fdqF0PiDQX3xkZSud9VOInQxYp9QjQ/o
         95RKPJ4bCHRqlcCW+Epn+ZA4TjRVEKykcXSNg6Da5LWaS6FmrO0WKVFF3GmQIiqTWD5X
         TANcHHqoOKzbvbWAqu3uy3eKhRHgUSkPiDVp1bcKQkUf/gpW5CujOQ6pEU01eA1lsBWi
         XuAwN4jyWu4MCbmg4C+7OKn87WHLFPNtVonq+jniiPli0+c1mRlbZj5//7JYGy+LDvpL
         nIlw==
X-Gm-Message-State: AOAM530hTus9vy5eB53sU0dKkfkBrjzHuJV7d6veowcJHLxsF33nJUHd
        ugGMGE8PY+Zu82k+70YL1Vo=
X-Google-Smtp-Source: ABdhPJxyLXfYdmw5m1x2LbNv4XxL+O2ObIPNFOORx2VZyqYCRuDTmHpjHxcZI3Ui3wR25eDY/zcQ7w==
X-Received: by 2002:a05:6402:350c:b0:419:3d18:7dd2 with SMTP id b12-20020a056402350c00b004193d187dd2mr15673107edd.148.1649352228756;
        Thu, 07 Apr 2022 10:23:48 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lj20-20020a170906f9d400b006e7f1e1f4a0sm4688138ejb.60.2022.04.07.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:23:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncVrH-0017wF-Jh;
        Thu, 07 Apr 2022 19:23:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] doc: replace "--" with {litdd} in
 credential-cache/fsmonitor
Date:   Thu, 07 Apr 2022 19:23:26 +0200
References: <20220406184122.4126898-1-tmz@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220406184122.4126898-1-tmz@pobox.com>
Message-ID: <220407.86h774dcyk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 06 2022, Todd Zullinger wrote:

> Asciidoc renders `--` as em-dash.  This is not appropriate for command
> names.  It also breaks linkgit links to these commands.

Looks good, for the linkgit case let's check it in "make check-docs":

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 1c61dd9512b..2f46b261282 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -46,6 +46,7 @@ sub report {
 		my ($target, $page, $section) = ($1, $2, $3);
 
 		# De-AsciiDoc
+		my $raw_page = $page;
 		$page =~ s/{litdd}/--/g;
 
 		if (!exists $TXT{$page}) {
@@ -61,6 +62,7 @@ sub report {
 			report($pos, $line, $target, "wrong section (should be $real_section)");
 			next;
 		}
+		report($pos, $line, $target, "should link '--' as '{litdd}')") if $raw_page =~ /--/;
 	}
 	# this resets our $. for each file
 	close ARGV if eof;
