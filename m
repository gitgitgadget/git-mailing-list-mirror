Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EDEC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A2F206F6
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="higBTo4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXTgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:36:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50542 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 15:36:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D4F2DD164;
        Fri, 24 Jul 2020 15:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N42hsrWf/glouPHOgG6IaEhYckI=; b=higBTo
        4mqch9u5pxpXw/r84bu74fZFShDL5pKxMnbYya/jnVHDthgBUNO1eOmDXhGQA4Uo
        ZR61zCTMS0pO6M5q5V/kK/t6Vtn/rIv1I2VPYabIuu3rA/+8UTZdwSSrnLVNBZni
        zwI4pl58caWSDK3XO6JsEFSei50+BBymItJ1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Evv3PSo9FbScC7S/mAtezbtBQT7HsstB
        qfuj5/jcQh5s2lcozsYaxcBHkwyb4H0jWOzw77MXlNP7h6LVrvIZWPM+P/LaoVzu
        kMjcEQwCcE9lBxHOfibkBl1SksrX/BEvClAFU1TDYSjt6vqfAgQl6ySkDxjZsvjZ
        txGfv5QThY4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 361C4DD163;
        Fri, 24 Jul 2020 15:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AB28DD161;
        Fri, 24 Jul 2020 15:36:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Casey Meijer <cmeijer@strongestfamilies.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
References: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
        <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
        <20200724011944.GD1758454@crustytoothpaste.net>
        <xmqqft9hn1pd.fsf@gitster.c.googlers.com>
        <02819EF1-CCA7-4A0F-9497-F6A52E6CBF30@strongestfamilies.com>
Date:   Fri, 24 Jul 2020 12:36:01 -0700
In-Reply-To: <02819EF1-CCA7-4A0F-9497-F6A52E6CBF30@strongestfamilies.com>
        (Casey Meijer's message of "Fri, 24 Jul 2020 18:17:12 +0000")
Message-ID: <xmqq7dusn1su.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9189AA6-CDE4-11EA-8C7F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casey Meijer <cmeijer@strongestfamilies.com> writes:

> Sorry I got mixed up,, that last message should have been
> addressed to Junio.
>
> My apologies. 
>
> To put it very simply, I'm asking that git respect the separation
> of concerns between itself and its storage engine (regardless of
> whether that's pluggable, or just the current filesystem, which I
> guess is technically pluggable, lol).

If "git" is told to store ref 'foo' pointing at object X and then
ref 'Foo' pointing at object Y by the end user, after claiming to
have done these two operations, if it is then asked about the value
of 'foo', it must say that 'foo' points at object X and not Y.  If a
ref backend is based on case insensitive filesystem, there are only
two options available.  (1) ignore case and violate the expectation
of end user. (2) come up with a way to "defeat" the limitation of
case insensitivity imposed by the filesystem (e.g. your ref backend
implementation _could_ URLencode/decode the ref before using it as a
filename on such a filesystem).  

Doing (2) would be transparent to the rest of Git (i.e. the rest of
Git does not have to care that each ref is stored in a file, whose
filename is encoded version of the refname) and gives us a good
separation of concerns between it and the storage backend.  Those
who ported Git to case insensitive filesystems didn't and chose (1).

As (1) violates end-user expectation, I would think it is fair to
declare it a bug.
