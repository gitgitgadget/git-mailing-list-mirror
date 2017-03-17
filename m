Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675A120951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdCQSiW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:38:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63430 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751196AbdCQSiV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:38:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0F53799BF;
        Fri, 17 Mar 2017 14:24:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6R10MpDUvQWusvUb5Fudh87JkW8=; b=Q68a+j
        C/VUdmFvaADIzkAuecZviN6dekv9fmo8CMIyYJCxhMVlJ0c5gLvHrBv7V0PL0cPw
        8fbRK2/eXW3Qzm3bE/IAQdvMgzcTEM3JgrIQwmfZxYDIoWbhOri5kb+QF8Ifp8dy
        aHkYVcyde+prA7Vr3m/ou+1jCK/yIkzY6Ln3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p83TekJ4qLaNkdSBiBZIypopWVeQRuJo
        aIQqy4fVjiWQ6QDPT5y3GwVX00DyejpkZdHWGQKFsJYntCXGuLn1sDMavJLg/Hrv
        IYgTrTeiK0vfuFlc1saYBBNtwFNomhZcb/5xZC1lKQHyNjaXy3cKbWRe8a8KMlGx
        BR0icMWDEuE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A71B799BE;
        Fri, 17 Mar 2017 14:24:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00E3D799BD;
        Fri, 17 Mar 2017 14:24:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Joe Rayhawk <jrayhawk@freedesktop.org>, git@vger.kernel.org
Subject: Re: Shared repositories no longer securable against privilege escalation
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
        <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
Date:   Fri, 17 Mar 2017 11:24:12 -0700
In-Reply-To: <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu> (Michael
        Haggerty's message of "Fri, 17 Mar 2017 13:07:36 +0100")
Message-ID: <xmqqinn77odv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC67FE3E-0B3E-11E7-B648-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The locking was added intentionally, to ensure that the reflog for
> `HEAD` is written safely. But the code didn't do that prior to the
> commit that you referenced, so (as a special case) ignoring failures to
> lock `HEAD` due to insufficient permission is probably a reasonable
> compromise.
>
> I think the special case could be restricted even further to when `HEAD`
> has the `REF_LOG_ONLY` flag in the reference transaction. I don't think
> that `HEAD` would ever show up in a transaction solely to verify its old
> value in a typical server scenario, but if so, that situation could be
> special cased too.

I find both of these acceptably good changes.

