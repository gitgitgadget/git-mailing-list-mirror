Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F2C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 15:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjBDPEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 10:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDPES (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 10:04:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB15FCA
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 07:04:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so5854079wms.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 07:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHiDrPOjUwmCCuj8sT2F23uY8TIpwl93kNfGQubvxqs=;
        b=f1oyXM9JB53Z8qAQC9a8uJvcp0vLXV/qg/YMi8ygrIplZB0WpcYVTqUAZ9zLYuHjyQ
         1kT89Ks3NDt5rInoigYZ5/1+7UOSBijGpWhPHmnvsZ3tuArdG3eSyBIn30UEd0Oc+2Mq
         ts+aY5dtUOq6R0EqJHR483XoZr9N0A3gIeVWFzNA0AyjJqf9/j5sr83+cotqYL/gVzf0
         /LkHItx8U8nwTuWCvLdOgrZ5VBYA0LsioX1IVASkmMx8u15nKJh2dgQxfuG9SkkW1T5b
         ttrIlJ9JmaCoYhPkLBA/orH4oD5IOBU93oOhl+mMhUU3Ydj3HL5MQ7+xDF+XH0QUWsK/
         zp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHiDrPOjUwmCCuj8sT2F23uY8TIpwl93kNfGQubvxqs=;
        b=K2c5AO+1pVnnzeHqOeEbp/kM0FE1Uh4rj0XyPoiGgs+Wska1d+EM8QotVndnf7lhAy
         7QhExILIvze0YWM7RNg4uS2Z1AoQPG36039teNRPciv/pAyaFTbYFGuyc40qVJqPj8D1
         VApp4gT12XT/CKxI3frm5Jrxfse9QkymZpHO7J6egEfkQoavH6ROVdrxIo2EkKD7cXm4
         kvffkqHsYFSi/QyjVy12utE9GBYfVBur2xIb/FfvEPMSWfVL4CL/KJ/Sf0DkxdRQHvtD
         c+dOEErhDgk9avpG812Coep9+AUwzMlTjxPzyCJbQEazfUaPuHiT3b0+vKabBb9Rih8/
         UrSA==
X-Gm-Message-State: AO0yUKVla5jAJ4I31V1c70lN7l4jllpJI0Jn/5maQiDNbBP+WszDTt0F
        uiAusQTuxwhf1osX8dOftx92BATe5TfPStNSmiCPHZ5Ayxk/qw==
X-Google-Smtp-Source: AK7set9RdutpJq8/FEeTQJ4ghKPrnlbES9AtmOUKYE5phrKYvCJHKFZzKUi5weHJog6V8evYoA7upUQkbYG4uuX5XLo=
X-Received: by 2002:a05:600c:34c5:b0:3dc:36b8:fb99 with SMTP id
 d5-20020a05600c34c500b003dc36b8fb99mr626101wmq.107.1675523055364; Sat, 04 Feb
 2023 07:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20230202202557.19297-1-kostya.farber@gmail.com> <xmqqa61vsniy.fsf@gitster.g>
In-Reply-To: <xmqqa61vsniy.fsf@gitster.g>
From:   Kostya Farber <kostya.farber@gmail.com>
Date:   Sat, 4 Feb 2023 15:04:04 +0000
Message-ID: <CAPRQfCZK+zAtT-4mQMAvGwNhB5O3sr3YecSvb0WHTxnC3A5r+A@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 10:36 PM Junio C Hamano <gitster@pobox.com> wrote:

> Kostya Farber <kostya.farber@gmail.com> writes:
>
> > Add the helper function test_file_path_exists to the
> > interpret pax header test. This change makes it clearer
> > as to what the test is trying to check, in this case whether
> > a file path exists.
>
> Really?
>
> The code with "test -e" is already clear that it is checking if the
> path $data exists.  This change does not make it any clearer.  What
> it helps is that it gives a message upon failure, when the test is
> run with the "-v" option.

Okay, noted. I will look into the helper functions more closely to
understand why and how they useful compared to other methods (i.e test
-e in this instance)

> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index d473048138..19d5bd0c04 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -73,7 +73,7 @@ check_tar() {
> >                       for header in *.paxheader
> >                       do
> >                               data=${header%.paxheader}.data &&
> > -                             if test -h $data || test -e $data
> > +                             if test -h $data || test_file_path_exists $data
> >                               then
> >                                       path=$(get_pax_header $header path) &&
> >                                       if test -n "$path"
>
> Nothing seems to be adding a new helper whose name is
> test_file_path_exists; the patch expects such a helper already
> exists and uses it in place for existing "test -e".
>
> Perhaps you meant to say "use test_path_exists" not "add helper" on
> the title, and use that function in the patch instead?

Yes you are right. I made a mistake by using the wrong function name
and I think "use test_path_exists" was my intention as a title name.

> Thanks.
