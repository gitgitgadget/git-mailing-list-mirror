Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EC720188
	for <e@80x24.org>; Wed, 10 May 2017 13:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdEJNoa (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 09:44:30 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36501 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdEJNo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 09:44:29 -0400
Received: by mail-qk0-f175.google.com with SMTP id u75so30132701qka.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=i9wvzvTZxXkc/O8+ltJtblQAYzJ2ILuVQtMd7X6mO6U=;
        b=UlretziOIlGXKvH7GrbDS4sSUikGKG+eDnpCfwe0IkwHHVhU2MpzShjWlCzehl71ku
         ZldJ6Y2UhmygJOlzZsA10xJSnq61JBr6zjFi3ptxpbesyXQ4kS3mMplkG7ScIrugYbIk
         DOdEDMN8epq+MLFojHm2zTzFXHJ4PnkcSSJgSE1GuMSPMo8jMncVRslOc77tW4x8z5ia
         /yHBMImp2wZiBpxSCw9emXGO2GVC/7sA7Bh5al3EyUw3x9hO93SMOzN+TFj68R/gj2rm
         j1vFTDU60fCdHbSTklVTCEBBPqBrH0LMhxkWl4qiYk2XIEOjkHc6exceSRrjzjLd5XG8
         884w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i9wvzvTZxXkc/O8+ltJtblQAYzJ2ILuVQtMd7X6mO6U=;
        b=U1abpwOX/I6T/P89UEwmWFOg8nzMXd3SKsQcC6koLK+aKWrPkFs0hh+Fpn7UodRbbr
         2ZJN9ycytbFbX5LTTxQon8EteR6nQkpd+VUj1C7QYF2UfM6TlO3gUOrh1CEgOaJ5Hllu
         nAUjc3ekSANt3XdswOu4KjObe0m+HyFYa7avIRZuh2HEiOFxwpNFleaSfEfQIPdrKu/k
         fk8upP61ZnufDlg5jTYpLO1YbY3CEcS8TxnZyCXiKzohy0J65VrVapOLptIMRxkofRLS
         I8Or0NGfma1wcFA6Dt2cohiGneKRPO5HGJvFvbA/88gR/8VQqCZ2DwB4SSgabMRQTL4v
         2uPQ==
X-Gm-Message-State: AODbwcAJsJeb2Sayd/VAkIQfXUd+gMTKCWyCPjDYyC5mXKcM3VS9fdOs
        oYlfKBaTr5GdmPL895cdfZPC0wrzpEIp5EE=
X-Received: by 10.80.183.4 with SMTP id g4mr4327228ede.138.1494423868376; Wed,
 10 May 2017 06:44:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.144.226 with HTTP; Wed, 10 May 2017 06:44:27 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Wed, 10 May 2017 16:44:27 +0300
Message-ID: <CAGHpTBLGwGXZk=xAB+Pb4GvtqN8+K=8BuaA-zov9sZZat-OYHQ@mail.gmail.com>
Subject: bug with git add and .gitignore
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When a not-ignored file inside an ignore directory is added along with
other files, a false alarm is shown:

git init
echo /d/ > .gitignore
mkdir d
touch d/file foo
git add -f d/file foo
git add d/file
# fine
git add d/file foo
# The following paths are ignored by one of your .gitignore files:
# d
# Use -f if you really want to add them.

I did not try to add a new file in d. It's the same file that is
already indexed.

- Orgad
