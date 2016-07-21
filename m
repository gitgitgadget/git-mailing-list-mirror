Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9785203C3
	for <e@80x24.org>; Thu, 21 Jul 2016 00:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbcGUA7A (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 20:59:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35747 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbcGUA67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 20:58:59 -0400
Received: by mail-io0-f193.google.com with SMTP id q83so4535438iod.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 17:58:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FC3nvp9WcTo07w+s4T/W5H9jPiWQLsKuSGDnMDZNP00=;
        b=qx7U+JVhCxxXoIQbbtYfmIdh6XQVmp1zNyptbww8pGBG8pllrGrui9fkw4jDwZbMcx
         1WBVEj1yYLu0YPTUJoRs1ENxrbNBYvLQxKx3oX/wt/nRyD+bai0szDFEeoeaNhbnWUwh
         EQQANICf5lL/1ucbvnOybyBLFylOXYiC5JGISDJh6YA6oMT3ODdX59zipeoK5R+mrxI6
         si3CvxPugfN/pchrJxssk0i2CwiqoQCxABd8XbqdtWwM8axaovBXRm1MKrSXIFqxU4dc
         rvJw8HWclqmmG0TS4ZprTYl6VZsrWmBAOIRyF1Dl3dSzv+lFSEI9TS+fB58ZWd5Escu+
         +YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FC3nvp9WcTo07w+s4T/W5H9jPiWQLsKuSGDnMDZNP00=;
        b=gdk47pwFv58E5HIr5T8Z9h4N0O1naYNe3aVH5kTFbJ8DKoywEgmaFl3T3dMuy3KjK2
         xiqwJPtwSa5rBjzyA86j+ZePQbp6jXwydCxRrW26nfgQN6VaQQ2W5CbhrJ/j/luKaoUK
         MrepwvYQuZi0xUQdKkT0OpMItas46rvm9SNKht1Z/R5IWGxQ8kxJLg/8Oixx06lEUR4U
         AqtnbVI5+VHtk8YCqgnGGn8hnuD1wI+bLSiINIJtV3JuY6zn/rmeI2I0eVEf80N3GaqG
         XQfxMCalezXZCSl6X4Xqu+UeJ/dDFOJbWTQkwpLRFxrAL1n2imfwddWVlr5/oYrJ5Loe
         dcTg==
X-Gm-Message-State: ALyK8tK2Sx7Ud+3DecVH+D1Y00zKiOis5DcmumgMMgDmTnJ0DwBqmOmgfGMpZD99i63ESvOTHWewAXm9ce/bTQ==
X-Received: by 10.107.50.19 with SMTP id y19mr45812321ioy.174.1469062738284;
 Wed, 20 Jul 2016 17:58:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Wed, 20 Jul 2016 17:58:57 -0700 (PDT)
From:	Parker Moore <parkrmoore@gmail.com>
Date:	Wed, 20 Jul 2016 18:58:57 -0600
Message-ID: <CAOiOGAePh6syq8XMWdzE_H8UQxzpgnsCsiYx-TG+mg46FRgXKQ@mail.gmail.com>
Subject: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Parker Moore <parkrmoore@gmail.com>

This fixes contrib/persistent-https builds for Go v1.7+ and is
compatible with Go v1.0+.

Running `make all` in `contrib/persistent-https` results in a failure
on Go 1.7 and above.

Specifically, the error is:

    go build -o git-remote-persistent-https \
   -ldflags "-X main._BUILD_EMBED_LABEL 1468613136"
    # _/Users/parkr/github/git/contrib/persistent-https
    /usr/local/Cellar/go/1.7rc1/libexec/pkg/tool/darwin_amd64/link: -X
flag requires argument of the form importpath.name=value
    make: *** [git-remote-persistent-https] Error 2

This `name=value` syntax for the -X flag was introduced in Go v1.5
(released Aug 19, 2015):

- release notes: https://golang.org/doc/go1.5#link
- commit: https://github.com/golang/go/commit/12795c02f3d6fc54ece09a86e70aaa40a94d5131

In Go v1.7, support for the old syntax was removed:

- release notes: https://tip.golang.org/doc/go1.7#compiler
- commit: https://github.com/golang/go/commit/51b624e6a29b135ce0fadb22b678acf4998ff16f

This patch includes the `=` to fix builds with Go v1.7+.

Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Parker Moore <parkrmoore@gmail.com>
---
 contrib/persistent-https/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/persistent-https/Makefile
b/contrib/persistent-https/Makefile
index 92baa3be..2b4173d 100644
--- a/contrib/persistent-https/Makefile
+++ b/contrib/persistent-https/Makefile
@@ -25,8 +25,10 @@ git-remote-persistent-http: git-remote-persistent-https
        ln -f -s git-remote-persistent-https git-remote-persistent-http

 git-remote-persistent-https:
+       case $$(go version) in \
+               "go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
        go build -o git-remote-persistent-https \
-               -ldflags "-X main._BUILD_EMBED_LABEL $(BUILD_LABEL)"
+               -ldflags "-X main._BUILD_EMBED_LABEL$${EQ}$(BUILD_LABEL)"

 clean:
        rm -f git-remote-persistent-http* *.tar.gz
