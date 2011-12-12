From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] mv: make non-directory destination error more clear
Date: Mon, 12 Dec 2011 11:55:42 -0800
Message-ID: <7vsjkp36pt.fsf@alter.siamese.dyndns.org>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075136.GC17532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:55:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaByY-0004Xu-1Q
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab1LLTzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:55:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab1LLTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:55:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC1016066;
	Mon, 12 Dec 2011 14:55:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=maT+pJ50cot/2kRvOE+Txo42zj8=; b=djjhj6
	WL7dt68F0qYK+xvg4IQx0fWoajX2e1orISsHJLKv9rb9cNrWX6v/yTc6/8R0Gbxc
	HUpmWNnT6HCCVLfYjWIsY6NswUaWKqLzpRwVhPiQpxQkZ3NHv5frvS3i++1GsGKW
	P4JL3TD+bUNR8rcVrdWQ4umUUnSqnSJcd/XVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPSoDfhtpK+KXALSgV6OazwLOAWuOnUb
	ipZ3lK0psQulRdnas9cJyCkm/doPKWvAWl648eOF68fLuI6hTIkEiCFEWgeYSifD
	oRK1Pbtg8Au1wJ0TpnqUnJVQMuzzgwlppuG0cxgx6nXLp5UfxQ5iT4LCDv8qDUqy
	WGlUnevN+No=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3BF56065;
	Mon, 12 Dec 2011 14:55:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 603986061; Mon, 12 Dec 2011
 14:55:43 -0500 (EST)
In-Reply-To: <20111212075136.GC17532@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 02:51:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 466209C8-24FB-11E1-99DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186941>

Jeff King <peff@peff.net> writes:

> Instead, let's show an error message like:
>
>   $ git mv one two three
>   fatal: destination 'three' is not a directory

Makes perfect sense.

> We could leave the usage message in place, too, but it
> doesn't actually help here. It contains no hints that there
> are two forms, nor that multi-file form requires that the
> endpoint be a directory. So it just becomes useless noise
> that distracts from the real error.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/mv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 11abaf5..ae6c30c 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -94,7 +94,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		destination = copy_pathspec(dest_path[0], argv, argc, 1);
>  	} else {
>  		if (argc != 1)
> -			usage_with_options(builtin_mv_usage, builtin_mv_options);
> +			die("destination '%s' is not a directory", dest_path[0]);
>  		destination = dest_path;
>  	}
