Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098471F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeBAXAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:00:43 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:37361 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeBAXAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:00:42 -0500
Received: by mail-ua0-f170.google.com with SMTP id q8so13007420uae.4
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=tUSKe5mmRJcOXyle/tZOHXJLISpQXLf7vcpGPTOXJZo=;
        b=dUqFCpZxuCHST0+J3Rd5p50CAJUk+WMzPkMPCc1P8OEH0pRlXOHybhFVu2FJtdL65/
         zY6d6aFDddx8UR6QcuRvRsHNVqbSR/F99yyDB/XoRnaUXDRd61v93Pdty7yAqb1OQBdq
         HFSvnldkkpAg6i/UWCBpfDvaoiObV0InIIKFTkW4MTDqza5aW3cXZ5+RPk1yDEQ1TTjC
         /UOkpRHP8hE6y00zk+T8bHfg7I1UxvTn1y/f8BLJWZlp3tlFTgdYo82bvTfTWgZ0+LYn
         50FZUIC3rYiG+TgxTlmgEKF3C39ZHA+EUnLUxpD/VgG2Ffyr3Zddt1L8LqWcChpcCsUx
         02uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tUSKe5mmRJcOXyle/tZOHXJLISpQXLf7vcpGPTOXJZo=;
        b=ntp0ry/oDWEYh/CFTtblGJIolM16bBoXzJWCWk7UnapIUhf9Dnsg0v1HHQhKW0HFQf
         AiepFCpiOC8dKbDzyHhEUCvK2rKIFQa867CK//0Jw4iJj1ijaaypyPVKvym7FIqvPlTe
         VAW7JBkbXia7fAh9psNxb2VyRmFDb2WsMKwyI6Kz3ilE8OI1iZa5IH7us/VZyrCiUEdN
         juCaAO5/QboSW+ts7YeOzQgt7x1kLLeWXU7fkeUlPEBh15IOuT0hWFmRJK+YLNogy2nK
         NZpxtF11Ku7myOl4z/ZkT6GZDsDub7fcTV+GKSTAc2GRLD1rKDCqca4Fdys5TCs9pOJ2
         K+gA==
X-Gm-Message-State: AKwxyte37XUcxPDlo8zEEN+fIYPAiPiuUJSu7342c32U2PRxZnGk22Qs
        tdfbvKe5GRY8a9OPs8Wx02sz8CtMDO8NfaozB60HJCfbLgo=
X-Google-Smtp-Source: AH8x225R6DJslh95wM1Ny/3UqEEhrIftoyH6A2aijU4hKJfra6UTX47Ahgs/lROJ99lpuRDsIWNOOiYIPPoYRSbduco=
X-Received: by 10.159.43.4 with SMTP id p4mr29778921uaj.142.1517526041338;
 Thu, 01 Feb 2018 15:00:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.2.237 with HTTP; Thu, 1 Feb 2018 15:00:40 -0800 (PST)
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 1 Feb 2018 15:00:40 -0800
Message-ID: <CAGyf7-He4in8JWUh9dpAwvoPkQz9hr8nCBpxOxhZEd8+jtqTpg@mail.gmail.com>
Subject: 2 conflicts referencing the same path?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating an issue with rendering conflicts on a pull
request, I noticed that the merge was producing this output (sanitized
for paths)

$ git merge --no-ff --log -m "Test" 190a25b6e0f32c7b8ccddf8c31e054149dece8b7
CONFLICT (rename/add): Rename A->B in HEAD. B added in
190a25b6e0f32c7b8ccddf8c31e054149dece8b7
Adding as B~190a25b6e0f32c7b8ccddf8c31e054149dece8b7 instead
...
Auto-merging B
CONFLICT (content): Merge conflicts in B

(There are several other conflicts listed "between" the two I'm
showing here, various rename/add, add/add and content conflicts, but
I'm trimming those out to focus on the lines that I think are relevant
to my question.)

This merge produces 2 (or is it 3?) conflicts for the same B path:
- Rename A to B in HEAD, add B in 190a25b
- Content conflicts in B

The version of B left in place _does_ contain conflict markers, after
the merge processes completes. The version added as B~190a25b has no
conflict markers; it just shows a small number of inserted lines.

The merge in question produces 23 different CONFLICT lines, but aside
from "composite" conflicts (rename/add, add/add) that can include the
same path multiple times in their output, only this one path is
mentioned in multiple CONFLICT lines.

I'm still trying to produce a set of steps that will allow a minimal
reproduction, but I thought I'd post to the list just to see if anyone
had any thoughts on how it could happen. Is it a "normal" (albeit
rare) case? Or could it represent some sort of issue in Git's 3-way
merge algorithm (in its behavior or perhaps in how the merge conflicts
are logged)?

Any insights appreciated!
Bryan Turner
