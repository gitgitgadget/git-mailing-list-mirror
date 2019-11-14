Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C661F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNUr0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34813 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfKNUr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so5112431pff.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ljf4bGTw76tYJUfi4edoMEYTPp9YsX580sIC97TcjUk=;
        b=TKrXELkz5xCJ3pdF2m71rKUjsk/pMgg2r/sYF+oVAUnDhsqFKhEFdX1lgsun3ok0sF
         4CG9EGO/bvVeGOF+hhuyEZvoDv6llyjc2QrLgbaPAbysN2XwZ3KvCvldxKbAg2gzZKra
         x9Jq5h/L+9yJvu19uxPpdqauFTkbg9exIsKxX+QymhQk4vMmxrOQbPoUs94oAxSE/Y02
         G5ZZXQ60DDEpOqDy6vKqisHfFI/UxAm3CH1iJs+Ybg49KWkYxmvUK/nomk/8d4D1uUw0
         GOd7CW2ePt8gJ3fsYjpWdK7hv4sA0ex49Jq3+3FUauMUWxW3z+JkQ374oecB3Z3EMWYU
         TGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ljf4bGTw76tYJUfi4edoMEYTPp9YsX580sIC97TcjUk=;
        b=iQtuHxD4MywrOAF7goq17co06plj/d6ShPpWu22hoKulJ0TILa7R6flc7nrSffktpw
         g4TEGhQVfw5g++huaVVf0VsCXirJTl86l5A8R0e8IpycYDx6xKITFJDSS+Ez0KXbo/tD
         UZNdSBCjBygGmG3J9SaxzDq8+8OBK5xQEJxbxw4X6PWkCcEjudCLUQIVU8LcCSQ6eLBu
         sh+Ri3kZykvA3QK4RgwaAz79Jtv6WVVL7mbZU2Odh9vNeh4518LS53a8/KJYy8xskyGc
         N/AZ3SWow1P+okkoIDltzpjlrnjZJ3h5mWQ3Fm4uA3lLz6nQcmvy/pFThcVhW0UHqgsc
         wWqw==
X-Gm-Message-State: APjAAAWzXejqJc42/O9sL5Li4xdwc1/MrBYCwWkdgO2IbbKoKiYSleI4
        5Kh1sLQrCVlfVVd85N++fZ5WWcVH
X-Google-Smtp-Source: APXvYqxwUUCEMZKjfohxczyHk7tyEWAcrnP6WHL0eijhGZz3wTWxmjm0eZpeYAcNKszN1H0BsLqKrg==
X-Received: by 2002:a63:f716:: with SMTP id x22mr4253762pgh.351.1573764443578;
        Thu, 14 Nov 2019 12:47:23 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id j7sm6504552pgl.38.2019.11.14.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:23 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 07/10] t4205: cover `git log --reflog -z` blindspot
Message-ID: <b1256c52bae1f6658ddaec90150abfdcc87ce9c3.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite does not include any tests where `--reflog` and `-z` are
used together in `git log`. Cover this blindspot. Note that the
`--pretty=oneline` case is written separately because it follows a
slightly different codepath.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..0335b428b1 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -134,6 +134,36 @@ test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
 	test_cmp expected actual
 '
 
+for p in short medium full fuller email raw
+do
+	test_expect_success "NUL termination with --reflog --pretty=$p" '
+		revs="$(git rev-list --reflog)" &&
+		for r in $revs
+		do
+			git show -s "$r" --pretty="$p" &&
+			printf "\0" || return 1
+		done >expect &&
+		{
+			git log -z --reflog --pretty="$p" &&
+			printf "\0"
+		} >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'NUL termination with --reflog --pretty=oneline' '
+	revs="$(git rev-list --reflog)" &&
+	for r in $revs
+	do
+		git show -s --pretty=oneline "$r" >raw &&
+		cat raw | lf_to_nul || exit 1
+	done >expect &&
+	# the trailing NUL is already produced so we do not need to
+	# output another one
+	git log -z --pretty=oneline --reflog >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
 	test_commit "message two" two two message-two &&
-- 
2.24.0.346.gee0de6d492

