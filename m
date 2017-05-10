Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842941FF34
	for <e@80x24.org>; Wed, 10 May 2017 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdEJKln (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 06:41:43 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38287 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdEJKlm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 06:41:42 -0400
Received: by mail-it0-f53.google.com with SMTP id e65so17448929ita.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oINaZmCfXHZWEwcyJQ2VRwxXKJ+DehaCYGzWy0MwkKE=;
        b=AyGAAGZUDUHPXqEOksjWPstYGlyeU2Oz4Wx/vyw1OlKsHinDG4QyKTNSf6jtvl/bep
         6Oe7NptCdAXC/m/xvY78WjVUG3AEdpVmurMyk4IX/ZCTKMUh5a2G0RiorYEB9BWJZawW
         0zAMNu9j8WwljsI7Cj2cs6ySpC6mPGG+mWNUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oINaZmCfXHZWEwcyJQ2VRwxXKJ+DehaCYGzWy0MwkKE=;
        b=okLwHjstfI98A/EeO3q+YXyYfVY0U7QP4mTnTUABIcyTgYQn/MHSNjM+Eiv2ysf/As
         2cRKfbM1rxyRRVLNO92fz7xYhyW545JuMNn+ZSkiMgh5aCWuy4cl5xbi0305epteGf9o
         +qbA+VCgRdV39MT++EcOOm26wCV2iTnx9fKhr4DBNCa4Xer3W9H2Krh/v5kcjuTcvebR
         lotDzFB+K71TwtlOFx+WZNlxTkAL87crgrG1uTEImlXt1PVhDWYyq+3HHXYwvmWYCFYs
         6p8NfoEWSpZC8U9lB+OK76RGeImlBk2PK0t/p/CLLIX+SB3bidcUgcjix/NT/xVtcRIM
         oT3Q==
X-Gm-Message-State: AODbwcCjGkut5xkejE1TUIePXNdojtyj6kn5MAg6Ebewri1mmYy15drn
        3AMGmCiSeIlnrGVDHvxIHMLGGOBk5bbYEAMU3A==
X-Received: by 10.36.94.134 with SMTP id h128mr528206itb.92.1494412901624;
 Wed, 10 May 2017 03:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.10.131 with HTTP; Wed, 10 May 2017 03:41:41 -0700 (PDT)
In-Reply-To: <CAKohpokfVbE9=q6Rhpe0wQP9OuxyaN_z6sJaxdozGqqwTpinbA@mail.gmail.com>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
 <CAKohpokfVbE9=q6Rhpe0wQP9OuxyaN_z6sJaxdozGqqwTpinbA@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 10 May 2017 16:11:41 +0530
Message-ID: <CAKohpokJ6zUCUdOCp4LeaCjsmfAPTSr40MV94j2EbpE1tFXnFg@mail.gmail.com>
Subject: Re: [Query] Override sendemail.tocmd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2017 at 12:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10 May 2017 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Hi,
>>
>> I have a use case and wanted help from you guys..
>>
>> I have set the sendemail.tocmd option in my kernel's .git/config
>> file and that works very well. But sometimes I want to avoid that
>> (for example sending the patch to someone without the list and
>> maintainers).
>>
>> The suppress-cc=all option works quite well to avoid almost
>> everything (including running --cc-cmd), but it doesn't suppress
>> --to-cmd.
>>
>> Are there any specific reasons why it is being done that way?
>>
>> Currently I need to go edit my .git/config file and remove tocmd
>> before sending any such patches and it sucks :)
>
> And it would be *really* useful if we can add the "review" (or whatever
> it is called) screen with suppress-cc command as well. Currently the mail
> goes away directly without giving us a chance to look at the final list of
> recipients the mail is going to :)

Fixed that with: sendemail.confirm = always
