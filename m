Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D78FC6FA8E
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 00:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBZAtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 19:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBZAto (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 19:49:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A0CCC1C
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 16:49:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy6so12020258edb.5
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 16:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2rwRipVYrRtgWIjzBTKU500RYT6MB8bUasAcvy8u1o=;
        b=e66sfHCEwszggHSNPtgJSLAFEoZ3eVdRqJOpQ9iWZ8WYTYdPptUscB24VBXiqXcQx+
         7JpWW3/0IoJHcnknvlfNHyV6mlg25AtYTp+g6EqwJ9B9eevLZzRyceHU01kwDDEzBeyr
         X34vPoVfrlLX+IDqi0gsEGEzfdnjz/rkjBk7KYXOPjIdC2aVsKdZoEhrJkKEAiJrd1AA
         MCoHcHnnW6J1rJ9kP/BOhAS0Hh0M0lZloq2O/SeCHecbCDNCrA3oWk4ePX6zGt4/MjhW
         LA8K9P1/GsHocJgqms/dp5p3Gdww2jOGMZaJs2CZtc//3abArg1wYMf+QtJH3hmNAyvR
         IfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2rwRipVYrRtgWIjzBTKU500RYT6MB8bUasAcvy8u1o=;
        b=cvlItQC5zb/To3GTCGDk461nzie31ocEhXWoRV7nY5bZbzshfdlvF0kWFAGahm+p/G
         Al9y2Q9FXRvqPK+qyeMN+Y4Yx+hugiKN4sDmXixN9zjF4Caj53k8RUDDUc/l8lrKKl1Q
         Jz7Cqj4nvSfCCbvJPjfHjOHiitDv76/fkne4JrAVNHQPzqJGzEMvGaX0jVDO5FS4WIzi
         psPpAKMQveUDdWTm3mNcxPt/kAsoIhfEGhDt6thg/HeJt+OYggjNGbcpIGLGRqzHmQlZ
         dSZZgWuXSKISEap4ftH4G9Org7GVETy5C/Ia2d5dofjMKGbKeb7nlDTtgIOPImJSbtpK
         ocsA==
X-Gm-Message-State: AO0yUKWh8WfTzpQkdJ38gb2XoBQvGGM8phWJ/i9k5wkIgXWvqrvzcyiu
        6p1Q0L6jM4bRw/6PNFhv+yelEstyZGghVrn53ij2mG6M4yJeZQ==
X-Google-Smtp-Source: AK7set+jyZKGx2i8wXW5pyxfyfOZcnB2utwi7W8DY7uOjGf/VIJiwx+zLYrdB6zs+u1Kbs+Kzpx3r5FkwleFDENuXnw=
X-Received: by 2002:a17:906:6d0:b0:87b:da7a:f202 with SMTP id
 v16-20020a17090606d000b0087bda7af202mr12605213ejb.1.1677372580654; Sat, 25
 Feb 2023 16:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20230222011317.97943-1-gvivan6@gmail.com> <20230223082759.36021-1-gvivan6@gmail.com>
 <4de72b33-fb1a-ab8d-11b8-9e89554fa8ad@emailplus.org> <CACzddJqv=CX8LC55_RHVi46GOUuVqY7C0iMLHaFn24uNHzPf9w@mail.gmail.com>
 <a191c829-dfd4-a180-114d-147787d88aed@emailplus.org>
In-Reply-To: <a191c829-dfd4-a180-114d-147787d88aed@emailplus.org>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Sat, 25 Feb 2023 17:49:29 -0700
Message-ID: <CADupsJPw1GrTJDdyckUkmBfNLs4TTuGFGfV-uUOZJDOvgPCryw@mail.gmail.com>
Subject: Re: [PATCH v3] MyFirstContribution: add note about SMTP server config
To:     Benson Muite <benson_muite@emailplus.org>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Have not tested all of the setups in https://git-send-email.io/ The
> Fedora instructions seem fine.  It can be updated through Git, so
> contributions for other setups are possible. There is a nice way to test:
> https://git-send-email.io/#step-3

I am waiting for someone else to offer their input on the matter. However,
I appreciate your suggestion nonetheless.
