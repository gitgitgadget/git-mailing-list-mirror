Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD1820970
	for <e@80x24.org>; Fri, 14 Apr 2017 21:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbdDNV3S (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 17:29:18 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35465 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdDNV3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 17:29:17 -0400
Received: by mail-it0-f49.google.com with SMTP id 70so1336713ita.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NcFcLMLxIpeKiz6e0KSy70OteYIyemrs7NjOdZZLJSg=;
        b=n3GzjK6LHqvBezHignLhKXsDDn1StD6mEz7CekXn+uRnuIbGlImP3Sv09dxdXrcJRn
         ZjKOYzzHzR0ILCVdxa185O+nUxqRJwF6g2In4YhBcX02wSk9yXukPXhBWtub0pYFthvf
         fd+LplJtVMNXlc/HQIOzue0MQl4EhBjr7Q1uoWZNLZQERGHeL8MJNDMMjTvOlzCKrpfM
         cUFzYulRz2HudxDntcKufzs00mZ/Ai1E5Fcv4SPcN/LxYyyaVDKG7BZyhvQF36wNONHZ
         YtG6RJUaXiRMiAkHb5JrwvwiIli1a1RytbLbnlFHfHOpCvU35iR1n/MP6Fy8GXCXSgLN
         vUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NcFcLMLxIpeKiz6e0KSy70OteYIyemrs7NjOdZZLJSg=;
        b=drDEiWCP/4Xc5t9pE64OmqoYLCd8tvqlpXVZDjK8NOOAILUl+Q+DbAcOYE083jwCcp
         x8NEX8FpEi/xHerk9AHIGph+6GZcx10RST1KU4srj4ssjRIZay2+ZeQlAtN1goj40Wb2
         2tXRKhPDIWx0MS5ptxbYLfcbnK/d9dG52frvnwqqeHB4PTP4RRXVSEIxNdLO7wkpfuoa
         xUgEtltwYV1BHi1uvO+YDFLePEjylg/cs0XFvbKCcFKwI3zNTGdOZzDC7VhImjQrd6S/
         WbYFgz1l54SvlYPQ0tt88MREouDZWnStmiN2I7Qq3oTdHJsWinXJrnPy+pZtbSzqzcDg
         LxRQ==
X-Gm-Message-State: AN3rC/4oVKKnOb07grKaCJ5nngBgyxSnCzZ3Iak1pqDx8mS1AfjDelaD
        q+B41mgIpTZqMVgZt6ZBD2Lr6ELtfWGVoDQ=
X-Received: by 10.36.82.144 with SMTP id d138mr709273itb.24.1492205356039;
 Fri, 14 Apr 2017 14:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 14 Apr 2017 14:28:55 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 14 Apr 2017 23:28:55 +0200
Message-ID: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
Subject: Is there a way to get 'git fetch --no-tags' semantics with 'git clone'?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I can tell the only way to clone a given upstream repo,
which has an unknown main branch name without any tags is:

    git clone --single-branch <url> <repo> &&
    cd <repo> &&
    git tag -d $(git tag -l) &&
    git config remote.origin.tagOpt --no-tags

Is there really nothing like:

    git clone --single-branch --no-tags <url> <repo>

?

I suppose this can be done with the usual 'git init`, set the config &
then fetch dance, but in that case what part of 'git remote' or
friends exposes finding the remote "main" ref as --single-branch does?
