Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343BB1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEOBSz (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:18:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56228 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfEOBSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:18:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62369139F66;
        Tue, 14 May 2019 21:18:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=LMARlfiq+erHX
        Kr7EMGgrtujxpk=; b=LWn/6filzmRmxzVzlRoWjqajs0CqUNuobKyB0wgr8XaOj
        oJePuGn6dODZzVRGKHMuvI96+0WOjjq52muh3k2uqf7WFbc+J444A6olUy6Bz1U4
        r5DdLl9xtO/Hec2UqErSBWpJgcNwbvvRcSTQ/k1niIePfw1DBh7ib8UNVNTbcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=hyGcsIS
        /MDZsvBdlo7kQWMZesqi6sCw/k12umEDKzyyeSBFTSvdz+IJ7dhTH/+uvN0S7hG8
        xDGz6MUO1BzdgvUzMzinLqYpaOwMeMT8eV7voPUZOsjYos96NqzE89+RWidonV20
        /bQVhM6f33iRatj3nGPgAixx8eIqnplubOnE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ACE4139F64;
        Tue, 14 May 2019 21:18:53 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCF41139F62;
        Tue, 14 May 2019 21:18:52 -0400 (EDT)
Date:   Tue, 14 May 2019 21:18:51 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190515011851.GP3654@pobox.com>
References: <20190514020520.GI3654@pobox.com>
 <20190514023245.GB34155@google.com>
 <87o945wj7w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o945wj7w.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 66E9D4D8-76AF-11E9-8B33-E828E74BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

=C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> On Tue, May 14 2019, Jonathan Nieder wrote:
>=20
>> Todd Zullinger wrote:
>>
>>> The JGIT prereq uses 'type jgit' to determine whether jgit is present=
.
>>> While this should be sufficient, if the jgit found is broken we'll wa=
ste
>>> time running tests which fail due to no fault of our own.
>>>
>>> Use 'jgit --version' instead, to catch some badly broken jgit
>>> installations.
>>>
>>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>>> ---
>>> I ran into such a broken jgit on Fedora >=3D 30=B9.  This is clearly =
a
>>> problem in the Fedora jgit package which will hopefully be resolved
>>> soon.  But it may be good to avoid wasting time debugging tests which
>>> fail due to a broken tool outside of our control.
>>>
>>> =B9 https://bugzilla.redhat.com/1709624
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>>
>> It would be nice to describe that bug in the commit message, to save
>> readers some head scratching.
>=20
> FWIW the jgit in Debian testing/unstable is similarly broken right now:
[...]

Hah, small world. :)

> So rather than describe specific bugs on RedHat/Debian maybe just say:
>=20
>     This guards against cases where jgit is present on the system, but
>     will fail to run, e.g. because of some JRE issue, or missing Java
>     dependencies. Seeing if it gets far enough to process the
>     "--version" argument isn't perfect, but seems to be good enough in
>     practice. It's also consistent with how we detect some other
>     dependencies, see e.g. the CURL and UNZIP prerequisites.

Well said.  I indeed avoided putting the detail into the
commit message because it was such a Fedora-specific bug.
I'll update the commit message to add more details though,
borrowing liberally from^W^W^Wperhaps stealing your
suggested wording.

Thanks!

--=20
Todd
