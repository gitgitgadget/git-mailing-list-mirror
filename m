Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBCDC433EF
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiFYQG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiFYQG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 12:06:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CF6167F6
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 09:06:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so4647225plx.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3ZEAF+UzAZGp43JeGLS8XeYyDllAZfeml7XL7NB++4=;
        b=FJBqcIYzA4XmKqY/v1TNIL554hwep5NHqiAfNgBTua+6DY2IWmo9bION47hV3fzelW
         U6EuoTumpKrJu+vuT3FChqLCvA3PqeLgDpfBiolDTZcPZmWQzwSJFRxfgD97llXbptNR
         lONBBYg30g/Vsc8o+gLt8EeMsQ//OCLKERGbxg4AXye0JQLgdnt0UMCOi/Nldlyo8sfu
         21IYzHC4koiwBC7AHvNInZL9QSYQSASKlTaEnNct9C/TobQ8GNzIT/U0shCDmAEg73EW
         tPr2MfQResjHazCQV8dwlU4hsJOn8l0t0LO0RfD8JRPxlA3Kp9z/E6YvpWMGmLsygc2B
         Gt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3ZEAF+UzAZGp43JeGLS8XeYyDllAZfeml7XL7NB++4=;
        b=He6d3LkqDFPoedYJL9A6JO2C4+HAyXRDojvx2YmnrYNSS1Xnr5guUzyXXDBoRCVqhP
         tkZotzxiFleHwji+5wIeW4SdtmasXwnJ0Vk3iIjt+EJtR+aSlgn+eLLLeVynw81fhLt9
         ZpoWKKFr3cqUkjzwuKHrQ6SZpxHxyh8nQOLslsAUxjKxU8+EIZSxKObmmHlpepSQUZtr
         +Czn8jz0n48e1cPcZniwf4x7YFCI09IFNcJxH/nQ9AkvVSGEhKDFFoTp0pe8Ss/pmiN1
         KOrZFIB7uH4U6NzUvhL1F00Fx2uXq6egQOnbGeZzfw0bAYJ/g4WfDlBZZ6mr0flFp2Of
         /EiQ==
X-Gm-Message-State: AJIora/jvFYZAT+M6QeZ/G3XYjHyNFSihVhQee9NlmWSBAg3NXwAeTHQ
        txgOSE+PcZ953hW50QACo16NQZYJvhGJ6yoAi7I=
X-Google-Smtp-Source: AGRyM1tPiLmYpEdMINVNhP/KEUIlOrTJVxc0GakIBTbIxZUSzkz+tZ4enlsnj6esB1kQY0pVm9/hf6V15whXK0wHTaU=
X-Received: by 2002:a17:903:32ce:b0:16a:607b:31df with SMTP id
 i14-20020a17090332ce00b0016a607b31dfmr5235237plr.117.1656173184160; Sat, 25
 Jun 2022 09:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAChcVumTgNqRTt=EtThXiw9ga=W9WC-uS0XOkz7T+TbtGKeU+w@mail.gmail.com>
 <xmqq1qvwfntm.fsf@gitster.g> <CA+P7+xrfkApv_r_YQqOt-LiaC=Ctb2px0UuaSwqU_ua_qmH4OA@mail.gmail.com>
 <CA+P7+xrwapFU6z9P7HOKmcGUVFiAn20PVahGG=SC=KSDTv0hNw@mail.gmail.com>
In-Reply-To: <CA+P7+xrwapFU6z9P7HOKmcGUVFiAn20PVahGG=SC=KSDTv0hNw@mail.gmail.com>
From:   Pavel Rappo <pavel.rappo@gmail.com>
Date:   Sat, 25 Jun 2022 17:06:12 +0100
Message-ID: <CAChcVu=HRECdUCjgNywiG=o+S8DvAtqYd7TjzrvFiZZq80Xaog@mail.gmail.com>
Subject: Re: Should `git remote show` display excluded branches as to-be-fetched?
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 1:34 AM Jacob Keller <jacob.keller@gmail.com> wrote:

> I found a working solution, but I don't really like the
> implementation, so perhaps someone with more knowledge of the struct
> refspec, struct refspec_item, etc would help me figure out if I am
> doing it in a good way. I just posted it.

Thanks, Jake. Does Git project have an issue tracker we could enter
this bug into?
