Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67851FD09
	for <e@80x24.org>; Sun, 28 May 2017 12:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbdE1M5o (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 08:57:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34105 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdE1M5n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 08:57:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so9431188pfk.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qod5fCuWSBRNNkU+s7XAwlX6MlqeDD0r7/F+PaJmmbo=;
        b=NNE6nX/DAhg5+5LhD3cFV+mCrSK0xkIZrWGTbNq4CNYkdD2KWjQ/eE9lhvoLb6VaU0
         y+IrnD8lL1TGJud7pV/e3SlcG+ehdIxifKP8T996uvuBMomng5rfTCBY+umP5hQLHeNB
         N4EdgMCP0FgKA0TUcJJHsbLGtadLmL40Kv/0KRNzHeJQ1xmamrxJZgcYzBxw/xu6K9LB
         lucdRoYUivKOMMMV92DLCqW2smCTThCpuxnRZU8+PLu1wFc30GEAyUDFVzA97AVw35Gi
         Dgur76xnWYEzlm7aflBFHIHVzdt97/WGfTUO/BfOZOkPL132EbSG/BHT0Vul40rFhg53
         GHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qod5fCuWSBRNNkU+s7XAwlX6MlqeDD0r7/F+PaJmmbo=;
        b=pmAo5MraZ5jGEROyQtdPtTAwEIUaF59qzfIWZehxUmwjZgk3aDBbLkQeTtsJfV3ju2
         wsZoNya4vZpKWQE+JJ35hYv3x54caQ7KAXSDmmv0Vy/Lqh+0ht16EZr8aEHgiPpfGMDG
         6JbXEu6Zc0ZjHpBnNjP2/cYPolpcQrtXx2mXOdSFSYndPqavvZpMRerikY5+rVBftVp/
         j90Do/EYoHaDpR8MLBCs4G3L5ZwyDzWn0K3PGEuvU0SWvfXQekk2RKCR7dpGDfz3XPMH
         R18KAa6brVP3dmQjGz4GI3kbiGjJBC2HpljyfIPhS94ot6aNAtZz2rWLIlw++467QSh9
         +2AA==
X-Gm-Message-State: AODbwcB3RRenKbEWR1ACof8iisFCKD88RbE8US+PBajcP0UOLV35Ztwu
        t/Av3waTCimsUA==
X-Received: by 10.98.19.93 with SMTP id b90mr12285520pfj.21.1495976263177;
        Sun, 28 May 2017 05:57:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bd10:cbc8:82cc:8993])
        by smtp.gmail.com with ESMTPSA id k192sm10917368pgc.31.2017.05.28.05.57.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 05:57:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Jeff King" <peff@peff.net>,
        =?utf-8?Q?F=C3=A9lix?= Saparelli <felix@passcod.name>,
        <git@vger.kernel.org>
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
        <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
        <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
        <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
        <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
        <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
        <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
        <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net>
        <CEF93B59EA3F49608B41892952454B1D@PhilipOakley>
        <xmqqh905c0tm.fsf@gitster.mtv.corp.google.com>
        <48CB2547397B471C99F54CFB3F113C3F@PhilipOakley>
Date:   Sun, 28 May 2017 21:57:41 +0900
In-Reply-To: <48CB2547397B471C99F54CFB3F113C3F@PhilipOakley> (Philip Oakley's
        message of "Sun, 28 May 2017 12:21:50 +0100")
Message-ID: <xmqqtw459m0q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> However given the discussion about an unborn HEAD, the option here
>>> would be to also pass the NULL sha for the symref and then add the
>>> annotation 'HEAD' after an extra \0, in the same way that an active
>>> symref could be annotated with the '\0HEAD'. This would kill two birds
>>> with one stone!
>>
>> Are you aware of the symref capability that is already advertised in
>> the initial upload-pack response?  Right now, we do so only when
>> HEAD actually points at something, and the earlier suggestion by
>> Peff is to do so unconditionally, even when HEAD is dangling.
>
> The suggestion is the otherway around. I would argue (as a viewpoint)
> that what we advertise are object IDs and their associated refs,
> sorted by ref name. (I'm thinking of the
> git/Documentation/technical/pack-protocol.txt here). My suggestion was

That's not the part of the protocol I explained Peff's suggestion to
you about.  That's ref advertisement proper, and its first line has
a trailing NUL followed by "protocol capability" list.  There is one
"capability" that tells the receiver specifically about HEAD symref
(if and only if HEAD is a symref).  There are two reasons why the
current code does not help even though that necessary protocol bits
are *already* there (i.e. you do not need any protocol extension).
One is that existing servers do not use the symref capability for
HEAD if HEAD is pointing at an unborn branch (i.e. dangling). The
other is that the existing code sitting on the receiving end is not
prepared to handle one, even if the server end sent one.
