Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6044C1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 20:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbeG0Voh (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 17:44:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44284 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389206AbeG0Voh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 17:44:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so11213363oih.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 13:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XoWsdUSy0yggxz2gBVFxIVwjVV4dpjXAWJewD5vq1xw=;
        b=PGngINuuu3vFhJt34fPKyDlLWH6ibcxVLgh7VXlrGw2JoCK+jrtC/Ffgnt2ZE9xx2O
         WwaNXNTSaF72AQJbuwZzgT2xOzeJl12ItTnHaBJ++O66/RaEc7keTDfiAz6HZQ7Z0/t/
         /COTseXudwILttRYE7QIRjeZujHYoMeM1868tOaGFKUdNwdx222C9mj07FHt9NTjTlrN
         G9EwKHnjk3s0WvxvnKoZ9H6ab9YwWYYsFuaUg8kaivC4JVUpCQ9H5VJsgo5zBDghUs1a
         jG/88FV+qdJntQCtntiyFWv/No44XPXFTPeWXvq7dqJX0jwYFXfadXwTWMQMUAvJZhRT
         rMsg==
X-Gm-Message-State: AOUpUlExYMqfxdfkUv43M4plibfC+QUe4R9Iv5XU9g1hlzgbiRrsMrLA
        LqZZDHBJpKgP28sfMDbNuJw2fh9vkVjoXj7Zkus+UD1+
X-Google-Smtp-Source: AAOMgpeZvOt5OD0aiJKJv6tDbAppA/gf/R/ChKv1nGIORec2qbQGWqfIKTywTFqY+0jqvtnhV++Ymk+W9lUps+SV350=
X-Received: by 2002:aca:1c04:: with SMTP id c4-v6mr8421347oic.173.1532722867661;
 Fri, 27 Jul 2018 13:21:07 -0700 (PDT)
MIME-Version: 1.0
From:   Drew Noakes <drew@drewnoakes.com>
Date:   Fri, 27 Jul 2018 21:20:54 +0100
Message-ID: <CAJd66x7ZHn=6AHFRXo5E4MhzEiW98Mpf37JRWv_18U5eYFeVJg@mail.gmail.com>
Subject: Multiple consecutive null bytes with log -z --name-only
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000010f135057200da2e"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000010f135057200da2e
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm a developer on the Git Extensions project [1] and am looking at an
issue parsing the output of `git log` in that application.

Some investigation suggests that a certain combination of arguments causes
multiple consecutive null bytes between rows, where I would ordinarily
expect one.

Passing -z with --name-only causes double nulls.

$ git log -z --pretty=format:"%H" --name-only | grep -obUaP "\x00\x00" | wc
-l
8994
$ git log -z --pretty=format:"%H" | grep -obUaP "\x00\x00" | wc -l
0

We can work around this issue, but I would like to understand if it's a bug
or if there's some information to be gleaned here.

$ git --version
git version 2.18.0.windows.1

Many thanks,

Drew

[1] https://github.com/gitextensions/gitextensions

--00000000000010f135057200da2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>I&#39;m a developer =
on the Git Extensions project [1] and am looking at an issue parsing the ou=
tput of `git log` in that application.</div><div><br></div><div>Some invest=
igation suggests that a certain combination of arguments causes multiple co=
nsecutive null bytes between rows, where I would ordinarily expect one.</di=
v><div><br></div><div>Passing -z with --name-only causes double nulls.<br><=
/div><div><br></div><div>$ git log -z --pretty=3Dformat:&quot;%H&quot; --na=
me-only | grep -obUaP &quot;\x00\x00&quot; | wc -l<br>8994<br>$ git log -z =
--pretty=3Dformat:&quot;%H&quot; | grep -obUaP &quot;\x00\x00&quot; | wc -l=
<br>0<br></div><div><br></div><div>We can work around this issue, but I wou=
ld like to understand if it&#39;s a bug or if there&#39;s some information =
to be gleaned here.<br></div><div><br></div><div>$ git --version<br>git ver=
sion 2.18.0.windows.1<br></div><div><br></div><div>Many thanks,<br></div><d=
iv><br></div><div>Drew</div><div><br></div><div>[1] <a href=3D"https://gith=
ub.com/gitextensions/gitextensions">https://github.com/gitextensions/gitext=
ensions</a><br></div></div>

--00000000000010f135057200da2e--
