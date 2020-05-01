Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62877C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B18A2137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oBEeJ12f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgEAPuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:50:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64738 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgEAPuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:50:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 335F7C1F42;
        Fri,  1 May 2020 11:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sctNFOXQF2YD
        BkTNCz1z9x7b6ec=; b=oBEeJ12fYyIK5m8ECVhHZk43AjothJIkkZtR6FoutMO8
        x7IOImK20nwqQX6o9uEAUgiKmJmZdb9zZsViuIDjDqauiVBuP88e3fR4fVLsT3f8
        o+FfQRMhGDYOC23OiwAeeujDLh2bqvwLaV0sUTIu0QJAuAM4/ostf4NsMB9NXZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NFLmbK
        5cIr11roin8qK7/oUtk8EO+8T/W+83r1GQQrK9BZ81hFsHW32wXsEEmc56L42VkH
        n/s+Puld8Sx8+vswOQwWJEo+2ZTs89GrLf9xCfg70UrTyRg3sj/Q8y/+J4qKCx5x
        H+DVN8xg2BOncArb/oaUOsq3C916SiIVP0NJo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BAC2C1F40;
        Fri,  1 May 2020 11:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07EA8C1F3F;
        Fri,  1 May 2020 11:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
References: <20200501105131.297457-1-leobras.c@gmail.com>
        <20200501125308.GE33264@Carlos-MBP>
Date:   Fri, 01 May 2020 08:50:48 -0700
In-Reply-To: <20200501125308.GE33264@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 1 May 2020 05:53:08 -0700")
Message-ID: <xmqqees3odrb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 87BE333C-8BC3-11EA-9B14-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> +of `sendemail.smtpPassCmd`), then a password is obtained using
>> +'git-credential'.
>
> this last part on git credential is just undocumented, since it is alre=
ady
> doing so since 4d31a44a08 (git-send-email: use git credential to obtain
> password, 2013-02-12)
> =20
> and of course, assuming you use a credential helper that keeps the pass=
word
> encrypted you could use that instead of this new feature.

Up to this point I understand your response.

Documenting that "git send-email" can use "git credential" for its
password store, if it is not already documented, is of course a good
change.

But I am not sure why this is "a good alternative".  Having more
choices that do not offer anything substantially different is a bad
thing.  Is this "new mechanism" better in what way?  Simpler to use?
Faster?  Less error prone?  Something else?

Thanks.

> having said that, this looks like a good alternative, but might need to
> make sure if die makes sense below or would be better to see if you can
> still get a password through git credential even if that fails.
>
> maybe the rule of what to do might even need some configuration itself.
>
> Carlo
