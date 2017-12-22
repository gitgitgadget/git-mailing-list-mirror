Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BF91F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756798AbdLVXK0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:10:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64711 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756734AbdLVXKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:10:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90D47C05DC;
        Fri, 22 Dec 2017 18:10:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJaaLCY7v0vx0H/C1eJq7QMk7Z8=; b=EeWTED
        Yc0g3xvjMeYg3o2RKfwQALtTwjDiaIv6BdW7ZzqsdMHneCRK3Q7QGYTkhhL8cPAe
        RGLFLNX+IZezlG9esn3XTA82bg8jLaZmjCQB++k+7V8t+CfdiEz05uJNEtLf5lT4
        4J5aH/B3+hFd2ZpddGGsIiQvWsxwD/+8yJOeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wdo3RJS7/bXEqaEnXAsdl0mWBAnzZwxU
        qULtX5qINaclgy2lcNG0CdOA54U/ZBF/DmX6Ta4DXWismOBEQid22IV6s8XfwZGr
        l9cM7A7Kfn0DgFOAceVdn+9l+McLs1Ow5rMFU2EpBNDyyeWIyy+Ki9OEGJ8lPwAh
        W8M+GHPQXoQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BDFFC05DB;
        Fri, 22 Dec 2017 18:10:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F19E0C05DA;
        Fri, 22 Dec 2017 18:10:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
References: <20171116020039.17810-1-sbeller@google.com>
        <20171116020039.17810-8-sbeller@google.com>
        <xmqqy3lyv7yt.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka8PRbiHggTADNDwwO_=8rysK3sDP7tV4qerbc8C5yaSQ@mail.gmail.com>
Date:   Fri, 22 Dec 2017 15:10:21 -0800
In-Reply-To: <CAGZ79ka8PRbiHggTADNDwwO_=8rysK3sDP7tV4qerbc8C5yaSQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 19 Dec 2017 11:39:47 -0800")
Message-ID: <xmqqbmiqpdeq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4994E24C-E76D-11E7-A4FF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Dec 19, 2017 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I had to squash in the following to make 'pu' pass under
>> gettext-poison build.  Is this ready for 'next' otherwise?
>
> I saw that in pu, thanks for squashing. I should have spoken
> up earlier confirming it.

So is this ready for 'next' if it is squashed?

>> With the "log --find-object" thing, it may be that this no longer is
>> needed, but then again we haven't done anything with the other
>> Jonathan's idea to unify the --find-object thing into the --pickaxe
>> framework.
>
> I'll look into that after I finish looking at a submodule related bug.

Thanks.

>> It seems that we tend to open and then abandon new interests without
>> seeing them through completion, leaving too many loose ends untied.
>> This has to stop.
>
> I'll try to find my balance again.

Sorry, but this was not really about you, but was more about me.  

I probably should more aggressively drop a topic that stalled and
also merge a topic that reached the point of diminishing returns to
'next'.
