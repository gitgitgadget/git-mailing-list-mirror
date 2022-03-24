Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CD0C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350590AbiCXQqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiCXQqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:46:45 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4D6FA28
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:45:12 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id a127so5539637vsa.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=a01spaJjImarfnCBbNEAUsKDHt9XhCx9bFrcssrzomk=;
        b=RvNB+GoZV9Epm7A+qpS6EurbosQCMqwSgXKjv+AUz1+J+yBvW81zq3zMNzLexK5SbT
         zNwu2dd8+BxUf3jdjm5Ox4FvRfknFbLnF1xgrxijHAk02MFlVFr6ih8GpauMP3fsWYa9
         2HXcyMUIk6vU1tmG21cLcoK7Yrm+pdyWNOh7CnabHBTJUqenMlSsYtWkTIa1vlIl0btt
         VlgXuSC0DEeNqXOvYLPDJBb7cp928xs3vlg2N+49XMQX/vqLfQXHiAnXj8DLDWATou7k
         htZnO5tYMm0/LySQzHCjz2hWiJ9JhgB1hVISugD8ras+edfx5lD/DPFeCZVyM1PiBjUe
         IpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=a01spaJjImarfnCBbNEAUsKDHt9XhCx9bFrcssrzomk=;
        b=UkAfuNrEM6OOGtWpEUrERhxs6AcThyCa/KRl5CgnoWMvo0UiW4EnzyyZcRRsOuPsyZ
         6Dj/f3MIkmWQaAPr97zh+E2Wpbf5W/GwlMhGf85pyxwPyJYmV3uYcoV18plrf151c598
         AE671srkeubhhCotzDlzmjGpovCKDInf4pr8USsnVp/t9T0lHq1FW2UqLhmeGcdEa2Lr
         fxREHZcdBaGdcwDcykBml5JiFejZwIa3U9jmA4GXtvIC2m0Zg72i+bMRrHjfFPjA7lMD
         HPU2qCQjFLRqu1ehP9nWOEe0SQPAXVL7AMfXqHAMv9vsScvhAO+HQsBOi+kt9nmzlZCw
         oq2w==
X-Gm-Message-State: AOAM531pGfbYNcqOcWT3qG/5cYp5c6b3l0CxJawEY67aNTn45lmuyOxY
        mjGK5MMdsT9WtGGiTeTvr5PBRsLQr20lE7YHmsE1wVYZnqQ=
X-Google-Smtp-Source: ABdhPJxhK5D2L8wiBwNthkyi8aJrEYwhSH2qyaABU0H89AgQZc9ikKkOCYKn/Ju2Wiaq+PfQCayiYmFJKoPG1Dhcit8=
X-Received: by 2002:a05:6102:390d:b0:325:26d5:7f73 with SMTP id
 e13-20020a056102390d00b0032526d57f73mr3245384vsu.29.1648140311911; Thu, 24
 Mar 2022 09:45:11 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Honza_Proke=C5=A1?= <proke.j@gmail.com>
Date:   Thu, 24 Mar 2022 17:45:00 +0100
Message-ID: <CA+ZGDOUKrNRdf-7+SBoVhPkAmyHEtt==AJ=jBDWGkOUcz=n4BA@mail.gmail.com>
Subject: bug report: pre-push hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I did setup pre-push hook to run unit tests.

What did you expect to happen? (Expected behavior)
Pre-push executes tests, I can see output, and if tests fail, push
does not happen.

What happened instead? (Actual behavior)
Tests seem to execute on the background, but I do not see output and
push happens when tests fail.

What's different between what you expected and what actually happened?
As above, so:
Tests seem to execute on the background, but I do not see output and
push happens when tests fail.

Anything else you want to add:
When I run pre-push script directly from terminal, it executes tests,
I see output and if I ask for last command exit-code, it is non-zero
if tests fail, so my script is functional. It was working until
recently, noticed today, but this behavior happened at least two days
ago. It was working well in past. My fella has the same issue with
similar script on up-to-date Arch Linux.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.105-1-MANJARO #1 SMP PREEMPT Fri Mar 11 14:12:33 UTC
2022 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
pre-push

S pozdravem / Best regards

Jan Proke=C5=A1

Full stack program=C3=A1tor / Web developer
