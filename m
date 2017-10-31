Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED9E20281
	for <e@80x24.org>; Tue, 31 Oct 2017 04:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdJaE2v (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 00:28:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751455AbdJaE2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 00:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5221DAA46D;
        Tue, 31 Oct 2017 00:28:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xT+Z3oCE+ga/15aMk5qGJBU6y+A=; b=mc6zrr
        FtPjXM7+4biosCm1jbrU20TZDYHakxtqEhwCkHrR2j145dWpDyeNOLm1bVnxmpxy
        8OOq2vtu9tPQrYhqqFfo6S6o1BDoCfRcGd97NTRfbLvm60VoRkFjFkKVQwZofe0b
        Wxx6JBWGtLG/VYGMc/gXDxmH+aXMC2/WdPWAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k3SJNhpLww3/Cx/t0+VYZd3gArP6aU/s
        tTrlltZX6A+hCLwVHFui5iEDumK81JEmFBEoGcKQxdAtapebzWM8lyAip35Ey5NN
        5zjjdeyUOvyuz/wJ4aLSdJbA+SfPML6QJOBkmqzv0KNFVjD34EXLwFy7ELp8XfRX
        wCxvEbsgEZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4971DAA46C;
        Tue, 31 Oct 2017 00:28:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4002AA46A;
        Tue, 31 Oct 2017 00:28:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Meaning of two commit-ish hash in git diff
References: <ab9b5c63-ca38-6157-6732-78aa5d5f291f@gmail.com>
Date:   Tue, 31 Oct 2017 13:28:48 +0900
In-Reply-To: <ab9b5c63-ca38-6157-6732-78aa5d5f291f@gmail.com> (Yubin Ruan's
        message of "Tue, 31 Oct 2017 11:24:22 +0800")
Message-ID: <xmqqd1542b5r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE3261F0-BDF3-11E7-86CF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

> diff --git a/path/somefile b/path/somefile
> index f8886b4..a1c96df 100644
> --- a/path/somefile
> +++ b/path/somefile
> <snip>
>
> This is output by a `git diff` between two adjacent commits but they are
> not any commit hash. I grep through the whole $(git log) but still cannot
> find those hash.

The f8886b4 you see on the left is the name of the blob object on
the left hand side of the comparison that produced this output;
similarly a1c96df is the name of the blob object on the right hand
side of the comparison.

IOW, if you have the contents of the blob whose object name is
f8886b4, by applying this patch, you will get a blob whose object
name is a1c96df.

The information is used by "git am -3" when the patch does not apply
cleanly to fall back to the 3-way merge.
