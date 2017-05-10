Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B055F1FF34
	for <e@80x24.org>; Wed, 10 May 2017 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdEJH3O (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 03:29:14 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35485 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdEJH3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 03:29:13 -0400
Received: by mail-it0-f42.google.com with SMTP id c15so19649056ith.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0aJUbZHQHBbAXoRN9+aeENrqNLFMCgW5Rkya7/i+ziU=;
        b=VRKJEkSQ/gK/vJ2FfI3fLi6lmEgcLFTCUoJmebnFA3cfwml5QYIZ3O2yBnXM/c+AZN
         GheBRDdRgXPFjcEMal+kE/zXIH6PLNozqUFrHjH96ljItnPZiZKCimkt7uqf+9JyxcPC
         Vhqv+/r1aTROuRvwk0f8newR+kV56qJaK3NTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0aJUbZHQHBbAXoRN9+aeENrqNLFMCgW5Rkya7/i+ziU=;
        b=AAWtXy+xxYLzO4155atzU74l0HLzpnTgNAmpIWzYhpZepHRb+eG5pDiXxTyb648DfR
         248SUVOegSw0xLuDS9vNZkmtW4nj1+iHvUliA/r/aorFQfZXATLEQLIQqvy5wz5BtA7h
         Q6bCjDZtaFTVk9ZV0wcr1k8okO5n328HdljxGZNFxnNp8LCjQ8+wB5VgglEx+xN9p4fh
         okNuXrJtkGttrNofNrfqzTWeoRm/6RY58QG6POE+NcmBBH7tWOzxY/Y+5m9WzzIogvZq
         2nRVlhCEpxJnnxy/13DaC9bs5Yr1rvZ0jGExh+zmztIOZHzhvgwpdMnCQvzKiVcVerdD
         aC4g==
X-Gm-Message-State: AODbwcCNCivQ7atNWwiEx8aB3rFfPKV3gfrwuRyIYkcOUsVjpAupldhg
        xJVLwn0wody5J4UKGWcqeWmiulFY9LCf
X-Received: by 10.36.94.134 with SMTP id h128mr28420itb.92.1494401352629; Wed,
 10 May 2017 00:29:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.10.131 with HTTP; Wed, 10 May 2017 00:29:12 -0700 (PDT)
In-Reply-To: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 10 May 2017 12:59:12 +0530
Message-ID: <CAKohpokfVbE9=q6Rhpe0wQP9OuxyaN_z6sJaxdozGqqwTpinbA@mail.gmail.com>
Subject: Re: [Query] Override sendemail.tocmd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2017 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> I have a use case and wanted help from you guys..
>
> I have set the sendemail.tocmd option in my kernel's .git/config
> file and that works very well. But sometimes I want to avoid that
> (for example sending the patch to someone without the list and
> maintainers).
>
> The suppress-cc=all option works quite well to avoid almost
> everything (including running --cc-cmd), but it doesn't suppress
> --to-cmd.
>
> Are there any specific reasons why it is being done that way?
>
> Currently I need to go edit my .git/config file and remove tocmd
> before sending any such patches and it sucks :)

And it would be *really* useful if we can add the "review" (or whatever
it is called) screen with suppress-cc command as well. Currently the mail
goes away directly without giving us a chance to look at the final list of
recipients the mail is going to :)

--
viresh
