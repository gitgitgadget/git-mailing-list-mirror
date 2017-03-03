Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D4920133
	for <e@80x24.org>; Fri,  3 Mar 2017 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdCCSwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:52:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752083AbdCCSwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 13:52:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0642B63DBD;
        Fri,  3 Mar 2017 13:51:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5A33XOE5n2klvSiOIOqe+jemhsU=; b=LWuPYf
        skon5NzCkR5zIbFoMSCY/CvQJKTrS1S4VFwL6C4rpx2sOT9MlSY+/5F9m7cLuWdH
        3PxVcAaX0P4p4tb0pioGsed4h14mp2OWESxsBYADdiuCyLXuCNJvco3dyA1bWHt/
        u/+SGtoHOGupGt+pJ2Rj+iW6m7otEs8rikFOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VEjGiKQvaqFl3FosrBJfHWzqu4L7bb+j
        XmUrNk02tLuxMsOxGwG+5liX3Lwi+ketTDaDU3gR4oQ01mkUrKChLx/rdYdCPep6
        0De38uzfPWscRRYWXYOuExBjuq3mGeGgVsAqYiaG7H0yW5rPDisQpJbQh/tQRZwS
        /SbgBxMFPQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2B1163DBB;
        Fri,  3 Mar 2017 13:51:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69BD463DBA;
        Fri,  3 Mar 2017 13:51:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/perf: export variable used in other blocks
References: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
        <20170302195041.1699-1-jonathantanmy@google.com>
        <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 10:51:57 -0800
In-Reply-To: <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 01:45:12 -0500")
Message-ID: <xmqqbmti9os2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB25BA6-0042-11E7-8F25-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks, this is obviously the right thing to do, and the mistake is mine
> from ea97002fc (t/perf: time rev-list with UNINTERESTING commits,
> 2014-01-20). This is not the first time I've been confused by missing
> variables in t/perf scripts, since it behaves differently than the
> normal test suite. I wonder if we should turn on "set -a" during t/perf
> setup snippets. That's a bit of a blunt tool, but I suspect it would
> just be easier to work with.

I wonder if we can make t/perf to behave more similar to the normal
test suite to eliminate the need for this exporting, by the way.
t/perf/README does not say anything more than "for lack of better
options" throughout its history, which does not help very much.
