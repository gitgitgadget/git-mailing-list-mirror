Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262FA1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbcHWQjt (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:39:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62854 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754379AbcHWQjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:39:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0605835629;
        Tue, 23 Aug 2016 12:39:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YPMzI82X6H1E
        EZMSXieVo//8Lnw=; b=sEN7c7H4ezNy4BkdlkpZY3cMB2VHbOOK3CpfBJxY+ZM0
        yiEacxeuDbT8Xjlt4buuHW8FkiGz/1rQVfWzCJnbLoUfEgEU0q1yX9UPvrjTaTqE
        mQ3GM+rF+9bbJ0Zyzbib/0LiDg01Os3ruMMdmV1cNlfbYw0srMpny8pcejv9BR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Fh7zqb
        G8rkuiKzRJ8eTzaKWPlWr/gvQwn6RDtjOcloBkRcOCWdqLE7L+T3voGmilZIsdGX
        sXI9EHcGP3BW6wdh1Hfdi35m48pNTS1CjcAw2W20Z+Acm0Rt2lN2FCcouT5zbqG7
        y5j7o1PfyYM0kU4NLuLbCDowhPKsxmv9q5bHo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2A2C35628;
        Tue, 23 Aug 2016 12:39:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7458F35627;
        Tue, 23 Aug 2016 12:39:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
        <20160821142634.dorgzldjvc3qiaby@x>
        <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
Date:   Tue, 23 Aug 2016 09:39:28 -0700
In-Reply-To: <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Mon, 22 Aug 2016 20:39:19
 +0200")
Message-ID: <xmqqy43nwibj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A08956E-6950-11E6-961B-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Especially that for submodules you need:
>
> $ git --git-dir=3Dsubdir/.git cat-file -p $(git rev-parse HEAD:subdir):=
file
>
> (or something like that), assuming that you start in supermodule.
>   ...
>
> But perhaps '//' would be better.

If the users have to know where they need to use different
separator, I do not think it is worth complicating the plumbing to
do this for them.  I'd rather keep things simple, and let the users
build complex stuff on top of the plumbing.
