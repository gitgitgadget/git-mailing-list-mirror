Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E8C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 07:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C770B6101E
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 07:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhHNHKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 03:10:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D5C06175F
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 00:10:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qk33so22339423ejc.12
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 00:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYXwFD5ypo7AE+T8HlopIxAjomJNfsodbp1xV0hBNSI=;
        b=i0SxEiX/N7vxZRR0iyZLJawLWXzIS8cdjUVFvCY50AEj4He1rPe+lZU1kTqT36y98j
         jAir/JOuSXJG340ao4gQ1faoKiONQZuiI0uPB82jFQqcSmk6nmnNZlWDJFSUqITUFUA2
         sXqO8O3WeQzVnxaHRiB65GU62sJAAu66av5OaoNTsgfcf8QZKoSiwP0B5UzHcuFr773u
         8+uP+MI8PPiNromHuid4S1X8CdwNNelMb5roFLUzvM3F+kIK8ZxIjS6pfU/OSwHe0l2Y
         kM5zSaAmrs8gQnBpO+J1g2yfvz0RG4H7qt2cVMViNDyHyPaApKPFdB6ASnShHl2WkYzU
         c4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYXwFD5ypo7AE+T8HlopIxAjomJNfsodbp1xV0hBNSI=;
        b=nXusXwKEnozoKyJ5GhM4Bs5zGGPwOm/ni9nsUvUzcG6v4WHn2HFyACWPa6DAocPk7u
         o+J8Jn2TF/EoFqXtAFH8Z1pZ3R+TThCxodNcC10ixb8KkM3iFo5Dlevfpw5mZ8OIGtUo
         fpGoH7WSn9C2BzTFqpcc60EudNQuXbGCGX1GwFhfDE54qv6NIKwStxpyyixBKVV8TlUt
         ji7oyc1alhcG6rSpOME612j+LhzY949+gaJtKboheN5ndeSsg51LfsqYrIOK5GgdjobC
         7pT86l3YQgDz0osdsjPYsEwsxXLHuYQwm4Xdw+qkH5H/dGUSbKTurMipi0qm2o5oK/e9
         eJ3w==
X-Gm-Message-State: AOAM533/+3P8GcQeSx4DtXXzfgY7oOL+bj/pO18HMwfcc9d97PCo79fM
        bjtwEg1B8Ba8d+c1b491RVbUWKROj0o+2KGBssw=
X-Google-Smtp-Source: ABdhPJxIX8g3fSIbC2qmkI9pmZeJ++0U46yuejrs4159jJDyOXpYfPuU+JXrSOASpr+lUkQDgPi4MeZSEZmQllk/EQ4=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr6206362ejs.197.1628925010751;
 Sat, 14 Aug 2021 00:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <m2im09a4dl.fsf@gmail.com>
In-Reply-To: <m2im09a4dl.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 14 Aug 2021 09:09:58 +0200
Message-ID: <CAP8UFD2f1XLwzBn1oxX7MgWBvu1ypYZiryDcMhG=W4KVTmqCjw@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog - Week 13
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 2:58 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Here's the link to the blog: <https://atharvaraykar.me/gitnotes/week13>

Great, thanks!
