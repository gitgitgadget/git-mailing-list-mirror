Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57071FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756538AbdCGXl7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:41:59 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33503 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756368AbdCGXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:41:56 -0500
Received: by mail-pf0-f180.google.com with SMTP id w189so6620428pfb.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 15:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IiutRJcZbntAkJRYglRINI8GbwR1wioCL33OjEWBeK0=;
        b=u5O5JOkjItxR0ClsE2GWU+JExjHSSg+od/9e0oY4GIRfphdiFvIVoc4CYN4O1UcEE3
         lflmsZlKgehs99dSWoVUoNR9jayI2AYFLWcECUnMPTh6mw2HjoBm9hzWA2pNjRoAP0BB
         Mz887CNmq9v8uhZefK1uWgX5hDlROfsTbMd4fzcxN2ENe0cREkfN+94gwLvgdc/IZknI
         jpTPlzRm1gumTZOu8sXW7kykyIQ3EGZLj7OEqGOt56ONchVx0GPTPPZzRyqIXSM70rZ9
         lAxVUkTNFdcuJKUI3jaHYKSIlj0FkVXtVuL50wlHDL71cq+GbX2dHJXZqlXP4EvdBUkP
         ikZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IiutRJcZbntAkJRYglRINI8GbwR1wioCL33OjEWBeK0=;
        b=nDggEB0bjTq1KpcCCYFvzW9q4IjUWPVWTFoZ/GfigRQPEIDrI7cRC9GQBw9qPaqOvK
         /F7jTGi6LcysjL6x/2U1gf04E7ZJLe7IteqwZkWr7Y2U60AC80Xd+SqYJbbxmoa2OJDT
         h5bzQKfWzY45tizCI0gOs9YJYLP/CH4yeolOaHnr9ZUtEG2WHqIrVVH74tKD9faXJtCm
         E1sPr6FwvX/f6cB0+45i50u5ML76SDmUd9rDTIjp9I8WUThoXkFQk7NPuqxPE4aKlWWk
         N2G408SvEXnrzwn3DrVWwUVMrzPu5xye66Ub8Y7ThLE4nrMkK9TaSvVhncqkrY8WZ8FO
         V6UA==
X-Gm-Message-State: AMke39nvbt5uYE2IEjeyzQXOiVBnF0ar9UIkgJiZLenxe2PRhGCvMTD0Px2ZaRYuUVMaL/WvaCJT/clk0ZvYH3BH
X-Received: by 10.98.198.78 with SMTP id m75mr3220594pfg.160.1488928102297;
 Tue, 07 Mar 2017 15:08:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 15:08:21 -0800 (PST)
In-Reply-To: <xmqqy3wg4rko.fsf@gitster.mtv.corp.google.com>
References: <20170302004759.27852-1-sbeller@google.com> <20170306205919.9713-1-sbeller@google.com>
 <20170306205919.9713-17-sbeller@google.com> <xmqqtw746758.fsf@gitster.mtv.corp.google.com>
 <xmqqy3wg4rko.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 15:08:21 -0800
Message-ID: <CAGZ79kYmaAY-ASa672eXmQapxJns+a3dEC_BiEmH7ti==arLtw@mail.gmail.com>
Subject: Re: [PATCH 16/18] entry.c: update submodules when interesting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +                    if (!is_submodule_populated_gently(ce->name, &err)) {
>>> +                            struct stat sb;
>>> +                            if (lstat(ce->name, &sb))
>>> +                                    die(_("could not stat file '%s'"), ce->name);
>>> +                            if (!(st.st_mode & S_IFDIR))
>>> +                                    unlink_or_warn(ce->name);
>>
>> We found that the path ce->name is supposed to be a submodule that
>> is checked out, we found that the submodule is not yet populated, we
>> tried to make sure what is on that path, and its failure would cause
>> us to die().  All that is sensible.
>> ...
>> But if that unlink fails, shouldn't we die, just like the case where
>> we cannot tell what is at the path ce->name?
>>
>> And if that unlink succeeds, instead of having an empty directory,
>> we start the "move-head" call to switch from NULL to ce->oid without
>> having any directory.  Wouldn't we want to mkdir() here (and remove
>> mkdir() in submodule_move_head() if there is one---if there isn't
>> then I do not think this codepath would work)?
>
> In addition to mkdir(), would we also need the .git file that point
> into superproject's .git/modules/ too?

The move_head function takes care of it
Both creation as well as deletion are handled in the move_head function,
when either new or old is NULL.

We can drag that out of that function and have it at the appropriate places
manually.

Why do you think it is better design to have mkdir here and not in move_head?
(For me having everything in move_head was easier to understand,
maybe it is not for others)

Thanks,
Stefan
