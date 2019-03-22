Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781E620248
	for <e@80x24.org>; Fri, 22 Mar 2019 02:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCVCYF (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 22:24:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33783 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 22:24:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so3293861wmi.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xstVJk23ajKINLV+n3875EzXRO6H5oDJPkRX4Irmzes=;
        b=WSDAWgWIdDUUCGUOrOrnDjYY4tHPsxk9UT6hKC0nyGtg2rpHSTgbSs5zfKcwx8onGn
         k4Xzv97toUtFLnioGpPjj9d3u5qMQGxHSgBZEPWWCr4rOJgslv7+RkMrQU5gAX6LVoMI
         AMTxfjel05kiYiEYGUcPqh2+nropzoKHqoQfuIywIjRmVMJCPY+N7UC6RjL9/gRcdzgF
         YK9und0ww9+AgD+VCCcDWzUF03Q07Qo2OZX3yuG+GlbUfc4/QevFDHzpSdpr68ypMix4
         1lCpmJy5fongK+RMb8SqbteXQ0uOgqVIwRyb4jdhSp4AerYNs/iEWOgAyN64xFYh9QOJ
         PeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xstVJk23ajKINLV+n3875EzXRO6H5oDJPkRX4Irmzes=;
        b=JPNirW9k2MiPK3m4Bx+oZx46Q71YCLinLMgaisdTrqbpxR2InrLvpK4SR41PsgJjjY
         UkUksnolkHHEyOssx0UJ+K00Wzt9jtXNtXUyRz0YIodkp8H1jTpb7UWupk7JWHybgRcz
         8n8+P5DruddhztdWuVw5fqjzR72Aj9ZRysG08J666h3RP9V+RfAqie66aZyuAMiHXbTG
         pT7clj9qTiWkyGEipw8P4bVlMyPRF/vQTWhSLkeoGgQhhcTNWOoWKxGCcfeFt/KUTmDX
         cqtZ46LtDX9lzGUsbj5qgQbhojVmcl6ZNycm8fp35tqYzQ3/yT0Pv8KsjcrCM6Ti9p5U
         CK9Q==
X-Gm-Message-State: APjAAAWP+NP5ByyG4L8I+kg0i6e9kEpNP3rrHGTIKTduJECH/J16zqxP
        3QWpB5yqLK0BTIxoc5XhCmM=
X-Google-Smtp-Source: APXvYqyBZ0E8i+h92WEMrgx+B/jVoID1j7t+K/bCUD6FkzRjzLPTL0Fx1BABTalbgC8YYsv69LRgZQ==
X-Received: by 2002:a1c:c68e:: with SMTP id w136mr1265092wmf.111.1553221442820;
        Thu, 21 Mar 2019 19:24:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g3sm6255194wmk.32.2019.03.21.19.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 19:24:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
        <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
        <87pnqklr8a.fsf@javad.com>
        <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
        <878sx8lpqw.fsf@javad.com>
        <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com>
        <87k1gsh1zs.fsf@javad.com>
Date:   Fri, 22 Mar 2019 11:24:01 +0900
In-Reply-To: <87k1gsh1zs.fsf@javad.com> (Sergey Organov's message of "Thu, 21
        Mar 2019 14:59:35 +0300")
Message-ID: <xmqqy357r6im.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> With it reverted, "[alias] cp = cherry-pick -m1" can be used to train
>> the user to blindly pick a range that has a merge without thinking,
>> which is what I meant by "ship has already sailed".
>
> Did you mean "With it *not* reverted" here?

Thanks for a correction.  Yes, if we do not revert it, then that
would allow people to follow a bad workflow we do not want to
recommend (and I think that is what Elijah does not want to do), and
that is why I said the ship has already sailed.

> Those who don't like such alias are still free not to define or use it.

That's not the point.  Those who do want to be careful can learn to
use a new option --forbid-stupid-things, but why should they?  They
should be forbidden from doing stupid things by default, which is
the point of this exchange.
