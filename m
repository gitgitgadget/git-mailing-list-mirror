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
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9EF1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfJVKUG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:06 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:39602 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:05 -0400
Received: by mail-pf1-f179.google.com with SMTP id v4so10364527pff.6
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UPmxpvz5/PCY/O3qjCziVp4k19Ep1/zOzUcfziyRfrg=;
        b=JJh16r6t5PdZK1ZBLwD721ecDcqqwQCnG9HkuNbyAcTN9bbn3/JrVzdqE+z1kuwGG8
         WdRBWab2Pfjd2aEfbQOtDZHxiRAvMMRO/b53sLpVHG+8OnWim+UIqXutBwoZHG8RVmey
         W/tqMTEYDAWrUjsCSwlnzYra5zK9Lj8g8Tdd+Tc8b+sNljCEr4wzfJBQvlanpaQCFcwT
         tvJKkxTrjrYkuBjDnhS92OoskUYXFwFRsFSzdp6boWxX+LV78Cxx6J5ByE9xbX+On4o1
         cLTU4BHul0/0cFhC7md+2MBR9Ad+RGOd4raZz8m/6n20PZQ+KF/etyN8Il3/4wmPoeab
         R7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UPmxpvz5/PCY/O3qjCziVp4k19Ep1/zOzUcfziyRfrg=;
        b=oB+Rzm0z1UCocK3LpgYoiJSyCrWGigLdoUZjzgtDGNDfyBMd7swHD9DQYFWsPdypuC
         tZYI6Sth37MUqOQZx1yiqHwpBIQPVI+0Glje/TF0R46PU7UhUaQpZn6UkJz2DvpUcBlw
         4KUNsdizZHlBYo/f65sbiHDhNAMY4ohsLKmZHMKg4U65zw81K1FjAoYYFuSbWXpjMRFo
         eZE6t33xnhlC3YSuA0hrU2hYRUH4XQ3cynGDyMs+4UFMfo1MOkWL5z7PafyGpuoNie/H
         Z6+9gOQ5Bp5FTYQXUUlUaw7+B7ZlUzWR88qx6p4DqaQ0u6dtTt8y3ekzTs6w8TeTgz89
         GvpA==
X-Gm-Message-State: APjAAAW0/9W8IGUPQCACP8TLscYPUIKpwMl1lK5qDtiUcDvo1IakvKal
        lPY7zQDThWP7S8xScdM/xOc5ENUI
X-Google-Smtp-Source: APXvYqwcuK3HX40EyI+laDbv3xcUzPmA4LshDqbWwx35nt+fxksL5TTlZPykZT1N2W6FZv3DszM+Ng==
X-Received: by 2002:a63:b24c:: with SMTP id t12mr3058938pgo.340.1571739604791;
        Tue, 22 Oct 2019 03:20:04 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id c125sm18575934pfa.107.2019.10.22.03.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:04 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 04/14] t5520: let sed open its own input
Message-ID: <0af3f5027ba9aa68da631afd21b32b534cc80cfa.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using a redirection operator to feed input into sed. However,
since sed is capable of opening its own files, make sed open its own
files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a3de2e19b6..55560ce3cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,7 @@ test_description='pulling into void'
 . ./test-lib.sh
 
 modify () {
-	sed -e "$1" <"$2" >"$2.x" &&
+	sed -e "$1" "$2" >"$2.x" &&
 	mv "$2.x" "$2"
 }
 
-- 
2.24.0.rc0.197.g0926ab8072

