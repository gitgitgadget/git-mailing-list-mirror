Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7541F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 13:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbcH3NLW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 09:11:22 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35375 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcH3NLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 09:11:20 -0400
Received: by mail-it0-f51.google.com with SMTP id x131so161734694ite.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+2NWIxXENZ8F1IET/gmZREmxzbyYI4ZS3Y8FQWKDyNA=;
        b=ybqYW/6EAIaGNjzZ2apQlpuoUmCzHaxS70Adcbd3gNDdBWR9FHDZfv/ltksZRBDqpC
         IKhd0f0k5Y4Y9fA0fPYBf9/QHANASRgGoOQow7ljXenym2Et0368LtaX9JKP06I0ztTC
         RFYk3FiGr9tXi7VdKpO7mioE6sNohXz+9PvnyW3a4NQp5+JjHwBpnAYSlErzdlES56T+
         G4Ox/nl0nisvoRM3gzPlz6xbxzVqwrfdvESPaipg4qCS2CkcjORKkEqsS+RBkOJxcwfQ
         YCd5j7LJ/QKjL+gVCzEWDKAYEMbgPvV8alvPCuZP75Up4SSHDySy4QbDonZkDr4VNozl
         Bt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+2NWIxXENZ8F1IET/gmZREmxzbyYI4ZS3Y8FQWKDyNA=;
        b=J0wdJIJezTZWLasM0TWX6E4didnOMM6sPtpy6EMoSQzq3cMLVA+2dqqk+XqKeJVaQt
         6q03r0QYCjCWEkjhM0GnXacSz7S1y4UMbMcVchkUNbwAWUd4/VcHjm/9bVm5NPl3JpXE
         yK9gMlJtpgnWbzDBV7b9PYxIFI2Wb9f/4kpYno24PSQMEjCXDQo8FVgNL9ZwRBKzzBo9
         SBasVtetfDIy25BPFg7ZSK7tA2NYuqLvj75oD6AskmkhUM/9vWDa+EazOBPZ//NkIj+e
         gLqhki3og9pQxBYc0f3DJQ0vmNI1Iv+bBvdqDUdleWxlwUxyZajpA+9K+k5ODEs4e1gn
         CGeg==
X-Gm-Message-State: AE9vXwNn/DGWQX/ejwB2OPWZkI7CajBbKUKstrsKQyKhZU+HYBD2Wak+UGltx6H8+FK/xRJPt5un0xh49QvssA==
X-Received: by 10.36.91.213 with SMTP id g204mr6491330itb.42.1472562678641;
 Tue, 30 Aug 2016 06:11:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Tue, 30 Aug 2016 06:10:48 -0700 (PDT)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Aug 2016 20:10:48 +0700
Message-ID: <CACsJy8CP+Jb=B5zvhJqtR3mZY3snP=o8Zi-df8bMOJTM_3z3Zg@mail.gmail.com>
Subject: how to showing a merge graph?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to see a "git log --oneline --graph" with all non-merge commits
removed, but history is rewritten so that the merge commits represent
the entire topics and are shown to have all the parents of the base
commits. e.g. if the full graph is

*   8118403 Merge commit 'bbb2437'
|\
| * bbb2437 3p
| * dfde6b9 2p
* | 9c0aeb2 2
|/
* 8db1c06 1

I just want to see

*   8118403 Merge commit 'bbb2437'
|\
| |
|/
* 8db1c06 1

I had a quick look of rev-list-options.txt but couldn't find anything
that does that (--simplify-merges looks different), and revision.c is
not that familiar to me to figure this out by myself. Help?
-- 
Duy
