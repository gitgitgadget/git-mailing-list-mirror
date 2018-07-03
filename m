Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD3A1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 16:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeGCQFU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 12:05:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35483 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbeGCQFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 12:05:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so2903226wmc.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Cm1BcZ0zqmhdRrM/MgCcaJlcd4Fk4vkZMhhF9Eiubf0=;
        b=jlaVhvlX6PLF4cx9BqeGNNDR66PgCtszx2C/+nvBfp1ljTeTLNFEvIJ3g5T0vwclDc
         EhxArRFb+aa91n7o9US31HdUEaRgW07qCaaz5jVNMqtadWbGvulXBJblqTs1UJpeWFsn
         6ewTf9DYPBLjI6Ja2BLA3xNaD2SxXKKckaweio7Li6PBkENK/acZ8bQxW2UOJwEhPLB3
         ELRobpTJdB6B5GLkMi3c0lCmVxafkTCdMZ4e8+GmowPU9PSL5zWJwHLuVIYWsqJEiveJ
         ZbIU7Z4mHTW5fNEX7fTEYsQ6IR7GLJIPIi0yf+oaTdJahuAvSZesELKk08lDZXuodd65
         gydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Cm1BcZ0zqmhdRrM/MgCcaJlcd4Fk4vkZMhhF9Eiubf0=;
        b=lvGgxgUaOQl+YBvptrCdWMkuZTT6mAgkVGTBvp/18MjJUi8udZqmCLIb1M5v//zxOM
         glS5VIvkTrhfjX4VvgP0DumcyQVTOKVPKhxHzrRj0yyqSVAqoXZ7mH73izGFGG8OoFbO
         bGiPz4nWfv+xQZZRnqn+jAqg+6fP8yv+ROrrF680IDD0TU/sdL7i+sLEiikpPNGoGcCV
         H2JTq9O4TNMn+/NHqWHWOVK/fSaMQbBWui0pX0mc9GGa62w8OVb82ZZrKrwuDi4y71/s
         RRrn5dhOqX9iHcVchztMp7ulxpcNph8u4HsrxEsjpGTvddSTTrpuLzMqLQC3KZm+fSLR
         2CPw==
X-Gm-Message-State: APt69E1RmPlSN0Zu7eq1AqykOa5WK+8bd9u9DucqqVLj0Owt5JBkk5hr
        ao3FHpydsSWDUenQADYgKIzbfBzY
X-Google-Smtp-Source: AAOMgpcmYpYM0KQa41PZcUbfJ/67yMQBNw0sXR1umvcf/avjyu0CzSSw2l7BeGj+rsjwkvImX6liwg==
X-Received: by 2002:a1c:a341:: with SMTP id m62-v6mr12536373wme.3.1530633918720;
        Tue, 03 Jul 2018 09:05:18 -0700 (PDT)
Received: from evledraar ([139.47.6.17])
        by smtp.gmail.com with ESMTPSA id 49-v6sm195593wrx.18.2018.07.03.09.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:05:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: fast-import slowness when importing large files with small differences
References: <20180629094413.bgltep6ntlza6vhz@glandium.org> <87o9ftckhb.fsf@evledraar.gmail.com> <20180629233538.7zxxrvou4twqyd6d@glandium.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180629233538.7zxxrvou4twqyd6d@glandium.org>
Date:   Tue, 03 Jul 2018 18:05:16 +0200
Message-ID: <87muv8cnk3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 29 2018, Mike Hommey wrote:

> On Sat, Jun 30, 2018 at 12:10:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Fri, Jun 29 2018, Mike Hommey wrote:
>>
>> > I noticed some slowness when fast-importing data from the Firefox mercurial
>> > repository, where fast-import spends more than 5 minutes importing ~2000
>> > revisions of one particular file. I reduced a testcase while still
>> > using real data. One could synthesize data with kind of the same
>> > properties, but I figured real data could be useful.
>> >
>> > To reproduce:
>> > $ git clone https://gist.github.com/b6b8edcff2005cc482cf84972adfbba9.git foo
>> > $ git init bar
>> > $ cd bar
>> > $ python ../foo/import.py ../foo/data.gz | git fast-import --depth=2000
>> >
>> > [...]
>> > So maybe it would make sense to consolidate the diff code (after all,
>> > diff-delta.c is an old specialized fork of xdiff). With manual trimming
>> > of common head and tail, this gets down to 3:33.
>> >
>> > I'll also note that Facebook has imported xdiff from the git code base
>> > into mercurial and improved performance on it, so it might also be worth
>> > looking at what's worth taking from there.
>>
>> It would be interesting to see how does this compares with a more naïve
>> approach of committing every version of this file one-at-a-time into a
>> new repository (with & without gc.auto=0). Perhaps deltaing as we go is
>> suboptimal compared to just writing out a lot of redundant data and
>> repacking it all at once later.
>
> "Just" writing 26GB? And that's only one file. If I were to do that for
> the whole repository, it would yield a > 100GB pack. Instead of < 2GB
> currently.

To clarify on my terse response. I mean to try this on an isolated test
case to see to what extent the problem you're describing is unique to
fast-import, and to what extent it's encountered during "normal" git use
when you commit all the revisions of that file in succession.

Perhaps the difference between the two would give some hint as to how to
proceed, or not.
