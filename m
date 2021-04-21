Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11512C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DC261444
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhDUI4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhDUI4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:56:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E1C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:56:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so62336356ejc.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PSl23+GZPOEmw0qUIpWWn+EQ6YlLeLUzDsLcWYyPur4=;
        b=iWnF8lcZxNl4KqQ1ENjqia/w4lUjFWSFom+VXkoc4dkeat/3Y0fTwBlECbJhG7oQCC
         Tcn455tkcb5gAxyZchpXk42Wy0Uoj238FjQk6Sj2Z7xZtFvHZF+iOulalHmYjWy8lJfm
         XdfV/+LZsY4+sk5awFw+ktGplhKT9p2fQVhyGGXU8GUIRLVprbgyu5+SbX9hp8CqMtTK
         MGvrQTMhrvc7630SjfRosbBPo5GaMhl1h9sKisDtlq8G6gYaNYo5l89sM5RUxHj8zL14
         70BZpvd1NQcTkev926ZFO9dMmrm+vMc3XMAml+kId4N1IAKMHcLREYB1HfHsjWJWGFZS
         WjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PSl23+GZPOEmw0qUIpWWn+EQ6YlLeLUzDsLcWYyPur4=;
        b=NwMowo5v6V4u96HsFrpdhL4YLTBQ+r72Z3NZgdg9Lh5kOommUbN1AWsAI+4pwTwuP8
         gXdLGy95N5D3r/JR/3WhCnAldkUgQH4QaIzaJN3NBOulasJG5f+DfcNrAAe67tcwmG4Z
         rXqi8i5cBnaBYGKcPDN3gHjj8Y7eiQHwDJv+Y8hYGjcvOP+JXErijZXdOrxjfIZmdxg2
         DJvh9xe0x64Qg653JrIU9xidSEA6SwevV06Qd9jIvP2WSNAhdytpSBmbRLFDSCWF7SLM
         CJTgWzFLRHDHZFHLmNeoBiIGZ81h3Ir6fKt39GzO9gppV6e5cp/ukZGyIDF5Uwy1YumM
         rrLw==
X-Gm-Message-State: AOAM531k0Khvl0rRfonBTd4tGWNekQfIBnGmRRM7Pd+VrzxrTplOgYnr
        /4cGtMOVmAeEvJDikzHAezqbsPzfjuNS9lsKDc/JziFzg6MCwA==
X-Google-Smtp-Source: ABdhPJwTgXlDcFoBdS9mkdtpcxL66luNjwqDpzc7SwisNKIea6nEN/EyaFD2FMnkZWUdxIq7sW9MvLoV+Wue6msPy4E=
X-Received: by 2002:a17:906:29ca:: with SMTP id y10mr32622121eje.250.1618995367736;
 Wed, 21 Apr 2021 01:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210412040614.gqiot5qcsfpiae3a@tb-raspi4> <20210421084604.3095-1-tzadik.vanderhoof@gmail.com>
In-Reply-To: <20210421084604.3095-1-tzadik.vanderhoof@gmail.com>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Wed, 21 Apr 2021 01:55:57 -0700
Message-ID: <CAKu1iLWfaAaKH4Uui4wfa0STFEaXqqtc304b5V0ZNtmBg78J+w@mail.gmail.com>
Subject: Re: [PATCH] add git-p4.fallbackEncoding config variable, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions
To:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
