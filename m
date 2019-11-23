Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F8C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A2020706
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZDns1Whv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWASI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:18:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54066 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKWASI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:18:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65286191F3;
        Fri, 22 Nov 2019 19:18:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iKlWjS6KN4HVLg3DJ8wkw2UAdsg=; b=ZDns1W
        hvs2OEs0R76UTyAdX18//BCFZ9sPEn5vWulUnQa+YAzTEi8oifnulu/kaFPGHHf2
        E1piFujT1RLHMD1wCZtKthdFidGSn08dU3cHdlnsWLyhWUEVwvPB0wI7uRzwGYCk
        VI5DIGkoWv+njJfH3ZIeybnYFy7yg35gitwu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jVoqzbBx0/C4IqbPnsfFUTOPki7OIOSJ
        QvzKNKCTQ4uCp0nOM3iZb2wF02HiWdsOb4pZlW6FBwDUHJKAM8dZHe6gy/yEGX/x
        hXUejY08G++kcbbkv9B4VsGCFhmhV2AdpuRKxXhgvheSToAvs+HA4vqYWjYxQDdT
        qvbh874OJL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BDD3191F2;
        Fri, 22 Nov 2019 19:18:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6170191F1;
        Fri, 22 Nov 2019 19:18:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
References: <20191116180655.10988-1-hji@dyntopia.com>
        <20191116180655.10988-2-hji@dyntopia.com>
        <xmqqtv712145.fsf@gitster-ct.c.googlers.com>
        <87d0dkbyxb.hji@dyntopia.com>
        <xmqqsgmg7hyf.fsf@gitster-ct.c.googlers.com>
        <xmqqeey07exp.fsf@gitster-ct.c.googlers.com>
        <87v9rby82a.hji@dyntopia.com>
Date:   Sat, 23 Nov 2019 09:18:05 +0900
In-Reply-To: <87v9rby82a.hji@dyntopia.com> (Hans Jerry Illikainen's message of
        "Fri, 22 Nov 2019 20:23:09 +0000")
Message-ID: <xmqq1rtz4f9e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8EE3670-0D86-11EA-8DD8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> On Fri, Nov 22 2019, Junio C Hamano wrote:
>> Wouldn't some of the fields this helper works on be of type "char *"?
>
> Wow, that's embarrassing.  I completely messed that one up after a
> looong day.  Gah!  Fixed and re-built with DEVELOPER=1 and re-ran the
> test suite for both commits in an attempt to avoid further fuckups.

The embarrassment is mine ;-)

> I also fixed the criticism on 2/2 (even though you mentioned that
> there's no need for that) and sent it as v4 because I'm not sure what
> the right approach is for changing only 1/2.
>
> For future reference; how does the project prefer fixups for a single
> commit on a multi-patch submission?

Unless the series is insanely loooooooooooooooooooooooooooooooong,
resending the whole thing, optionally with summary of the changes
since the previous iteration for each step after the three-dash
lines (i.e. this allows readers to notice "unchanged since v3"
and skip individual ones marked as such while reviewing v4), would
be a good way to help both reviewers who saw the previous round and
those who have skipped the previous round.

Thanks.
