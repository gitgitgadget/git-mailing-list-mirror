Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94CED1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfILToA (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:44:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40101 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILToA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:44:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so16608587pfb.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PuxrZCshsJn0K4a8+y9RZiLsGUxqZYYjB/oMeXHB74g=;
        b=REu8acFCRoQTiblG0ngK2VCCFLN1VpsdPDtfbKoLoIvirWB9EpV8YSW98sVWisko6X
         qL+n18eb5XrxOy7sxK5iGmVnQ3R5JSv8udFNa4liOptwWiUdc4NE1BGsDQCNQW34VlwL
         Oa3Dd+y1FbGSg4N+MaGzPrvEQKfXWBaj3qbdunuJ25VVgLZ1EB/c5VPm8mWI4OOvYyPa
         Nb+0UTIMvDBwwkq8McND4c3IEYonb8WJlam9UANrPhhsDcW0YXyPQxQ+IePUS7+W1uCL
         LrI9DDo0P+iqWOD0XrfNO0oURO2u6kIQDmVNwKuOROyKrQXTgjJdFkWsqaPTPTxDcpUy
         OBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PuxrZCshsJn0K4a8+y9RZiLsGUxqZYYjB/oMeXHB74g=;
        b=osmET/Dx+aAS2GzaZvWSJHP9kQO1Z/bAw0R7if30hzrcbGWVcqTUzJF9LPhx2LjGm6
         ct7zj18MLA7U5nOgxRaRJt/Sns0unRTXMmo5ttprimijMF6W0Z75o8pGiurKVYayaqkh
         mLR9+FzF1Dg3bGsEdSjsjV4LNY7onbENdhCdjfvcMwARqXuk8VISOocUH8ej+Ls2CXU6
         WpCaRHCdkiCaPdPU7aSYn1H3qRWSHKSG1v/KR8OB7zwfDKt30c5VK+t0IftcBI9f996y
         x6hrnTFK/m5EChRrOxr2cmhUSjs4P+MvE4xVRn7nMRAiotB6rpndaS2a2r+qKlicvuJL
         aKVQ==
X-Gm-Message-State: APjAAAVKG6JVFtmB5DIrf5/8MktH97nVoKXlUyrb1ZByL8zpidWX1YDa
        Lkz+AeHr0czcf2sfudYtMMbAEpGyQm0=
X-Google-Smtp-Source: APXvYqw7eZC0TKTqLsXXUCo50DJgeFen1WgXnYMe3B7cAShc6uS6TyE9xJKeNLX3Mphc/1+TZxO02Q==
X-Received: by 2002:a17:90a:e57:: with SMTP id p23mr392510pja.126.1568317439300;
        Thu, 12 Sep 2019 12:43:59 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id s1sm95867pjs.31.2019.09.12.12.43.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 12:43:58 -0700 (PDT)
Date:   Thu, 12 Sep 2019 12:43:57 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] completion: teach archive to use __gitcomp_builtin
Message-ID: <39d6091ce636b2d732d589b55e7686796694e994.1568317093.git.liu.denton@gmail.com>
References: <cover.1568317093.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568317093.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, _git_archive() uses a hardcoded list of options for its
completion. However, we can use __gitcomp_builtin() to get a dynamically
generated list of completions instead.

Teach _git_archive() to use __gitcomp_builtin() so that newly
implemented options in archive will be automatically completed without
any mucking around in git-completion.bash. While we're at it, teach it
to complete the missing `--worktree-attributes` option as well.

Unfortunately, since some args are passed through from cmd_archive() to
write_archive() (which calls parse_archive_args()), there's no way that a
`--git-completion-helper` arg can end up reaching parse_archive_args()
since the first call to parse_options() will end up calling exit(0). As
a result, we have to carry the options supported by write_archive() in
the hardcoded string.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 365edff639..7b1ab46f0b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1250,10 +1250,7 @@ _git_archive ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--format= --list --verbose
-			--prefix= --remote= --exec= --output
-			"
+		__gitcomp_builtin archive "--format= --list --verbose --prefix= --worktree-attributes"
 		return
 		;;
 	esac
-- 
2.23.0.37.g745f681289

