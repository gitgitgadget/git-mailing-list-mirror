Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7460820441
	for <e@80x24.org>; Sun,  1 Jan 2017 01:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbdAABPq (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 20:15:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754832AbdAABPp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 20:15:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB4455D837;
        Sat, 31 Dec 2016 20:15:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zn9aLYPYYRbcgh4lRq1vM/pPy5k=; b=oXbSV7
        1YNjWfroPFan3UvDX3L3M39gI46yxMBjwyu3KuOx/qMfVWlgVjcPkDqjSAjCoiIQ
        qCnkoxh4CZDbSrCRIu39sZBh3kNVjEXTKD+99ceWpxGLX9yakRo4zQjKbZyfocJZ
        RL/oxVRgh9uTAvjqulI6ZdV+H4l7wuaRV9Jnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qjhua1Ju9fNTYg4Zx+iRKHdXiVXAjab5
        leikdug3OkINijrZ4CUmDNI06G9/wfSyULVDhh9LKEhzeqfXUeY4q+I4fYiqCsbM
        FWr9vAPhZZ0tZ4YhctbLfHsTiU8NAG0dXwDeqxBBvw4EYGT7TyI1Ud7BZFODLZoI
        HV+irEI9Q4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3CAA5D835;
        Sat, 31 Dec 2016 20:15:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 405BE5D834;
        Sat, 31 Dec 2016 20:15:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Counter-intuitive result from diff -C --stat
References: <20161228080916.72id4hzqxfbygtth@glandium.org>
Date:   Sat, 31 Dec 2016 17:15:43 -0800
In-Reply-To: <20161228080916.72id4hzqxfbygtth@glandium.org> (Mike Hommey's
        message of "Wed, 28 Dec 2016 17:09:16 +0900")
Message-ID: <xmqqd1g760n4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D18D3972-CFBF-11E6-A7D6-06F112518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> Hi,
>
> So I was checking out differences between two branches, accounting for
> file moves with -C, and was surprised by the number of insertions and
> deletions that it indicated, because it was telling me I had removed
> more than I added, which I really don't think is true.
>
> I took a closer look, and what happens is that I had a lot of stuff in
> a __init__.py file that I moved to another file, while keeping a now
> new, empty, __init__.py file.
>
> Which means while diff counts the deletions from __init__.py, it doesn't
> count the additions from the move because it is a move, leading to a
> counter-intuitive result.

Intuition is in the eyes of observer.  

A pairing of the original and the result you saw might be not very
useful (which I have no opinion on), but in the context of the
chosen pairing of the original and the result, in order to produce
the final result, you started from a copy of the original and
removed quite a lot while adding just a bit, so what you saw was an
outcome that was deliberately designed.

