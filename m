Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94D920196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbcGNQc7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:32:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbcGNQc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 12:32:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95C8F2A630;
	Thu, 14 Jul 2016 12:32:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=26Vqj4eO4LhTq45Jz8xw/QPQviM=; b=LzPEKm
	28xa/0a6Hip4SHLUUQR048EEYYtd9Cih0XXz7HBmw0LyZMkajJkQ6IHzOihwPQ4I
	sKxxzWok94qmKWDR/3w/a6DLQuXfGXoSfipr3Wa/5VODzSCoGMHmsLITKuPYuG7L
	SwMx5c3TCv3MyXqq1KspSjxLshCF2UiG9B73c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q6Mz3LZh2vf4hKg1CxAszRUDNh5/1orN
	Gd8OO0WqSyOeR5nagi98UOyO+VUbrNpdJKxobm22kSwRiy+zxXYuvLOXAs/0a8RB
	iQJQcfwbylkvIwjcxtICK1VpQlU+wFJcnaWp+Nz2EEaW4IMQokoqe3H6WhXUS1JK
	njxNoF/uRkg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C1662A62F;
	Thu, 14 Jul 2016 12:32:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FD282A62E;
	Thu, 14 Jul 2016 12:32:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/3] Teach `git fsck` a new option: `--name-objects`
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
Date:	Thu, 14 Jul 2016 09:32:53 -0700
In-Reply-To: <cover.1468510191.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 14 Jul 2016 17:30:10 +0200 (CEST)")
Message-ID: <xmqqmvlkrxhm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E6C23CE-49E0-11E6-AD22-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Example output:
>
> 	...
> 	broken link from    tree b5eb6ff...  (refs/stash@{<date>}~37:)
> 		      to    blob ec5cf80...

The objective makes sense, and their progression is very nicely
structured.  I can "smell" that these are going in the right
direction only with a cursory scan of the three patches.

> Originally, I intended to teach name-rev a new mode where it would also
> name objects other than commits and tags,...

As to having it in name-rev, it is still a "good to have" for an
object that does exist.  It would be "super nice" if it also worked
for a missing object.  It makes tons of sense from the end-user UI
point of view to have this feature there.

I however agree with you that it is sensible to do this in "fsck"
first and leave the "good to have" to later, because (1) naming an
arbitrary blob like this needs full object-store scan like "fsck"
does anyway, and (2) the primary occasion users would want to use
the "super nice" part of the feature is when they discover an object
is "missing", and the first thing they would want to run in such a
case anyway is "fsck".

So, in short, I very much like them.

