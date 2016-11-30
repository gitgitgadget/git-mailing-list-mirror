Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA191FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 18:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757824AbcK3SkC (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 13:40:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757667AbcK3Sjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 13:39:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 118D7511CB;
        Wed, 30 Nov 2016 13:39:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vIplCROkOlae
        GT3QLi8P6hYXFbk=; b=stg+tY5ZLCI7TvPHZu0V5vzSeJ0UJ9xSc92egyrNnZEq
        82EEWfZiVuAx/6XSHUPYEbhcH8H9lvXuhSMS7FeUKhpLNC25wFZfwbUcnUBzMUZf
        2MmEppOXrsCoVFKfWuCknCVfF2ofP02TfPYgBllz4hmgNij1BjajwemN/RirGPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aPB6rf
        tRmbD6hezo5TBDS13K3uj4E4xTzdnKDk0m9fYiqqe1z1LUqmHDyEFDUNR38HiAR4
        yjaCXIoZA1i8fV898G82GL10EsorxhZvz9Msy0RALE2ga5HE0HNGq0nS2XTw9M1O
        4hpKQwTr6Z8iriRWvnDW8/t9n3qTdxm9Yz/gc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06FB9511CA;
        Wed, 30 Nov 2016 13:39:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68DD1511C7;
        Wed, 30 Nov 2016 13:39:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611242211450.117539@virtualbox>
        <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251201580.117539@virtualbox>
        <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251841030.117539@virtualbox>
        <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261320050.117539@virtualbox>
        <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261400300.117539@virtualbox>
        <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
        <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611281830040.117539@virtualbox>
        <855b9172-7225-e09e-e46d-87940f9fda75@gmail.com>
Date:   Wed, 30 Nov 2016 10:39:51 -0800
In-Reply-To: <855b9172-7225-e09e-e46d-87940f9fda75@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 30 Nov 2016 17:02:08
 +0100")
Message-ID: <xmqqy400dd6w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 618D73CC-B72C-11E6-9718-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> My original "create a file in libexec/git-core/" was simple, did the j=
ob
>> reliably, and worked also for testing.
>>=20
>> It is a pity that you two gentlemen shot it down for being inelegant. =
And
>> ever since, we try to find a solution that is as simple, works as
>> reliably, also for testing, *and* appeases your tastes.
>
> I just would like to note that existence of file is used for both
> git-daemon and gitweb (the latter following the git-daemon example).
>
> So there is a precedent for the use of this mechanism.

I think you are thinking about git-daemon-export-ok (for 'git
daemon') and $GITWEB_EXPORT_OK file (for 'gitweb').

You do realize that it is apples-and-oranges [*1*] to take these as
analogous to what Dscho is trying to do, don't you?

First of all, these are to control access to each repository on the
server side; the presence of the file is checked in each repository.
What Dscho wants is to control the behaviour of an installation of
Git as a whole, no matter which repository is being accessed [*2*,
*3*].

More importantly, did you notice that git-daemon-export-ok predates
the configuration mechanism by a large margin?  The "does the file
exist?" check done in a87e8be2ae ("Add a "git-daemon" that listens
on a TCP port", 2005-07-13) is a relic from the past [*4*], and
32f4aaccaa ("gitweb: export options", 2006-09-17) added
GITWEB_EXPORT_OK to mimic it, also long time ago [*5*].  They are
not something you would want to mimic in new programs these days.

Besides, $GIT_EXEC_PATH is where you place git subcommands.  Who in
the right mind considers it even remotely sane to design a system
where you have to throw in a file that is not a command to /usr/bin
to control the behaviour of your system? [*6*]

So the "precedent" is irrelevant in the first place, and even if it
were relevant, it is a bad piece of advice to mimic it.


[Footnote]

*1* Or is it apples-and-pineapples these days?

*2* Not that I agree with that desire, if I understand him correctly
    from his description against the approach based on an
    environment variable.  If a user has multiple installations and
    not even aware of which one of them s/he is currently using, a
    mechanism that affects only one of them (instead of consistently
    affecting all of them) would lead to more confusion, I would
    think. =20

*3* If such hermetically configured independent installations are
    desirable, etc/gitconfig aka "git config --system" is a more
    appropriate thing to use, and you do not need to do repository
    discovery before you can read it.

*4* If we had config mechanism, we would have used it just like we
    use daemon.* variables to control what services are enabled for
    each repository.

*5* By that time, the config mechanism did already exist, so the
    GITWEB_EXPORT_OK could have been a per-repository configuration,
    but "gitweb" had another excuse to deviate from the norm.  "Is
    this repository visible?" was done during repository listing and
    the script did not want to run "git config" in each and every
    repository-like directory it encountered in File::Find::find().

*6* And I do not think $GIT_EXEC_PATH vs /usr/bin is
    apples-and-oranges analogy.
