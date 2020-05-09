Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C0C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0CA2184D
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vR7i9nj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgEIRMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 13:12:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54513 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgEIRMD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 13:12:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52391C1750;
        Sat,  9 May 2020 13:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IdTjl78JwX09lIcroTG5iXzCzbg=; b=vR7i9n
        j0eAqSnq100hpe5vRxOH9Z2HeQxlA/8Itlbe1TYbtzbeO5ydlFDqEX5XBwUpfYqA
        tUoC3bwo0jAsV8Ma8oSsaWbpn7x21P+YZ697sNHQ3AFDIi4MslrVJ4l59CPwyNy0
        coUPiJeNk2p9pdO5GoCLVZ658xwMR49Md+PKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uZ9Tm9shPRXmFrVLzw2yNJlu0EoBLEYs
        N5Jf+we53VV3EB8yyPzNm4T6o5dmP3dRPjzOsvSUOkgV7/LK+U6W9hGCFCTGu3gY
        4pE48hfR3TPFfo2nVoJEXbuFbfVq8GG8A1ivFBc8fOIwq27udRIOnHZloWsIPFcz
        AJ/6ZzPq/nw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4905DC174F;
        Sat,  9 May 2020 13:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85B0EC174D;
        Sat,  9 May 2020 13:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: Preparing for a Git 2.26.3 release
References: <20200428055514.GB201501@google.com>
        <xmqqk11mvzb4.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005090903560.56@tvgsbejvaqbjf.bet>
Date:   Sat, 09 May 2020 10:11:56 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005090903560.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 9 May 2020 09:07:55 +0200 (CEST)")
Message-ID: <xmqqwo5luj6r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30E81EBE-9218-11EA-AFFB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 8 May 2020, Junio C Hamano wrote:
>
>>  * Recent updates broke parsing of "credential.<url>.<key>" where
>>    <url> is not a full URL (e.g. [credential "https://"] helper = ...)
>>    stopped working, which has been corrected.
>>    (merge 9a121b0d22 js/partial-urlmatch-2.17 later to maint).
>>    (merge cd93e6c029 js/partial-urlmatch later to maint).
>
> Are you planning on also releasing, say, v2.23.4, with this fix?

Yes, some subset of the changes we will apply to 2.26.3 probably can
be backported down to older maintenance releases.  

Our usual policy is not to backport beyond two or three maintenance
tracks unless it is a security fix, and because the current maint
track is 2.26.x, which means 2.25.x and possibly 2.24.x series are
the oldest candidates.

If you think it makes sense to start the discussion to choose that
absolute minimum set, I am fine with that approach, too.  The
partial-urlmatch topic was designed to be usable with tracks as old
as 2.17.x series, so I am OK to go a bit further back but if we are
to do so, how far back should we as the upstream go back?  I am OK
to say we make the 2.23 series as the oldest for this round.

And then if we were to draw the line there, what other changes in
the set do we want to include the 2.{23,24,25,26}.x maintenance
releases?  That would certainly be a narrower subset than the list 
in the message you are responding to.

Thanks.




