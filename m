Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E87C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D582067B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 19:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6OAEiSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCTez (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:34:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52884 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 15:34:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 869A15C7F2;
        Wed,  3 Jun 2020 15:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zNRyXX+udrDmQPpFPXecFRDhR58=; b=f6OAEi
        SqZdhrmYs0lNkBYFHdK1It/QP67s1Vf8YtFWFR9WVx6UpXD62FtO6p7TWxMKb+cp
        TA977puA3sSgkYAsVJdOwBDPiBddF275SRRNqJNhp6iX7E1e56W+LR6e0k6Yc/Dj
        lwigqEqqIxmo0kcfMGD3wpaKIvZMf4Y5at5co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LZVJz/My/PGOXzbyvcVbkSsM1XMmvz1K
        rlhHg5P90mTmVn0CkhqUbnjZGCWLf66p2ITXNqOX2o3j0cJ5B5K4ja8BPyWHK89Q
        yAwhzy8i1XJ4kBd/dld3Lcb/Uqh+ZZFIa+nZMFuKhK5LNWLwYb4HDURPoQXldJpr
        nvXgp7nSGLk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E8FB5C7F0;
        Wed,  3 Jun 2020 15:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06E0E5C7EE;
        Wed,  3 Jun 2020 15:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE] Git for Windows 2.27.0-rc2
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>
        <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
        <xmqqv9kats3k.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006022232340.56@tvgsbejvaqbjf.bet>
        <xmqqlfl5rwug.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006031550400.56@tvgsbejvaqbjf.bet>
Date:   Wed, 03 Jun 2020 12:34:51 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006031550400.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 3 Jun 2020 15:54:03 +0200 (CEST)")
Message-ID: <xmqqy2p4q6xw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B6D652E-A5D1-11EA-A426-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I'll remind myself that I'll try to tag and push out the final
>> before 1700 UTC, which would be around 10AM for me ;-)
>
> That will work. That's 7pm for me, which is still safely after-hours, but
> it's better than 2am.

That time is 2AM for me depending on the season, though I am
straying off of my migratory patterns this year.

> On the other hand, I do not even think that Git for Windows versions
> _need_ to be released on the same calendar day as Git versions.

True.  The "same calendar day" is a fuzzy notion anyway, and the
other major platform seems to lag by a lot more if I am not
mistaken.

I was just trying to make the schedule predictable, so that you and
others do not have to say "if the tag was pushed early enough in the
day for me".  I'd actually prefer to tag a bit later in the day
myself, so we can pick any time, or pick no time at all and have you
and distro folks subscribed to push notification RSS, perhaps.


