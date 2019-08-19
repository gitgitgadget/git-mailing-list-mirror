Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3154B1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 20:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfHSUE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 16:04:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60722 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 16:04:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7E67710CE;
        Mon, 19 Aug 2019 16:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BuGtLVROT5Rdl/V/EXtcUamxQoo=; b=nPheBC
        4KYKnu5cZJiHYxiPyc815BMSsiOuvC2RkG3eoWthpkNIhl7VpIvhaz9KuRs9fA4Y
        KC/vQdNtlhav07qbl/3EfCQGddPDjJAc8kdWotWvvTNrdFJQYRoQrHrq7Jvw54YA
        tJ5+WroqDn2aKjYzvB09L7vI+aeXB0P2XZc2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TU5ldNDGKSNcqh9RDLWfiU1pSn0mw8jV
        j4mwRyHV+ciLmXlMmKe6AFc9mszfCkunLJ42B4a0h/Hy3TFLQmyYVRPJd8XAYxqr
        eb/LmQvqeo2y60djIHdhRr/TrO7ut74ejgfUj3GNg7KbOUF4YoCucxtDK/6ZX6bB
        YD5VzgCWLjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0EFB710CD;
        Mon, 19 Aug 2019 16:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE39D710CC;
        Mon, 19 Aug 2019 16:04:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@matthieu-moy.fr>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
        corentin.bompard@etu.univ-lyon1.fr,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH] pull, fetch: add --set-upstream option
References: <86zhoil3yw.fsf@univ-lyon1.fr>
        <20190814134629.21096-1-git@matthieu-moy.fr>
        <xmqqlfvv6417.fsf@gitster-ct.c.googlers.com>
        <86blwlcylf.fsf@matthieu-moy.fr>
Date:   Mon, 19 Aug 2019 13:04:50 -0700
In-Reply-To: <86blwlcylf.fsf@matthieu-moy.fr> (Matthieu Moy's message of "Mon,
        19 Aug 2019 11:07:40 +0200")
Message-ID: <xmqq1rxgyl99.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B6AD37A-C2BC-11E9-B406-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@matthieu-moy.fr> writes:

> To me, it depends on the involvement in the project. If I plan to send
> several contributions to a project, I'd usually clone the upstream and
> add my fork. But I also often do:
>
> - Find a project on GitHub/GitLab/...
> - Think about a minor contribution I can make
> - Fork from the web UI
> - clone my fork
> - code, commit, push
> - make a PR
>
> Only if my PR takes time to get accepted, I'll add upstream as a remote
> and pull from there to rebase my PR.

OK.

>>  - The second step adds the true upstream using "git remote", and at
>>    that point, in your mind you are quite clear that you want to
>>    pull from there (and push to your own fork).  Not having the "I
>>    am adding this new remote; from now on, it is my upstream"
>
> Note that you can also group "remote add" and "pull" by saying just
>
>   git pull --set-upstream http://example.com/project-main-repo master
>
> (I still tend to prefer the "remote add" + "pull" flow to name the
> remote, though).

I do too, and that's where my "shouldn't this feature be part of
'remote add' comes from.

> That wouldn't make the commands really easier to type IMHO, as you would
> still have to pull at some point, so it's:
>
>   git remote add main http://example.com/project-main-repo
>   git pull --set-upstream main master
>   
> Vs
>
>   git remote add --set-upstream master main http://example.com/project-main-repo
>   git pull
>
> The second is a bit shorter (saves the second instance of "master"), but
> I tend to prefer the first to avoid the overly long "git remote add"
> command.

I do not particularly care about five extra keystrokes.  The reason
I prefer the latter more is conceptual clarity of it saying "I use
'remote' to set things up, and then use 'pull' to get updated" (as
opposed to "I use 'remote' to set things half-way up, and then use
the first 'pull' to finish setting things up and getting updated.
I should remember that I do not need to give --set-upstream to later
'pull' I used to get further updates").

> Actually, since "--set-upstream" means "next time, *pull* from this
> branch", it felt weird to have it in "git *push*" and not in "git pull".
> Certainly, not having "git pull --set-upstream" it "git pull" wasn't
> that much bothering (otherwise, someone would have implemented it long
> ago), but I still find it a nice-to-have shortcut.

Yeah, I do not think 'push --set-upstream' is a great feature,
either, but since we have it already, I do not mind too much to have
another on the 'pull' side.  It just feels that we are piling band
aid for the lack of the right feature in the right command by adding
it to wrong command(s).

