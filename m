Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705A01F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeHVUL5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 16:11:57 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34081 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVUL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 16:11:57 -0400
Received: by mail-oi0-f54.google.com with SMTP id 13-v6so4313146ois.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=q+NPoyeobuwQ+PJEzfxIVb3qPjS6wYop+2pBB49sTQs=;
        b=N4VeJT6y6KEPSmpyN7fk39dJwrH/9wWJoSxcLBC2+PEEjLC1hIbudVeenzAnRjpeFX
         6y+4w9/6zYaaZF39ZFD4WaIbUsIe9rGKhSXvDSylJWkLHquJ55P1lEOgtMGU1qmgJrgN
         HiQRCpiAjv6EPmQzERJKfq03k5oWPfsMCNJMjRjexX7fxIjEV4ADatw1sjIHnPAhtJ8d
         RUOYYT8eq/jZqdMVgtYBHDd0dGtuNLM3yc21SX1psyZCf3NKFJBGT8G5hYtioIPxNADP
         /WPyn05Ho236rpv/NGk/MB7J+US7w0yDzrYGclMCY2YSIjzzInEQJNvtorW8jsKdmZs4
         8UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q+NPoyeobuwQ+PJEzfxIVb3qPjS6wYop+2pBB49sTQs=;
        b=Lr4hLKTfViVSmPMd5ibD8OgjPKmTNRP49BUhMtCGt8xZlM8K4PnX8nDaY5q4yZRBvg
         Lo6acnJ+MR7Bu1sjKwhvX+GDvZF9O7u8tqhjIDtoXQKdCHKJ6Lh3M6arBiRBjdsFyWA8
         F3DiYFLtMGVKBQSb+m5/XT+OrjGzE5/QtIgY+u59roytOf9HTpsnDxA6mpcAhCL8609k
         uVTBVKak04rezcjYtud8oHQ59uICC4qKI4nskjFAkoehVH6z3bMN4sLnm0O+kCYefC+o
         xQCbAUJtvcr/xizE3cstrxDPU7ypKTwJeTlMS7ZAAMNGC8kJ58Bq2PfuAtiM4yd8j1Oc
         VriA==
X-Gm-Message-State: APzg51BOGc5umRpMqo0BqpdUy2kQt//Zxc5pty1H8dQByCyZf46shal3
        dd60qVUq3wEWz3wq9XKwmwKiZMz4GgEyrIMy5Opt5HAM
X-Google-Smtp-Source: ANB0VdbCADRAiW1AkOFbPzAZG4dz7j04kX/O/UrWYo2ryDMHlimUTEhWQ+WiNOUFn9WThYzjsrOhFCm8XRuoKK2RLGA=
X-Received: by 2002:aca:56d1:: with SMTP id k200-v6mr5068368oib.319.1534956379756;
 Wed, 22 Aug 2018 09:46:19 -0700 (PDT)
MIME-Version: 1.0
From:   Hari Lubovac <hlubovac@gmail.com>
Date:   Wed, 22 Aug 2018 09:46:08 -0700
Message-ID: <CAFLu24kbCJu74tgfRDR=xPZ3pkbau9R6jmqPbFKR=ZnWOvbCvQ@mail.gmail.com>
Subject: MINOR: log-format "%C" & "%+" log
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

I don't know where else to report this. It relates to the "log"
command with "--pretty:format" argument.

It appears to me that "%C" format argument combined with "%+" or "%-"
results in no color applied.

For example, I'd expect the last part of the output line ("%+D") to be
colored red (it does when the "+" is removed):

git log --pretty="format:%C(Yellow)%t %C(reset)%ad
%C(Cyan)%<(6,trunc)%an %C(reset)%s %C(Red)%+D" --date="format:%m/%d"

This info is taken from https://git-scm.com/docs/pretty-formats: "If
you add a + (plus sign) after '%' of a placeholder..."

Thanks,
Hari
