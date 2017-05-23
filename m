Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C9A1FF30
	for <e@80x24.org>; Tue, 23 May 2017 07:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936046AbdEWHqk (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 03:46:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36809 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934001AbdEWHqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 03:46:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so25726075pfb.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OQGJrUKOiRMLDg9b0LeJvBYg4k6pjgo+sTdSSWTSOUQ=;
        b=hoJkeYCcfW7Cn9V0MjDQeNVyRJ/9H9w+nKmy9YEHq6YelVXeZL/WSLCKHz9K2lAVc/
         uZx0Za4jesDRJDCsdJV+ta0l+PPRBcKqQG8t5doQ2fx+fE4LMw8XUAiCVeNswB+ijE9m
         JgyCyOlLyt4ylVYnTknkZ7E8/9lyG+4n8TTsHv4g3Bk3YSViPYZcV2+C4l0TfxOd2G3m
         2r95CIVc0LyE0499T/v3sW7zz1Q/i+o32IckF9VVPuFAq96UA8dZv7cEL2d7FX1c2G8X
         S0ZZhM9MFAawLD1FF1bHMLgDHinROZPQAO28M7NZ1Gg/VGwzq0ohVxfYim4V1YaOVKZd
         Toww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OQGJrUKOiRMLDg9b0LeJvBYg4k6pjgo+sTdSSWTSOUQ=;
        b=MOIye4yc4+y4DaqjJWU59558+r1OXVCKsqVxTCGJtJqqIviBIeT8RXBG6Es4agHTgH
         DOWmC7JCgXR/QEbUijYzQ3hbqFhIHL3sDaoQSEk7xNRGn2k55RHlbUb56Tp1v3lZQ+Mp
         GI7so+8pBu1urcTLinaSaj2DnVawfBQER4SJfxj+lwriB64d9ovvjgk3BWeHQ3qGm08u
         /i0AtvyJyaNB0UUSg2TC/177Msay6nQ/EgV0QnDYmPkVEDU9LMfkwk3TMWkdghudskyB
         1NlVnvkQokLoI3SsB5Wl7m9ClI4LlQ5qvUW/PPHEmyRVBek/rgdyWVvEskE2Eca2QSUp
         1ySw==
X-Gm-Message-State: AODbwcA9DhAfAr7YY5ASnqfyMcK5slalqz/nkmloo5q0HhjTKpGJpKLz
        oKaH6L1gOzKZMQ==
X-Received: by 10.84.215.155 with SMTP id l27mr33922073pli.31.1495525597127;
        Tue, 23 May 2017 00:46:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id q76sm11784695pfd.40.2017.05.23.00.46.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 00:46:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     xiaoqiang zhao <zxq_yx_007@163.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jan Viktorin <viktorin@rehivetech.com>, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5] send-email: --batch-size to work around some SMTP server limit
References: <20170521125950.5524-1-zxq_yx_007@163.com>
        <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
Date:   Tue, 23 May 2017 16:46:27 +0900
In-Reply-To: <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 22 May
 2017 11:26:41
        +0200")
Message-ID: <xmqq60gskobw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Looking at this the Nth time now though I wonder about this approach
> in general. In all your E-Mails I don't think you ever said /what/
> sort of error you had from the SMTP server, you just said you had a
> failure or an error, I assume you hit one of the die's in the
> send_message() function. Can you paste the actual error you get
> without this patch?
>
> I wonder if something like this would Just Work for this case without
> any configuration or command-line options, with the added benefit of
> just working for anyone with transitory SMTP issues as well (patch
> posted with -w, full version at
> https://github.com/avar/git/commit/acb60c4bde50bdcb62b71ed46f49617e2caef84e.patch):

Yeah, if the issues users of 163.com are having can be resolved with
a more general approach like this, that would be very much preferred.

> Now that's very much a WIP and I don't have a server like that to test against.
>
> Having worked with SMTP a lot in a past life/job, I'd say it's *very*
> likely that you're just getting a /^4/ error code from 163.com,
> probably 421, which would make this logic even simpler. I.e. we could
> just adjust this to back-off for /^4/ instead of trying to handle
> arbitrary errors.
>
> Anyway, I'm not interested in pursuing that WIP patch, and I don't
> think perfect should be the enemy of the good here. Your patch works
> for you, doesn't really damage anything else, so if you're not
> interested in hacking up something like the above I think we should
> just take it.
>
>
> But I do think it would be very good to get a reply to you / details
> in the commit message about what error you get exactly in this
> scenario, see if you get better details with --smtp-debug, and if so
> paste that (sans any secret info like user/password you don't want to
> share).

Let's wait for a few days to see if xiaoqiang wants to take your
outline of more general approach and polish it.  I do prefer the "no
config" solution as xiaoqiang won't be the only 163.com user, but
Individual Contributors cannot be forced, so ...

Thanks.
