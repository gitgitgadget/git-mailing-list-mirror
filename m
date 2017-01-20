Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1745B20756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdATTeU (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:34:20 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:37630 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbdATTeS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:34:18 -0500
Received: by mail-it0-f50.google.com with SMTP id r185so27963442ita.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 11:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6OAJMld8fdmu8Vg45k7gSavLptEqZ2xGEXsg4qhFzYk=;
        b=C+D+v/N7LKjBKUnBdKjiPS3BFjScWWdS6WTJbEUiiFWeA5N8mtDnSI6UYuJF9JwHII
         fZjPuztN3wy1akNUCDy1WUPtc4b2IcVE4EwRugq1vheqkmNo0mt1uwy0GcuyPMuikeSY
         eFI9mB6uYCN1LhjyuqGidXi5aNXtZIS1tQ/uCswEw85sailycB1+i2AT/m8G/kraGD12
         76kAGsYuB9T3C433iVUfDVoxfdWdKv355T+Cirg/SRgFUKVtf73A8A2CBxaREfCObl1v
         9VLFMfkqeo5odDHD58f/dOpQJQQOTOxqMXzwItBrxwRmMn2FURBnrNdFjKir1zJt8Ab7
         0dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6OAJMld8fdmu8Vg45k7gSavLptEqZ2xGEXsg4qhFzYk=;
        b=UssBomKuJOd+fL0Tl3r+wrZOIOtMvaSJ/APdKZHGW1lpfJzW/w32iZjnjl0G6aDxEU
         tDlKkMko9iOf4PQb9yzjcRY85RfZSzitSxOy6kRFSirY7izmbBIn+tbclYdSHbBIdMlq
         xDFRsAYVlv9i/bQcjWad1GZzYT/wlDoDlSXCBwfzZJc79LPL0CjXOEa6GzSu84Xl7n0/
         nXuuSAvtC+3xf9P1a+g1i0M8mU/TkHtZoJus3MWQEWZb2n6iGwHr54u3vs+gDqLHJBH4
         +sXNywXXO66Wnqaloq+ZRcW1RJaksstQmNXWO1csuq0nsRHMmyHqfFx4ny1xPkdWFxwW
         zNgQ==
X-Gm-Message-State: AIkVDXJ5mQktMLvaIYZWlgSGgr8eGzyoxbReAaMh1Jt4SDeRlFSXxMJaNRW4TeS3igFotvsFwNem6qFwoIFqiMcR
X-Received: by 10.36.141.2 with SMTP id w2mr5074622itd.114.1484940825564; Fri,
 20 Jan 2017 11:33:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 20 Jan 2017 11:33:45 -0800 (PST)
In-Reply-To: <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com> <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jan 2017 11:33:45 -0800
Message-ID: <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 11:17 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 19, 2017 at 11:30:23AM -0800, Stefan Beller wrote:
>
>> Now let's ask the same question for "git -C sub status ." (which is a
>> command that is only reading and not writing to the repository)
>>
>> 1) If the submodule is populated, the user clearly intended to know
>>    more about the submodules status
>> 2) It is unclear if the user wanted to learn about the submodules state
>>    (So ideally: "The submodule 'sub' is not initialized. To init ...")
>>    or the status check should be applied to the superproject instead.
>>
>> Avoid the confusion in 2) as well and just error out for now. Later on
>> we may want to add another flag to git.c to allow commands to be run
>> inside unpopulated submodules and each command reacts appropriately.
>
> I like the general idea of catching commands in unpopulated submodules,
> but I'm somewhat uncomfortable with putting an unconditional check into
> git.c, for two reasons:
>
>   1. Reading the index can be expensive. You would not want "git
>      rev-parse" to incur this cost.

Well, I would want rev-parse to not be run in the wrong repo.
(intended to rev-parse something in the submodule, but got results for
the superproject).

Talking about rev-parse, I was about to propose an extension in reply to
"[PATCH] git-prompt.sh: add submodule indicator" that rev-parse could
learn a flag similar to --show-toplevel, named:
    --show-superproject-if-any or
    --indicate-if-in-submodule-possibly
which would help out there.

>
>   2. How does this interact with commands which do interact with the
>      index? Don't they expect to find the_index unpopulated?

That is another sloppiness in this RFC patch, as I haven't nailed down
the corner cases yet.

>
>      (I notice that it's effectively tied to RUN_SETUP, which is good.
>       But that also means that many commands, like "diff", won't get the
>       benefit. Not to mention non-builtins).
>
> I'd rather see it in the commands themselves. Especially given the
> "ideal" in your status example, which requires command-specific
> knowledge.

So you rather want to go bottom up, i.e. add it to each command individually
for which it makes sense, instead of rather first having a catch-it-all like
this and then we can have a flag similar to RUN_SETUP, e.g.
ALLOW_IN_UNPOP_SUBMODULE, which allows commands to
take over the responsibility to act responsibly in this case?

status may be the first command for going that route; I wonder if we'd
want to add this feature unconditionally or only in the porcelain case.
(In plumbing you're supposed to know what you're doing... so there is
no need as well as our promise to not change it)

Thanks,
Stefan

>
> -Peff
