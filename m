Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C123202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 18:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbdCOSqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 14:46:02 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34376 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbdCOSqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 14:46:01 -0400
Received: by mail-pf0-f170.google.com with SMTP id v190so12635847pfb.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zfdl3vKx2PhLcc8/ovHPApiIlWmrJpSzZDjGlR3A/+U=;
        b=oEu2TJ+SI0avARvsH1vhgmRgqte+qWU0N4hZxWQ2FjZIYjoZp+zi9NXqnrhQ1KeJmk
         Bf6mS7wlhhqXzmsbu+KmM9NjXWU33evhYcA8uSeKA6IOelBFLm7KDL1Y977cKOOl97Fz
         XwAtdIfk+qs36VVLI8c9O2Ix79tw4OKr+QvyVl/GiNjRk/Lh2TVlk4PuBKA29qlhE2/l
         Ox3vYFHQjKO48GhW/5LhTc44Jpft3JyP9IEqeF8ca5vY0qxv4a/6aPTtFHyOTgc5rcnk
         eWbF6G7BlD1eBBQrAKxRNp+RNBRcN+Am6VKln9AgKtWnWY8Q05kP7mw8C4Ul14HDA+wt
         LI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zfdl3vKx2PhLcc8/ovHPApiIlWmrJpSzZDjGlR3A/+U=;
        b=kgUhwEaxXbAPLsanoVgNfCXC9y+S5lsOXiW5o2Z7O2d8ayP3SKfM6OYjBKFJNdQQwg
         Q/fWmGnlzjuGSFh9QW/62CGLrxVtmmLkJ9AepZn/Q8aXamLJHABdc42Avhw6vVeH0kgK
         Nzgp9X88DN1vd1bVim0nZBfmCek98TTX1WPQvkaBoaA3KYI0F4uxCyBFXe+YUDQVRk7y
         gxCCQFnIZaaU/wjdNUvO10rSIKW/m2QgpeLQ658m884rIF9FthlDdZ0/q5hqUGRB1zey
         GsI6lYNxjK3FByCGLIDVqyoXkIjFyKuYLk8fDAAfE23FCizaVHJCc1HhZGsVcIUB22sG
         E2zw==
X-Gm-Message-State: AFeK/H38rybZO/BoqjyRWFlqAA5KZu+Wy7v1wLDC4jerpXo49Hwjt5AppyyNAkwRBro1hD6Frmchy4rhMqD278kb
X-Received: by 10.84.224.133 with SMTP id s5mr6384290plj.93.1489603174264;
 Wed, 15 Mar 2017 11:39:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 11:39:33 -0700 (PDT)
In-Reply-To: <xmqqefxyfl6b.fsf@gitster.mtv.corp.google.com>
References: <20170314221440.18259-1-sbeller@google.com> <xmqqefxyfl6b.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 11:39:33 -0700
Message-ID: <CAGZ79kZiM2wkrUZ-KBt0kccfxRZCr79VP-7-YnsqmWX4HAH5-A@mail.gmail.com>
Subject: Re: [PATCH] submodule-config: correct error reporting for invalid
 ignore value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 11:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> As 'var' contains the whole value we get error messages that repeat
>> the section and key currently:
>>
>> warning: Invalid parameter 'true' for config option 'submodule.submodule.plugins/hooks.ignore.ignore'
>>
>> Fix this by only giving the section name in the warning.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule-config.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/submodule-config.c b/submodule-config.c
>> index 93453909cf..bb069bc097 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -333,7 +333,7 @@ static int parse_config(const char *var, const char *value, void *data)
>>                        strcmp(value, "all") &&
>>                        strcmp(value, "none"))
>>                       warning("Invalid parameter '%s' for config option "
>> -                                     "'submodule.%s.ignore'", value, var);
>> +                                     "'submodule.%s.ignore'", value, name.buf);
>
> Obviously correct.  Nobody seems to have complained about this since
> it was first written in 2.6 days, which is a bit sad, though.
>
> Thanks.

https://trends.google.com/trends/explore?date=all&q=submodule,%2Fm%2F05vqwg
(Comparing "Submodule" (search term) with "Git" (System Software) over 10 years)

#TiL
* submodule searches are less than 1% of Git searches,
   so not a lot of users compared to Git itself.
* submodules are only used in larger countries unlike Git,
  which is used in a lot more countries (well, that may be
  displaying issues)
* submodules are a German thing (relatively speaking)
   followed by Russia, US, Canada, Australia, Japan.

:-)
