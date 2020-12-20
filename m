Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDDC4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 04:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8725022D0A
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 04:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLTEX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 23:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgLTEX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 23:23:57 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165BC0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 20:23:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e2so4242890pgi.5
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=F+vGUQAlDqf48JoAWBV6RtLJPnDgyA2D9FKMlBKvmfY=;
        b=U/aoNvnINYFiTuiEVP8bqaeXY6HQzcE0WARp53MPa4kubqb63eSlBdL4pgeWvSLndK
         wYqM88LaziHdkcXBEUXLWs6Lom/Rhx+Cvnv2AQaRDCJZWe5ZczU2PC0IQhzF6zmiKKQB
         QBHx53SAoFeGOX0yCEhJ1q36F2c9UMMu/QtthHz6fLEc0ob6ohXOIqXNXlHxySp6H+WH
         jDeUvB+wUsvzVO2kFX9j0c4uQ0sITEd+e1XPuZmjX+R4I93IKYb3zK3FHuAB93kQ9aE7
         v8sJYFJICXFFR0lCmhR/Ix//sLYB41gkp/qN78qSGrdi+V2BrxKMhYZMl0yO/DAJNS7a
         JAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=F+vGUQAlDqf48JoAWBV6RtLJPnDgyA2D9FKMlBKvmfY=;
        b=P4KhTM8qgqbm1pjOrONbV/F/QABAY7jGkwQpXwy/QBUvx880AaLtrsaYWFOeu0ZuEc
         P0fPoRBSolBph3Dlr1ZYvctl2qFlUjooAWEnyjWMHRhtzxG0LhRV0/PrUj4NsjHNDLPL
         9/pF947yBjDrwUkqmwwHsdOTT26zNNQjjbK3uBatccJCYDG45OUgzPAPVp6Yx94bqy2I
         Sq446WpbS7dXzKo0lPsNDthWsMFkKreWK7IRPKKMTuh51glFR8iP7RqB8PTRr+HLf+c+
         PsmzAjtOUc+FJV9zPkwW3kFVsBKZsmNdbBJenPSG8uxz5CWfRWMUYERpOORXME/zB5Wu
         vj5w==
X-Gm-Message-State: AOAM533BO2PM084TyT3RYy0eMpdyUgjWM7TEvUDKAZugX20Ut+YHIplj
        wWH3Jvsi5BDqpcB1b+Rd+/elW8ECFL4sc96BKRshlAEqDGU=
X-Google-Smtp-Source: ABdhPJw61tu7rNz6TmVBXuX/5ZCuHdnyf/av7qmeD+UAekKrwp3waKgbYmBxBcS+PkDgNOKxTWzpQgiqvS07Sw2wSgs=
X-Received: by 2002:a65:6a46:: with SMTP id o6mr10515304pgu.36.1608438195985;
 Sat, 19 Dec 2020 20:23:15 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>
Date:   Sun, 20 Dec 2020 01:23:05 -0300
Message-ID: <CAFDeuWOit1vKUT38Uvbj2wAsb5CBo59p2h=SE6FGNb6XGOGG-w@mail.gmail.com>
Subject: [BUG] In git-log, --name-status flag overrides the --patch flag
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

When using the command

  git log --patch --name-status

It seems the name-status flag somehow overrides the patch flag, by which I =
mean
that I get the same output as simply running

  git log --name-status

It would be nice for the combination of these two flags to work, as it woul=
d
allow one to view both a summary of changed files as well as the changes
themselves, at the same time.

Happy holidays,
=C3=89rico
