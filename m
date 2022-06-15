Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DDC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbiFOO24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiFOO23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 10:28:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB291EC74
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 07:28:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso2280588pjl.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doicqxWT7t4+ZQ2Fo9SiO5zmrlnAK4h4Wq3mBe4jgbQ=;
        b=hid5zQopzQclyf9ziETTaEFMYoF7mf0MAgNAoIJQF+EHWh26HAEl5Oo9S9Y3OJn9cU
         MW3WJGpaJSJEdUwBNZT8cmwY9WCTJyFopaKsfjA8E/GWU9sP1E4h8ikS1jDqOK3vl1ie
         SJLLF6woypwx1EY0E/iWVXoQ0yxf9x4J1dXSP0hKgu7aRNwAAn+hflKO8KmMcuqJKqCC
         z8ow2du0emxaQyxyerI4KIm/uIcsVPf2HGAuOdLVq7/NwPZF5ErkAJYu0P1rrWzJfSgW
         bEI6AFRXlEL5Q0ITHQojNh3BX7m2wTKt0VN11ju1hJWhyfdK/5UbOvs5sJLpYigP8dcz
         DGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doicqxWT7t4+ZQ2Fo9SiO5zmrlnAK4h4Wq3mBe4jgbQ=;
        b=40QP3e+3E4c+MLBjD3cXtNrPPVJFrehW2aLBo6ClaYGoaVvOKFip+cBwrLyQIJssi3
         Kt+0tAKtqNThowHLvTaAGlGdr8dM2lYXdJ8vifv0oMFRPe/QdVdxip/5IMesTPvAwKbZ
         s6h4uqD3dc+AzFmsC4Lgj3WZUtlLAz8lt7NkFlPHXqiZVjbJ2SFLMNRyD5pcaUb+pNym
         nnGUL5O+OrSnOZL7VrSazuLp+xgJFOAt0t6rJxTbQZcQoS/jP026yhVmm/8lVZXDTGKE
         yUFkpAYr4F9nqKWX2ZHDW/zxwSGSBDpNDGSzefOq6FP+uTgz9Ejt788quha0F87hf9P9
         JfSA==
X-Gm-Message-State: AJIora8WaUVBO3LtxAfH39p7NWRUW6zDOiLmSlz32DI8MMd8/XihiGxE
        Tj5LZO1xqrBxTzTuML03qk4=
X-Google-Smtp-Source: AGRyM1s+qS0ejN5AZbT87BvYZVFg6XAs39n04epWKEhfB3G2jwprpNLe6UQcWzcYRdF8AGOZjvcuVg==
X-Received: by 2002:a17:902:bc85:b0:168:dadd:f86 with SMTP id bb5-20020a170902bc8500b00168dadd0f86mr9539370plb.93.1655303308718;
        Wed, 15 Jun 2022 07:28:28 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.224])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ab8200b001616b71e5e3sm9343772plr.171.2022.06.15.07.28.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jun 2022 07:28:27 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/3] bitmap-format.txt: fix some formatting issues
Date:   Wed, 15 Jun 2022 19:58:04 +0530
Message-Id: <20220615142804.69543-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YqlDlYHR1HBJRiDZ@nand.local>
References: <YqlDlYHR1HBJRiDZ@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> - Are the hard-tabs added in this file required for ASCIIDoc to treat it
>   correctly? They are a slight impediment to reading the source in my
>   editor, but it's not a huge deal. It would just be nice if we could
>   replace "\t" characters with two or four spaces or something.


No, it is not required for Asciidoc. But `git diff --check` was complaining
against it. Don't know if that is related to my git configuration settings.
Moreover other parts of the file didn't seem to use spaces. For these reasons,
I used tabs. But can remove it if you say.

> - The above hunk is the only one which rendered slightly oddly to me; it
>   looks like the paragraph beginning with "The obvious consequence ..."
>   is surrounded by a <pre> element, when it should be a continuation of
>   the above paragraph ("In each bitmap ...").

Thanks for pointing out. Don't know how it was missed. Correcting it.

Thanks :)
