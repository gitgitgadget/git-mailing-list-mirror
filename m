Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B28AC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CED32072E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 16:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O4FpslW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFQxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:53:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58686 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 11:53:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94DF6AD258;
        Mon,  6 Jan 2020 11:53:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4/j0lceQzgxECiRdQFR7d0diihc=; b=O4Fpsl
        W/jPhHSdn0snACWWPvuf4cKGTOScCgSxR3hfueTwiP/WjomSwuxe/uQaMsSxdHId
        dotZ7BTGcIOnxyLLe+lro9+ZlAbfCYUw9CkQ2NzgCeITF18vKxYtOzMi0xlJNZ8C
        Y0cUJWXMsf+HQwdfd+icIm57eEdUiENuP3I24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TrZzRaHndfdOnAyymu3eW7VWlzbdF1hI
        RCXybZadBa03T/mpeM9zfGBjMOtkKcO50kCsHqveUygsfznaqzd97H0fr1KkzZYr
        eiQ6+FTpqCApPoTXyGNnV2QhUrbvkzJ0lkoUudlbCgyE9v9Ed1Jor6MMfsdDVn03
        HMPYlpRy8sk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D3BFAD257;
        Mon,  6 Jan 2020 11:53:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B167AAD256;
        Mon,  6 Jan 2020 11:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] commit: make the sign-off trailer configurable
References: <20200105174127.9278-1-hji@dyntopia.com>
        <20200105174127.9278-2-hji@dyntopia.com>
        <71a718a7-2be7-391c-dc8f-0626a0a21aac@gmail.com>
Date:   Mon, 06 Jan 2020 08:53:41 -0800
In-Reply-To: <71a718a7-2be7-391c-dc8f-0626a0a21aac@gmail.com> (Derrick
        Stolee's message of "Mon, 6 Jan 2020 08:38:23 -0500")
Message-ID: <xmqqtv58a5m2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191E79C4-30A5-11EA-876F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> My initial thought was that the sign-off was supposed to be a purposeful
> decision, but then I also realized that I never do anything in the Git
> codebase that I _can't_ put online under the GPL. (It may not make it
> upstream, but it will always be put online somewhere.)

Hmm...

Sorry, but I do not quite understand the flow of your logic here,
especially, how "but then I also realized" trumps "signing off a
patch is a conscious act---it would weaken the legal meaning if you
automate it", which was why we deliberately avoided adding this
configuration variable for the last 10+ years.

So, I dunno.
