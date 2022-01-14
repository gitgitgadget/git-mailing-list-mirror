Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031DC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 06:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiANGms (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 01:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiANGms (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 01:42:48 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E44C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 22:42:47 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id m90so15434791uam.2
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 22:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opJ2VRUD84ckyyaS8VASZoV7bwS4/bOYlIhUQtXI/X4=;
        b=iEi0Gtt5+0HyyXuJ0N8Rgo1M+2w8B9FpsqRDT6o2AG3ma8IM9KnIa2OQM1jU57uVMQ
         Pe4SHzk1uUJbggam+Wst/NZItAgaHswr8yMGzSPHgcoeo+umlTLICOe4pPZTIDbSXBfT
         nbOckuL+bt4aemgyzGcpiGe+ZNmgs1VrNCBkOh8gwge2kuEi2ceH1nl6FBHXyB21BBNd
         SbkdAEl4Pc2+FXJaZzdrLm7rm3QbG4XcGIonkuH/67w2wUFW6bdkAXRbNCdVYAUBdMSk
         v9xrqzs9iOad8162EK734ixo87cU72tzdu0KhJrPDoAuJppANR7KUrSRCZgCnAbHIySx
         Iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opJ2VRUD84ckyyaS8VASZoV7bwS4/bOYlIhUQtXI/X4=;
        b=OU08TWrT/ttzt67brLKDMkr4FJtzVOr22pTCuWISO1Hk7NKlV0bzDmgAztbdnJCI8S
         FmrfUhfnfOwBfMUiR2adil1T1yB6VKJCI1F37vwGD7hfL59j2iG3bvF9AfZKQQPQBILQ
         M2qR5eAIy8jumK/Qsqp0TYW4xwxvTFM/XOf5RblZzJ3UM2vOFtc2+xosoPU0qA/1vKK0
         AByu+EVRbbI5WjTu64qBt4o0JpS6PxAGB1IB8yVEJrAJOFN9Pww/CAVQQrvlZ3HYTy5i
         7uJhFKm3DkJxQOrDcZSzvOMIKeEkJ8vlYcjlMOTUKTGsunYUBQEFBgdVAK9hJItB+Os1
         JGiQ==
X-Gm-Message-State: AOAM533dRoS6iEdDmo3gcUHi6V9cNmWmOdhUhvrKFYxmXz9mN2oab1by
        +OsY4Qfs8vXsolGrDupGzA0GZDl/Ry6xQpohkf0=
X-Google-Smtp-Source: ABdhPJxFIK5FgEmwKWwi7IWy1eDuC9o8VX/Fn4amW/M3lOvuiYREojXEXehB0yTmQ/ExNWyLwb37IIuiVfEjpt0OP6s=
X-Received: by 2002:a67:d615:: with SMTP id n21mr3886855vsj.43.1642142567095;
 Thu, 13 Jan 2022 22:42:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642129840.git.dyroneteng@gmail.com> <xmqqfspqeun5.fsf@gitster.g>
In-Reply-To: <xmqqfspqeun5.fsf@gitster.g>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Fri, 14 Jan 2022 14:42:36 +0800
Message-ID: <CADMgQSQC4T+MBgbFROy0cmB8FFk=EgikPfErwpMbduaFvEebDA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 1:47 PM Junio C Hamano <gitster@pobox.com> wrote:

> Apparently, it is not a common knowledge at least for you (and
> probably others).  Perhaps we should add a paragraph to the cli help
> and explicitly mention "options first and then args", before we go
> on to say "among args, revs first and then pathspecs".

It's much clearer now, thanks for the detailed answer.

Another question, if I want to follow your advice and add a short
paragraph in git CLI document, should this patch continue in the
current RFC patchset or launch a new patchset?

Thanks.
