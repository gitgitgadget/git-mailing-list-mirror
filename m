Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7547BC2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA620740
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uPQP7vfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgELUeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 16:34:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60454 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELUeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 16:34:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 306F2D3B7C;
        Tue, 12 May 2020 16:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=4
        L4fVIchBqo5fOu8wfu52qmj99c=; b=uPQP7vfDKVHMzNzcJebEqeXPA8UvrFp3A
        zUO3A4iq+mg6sWOrRtLklJgVB4bRKJ37wMFNKWJQOpY8wbU86ML/Fec5Jg/LU36o
        06wF4zcx+KGeGpegEvwnAmAwH5k79aTqHIZ/Eaqlh8N/zV1Ju6ykDghGO8RmrjtZ
        c8ydvlAGHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=UcR
        6hdR149qBC/VXXLfXIq6g9HUA680vJS75YF8OsGKovXmuVnPZmC/Ix4AQwIDtfY0
        Z17/QJZ7wk/WVEMU3KdP4TVjvh6v/K7T/ocDBkiTZOnJBvaWZmRCd5cLSUzmA+PL
        ajsp9lofcrz72ALmEPulCl6mET8AZ1MF+tC4rWJw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28457D3B7B;
        Tue, 12 May 2020 16:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73F12D3B79;
        Tue, 12 May 2020 16:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [Q] what's git-sdk-64-minimal.tar.gz from wingit?
Date:   Tue, 12 May 2020 13:33:58 -0700
Message-ID: <xmqqtv0kc2q1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9F93342-948F-11EA-B429-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the past few days CI/PR windows-build and friends on any branch
seem to be failing quite early in "downlaod git-sdk-64-minimal" step.

    a=git-sdk-64-minimal && 
    mkdir -p $a && 
    curl -#
    https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz |
    tar -C $a -xJf -

It seems like we are getting 404 equivalent?

<?xml version="1.0" encoding="utf-8"?><Error><Code>BlobNotFound</Code><Message>The specified blob does not exist.
RequestId:51b9fae0-d01e-0121-259c-281a07000000
Time:2020-05-12T20:32:10.7112978Z</Message></Error>
