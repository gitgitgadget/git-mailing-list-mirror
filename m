Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149BAC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhLIR6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 12:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbhLIR6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 12:58:09 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F051C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 09:54:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bu11so5845005qvb.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omerkatz-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=eFg1De1A/MMlKTfNJLMnSLUTdtFgDOE0PXb32NadE5Y=;
        b=5WJ2FPsCEY9G9XojfaRPYiArmW0RFO6jFLeYV19cZfP+H4kPsFXpl1bImm6wAbdQVu
         45Hc2pwTGblHfLrO31vdlDyTCPqR4zboD4FjN4BUpToIiP1+4Ruf9E+0yHYJ0ljix3ak
         Q3w+UAtBStyD0+CqPM9AtzRX8RJbwON3Lo8uu65NIVxiwJeyLe6vSIdjJHv3aemL0fHf
         qgUTAG300tiUEOe3yCVOgezQkxDYwQZ9NVBNQ+lS1px2O00IR5uCZAjxoVx2D76LKMs9
         4UQGz3ly0LeTwL6z6BdfG6usg3krY/swZRkoCqxL6cLxe8FfFWAqXz1BLInvJGkURdNB
         goCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eFg1De1A/MMlKTfNJLMnSLUTdtFgDOE0PXb32NadE5Y=;
        b=2d7VuJW9/Tg/QobpkQrgxCpHe5kohiCLpn/jTWyyotkEP5hu15ib1qv23tinBkiNqm
         3W5yagJArB2cpmfhuJY3kf3+dQAl8BjEU5/+f/mDGJJV46L6ocL+w1nMJeWUUXkRePAs
         xUkDDwv8mxu/3lWcjUh3FoK7JNCBAEE+gFHAxr82GOlNSWI0VofWTAkTY66FCGjCY2ol
         OI28x8vWqpAlCBJPCFXOUpZLFjqQU4zJFm/gFs/OsPJpog8c57mLkyI1MI2sm5qDCY58
         6jPLzTVX9FgD8+HdYo5h0f8uuccrdAjdSb6p6N2HmReBYd13YYMa3OUisFgS/EB+9h2p
         WcrQ==
X-Gm-Message-State: AOAM531iggsnknHyUiPvyZvKLIO9afMZVfHTagH9Fa4yqTRQQP8ZvS6a
        CSwXjjdC26C8aS7dl+nboiFvzbSue347Fyz6cxHbUQugd4W8JVfbfHM=
X-Google-Smtp-Source: ABdhPJxasasD2ZyMc9cTV/SgAqPsFo7Y+RkkYzl1sSRYXc6YBc49YpRcNLQaF/DFqGm96UGz9NCvoUIzp4OrN/T/CAg=
X-Received: by 2002:a05:6214:21a6:: with SMTP id t6mr18316487qvc.5.1639072475230;
 Thu, 09 Dec 2021 09:54:35 -0800 (PST)
MIME-Version: 1.0
From:   Naomi Elstein <naomi.els@omerkatz.com>
Date:   Thu, 9 Dec 2021 19:54:24 +0200
Message-ID: <CANCdVxBSeR=CnEBxS341tbs_hVRB=Hwmyc4eM=zbREm+Zz8BSA@mail.gmail.com>
Subject: Bug - SSH commit signing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some reason we can't sign commits using an SSH key because the
public key is not found.
This may be a configuration problem on our part or a bug in Git's new feature.
