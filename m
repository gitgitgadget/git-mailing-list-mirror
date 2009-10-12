From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git config: clarify bool types
Date: Sun, 11 Oct 2009 22:01:11 -0700
Message-ID: <7v7hv1kxyg.fsf@alter.siamese.dyndns.org>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxD8L-0002gf-Cx
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbZJLFCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbZJLFCC
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:02:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZJLFCA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:02:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B57E74606;
	Mon, 12 Oct 2009 01:01:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=10Z/5lNIqqjXu+qG+V9kmi61KQM=; b=csbEzf
	RrDzAPEpGQ944WfLMaX6hT1t4jlfkl5oBSh22/FdflYJiZbwVPAzCROTW1YDSj+Q
	bkJGJ+WkqSlZziZUjPfIuoH8iwJ+/nDSNh4Xc4e5M79Za/Bbfc8YmS7bQJOnSYNR
	BGRULmHGmn6YzNSofAeKiVganIfOilM8Yurzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jUkZMXY26rGCNW1B6lX8wvd3t+Cb8bjf
	SWxdqAufiHBCbkmJNTFZdiSk3J/bTZoK0UWJUwtcNBoHAgOaPTdlHP+SzUllOrGY
	lPzQBtZt8NP66rapj9Yf2/KoZZTByI+/lP8oa75AsmUWSK259o1Q5+if6LAw+A0k
	QiLiWGnID6g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D85F74605;
	Mon, 12 Oct 2009 01:01:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B76574604; Mon, 12 Oct 2009
 01:01:12 -0400 (EDT)
In-Reply-To: <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun\, 11 Oct 2009 23\:46\:12 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45699D9E-B6EC-11DE-BFAE-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129975>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The value is what it is, the --bool and --bool-or-int options don't
> specify the value type, just how it is interpreted. For example: a value
> of '1' can be interpreted as 'true'.

It is not really about "interpreting", but about showing, isn't it?

With this in your .git/config file:

    [core]
        repositoryformatversion = 0

you would see

    $ git config --bool-or-int core.repositoryformatversion
    0
    $ git config --bool core.repositoryformatversion
    false
    $ git config --int core.repositoryformatversion
    0

So it would be more like...

	show value as boolean
        show value as integer or boolean
        show value as integer

wouldn't it?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin-config.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-config.c b/builtin-config.c
> index a2d656e..29d7b75 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -66,9 +66,9 @@ static struct option builtin_config_options[] = {
>  	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
>  	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
>  	OPT_GROUP("Type"),
> -	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
> +	OPT_BIT(0, "bool", &types, "value is intepreted as bool (\"true\" or \"false\")", TYPE_BOOL),
>  	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
> -	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BOOL_OR_INT),
> +	OPT_BIT(0, "bool-or-int", &types, "value is interpreted either as bool or int", TYPE_BOOL_OR_INT),
>  	OPT_GROUP("Other"),
>  	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
>  	OPT_END(),
> -- 
> 1.6.5.4.g31fc3
