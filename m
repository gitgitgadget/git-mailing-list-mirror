Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A2CC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCC521655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC66AQTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgABT4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:56:41 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56503 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgABT4l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 14:56:41 -0500
Received: by mail-qt1-f201.google.com with SMTP id b7so25202831qtg.23
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LsjgKudaK8iFe4cpXrA92Wnwg56O8Z/4c84nHlqSerU=;
        b=IC66AQTVBuzWj+o6m4JE/U0DQnwvFdE+HS/2Fqefq0XeuJAkPMjL54PqsT/GM+vZRp
         1nnp2P2xNHqabT30t8xManQzS4EwDvs3U7a10bojnpWmjBBTbvY45YDQU64VWTy71y0Y
         HA7AF3hRK9zyqJrChNUaDCUh79AWMwecfMbfHxzfMGupe3/TPUkizcLAKcI7a5y2ICq4
         xkX5A7rTWZTpkQWEl7gw9FwTPisMuKDKgk0htlOchRtDRupxIUjwdwKRCgx5F78HopBi
         lON+Udjo0MdZDPD5ZBiHOzrlujmtFnPclnQKd51r3/cn7fXakjd4VwoHp7c54tl/6whZ
         Izjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LsjgKudaK8iFe4cpXrA92Wnwg56O8Z/4c84nHlqSerU=;
        b=Ki4JuPTa0EixuTnpqzLPWTmxjc6CmEiGJgdUciuNIm6gnclMZfulVOCVlbZ18LFSsD
         6lxbDNwl1+yWbsWJZyR2379o7ISObVvtXTY8/hvW5WUiRMkmCklK7iO7Xai48EN7aaO7
         wd+54v94UqASYvzL6osQ/ky3CWPfKlCqtimvBu1t0hyF+/DfI5amwDmNnARaRbJx88Vn
         2Gp4IHkXEA/vHd75z38rj+p6dZYjFgX0i87lT3DYVSd8wwf8TCWPniGMc6L7HnI2BxdT
         naTRwNWW39sBe0x7c3ySlJrAStXfBZtM3Qaj9jg3Dho++K1NItFpGc+zU3IEf3iEW38N
         lI5Q==
X-Gm-Message-State: APjAAAVnb5LrK17Lcw1LMp20+KigRKibM3yWEjpwkgdwNGbRrpqDV1nU
        OmEPpfQaZOwFYU2lbqAnmB+g/UCfwk4IdDCFIMEm
X-Google-Smtp-Source: APXvYqxWFWPFes2I2IqBAQgVKtdazkauHqn/ftmHYrqJm4dWrmuRg6iRTtk34QqpeQigEyqo57caHm/vxG25aTpHnVUa
X-Received: by 2002:a37:514:: with SMTP id 20mr65367679qkf.321.1577995000396;
 Thu, 02 Jan 2020 11:56:40 -0800 (PST)
Date:   Thu,  2 Jan 2020 11:56:37 -0800
In-Reply-To: <xmqq7e2cfh68.fsf@gitster-ct.c.googlers.com>
Message-Id: <20200102195637.176142-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7e2cfh68.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, heba.waly@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Junio, what are your plans over what you have in your tree? If you'd
> > like to hear Heba's opinion on it, then she can chime in; if you'd like
> > a review, then I think it's good to go in.
> 
> On hold until anything like those happens ;-) 
> 
> A random reviewer mentioning something on a patch (either in a
> line-by-line critique form or "how about doing it this way instead"
> counterproposal form) without getting followed up by others
> (including the original author) is a stall review thread, and it
> does not change the equation if the random reviewer happens to be me.

OK :-)

> > And I think the answer to that is "s" is used throughout the function in
> > various ways (in particular, used to print statuses both to stdout and
> > to the message template) so any wrapping or corralling of scope would
> > just make things more complicated. In particular, the way Heba did it in
> > v2 is more unclear - at the time of setting s->hints = 0, it's done
> 
> You mean "less clear" (just double checking if I got the negation right)?

Yes, less clear - v2 is less clear than v1.

> I think I've merged it to 'next' yesterday, but it does not mean
> that much as we are in -rc and it is not such an urgent "oops we
> broke it in this cycle, let's fix it" issue.  If we see a v3 that
> improves it, I do not mind at all reverting what I merged to 'next'
> and use the updated one instead (either way, it will be in 'master'
> during the next cycle at the earliest).

Sounds good - thanks.
