Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD8FC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9664220747
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 08:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANXDwT1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGAImD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgGAImC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 04:42:02 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EC2C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 01:42:02 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t4so7163541iln.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=nceoOcfEvP5wIljxfv6q0+2fIEfCAN/MYtoh0zE3vTg=;
        b=ANXDwT1hBLY9hJbth4kmamF1n1HHxDXm44n5qyJP6qtKs0wLDkSOWmDW17B2EilPhT
         4Xiroahxg9+p4KxsbLrGo0HozkF3HtzaNrF48YxlBD2Yl6wTkSVI7oWU2wUNVMS1pvzS
         3h+bC1Ap0+GFxLdf1PxzPwg7zXn0LrTBK1IhOU/AjYCrkSxsciZwm5T1BEfjJoBJw8mh
         hxTlUPGdgLHP/ffrYBOSOX7HJlTmkzp/5GL/tHkSZRCWBNGF7c0IKtvHFpX8/zLFRHAL
         9UZWTbxTBdtTsBeGmGeM0jMzk9P+DXu3RGOnzUdS5jkIcvhWRRs/66iHxdODDrb+mtBF
         1euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=nceoOcfEvP5wIljxfv6q0+2fIEfCAN/MYtoh0zE3vTg=;
        b=b2umQkAh5XhWYd+NzjpKfxlzFZFAxG6h2npL3vNBiV3fi7Qkavrz27VNZHZLI4FHbk
         DZm2vQkUSxZkyqL+b3Ys2BUp9eT041bJtf70ggEurHjKBus5IA01AJOjz59TAMGP03xQ
         Ya7+sIyMKfKyqFdFnunI8c2yzsHEQ1Ou5lidRTOcEiK8KEJD6LXjxEelvJX0G8rY+tpe
         JcKJjlx9Igyl3KQ+DQRoQX4Iu5LktiaZIZH+Wg8VkX29X3cfF8tuIlHrmT/Sbf0HKTpV
         lVpJgcRI46FENke4ylKXuIJ9uEtLj3+zWAJDVtl7E4ovLw5CEzTLjeB/3cReLQgp6CJ/
         TzAg==
X-Gm-Message-State: AOAM532SW75Cyy1b99PLO1LY5fGb4//3MqE25bzFVWtiAxKw+lgZAlOK
        ETCzO8y2b1m0KoD0QbRQoznYcLLYCnlu7B5rO+n5ahmS
X-Google-Smtp-Source: ABdhPJzaXDPqX/nA1AUJ8yP3yA2dYvH6MbB2LUdoEUbdsoqEcvBhSDTn66P2B7ZufVMMbmyVH+hQnQ8gbMk64Y4raEQ=
X-Received: by 2002:a05:6e02:581:: with SMTP id c1mr4916785ils.55.1593592921520;
 Wed, 01 Jul 2020 01:42:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 1 Jul 2020 04:41:50 -0400
Message-ID: <CAH8yC8m1=0n8zzoW--g_XLebJFqFSXpBpTr+1S58z7snLTt-0Q@mail.gmail.com>
Subject: Why won't git checkout a branch?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why can't I checkout a branch? What's broken this time?

$ rm -rf libb2
$ git clone https://github.com/noloader/libb2
Cloning into 'libb2'...
remote: Enumerating objects: 39, done.
remote: Counting objects: 100% (39/39), done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 291 (delta 14), reused 23 (delta 8), pack-reused 252
Receiving objects: 100% (291/291), 431.67 KiB | 4.23 MiB/s, done.
Resolving deltas: 100% (162/162), done.
$ cd libb2
$ git fetch --all
Fetching origin
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/autotools
  remotes/origin/fix-bigendian
  remotes/origin/m4
  remotes/origin/master
  remotes/origin/overhaul
$ git checkout m4
$ git branch
* master
