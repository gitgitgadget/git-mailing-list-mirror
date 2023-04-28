Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C3C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbjD1PfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346458AbjD1Pew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 11:34:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A01FFF
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 08:34:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5286344e1d4so5279619a12.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682696089; x=1685288089;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MO3ysLv9vFpYFAvbezJHD/9vOkUuQ2UBArHvqNZGpB0=;
        b=ABH5HAfmWP45DzufAAZhxIigqccLZqKNyE9/hK+XtP/FwaUG7VWdL3ZW5Q9SejI1gJ
         fVOi9cNZQjtNZVe1xwMDvSnlVHZWyels7DeGcUpMSpm3dG7SSM/5Sp6qsT0kOxxl5Eyi
         MVj1AI8iyK6yOdjSMiX2a7OY2kGpNzJrlT3HykVQtFOl6nfiG/KXpQoUDS2WxlRJ9HJp
         j1UoiHYe5OcuqAh+BKVvakhu9PfqAdwpXe3imvf+Ort0k8OYvg/6AgTWsQvIwWgOvueR
         177Qly463FembaadKlDRV7zlrRntMsacBkf9n/18bY/3d8xR43wpuM1F7dE3Ovk1Lzli
         1JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682696089; x=1685288089;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MO3ysLv9vFpYFAvbezJHD/9vOkUuQ2UBArHvqNZGpB0=;
        b=OyTxjJDQ86LAzaujW8SBz/IBt8qFcbiu/9W5yhPWAkueoDCPHfJQQagI9w/xwS/gHL
         F/epAomcouVGDpJ7mJSOqAhsFlbNEvdUFaQozmyhSaAX5Xap6qJMxXzeb4aQw/veYiy3
         siq2hamb7jvlLMhAAVETFwX4/QBXWLLyUkHBvwyk3WJygnVX8GT8PLugWern4Mh0f3mZ
         JRwKxPOjfZB240E1hrCdIBz4PEa+DcpCkOlmorx1G3tI8C5G5y4/ykaQKKo9wvFbNp7k
         d8fMCJeFg/Y8eqkJwnNn3HvYcoaqfH5TS/gx/agd7bph7gmj1aAcDT5dNa9/WyutFWZd
         mQ6Q==
X-Gm-Message-State: AC+VfDxP2jmf+Nug3LWYZTuFx7NYszXRYdOrpP2hCgIgat20iKbO2L+6
        l8qCCrZSK0WN5YRWdi6rqoGzLCySrONmjMDudFaUMfRMdbQ=
X-Google-Smtp-Source: ACHHUZ5IBWmkB892TlBl4GFWz5zdn+zgqYjMWUzXDbkp/D9b75nDn3FCLn8I6vVP5ZVjcLwuuA/NwnxtySpxNV7qGSE=
X-Received: by 2002:a17:90a:ac01:b0:237:40a5:7acf with SMTP id
 o1-20020a17090aac0100b0023740a57acfmr5886148pjq.33.1682696089423; Fri, 28 Apr
 2023 08:34:49 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Stromberg <strombrg@gmail.com>
Date:   Fri, 28 Apr 2023 08:34:38 -0700
Message-ID: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
Subject: Weird merge records
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I'm in a development team that has one official repo, and each
developer has their own repo that is much the same as that official
repo - modulo how recently we synchronized them.

I'm getting _many_ Merge records that look like:
    Merge branch 'develop' of ghosthub.whatever.net:abcd-def/ghij-jk=E2=80=
=A6

...and I don't know where they are coming from.

The merge records do not appear to show up in 'git log -v'. I only see
them in Ghosthub pull requests (Ghosthub being like Github, but
private).

I suspect the merge records may be coming from this small bit of shell
script I've been using to pull from the master repo into my personal
repo:
    git fetch upstream
    git checkout "$branch"
    git config pull.rebase false
    git pull upstream "$branch"
    git push origin "$branch"

Does that snippet look responsible? If yes, how might I change it to
stop creating all those merge records? If no, any guesses what else
might be causing it?

Thanks!
