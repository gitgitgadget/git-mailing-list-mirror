Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFECE20958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbdC2WrL (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:47:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51703 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932172AbdC2WrK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:47:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0398E8925A;
        Wed, 29 Mar 2017 18:47:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ft9um7jPqUL6SF6W+vgk/1q4AVg=; b=S8I9iO
        dFzhQ6fhTAUwsD+P6d7qA09dGPRmSCbRksnvMGTwEI/lY7X6s0RXv2TC4k++KQnL
        6CTCSWkX5tSe2bT/SUo7Cuk7hlbpAsGXqgxflJR/wm02+L0RuBE+y2XxeRWGEEzV
        3uQIvzTno7xNDWBPIk90GUYDIQFovxVDUlpA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c9NhZY6349jsRLakxBZmB4uBPv6QU8nd
        3ahtGZvOQze6TGqvkTfLp5XA9s+W6WIN5E9x/bUWQ7OqYF4SJiQ8u3WbHRD6+sGj
        LStP2SQhCQBFVOd40Dcpn7isoHvXkyaI9XweL1FjN9oqCMDAEsGBy/GemE4uCrbm
        LCddBFlXOn4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F02F689259;
        Wed, 29 Mar 2017 18:47:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 663ED89258;
        Wed, 29 Mar 2017 18:47:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] unpack-trees.c: align submodule error message to the other error messages
References: <xmqqy3vn93a9.fsf@gitster.mtv.corp.google.com>
        <20170329223424.4678-1-sbeller@google.com>
Date:   Wed, 29 Mar 2017 15:47:07 -0700
In-Reply-To: <20170329223424.4678-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 29 Mar 2017 15:34:24 -0700")
Message-ID: <xmqq60ir8zv8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3A4E062-14D1-11E7-8D61-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As the place holder in the error message is for multiple submodules,
> we don't want to encapsulate the string place holder in single quotes.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>> Nitpicking about wording: unless the user has adopted a strongly
>> object-oriented point of view, it is Git that cannot checkout a new
>> HEAD, not the submodule.
>> 
>> How about:
>> 
>>                 _("Cannot update submodule:\n%s")
>
>> That's vague, but if I understand correctly the way this error gets
>> used is equally vague --- i.e., a clearer message would involve
>> finer-grained error codes.
>
> Makes sense. Here is the patch.
> Let's roll this as its own instead of waiting for the discussion on the other
> patch to settle.
>
> Thanks,
> Stefan
>
>  unpack-trees.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8333da2cc9..0d82452f7f 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -167,7 +167,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
>  		_("The following working tree files would be removed by sparse checkout update:\n%s");
>  	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
> -		_("Submodule '%s' cannot checkout new HEAD");
> +		_("Cannot update submodule:\n%s")

Missing ';'.  I'll fix locally, but the final integration result
won't be pushed out until later tonight, as I need to redo jch and
pu branches with a fixed version.


>  
>  	opts->show_all_errors = 1;
>  	/* rejected paths may not have a static buffer */
