Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07390C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA0E2076E
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kfFJmisw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgFZHbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:31:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60086 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFZHbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 03:31:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B03861364;
        Fri, 26 Jun 2020 03:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TrdaKtu0U+ns
        GTw1RRQm0Npbzck=; b=kfFJmiswrDTC9EZopH7cBsAPh9mXyNbl+ZkiPLvduWBH
        zz7I9inV6L3iig9ulxax5MxL4WHwGRDApi6rf+I9PHr7u8th6cKWSWEOfIO8wXQu
        6fCNHrqMs+bLAypXmt3NK5PiUSXq1IPRDeh+q5A4qpaoxhY3zHOXYq6SPhtm7e4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VlLuvY
        9CZyvGB3IYmOLnXrCthSAFacYigoYIYespHIPX4nXnpcidhjtzdc0qo4T/+452St
        uq/ujNoWeEDDhjhiqeX/2ZvgWFNnjhW3CY/u+q8TfuJwwvcu65/IZB0ynFPuFdWA
        igtFqWjXaNwDtKo8G74ul6dcSi0Z6vG4v0muk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47EC261361;
        Fri, 26 Jun 2020 03:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9BC16135D;
        Fri, 26 Jun 2020 03:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #05; Thu, 25)
References: <xmqq1rm24ol3.fsf@gitster.c.googlers.com>
        <20200626070807.GA84491@Carlos-MBP>
Date:   Fri, 26 Jun 2020 00:31:19 -0700
In-Reply-To: <20200626070807.GA84491@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 26 Jun 2020 00:08:07 -0700")
Message-ID: <xmqq1rm2i8qg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07CBEAD8-B77F-11EA-873B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, Jun 25, 2020 at 06:12:40PM -0700, Junio C Hamano wrote:
>>=20
>> * cb/is-descendant-of (2020-06-23) 1 commit
>>   (merged to 'next' on 2020-06-25 at ca0eaddf5e)
>>  + commit-reach: avoid is_descendant_of() shim
>>=20
>>  Code clean-up.
>>=20
>>  Will merge to 'master'.
>
> apologize for the most likely unnecessary clarification (probably impli=
ed
> by the merged comment indicating ca0eaddf5e), but this branch uses both
> rs/pull-leakfix and rs/commit-reach-leakfix, that are currently merged
> earlier into next and also scheduled for master.

Hmph, Does it break if it is merged alone to 'master' without these
other two topics?  I somehow thought I disentangled the topic from
unnecessary dependencies before queuing it, but it is possible that
I misremember...

>> * jk/fast-export-anonym (2020-06-22) 4 commits
>>   (merged to 'next' on 2020-06-22 at b517b2f707)
>>  + fast-export: allow dumping the path mapping
>>  + fast-export: refactor path printing to not rely on stdout
>>  + fast-export: anonymize "master" refname
>>  + fast-export: allow dumping the refname mapping
>>=20
>>  The way refnames are anonymized has been updated and a way to help
>>  debugging using the anonymized output hsa been added.
>
> s/hsa/has

Thanks.
