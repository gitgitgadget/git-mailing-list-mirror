Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F0C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 21:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDMVg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMVg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 17:36:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D959D2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:36:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so8779404pjb.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681421786; x=1684013786;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNM4tlBAiJqwTn6qFqlmHyGB2rgKvGKAong8bM1YmUY=;
        b=N/B3LgbhLu2Gj8/MCzial6s+E7bMIw6AscgQKXLJ4ZifNZBQjVuqkUxHxhG28VaJ7U
         phclm6j2aDh1WPfUCYbiMSaN/KC4WoZtkKsXVdW/DlPOLIvAz4QINg8CUvtZ6beXOYUK
         4104naiornHnzQ351LVGsyCB61yFGZiEJKdmReuNSR6ym2+n8AQO1zaPuOrHAdiqExHz
         f+PhhJvkctDlNLacSkxLNhHcT4cPwXgHdee44FGazpnaV4qai3egl1lFchMmNKVnHdHW
         ziEvxdJ9lWvgI2S8BPlhCIfvzXgvJ+JtZ/RnWkSDBWWqVxe7crgg6Et3VcOEgUwGpccb
         vJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681421786; x=1684013786;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fNM4tlBAiJqwTn6qFqlmHyGB2rgKvGKAong8bM1YmUY=;
        b=I3YjWLpYdKE0CraFC5UnV53Td+rY2tfUFRy6URQo1/1bQXIWnMKiA0iAaPd+7H6UR2
         z3d3b4chJLO6L/AxyJjE9KzT/D6sKVeopO+6PVsGq2/GYU30f1e5G0U2QqLW/sffPACU
         X/rBlZZg+JGFzSJH48VghYupr+1RHkDAg0bulsbMhcfrQ+FKI7O/gUO7Bp9alsbkXx75
         SjN+0bVremWMVo3pkFAv+xsVGFJw8K0sPmz6Gb1XFZaF8AAQiJxH/wHNYRlkNPAA7Drd
         eU+EEv/lUP8BeEdefJdvthp6vSXyHSnQGWLsdMUnfJX1j88L45ByOnXReTaRzcYoCm6p
         VkqA==
X-Gm-Message-State: AAQBX9dWoZVZLvBeN+wFbotKfX7pnLP7NFX4QNMB49ZLANxBvqA8IKpO
        XVi4LZhsHgZwpjkkZnnRRWg=
X-Google-Smtp-Source: AKy350Y+PeQLuJy7i8mbfWlonT1Tyv8CotUIy5elC/apdFu/JptZgm3sblDG9hEDfoJr1ghgH3GWRA==
X-Received: by 2002:a17:903:32c6:b0:1a6:48e6:ea8e with SMTP id i6-20020a17090332c600b001a648e6ea8emr450061plr.4.1681421785754;
        Thu, 13 Apr 2023 14:36:25 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 9-20020a630e49000000b0051b3ef1295csm1740648pgo.53.2023.04.13.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 14:36:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     vdye@github.com, derrickstolee@github.com
Cc:     git@vger.kernel.org, Shuqi Liang <cheskaqiqi@gmail.com>
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
        <20230322161820.3609-1-cheskaqiqi@gmail.com>
Date:   Thu, 13 Apr 2023 14:36:24 -0700
In-Reply-To: <20230322161820.3609-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Wed, 22 Mar 2023 12:18:18 -0400")
Message-ID: <xmqq7cufxy5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Changes since v6:
>
> 1. Fix word wrap in commit message.
>
> 2. Use  'mkdir -p folder1' since full-checkout already have folder1.
>
> 3. Use `--stat` to ignore file creation time differences in unrefreshed
> index.
>
> 4. In 'diff-files with pathspec outside sparse definition' add 
> 'git diff-files "folder*/a" to show that the result is the same with a 
> wildcard pathspec.
>
> 5. Create an 'ensure_expanded' to handle silent failures.

It seems that review comments have petered out.

Shall we mark this ready for 'next'?

Thanks.
