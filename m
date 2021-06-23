Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38306C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2746115A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWXdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 19:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWXdD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 19:33:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4054C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 16:30:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h15so6897459lfv.12
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JuerHhojD/GBefmyKphtQny0fEd4ZOYYvplP2rIGJkM=;
        b=ry+6bzBgVx/d2CCa0/lw/UQ6F0XIncY6uzUOq2DLJCvL/5Le/Awf92LcPXnT1ylW+6
         yli7f4mqKF4xxdOna3XGhDXdSVHv6CGn5Z8IUGLbPylfVrl10m7k7dsRPIMoUNwZaZqB
         aJ1xvMfsTVE3oUdm53Uplc2JZs6kRU9OVDdj30zg5MI7GivzFSSNBlwDb708Q4nZKe56
         fnx1jgJdcoNjFXUfH+v02dhkIgRgoRR3cOdxEGZ8Pc8vlZPSQGyaNMh+FtLKntMDEkbJ
         l7Ay8heLP4iY+MXQEY+mdlE5qB+rq7eTzmxN8ZcS7Qd1TP9yrCZMbPRol3pNDGzRq31I
         Q9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JuerHhojD/GBefmyKphtQny0fEd4ZOYYvplP2rIGJkM=;
        b=UH9o5K43zaPxgxdSMAIo/O69wRufFEqxnLrMadYiQeEed8on4aBT9gJGSW5/8E9wco
         PNDMd5Kh1kVmFwd6wCCaNlwV3Fys4r1uXGNBzzcUGSM/bDiTPNyiz+gdUVv9Hc8OlwoK
         Eprquu0SNSaoYlDiDb3LW47KGGx3TXo9TtVtrEz132G7bSKNq9jlKO7Uox9h4mfKeYsE
         s4dLYVmq7Na3fzwg+cOwGkcm4g+/Mnpa2lJjlrJXzMd8FcjZqmNdmf1aRBHTSAzHxiXh
         A/1bZnZVDDUcdr/J1w00f4I1PzTB8ZDqqJ4NwdM4mKiohr87zTeDsUZ4kXFl5WwQbITO
         Ce1Q==
X-Gm-Message-State: AOAM53183bTjihwule+9PiczzVaMCoY5meYsBShv/MyfL14TXZQ7ru+Q
        3Pu9nlF4Dy4fZvbgmOgk5cf1tTAm4tPN8eLh3qDuT28gVyM6b7nc5p4=
X-Google-Smtp-Source: ABdhPJy69+JWQMXrvtfqy/Z1XsXQ5tE+K2KmmyMXFrHKCQvqtIbMAGRwTYln8e/iXwDkW7KX1JvH6LrzRBleR2my3tU=
X-Received: by 2002:a19:ad46:: with SMTP id s6mr1527440lfd.466.1624491040619;
 Wed, 23 Jun 2021 16:30:40 -0700 (PDT)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Thu, 24 Jun 2021 07:30:29 +0800
Message-ID: <CAGP6PO+hnvAdYuMKQG15-fhRVdDBCCn2xfnLP5=exPcs4GHJVQ@mail.gmail.com>
Subject: Where does the variable GIT_HOSTING comes?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Ubuntu 20.04, see my following relevant git variables settings:

$ env |grep GIT
GIT_SSL_NO_VERIFY=1
GIT_HOSTING=git@git.domain.com
GIT_DISCOVERY_ACROSS_FILESYSTEM=true

I don't set the `GIT_HOSTING' variable at all. Then where does it come
from and what's the function of it?

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
NO. 552 North Gangtie Road, Xingtai, China
