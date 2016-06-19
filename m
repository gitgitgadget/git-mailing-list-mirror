Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376E820189
	for <e@80x24.org>; Sun, 19 Jun 2016 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbcFSUd3 (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 16:33:29 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36032 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcFSUd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 16:33:27 -0400
Received: by mail-vk0-f43.google.com with SMTP id u64so173916692vkf.3
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 13:32:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iqw+ml6gssVpT209PzHl0CuPdX6W1nWIRNZo1XvrcZg=;
        b=DIYStrbyDsMVKijHJW4vOeFUeTuodoI32Mf/qMskDFXCraqtMIvlUyMtJh8uC4TN/h
         gUmNQuFBjeS/YL7HxDM6xPj1JZnakwUxDhsTHxyapKiIZf/bT5AhJQ3UXsfivBYjN3Fr
         Y3V7wxf2zIVu7ANg3n+yw0nBhdk+D+s4CP7569MBBNQ3u4GuM8X6E9N+FlVsoJCCz8v8
         ZID4nfm5VTCq49xvcvfF/377oN6OmLNEZoIzKLSNffJVSEC+u09R7o66e6n2mPqBKM/F
         SSQV72vaYpYtQGNl863bGCCE4PxHG76SjKr0xCLJQSNAT44w1yg/jxLNNlp2Vd2TmO3y
         pkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iqw+ml6gssVpT209PzHl0CuPdX6W1nWIRNZo1XvrcZg=;
        b=mXUXvUjQtcVEPSiT2K++zRPSJUiEqiqK0JcYawmdDE17gw+Ki2fdoPnFzcNJpkrj98
         3NOkDvxCXcU1eZ95kJhfbwSKoQ8jwsHPesC3pU/BUHw/07yW528ju59bzZM5koGWMBW3
         mL50jNCIsvNNrDNLw3Yng6RmyiUE1V5Vr7y4dU5lZMTjmd+55MfJGTZuhQDQbdoNN8Vr
         X9J6nlCsUMeIYt6z54psRBn5EwgSY9uWgssYSLHt4IOiS3SKv0S2gpKpPvvPf6uTqB31
         UCq9czCvN3eNoWfKOOY07JHh2eLfPSnbuZBHtkaHBBiFzKKKA3b5yhIfF2wSMLNB5tvv
         VLSg==
X-Gm-Message-State: ALyK8tIPIwC5ETzTrtNmDhFx+9V7YLkJGOXhnEiC7rAePLMC7Yy/nobA411wTdPOVGfLSdZdftAAinEYc+mAMg==
X-Received: by 10.176.5.2 with SMTP id 2mr5256996uax.76.1466368377546; Sun, 19
 Jun 2016 13:32:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.15.65 with HTTP; Sun, 19 Jun 2016 13:32:18 -0700 (PDT)
In-Reply-To: <xmqq60t5ya55.fsf@gitster.mtv.corp.google.com>
References: <20160619005704.1771-1-emilyxxie@gmail.com> <xmqqmvmhyiut.fsf@gitster.mtv.corp.google.com>
 <576623F7.3020700@novalis.org> <xmqq60t5ya55.fsf@gitster.mtv.corp.google.com>
From:	Emily Xie <emilyxxie@gmail.com>
Date:	Sun, 19 Jun 2016 16:32:18 -0400
Message-ID: <CAAin2AQjEUdE4Di1FJPHOFmwWEJX8-zCq_fRHiF=9RZ5S28XsQ@mail.gmail.com>
Subject: Re: [PATCH] pathspec: prevent empty strings as pathspecs
To:	Junio C Hamano <gitster@pobox.com>
Cc:	David Turner <novalis@novalis.org>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks for the quick responses on this patch!

In response to Junio:

> "At least you would need two-step process to introduce a change like
> this to warn the people whose tools and workflows you are breaking.
> That is, (1) in one release, you add code to only detect the case
> you will be changing the behaviour in a later version and give
> warning messages, and (2) in another release that is several release
> cycles later, stop warning and actually change the behaviour....

> I do not mind a two-step breaking of compatibility to address this
> issue; I would also understand if the author thinks it is not worth
> the hassle to do so.  The sudden behaviour change with this patch
> alone is however not acceptable, I would think."

I understand your hesitance with the original method. If the agreed
solution is a two-step implementation, I think it would definitely be
worth my time and hassle----in part because I'm particularly excited
about the prospect of contributing to Git, but mostly because I do
believe that it would be a good improvement.

Given this, I'll edit the patch and re-submit to only emit warning
messages for now.

- Emily
