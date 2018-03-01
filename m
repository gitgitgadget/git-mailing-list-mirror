Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FC01F404
	for <e@80x24.org>; Thu,  1 Mar 2018 14:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031283AbeCAOjK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 09:39:10 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34770 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031184AbeCAOjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 09:39:09 -0500
Received: by mail-wm0-f49.google.com with SMTP id a20so31302686wmd.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCKuRNQ5MSAFOTQP7Sz5K3YqzT7VV3X9SJJTwVeJKYc=;
        b=nIUCqw6ZNE3XzS9JmI36GBhHolOXym+An5whGpL2ZXQS2v1oSEWowkjI0hKiS9ZXvo
         g3AgJTLEu+PITt9QrvhUykHeYK7SlhtZ6dddxcJiStYAdHUWzJQYiOL+eKSKqgBo5XOG
         j2mDEaCv+pwrPaUVQ/+RUfi7m/ngsJkFOGG5XoiWLIrftZSDg67QK0BIYwqSxW9fdktS
         04+vPaRiWUGeVYGnUvSRJOKEcIxyG6oi4H8hm6InJzHXkUcGL1SDY6RhhM+Ep87fxjlU
         UHubfP9n2aNj1GQJYyqfOxhzz8CQFmbUd8ggVYVZMSFqr8UR/H3e8jLJr89YwLv+q/7O
         Yf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VCKuRNQ5MSAFOTQP7Sz5K3YqzT7VV3X9SJJTwVeJKYc=;
        b=K/w8IeQGlUHR+s8xSVzAIf65Q/6fsNEwEYDx6x/rCaYW9o4lUuDG/M59jKjhp7I/Xd
         xHLYV45kQtX9k+0gljAtJHNaZU7YSeXmVAw+ktHcV7uYEyLRykGZCWGiemCgPEg52z5m
         GDZA8KlJIvpW9YK+yMQFnVoQzguVcYhdRgkJ0BhkfUgREoZ0n3XOTCOpTVJZTnplpL5R
         B1LiJt0QD4HUDCooygZeT9mLyJmqqZFtMhtaHtxbypYhr0rRmBExSQaUnnVbMvVEx1eY
         u9E+Upaw+McwarLq2Sa5p/U/PjkBQqQLcLGxrg8MxIZD3zi5OUhg/YLej8rlv9QKA05n
         1pZQ==
X-Gm-Message-State: APf1xPBBmnvVLJSBGxUjN+WdHmEKCbzZ7SKkN4J3xs1b5hV40O+ODEOS
        x2f25D/zZXHR1YCukZ9yODUp9zQ7
X-Google-Smtp-Source: AG47ELvvUaBaQRtivgq7lRwoUIeybVba4JKq9bIMgwJ/HLNIc9bGIP0nQmDb3xWnbIgfnuiLMlHNHw==
X-Received: by 10.80.151.105 with SMTP id d38mr3102688edb.79.1519915147811;
        Thu, 01 Mar 2018 06:39:07 -0800 (PST)
Received: from birger-Dell-T1700.hials.no ([2001:700:1200:5104:f593:cb86:c151:ca05])
        by smtp.gmail.com with ESMTPSA id k5sm4362761edc.3.2018.03.01.06.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 06:39:06 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birgersp@gmail.com>
Subject: [PATCH] git-gui: bind CTRL/CMD+numpad ENTER to do_commit
Date:   Thu,  1 Mar 2018 15:39:04 +0100
Message-Id: <20180301143904.28652-1-birgersp@gmail.com>
X-Mailer: git-send-email 2.16.2.268.g7f9c27f2f.dirty
In-Reply-To: <CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com>
References: <CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 git-gui/git-gui.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 91c00e648..6de74ce63 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3867,6 +3867,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
 bind .   <$M1B-Key-plus> {show_more_context;break}
 bind .   <$M1B-Key-KP_Add> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
+bind .   <$M1B-Key-KP_Enter> do_commit
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
 	bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
-- 
2.16.2.268.g7f9c27f2f.dirty

