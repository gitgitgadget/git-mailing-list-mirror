Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0481F406
	for <e@80x24.org>; Fri, 11 May 2018 23:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeEKXmc (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 19:42:32 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:40329 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeEKXmb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 19:42:31 -0400
Received: by mail-yb0-f169.google.com with SMTP id o80-v6so2376497ybc.7
        for <git@vger.kernel.org>; Fri, 11 May 2018 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tmwOZDtnuffep4ed/RIsh3W5HiXF97jW5orxJXMdgp0=;
        b=K1GmMmmyjWVJ3hc49D6H8JH9PydLQqCXCx+9PH9Xn3GKaHLhtA7YuHC+yYsrEhuHVG
         rzV3hfoq32QvoUF+vk2du4ABDa+OzJTTZZ2up+LQ6eUN7QM9hYZKMP5GGNzCxCYi1Ces
         l08qE0cSOMvDOeHAsbubOHuEqp7mYMbe3tGbx+yrNe25Kxo6MK/7axzTPQ+i/AQLhQGZ
         TDQBHle8On6HDgDUfBOG9jZ1mwx41yZeSNfgABRsHhdT/DiAG4EZ3N7SdCMGnvpjgGRL
         yBZUdTnKPZAHLi7jeTh7GbnchJQHYnVVjUOU8SETRw9Jdbm/SN6SxRqO9qHCKvpJLzz8
         DvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tmwOZDtnuffep4ed/RIsh3W5HiXF97jW5orxJXMdgp0=;
        b=AsYiB0EhIpIdpMpnK4j8rjiMdQPoynvk8ZbMSC5g+liLCp4M4j7uw11tcZv63M/TbN
         H6BN8U3bSt2W8Sn+7WBhtQjS6rOTaRidmj7SAH+XZrZXe/gVGsAD5VeCsq+EYxD9sQZA
         PoC0UmxxgZk7bcl7Y7cMY39QfspyixnbCvRgh423KgO7j2VbQpDlnCJp9Hr6P2qWZvV/
         FXIqsOArVBSphniqu9EAwZAKYPVWMoQP1d+K2XczdN42uNCtH7jH7TELrBW6qjnS5XdD
         Oy+2RgbUATWm+dqyrQfp0Gmnt8xqrAy8bXingyiXXhdd27w3aQ4Ud1o5Qd/0olS16/eD
         M6Aw==
X-Gm-Message-State: ALKqPwdBJz1qYKTP1NVZO7kmyOySHZ7I2BLCF20DpD+7Ffbu2Dzb1uZi
        DRCT1+RazWiqxyhBe1b+7M/ZdeF1oeF9IRZ6fCbMoQ==
X-Google-Smtp-Source: AB8JxZpvcQUCuBVoLtz6nOqBHVveU02RaDF9CV41aFQBg80jIvA43TYuPqMrQleMvSOEUZONwv278hY8soP4XQokr6c=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr2238076ybb.334.1526082150219;
 Fri, 11 May 2018 16:42:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Fri, 11 May 2018 16:42:29
 -0700 (PDT)
In-Reply-To: <20180511232840.GB41222@aiede.svl.corp.google.com>
References: <20180511231751.162855-1-sbeller@google.com> <20180511232840.GB41222@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 11 May 2018 16:42:29 -0700
Message-ID: <CAGZ79kYcOgBM_XQRidsB-T2V+vfuiG5rrNKTvhHYwzPs3mF4qA@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.sh: try harder to fetch a submodule
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 4:28 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> This is the logical continuum of fb43e31f2b4 (submodule: try harder to
>> fetch needed sha1 by direct fetching sha1, 2016-02-23) and fixes it as
>> some assumptions were not correct.
>
> Interesting.
>
> I think what would help most is an example set of commands I can use
> to reproduce this (bonus points if in the form of a test).

I tried coming up with a test in git-core that produces a remote similar to
Gerrit, and let me tell you, it's not Git that is weird here. ;)

>> > If $sha1 was not part of the default fetch ... fail ourselves here
>> assumes that the fetch_in_submodule only fails when the serverside does
>
> I'm having some trouble with the formatting here.  Is the part
> preceded by '>' a quote, and if so a quote from what?

The quote is from fb43e31f2b4.

>> There are other failures, why such a fetch may fail, such as
>>     fatal: Couldn't find remote ref HEAD
>> which can happen if the remote side doesn't advertise HEAD. Not advertising
>
> nit: it can be useful to have a blank line before and after such
> example output to help both my eyes and tools like "git log
> --format='%w(100)%b'" to understand the formatting.

Why would you use this formatting?

>
>> HEAD is allowed by the protocol spec and would happen, if HEAD points at a
>> ref, that this user cannot see (due to ACLs for example).
>
> A more typical example would be if the ref simply doesn't exist (i.e.,
> is a branch yet to be born).

Oh, I checked that but not for the submodule case, let me check that.

>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 24914963ca2..13b378a6c8f 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -614,7 +614,6 @@ cmd_update()
>>                               # is not reachable from a ref.
>>                               is_tip_reachable "$sm_path" "$sha1" ||
>>                               fetch_in_submodule "$sm_path" $depth ||
>
> Is keeping the '||' at the end of this line intended?

yes, as we only want to run the code below if there was some error.

>> -                             die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>>
>>                               # Now we tried the usual fetch, but $sha1 may
>>                               # not be reachable from any of the refs
>>                               is_tip_reachable "$sm_path" "$sha1" ||
>>                               fetch_in_submodule "$sm_path" $depth "$sha1" ||
>>                               die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
>
> Should this error message be changed?

I don't think so?
