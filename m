From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] upload-pack.c: use parse-options API
Date: Mon, 30 May 2016 12:26:01 -0700
Message-ID: <xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, peff@peff.net,
	sunshine@sunshineco.com
To: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 21:26:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7SpZ-00067y-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 21:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161791AbcE3T0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 15:26:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161746AbcE3T0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 15:26:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A64C22094B;
	Mon, 30 May 2016 15:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZagYsEj0SmfZFm96WqVPnxp67zM=; b=j1WeVv
	znjMPZKYlF9SX2h6uihzCI1IuJYNTEqfJPfwUcR9Ktl7TbJboNaQb2i6Yj5gFCV4
	8DxviAJtnUF0mwA2exMFCaBP5n729G2eSDLOMA2ElXPrxC4hg49m32mxIhMH2NiZ
	SC9UCzTrYwVmOaUI/QHzyK5bBYKqvAhL1HlrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eipPzIGlLMCTwRTbakvS2WdTQ73fWsYF
	OzBGtx7lXIBI2epatiiuJGTVKbpTMMUVXoU+SipwnNLb8Zhwh5Gb3UFh21rbGYyG
	rEGWLjUe7rJy1SdPQjihSi/tIsbDoWSkds38akBq2OGoiybKpDrcKKG+mdeUVIGc
	qvSWJ6j/+dU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F1352094A;
	Mon, 30 May 2016 15:26:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1024520949;
	Mon, 30 May 2016 15:26:03 -0400 (EDT)
In-Reply-To: <20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
	(Antoine Queru's message of "Mon, 30 May 2016 16:53:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59023420-269C-11E6-86ED-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295928>

Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:

> From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>

Don't you want to be known to the project as the email that matches
your Signed-off-by: line?

> Use the parse-options API rather than a hand-rolled option parser.
>
> Description for --stateless-rpc and --advertise-refs come from
> 42526b4 (Add stateless RPC options to upload-pack,
> receive-pack, 2009-10-30).
>
> Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
> ---strict::
> +--[no-]strict::
>  	Do not try <directory>/.git/ if <directory> is no Git directory.

Not a new problem, but "is no Git ..." may technically be correct,
but it would be easier to read if phrased "is not a Git ..." or
something like that.

	I am NOT asking _you_ to change/fix that in this patch.  It
	is just a note for "a low hanging fruit" for people to pick
	up with a separate patch.

> +--stateless-rpc::
> +	Perform only a single read-write cycle with stdin and stdout.
> +	This fits with the HTTP POST request processing model where
> +	a program may read the request, write a response, and must exit.
> +
> +--advertise-refs::
> +	Only the initial ref advertisement is output, and the program exits
> +    	immediately. This fits with the HTTP GET request model, where
> +    	no request content is received but a response must be produced.
> +

Good.

> diff --git a/upload-pack.c b/upload-pack.c
> index dc802a0..083d068 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -14,8 +14,12 @@
>  #include "sigchain.h"
>  #include "version.h"
>  #include "string-list.h"
> +#include "parse-options.h"
>  
> -static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
> +static const char * const upload_pack_usage[] = {
> +	N_("git upload-pack [options] <dir>"),
> +	NULL
> +};

Output from "git grep -e '\[option' -e '\[<option' -- \*.c" tells me
that "[<options>]" would be more in line with the established
convention than "[options]".

	I personally wish if all these hits from the above grep
	consistently spelled it as "[options]", because there is not
	much gained by enclosing the word in <> to highlight it as a
	placeholder.  An argument that "it is done for uniformity
	with descriptions for other non option arguments, i.e. not
	to special case 'options'" would not hold water, e.g. in

        builtin/merge.c:        N_("git merge [<options>] [<commit>...]"),

	<options> is still special-cased in that it implies multiple
	things, unlike "<commit>..." notation that has to explicitly
	say that can have multiple.  [<options>...] would have been
	justifiable with the "make it uniform with non-option args",
	though.

	BUT this patch is not about "make usage string better"
	patch, so I do NOT want you to switch upload-pack's usage
	string to use the "options is special anyway, so let's not
	waste two display columns with enclosing <>" convention.

So, in conclusion, "git upload-pack [<options>] <dir>".

The remainder of the patch looked OK to me.

Thanks.
