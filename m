Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE53C433E0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 17:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE29206F0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vA41/S0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgGLRdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:33:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65230 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLRdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 13:33:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06E29E21F2;
        Sun, 12 Jul 2020 13:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=reWDBssRnXt4673PFezkWSy/MMA=; b=vA41/S
        0W0fvBLx6vehtCZqaK0v2Jgz6uro3Ko/9jGrVF7pD5AqeCcLw/aVCtsdV4PdW00V
        eA7chb/pE3olIKT1rOaQYLamwcTHJIGstMSl9qJPYjjjmv0mNlOo17lb6RTIZcAc
        ifd55e3oHzPudj2dm5GCvtfZCz2gbdLjLoaU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R1yJIuBBpZziRaZz+eIW+HbQaGeNU6KK
        +Nr4aXnk9u1ZZBNE5bb59tnNaSoSSjPH28Mh4z9KbJ7glCEtnN5IivuvqJEQjmR6
        H4EvWNjIzxlbFi7Iqgx8fjyi6eH7+TgJmuJlrqkNd4CS6DV/UQweDY3P0PZSLxfE
        Pt4YyKW8ouI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F25A8E21F1;
        Sun, 12 Jul 2020 13:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C8B5E21F0;
        Sun, 12 Jul 2020 13:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
        <xmqqimetrcay.fsf@gitster.c.googlers.com>
        <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
Date:   Sun, 12 Jul 2020 10:33:09 -0700
In-Reply-To: <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Sat, 11 Jul 2020 17:19:15 -0400")
Message-ID: <xmqqblkkr63u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1F9264E-C465-11EA-8605-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Sat, Jul 11, 2020 at 02:07:01PM -0700, Junio C Hamano wrote:
>> So, unless your script depends on the presence and/or the contents
>> of FETCH_HEAD, you can safely remove it.
>
> Excellent, that just saved me 20G per each mirror. :)

Meaning that minimum 4k per file adds up that much due to 5 millions
of repositories, or something?
