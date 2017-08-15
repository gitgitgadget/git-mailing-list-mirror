Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE9A208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdHOSpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:45:43 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36689 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdHOSpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:45:43 -0400
Received: by mail-ua0-f170.google.com with SMTP id k43so6074441uaf.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kimbirkelund-dk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Yz/YncUNdq1YELs1gBAW37/qJA9MnUj1JkKAdnLtjjU=;
        b=a3af3dWIIVqFGxsOSy0i4lm60B616zEWSVtuckIWB6NionVD/UVZNrISsoe9Z/3E15
         +e0hHxeVKc7LusYGFnMrY40ZZ0m/IAIUjtNYW/DXjT8zXckgC3mu4RbvGJY8E04m9CIt
         CMwrZtJYMwEY1NYiWXCV/jALQLvF0b8B8aNHSBCL183cSDKrg4MZIAT5I5C4S2KaXg6K
         oAYCb5lcXXM3GhvlsY019IBV/RMGe1XqHkQCLB8pKcl/1FwqD9TIg2+eDJqz5U+cLNTT
         MWQzVlfFB5+5V5GW4qrr6NaQF3mNJhL3DXvLdccIMG9N9b8wOPQelOb1vwDiRa5+KQG3
         y5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Yz/YncUNdq1YELs1gBAW37/qJA9MnUj1JkKAdnLtjjU=;
        b=lz6qCdpfQk2XkcJXxdCUV4Yz/xHYY3j/9ab3YApest+9Xama3gvxtW0V5Q24LDgzoS
         N50gB60PqnPv2K2E5K17yTpFAH77mzZRSmjKVevSu/34j9ihVXLDw0PnaYICrwI/X+1h
         Jx/5Kc1B+mctqOTrtFnV9PZpTKREW+x5ChPMkRStHaoaVflLXUVIH1eQ4VvdxyfNfxtR
         JmRvrRWmvWNCvP+5NgS2ornP5uxmmuxsZemG/S47kFYo9TCFnk75935pFqmv0if/PEEX
         mH31Pu5Kez3DjEQzLlkyKGUFqiD3j++i++7TZYlB8SNzSzlJIrJFVJol58sHVq+C2hPc
         9UpA==
X-Gm-Message-State: AHYfb5hCSJEJQ5Goo4CyjG9iBdunz9gWb0UN+JJSvaUDvWk3B8w2GgK6
        EzYrVqa0WOTVZG6IyvRrDsaYlS+FfcyNx0Q=
X-Received: by 10.176.84.153 with SMTP id p25mr21094741uaa.174.1502822741845;
 Tue, 15 Aug 2017 11:45:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.39.68 with HTTP; Tue, 15 Aug 2017 11:45:20 -0700 (PDT)
X-Originating-IP: [85.191.104.86]
From:   Kim Birkelund <kim@birkelund.me>
Date:   Tue, 15 Aug 2017 20:45:20 +0200
X-Google-Sender-Auth: teXZvhkkGi8bdJr6yZBq3hcoqFo
Message-ID: <CAOCG=_p--J5PKGrQTdquMvcBNQs67MNaN3vM8Tbwn2nZNwVR+Q@mail.gmail.com>
Subject: git clean -fdx deletes tracked files
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I hope this is gonna sound as weird to you as it does to me.

The link below is a zip of a small git repository that I can reproduce
the bug in on 2 machines.

Repo: https://www.dropbox.com/s/fz4d0i5ko7s7ktr/test.zip?dl=0

It contains 2 folders: helpers and b, each of which is an empty npm
module. b\package.json refers to the helpers module.

The following reproduces the bug:

1) in terminal cd to the b folder
2) run npm install
3) run git reset HEAD --hard
4) run git clean -fdx

At this point both files in the helpers folder has been deleted and
running git status confirms this.

Tool version:

git --version => git version 2.10.2.windows.1
node -v => v6.11.2
npm -v => 5.3.0


I have no idea what is going. Very much hope you can explain :-)
