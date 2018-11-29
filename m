Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466841F609
	for <e@80x24.org>; Thu, 29 Nov 2018 01:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeK2MXN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 07:23:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62893 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2MXN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 07:23:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CE923A9FC;
        Wed, 28 Nov 2018 20:19:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gHEC8BZVbRUvKMy6IEarx8gn4xQ=; b=PLzZeb
        QN4GMwHoZkxupk0mAfn+lVKEav7YqtazpNoaCd1agE1fM19NamZJXqwENXBJga2u
        sQLDHNlx5HEk2P95qcNUHO9xQL0HcXZQdKGD7rf7dU7Shh5ejXtlPq10kx1D52yj
        bv3EeZM3yyAfkFPkSjGrgPQcUnmWOPaGjzQ9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nPad7UdJU1myYKlekK5AqewtR9PshRcv
        ajcwSNAlkC5d3ep9MaVMpy48gikjIFoEjK9kKodTEsfa7U3CmJQe4L26HLeEOPhG
        D8V5oXK8+JNSHCnpAkEd6IeYOw4+AHbnSTfqj7As/THbv9RkDV7CQT0LUEmxbz+s
        uCcpvRb4mTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9490B3A9FB;
        Wed, 28 Nov 2018 20:19:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A62F33A9F9;
        Wed, 28 Nov 2018 20:19:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     newren@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Forcing GC to always fail
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
        <87efb6ytfj.fsf@evledraar.gmail.com>
        <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
        <87d0qqysay.fsf@evledraar.gmail.com>
        <CABPp-BFBLKU5jnpr7scXJdj==qNtHJZ8R+LLMRE7qXT47eXXDg@mail.gmail.com>
        <CAGyf7-FwGRVtFYbOGW8DmY9F-cgun0n5K-ZWBjXCR=wvWh=8dQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 10:19:32 +0900
In-Reply-To: <CAGyf7-FwGRVtFYbOGW8DmY9F-cgun0n5K-ZWBjXCR=wvWh=8dQ@mail.gmail.com>
        (Bryan Turner's message of "Tue, 27 Nov 2018 18:26:07 -0800")
Message-ID: <xmqqtvk0r87v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4D02CAE-F374-11E8-A311-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> For us, the biggest issue was "git gc"'s insistence on trying to run
> "git reflog expire". That triggers locking behaviors that resulted in
> very frequent GC failures--and the only reflogs Bitbucket Server (by
> default) creates are all configured to never ex[ire or be pruned, so
> the effort is all wasted anyway.

Detecting that the expiry threshold is set to "never" before
spending cycles and seeks to sift between old and new and not
spawning the expire command?

This seems like an obvious low-hanging fruit to me.

> Another issue with the canned steps for "git gc" is that it means it
> can't be used to do specific types of cleanup on a different schedule
> from others. For example, we use "git pack-refs" directly to
> frequently pack the refs in our repositories, separate from "git
> repack" + "git prune" for repacking objects. That allows us to keep
> our refs packed better without incurring the full overhead of
> constantly building new packs.

I am not sure if the above is an example of things that are good.
We keep individual "pack-refs" and "rev-list | pack-objects"
available exactly to give finer grained control to repository
owners, and "gc" is meant to be one-size-fits-all easy to run
by end users.  Adding options to "git gc --no-reflog --pack-refs"
to complicate it sounds somewhat backwards.
