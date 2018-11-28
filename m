Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526841F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeK1WmT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 17:42:19 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45443 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1WmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 17:42:19 -0500
Received: by mail-lf1-f53.google.com with SMTP id b20so19078880lfa.12
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FKf/caR20T04knpsPuF1/clAr4xyvo0LHp3UJ9qfYAo=;
        b=PabSypQBhNNkkB8s6fyCLWTOGXHpMTMYjVzYYOK71Fl9i6tr0BM5SbTChWOsexgEAc
         eMzr3bYxTsDUqwdUMxRXFgihQxIfOW9T4xVhXdy/RgANoUp02bpkeUESQvUGnjDaag9n
         VvCz7RRovCaYRYTHQflla7iwdnr08Ov5YsIPnfdVFAuoKoT8uclHr+FWWw54V9b8eWHR
         HYEBoe/l42KNfUZxiRP0G6jGMK6IRAuhI/tnT51z681/fBZmbxniETXkPZ34togCg+Ll
         ErGXFHpCdCmewl2eW6IiX1neDrtqEvHDVtEufbcAUAFVf3ve3Xw1+L314fSXGHtB5Q+o
         KgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FKf/caR20T04knpsPuF1/clAr4xyvo0LHp3UJ9qfYAo=;
        b=fQm0uwiZqPOjMa4FmfbzVLASs2/+hZjQCPg9HxLGwPro66xo/CFtdskMRZcTjZa1Wx
         bv+5YBAWZ6aCqy/HCyCPwHA06IvMdTtMRrZWOWBGdeYbcNKdobXs0Wp6JCUkg780HCWz
         Pcpjuyz0H3c+HQ7fBJD9XRw4YmnnGJcJMY+f5GnxCD9TOhgJYH9tp0JFcU4H2LuNsAyk
         sES8Et+9SJ+5mnuvv0UmNXTO+fbLtNQmG/MU/kbKUUlsVNE2t3V733XEhlhZYGxIZZ2l
         7f4ZO4xEyika+X3DCEaHbRAVbn6V4Yoov5jWw0GU4RGzm1mbaDq5iG4co0IpecI99yMt
         u9/A==
X-Gm-Message-State: AGRZ1gKu5RPk0peYbsIWDzbTGhfT+LuzL9LfKZ1yfIMZXLYLHUmQvTF3
        BwJ+XJ9CJHu1LxIFea401R2BGQoE6JBBSbvwSUt8kA==
X-Google-Smtp-Source: AJdET5eLuC1ylAzwoGFgmckIGfx1ItRk0/QslEJRk19edKZTjARn47frRkdYTvIgMHNCEZsrU0Ei/DSrMswKwH6NGLE=
X-Received: by 2002:a19:a149:: with SMTP id k70mr21098571lfe.5.1543405255443;
 Wed, 28 Nov 2018 03:40:55 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Pawe=C5=82_Samoraj?= <samoraj.pawel@gmail.com>
Date:   Wed, 28 Nov 2018 12:40:44 +0100
Message-ID: <CAJjcwZ-bjCVbsXhyRtQHsH9U+yytbRvq07j4hTOnuD-g0XXL0w@mail.gmail.com>
Subject: Broken alignment in git-reset docs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!
The git-reset documentation page section which is accessible via URL
https://git-scm.com/docs/git-reset#_discussion is not looking good.

ASCII tables should look like this:

      working index HEAD target         working index HEAD
      ----------------------------------------------------
       A       B     C    D     --soft      A       B     D
                                     --mixed   A       D     D
                                     --hard     D       D     D
                                     --merge (disallowed)
                                     --keep  (disallowed)

but are like this:

  working index HEAD target         working index HEAD
  ----------------------------------------------------
   A       B     C    D     --soft   A       B     D
--mixed  A       D     D
--hard   D       D     D
--merge (disallowed)
--keep  (disallowed)


The web archive has got a snapshot from 2014-06-28 when it was ok
(https://web.archive.org/web/20140628170155/http://git-scm.com/docs/git-reset).
