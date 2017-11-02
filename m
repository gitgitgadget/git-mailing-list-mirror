Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A912320450
	for <e@80x24.org>; Thu,  2 Nov 2017 08:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdKBIag (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 04:30:36 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:49500 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdKBIaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 04:30:35 -0400
Received: by mail-vk0-f41.google.com with SMTP id t184so3068841vka.6
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vfXLKUEfDPljkhLQsikPcCL/y6NxxqD5Ll5ZL4E70n8=;
        b=Xle+bh3+Ob1EjQumcJcnZqVt59meQsmKeBY8RyORbLzETe2mWk1fsVirUYA4HKW0zG
         syqNlzzlyN0cBJ6yY/IHkUKoivSvViZKugE7Bgrdx9e0lvwQehqaHxoAJP2/h4y/MqqV
         TGjlI5NKPinedHvgYsWmu8pLgQ3LgfgoOb1UsHH+ImGcpOw1+Z3lklq6JaFh+oyOl1sx
         s1jyntc9rjpqY9UwiCoJWluRUEngCDCdRJpKQ8KTRP7m1EJhFon0sTcTjN0hAI3xZSyG
         Z7owu55FkwQ1Rq6BdF5YquChUBDYJzknxxFNFxBXVLXTw6acDzxhEjZAg/W0YhaqXfNN
         l2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vfXLKUEfDPljkhLQsikPcCL/y6NxxqD5Ll5ZL4E70n8=;
        b=UThCSWOPxgJ2Pg3nkrYtq3e48L1vGc8PvzElG3Lyjb6HYUVALRtut+GjSWIVJx5XSZ
         VSmCX5SBUGa8sLeVsryvsa1wehpCt17SJL++3QJgCxAZXMyyYx+hEhncw3hh1FFh+QKg
         cxM1oRIQv64B/p18zSRHjC0n++6xAdfLoPDMCc6QIOIDlLgq/smquKbb7+0iK6t2bAxS
         ItVQWfnjuBO6XDOkfhQSctOiP054hKYRpksmjh5nr0m0ptP7X8Vms3BSYDKWezP7HNdy
         1SWThE+lYD9Wr00ZJ4nJrhUNWx7bZIr6NIZf7b7ODnF7J01PURZ5EdmGkknXAU7I8bU0
         K7uw==
X-Gm-Message-State: AMCzsaXRCmijfTf2LQJn9lxve17HBpyXMxIt77XZl2+k/eGrrfOyicDX
        uqkpKyQc12NCn5pasp3JBiVua+3jxCbfHojF2HeCbw==
X-Google-Smtp-Source: ABhQp+TuK0jQwUhP5Cr8pXasu1XhewHmUvkEs/D9nlKiNONsG2sOjXVdCKoXIxOMMC4vfCmPTY4qpZ6vQC7OGKPtvQY=
X-Received: by 10.31.84.5 with SMTP id i5mr2198878vkb.177.1509611434190; Thu,
 02 Nov 2017 01:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Thu, 2 Nov 2017 01:30:33 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Thu, 2 Nov 2017 10:30:33 +0200
Message-ID: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
Subject: Regression[2.14.3->2.15]: Interactive rebase fails if submodule is modified
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can't reproduce this with a minimal example, but it happens in my project.

What I tried to do for reproducing is:
rm -rf super sub
mkdir sub; cd sub; git init
git commit --allow-empty -m 'Initial commit'
mkdir ../super; cd ../super
git init
git submodule add ../sub
touch foo; git add foo sub
git commit -m 'Initial commit'
touch a; git add a; git commit -m 'a'
touch b; git add b; git commit -m 'b'
cd sub; git commit --allow-empty -m 'New commit'; cd ..
git rebase -i HEAD^^

Then drop a.

In my project I get:
error: cannot rebase: You have unstaged changes.

This works fine with 2.14.3.

- Orgad
