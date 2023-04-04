Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B503C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjDDUWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDDUWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:22:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD93C2F
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:22:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bi39so2771368qkb.13
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Scku16UJVa3W5OsGRyb//EOsMIY9/TJdetuko9EXTJM=;
        b=FiIJNT6ScyJ3vUplmUN0KXYy+vW0XXzN8rkmWX2xzCxjzkSd0yzJRYtfM5D/gb7t2X
         qwukLp6KXR/o/jxAFqVMP84E79CT03UIv10vP8XfbhGvgBL9QLnQ6tEk6hXgB6o712bC
         mba3b/9MCw1XzGWqwuUMgFcry7usksuu6qEpQqWYTA1LB52z+5uhKxEHFH2eAfuK/C1H
         HVqQtBHhBAhZbRBXZA0ujHObyyTSs4kolGaUFqo4BUouxiibGekc2tzggjuP53FcmD37
         wkA4zwugF8JtokOmqG5JZqxMy0jj72dxsAzermAActFkUYKkIzOfIu49CX+vS4v0446R
         DvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Scku16UJVa3W5OsGRyb//EOsMIY9/TJdetuko9EXTJM=;
        b=FvK+Jd00rIOwWHfgXfA2OI23cdzln7GTntZeGakYfkpHo87wKBkyhNsze1AoCprocv
         Pcx10hR+I8C+yZLZVrRtm706IZDbYZI1OD/h7fcBS+LNl68wL+f6jhYtTtGYqhAtH6c1
         HS+jjaYfXvmkKNggRY/K2fKcgF3vFCY6q7xP8v0nvDGNVv4HmSPv0e35tR0UxJw0riOK
         J8oR8dWgVw9lFQLwyF/f2T+1jgaWmgPwEqKXaoEi7uc5s5IEh7jLXSV4iicmOrD+59+3
         dVrKFsbJ3loegj8VP09hyHKO+aHDB1vvyhb+6ZNUyT5ZPlUspJhysadFy7OQQ8zUNKDB
         19tQ==
X-Gm-Message-State: AAQBX9fUR3JGWzpQiHqhqL/jKhJ6QCxLTGSAiAgjedMcRrhsvrTZX27E
        vaZvlGuclp9I55ZirEN/Z+Iv/EYgZoVuzrWAckeiW8F1uJE2Ng==
X-Google-Smtp-Source: AKy350Z6qENGlvsCrrXKwOnOElEr9gWEoALEQ4nnDwpl1e7c9dfKKmNG14ifre25Y0I0L7a7B8toh07CY9V5NIoedE0=
X-Received: by 2002:a05:620a:190b:b0:746:7be8:f89e with SMTP id
 bj11-20020a05620a190b00b007467be8f89emr204597qkb.7.1680639751496; Tue, 04 Apr
 2023 13:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <YT2PR01MB98744AB0A168B729E89D57AFF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB98749C01D9FE7D040F80A51DF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT2PR01MB98749C01D9FE7D040F80A51DF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Apr 2023 22:22:20 +0200
Message-ID: <CAP8UFD1KCCqOFQ86Q4Sg4x0KYrO4B1dRyJKih74S61JsTGim7Q@mail.gmail.com>
Subject: Re: Git fsmonitor
To:     =?UTF-8?B?RnLDqWTDqXJpYyBMYW5kcnk=?= <fred.landry@pqm.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 4, 2023 at 5:57=E2=80=AFPM Fr=C3=A9d=C3=A9ric Landry <fred.land=
ry@pqm.net> wrote:
>
> Hi,
>
> I could not find details about which platforms are supported for the fsmo=
nitor feature.

The doc about core.fsmonitor says:

"The built-in file system monitor is currently available only on a
limited set of supported platforms. Currently, this includes Windows
and MacOS."

You can still configure a hook instead of the built-in system monitor
to get a similar feature on Linux. For example the githooks doc has a
"fsmonitor-watchman" section to use
https://facebook.github.io/watchman/ which works on Linux using
inotify.

> I am running debian 10 servers and git-2.4.0 and I am getting:

Git 2.4.0 from 2015 or Git 2.40.0 from 2023?

Best,
Christian.
