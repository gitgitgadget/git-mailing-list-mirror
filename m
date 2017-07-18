Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7941FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 21:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbdGRVig (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 17:38:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752360AbdGRVif (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 17:38:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35AA58008F;
        Tue, 18 Jul 2017 17:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=auF9V3syuoFDj8UvQoeWvA3liAk=; b=KmugyE
        s8bOgfpZpTNu+xQCY/wRUUekyfg9+SLHWtW+qMjbZVYWQ6anAVVAl9oxIwAPni1x
        xb++WFyGkkYydA6pGDwwIv5HG5dqgdI4PRIegE6QGmzMlHnLj9At+oy3MSbzSbkO
        jfwVnKeSsYe2TDw8vQ1njl5MC1+O2PDc0vxfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kYwpLppegwp9ZlfKPKM4dMbPnGKRXC6X
        O2gxJVLcHJoYnogfJdV1WjTAdrE9Jr2EsVAbLDBsOlS79toS1IHxdVHDngNGnKvm
        cpPcsyURsjUZsndMQpvKBMDX4wkuY3W81RbweMvXJSx6lOFQn74WZscLdgtu3qJP
        weThyqECTdg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D16F8008E;
        Tue, 18 Jul 2017 17:38:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C4CA8008D;
        Tue, 18 Jul 2017 17:38:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
        <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
        <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
        <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
        <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
        <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain>
        <xmqqmv82g1g7.fsf@gitster.mtv.corp.google.com>
        <20170718175458.hadk64c3yccyv57t@LykOS.localdomain>
        <xmqqeftdpor5.fsf@gitster.mtv.corp.google.com>
        <20170718211651.rcnbkhcwem4sbcb5@LykOS.localdomain>
Date:   Tue, 18 Jul 2017 14:38:32 -0700
In-Reply-To: <20170718211651.rcnbkhcwem4sbcb5@LykOS.localdomain> (Santiago
        Torres's message of "Tue, 18 Jul 2017 17:16:52 -0400")
Message-ID: <xmqqvampmnmv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72C7FCB8-6C01-11E7-9C54-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> ... It seems Debian oldstable and other variants still ship gpg1,
> which doesn't have it. Would it make sense to have a fallthrough branch
> on the switch statement for gpg2.1 instead? something like the attached patch.

If the problem of leftover agent is limited to a narrow versions of
GPG2, alternatively we could unconditionally attempt to use gpgconf
and ignore the failure ;-), but as long as we know all problematic
ones identify themselves as "gpg (GnuPG) 2.1*", then your patch
(with s/;&/;;/ of course ;-)) sounds very sensible.

> Thanks,

Thank *you* for working on this.

> From 07ab87c1ddb31197a3a5c124ad5a2462a460d4e3 Mon Sep 17 00:00:00 2001
> From: Santiago Torres <santiago@nyu.edu>
> Date: Tue, 18 Jul 2017 13:16:11 -0400
> Subject: [RFC/PATCH] t: lib-gpg: flush gpg agent on startup

Perhaps it is about time we lost RFC/ mark from here.

>
> When running gpg-relevant tests, a gpg-daemon is spawned for each
> GNUPGHOME used. This daemon may stay running after the test and cache
> file descriptors for the trash directories, even after the trash
> directory is removed. This leads to ENOENT errors when attempting to
> create files if tests are run multiple times.
>
> Add a cleanup script to force flushing the gpg-agent for that GNUPGHOME
> (if any) before setting up the GPG relevant-environment.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  t/lib-gpg.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index ec2aa8f68..ffb20a438 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -10,6 +10,8 @@ then
>  	'gpg (GnuPG) 1.0.6'*)
>  		say "Your version of gpg (1.0.6) is too buggy for testing"
>  		;;
> +	'gpg (GnuPG) 2.1'*)
> +		GNUPGHOME="$(pwd)/gpghome" gpgconf --kill all ;&
>  	*)
>  		# Available key info:
>  		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
