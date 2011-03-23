From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] show: turn on rename progress
Date: Wed, 23 Mar 2011 14:25:02 -0700
Message-ID: <7vvcz9cyxd.fsf@alter.siamese.dyndns.org>
References: <20110323181756.GA17415@sigill.intra.peff.net>
 <20110323181915.GC17533@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 22:25:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2VYQ-0000Wz-3I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 22:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab1CWVZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 17:25:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab1CWVZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 17:25:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC5084844;
	Wed, 23 Mar 2011 17:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jahdthEwk7pqRMRghOLjJzhxvJo=; b=QjafDz
	TKL4lJeq2YRULB9sQr87YkJyJZBuitQXUOOu2tgPJ2EbLXhlOgAgdk8mESGsIdWU
	RsldXGWKQeBf/5HIUb/amRYUJPGufsViWaXPVP7qsjC2WJqx5z3/7oR7ApcUdlSC
	9i5D3kydKn4UiJmqAwOknZFLBZRqQMla44beA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rlno3Pk1L0mlUA+EDlC+mSjkHbaVKl6y
	Vr+FEVNSMEO+axl6skKOF4OHUPTcbFDkNFnB4EK2MX9GNdSu/6BB78CwNIXeoeEF
	OEdGI3VrrZF/XIIeSTq6oN7vKZyazgUAJfng06l8R9uhiujY4VMpptL9xCSdG+sN
	/nmrANCu6Ao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C95B54843;
	Wed, 23 Mar 2011 17:26:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4D694838; Wed, 23 Mar 2011
 17:26:44 -0400 (EDT)
In-Reply-To: <20110323181915.GC17533@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Mar 2011 14:19:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42547AF0-5594-11E0-843D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169872>

Jeff King <peff@peff.net> writes:

> For large commits, it is nice to have some eye candy for the
> rename detection.
>
> This makes sense for "show", which is showing a single diff,
> since the progress reporting will be shown before the pager
> shows any output.
>
> We don't want to do the same for "log", though, because the
> progress would be interspersed with the various commits.

I understand that you said q&d, but these days since f222abd (Make 'git
show' more useful, 2009-07-13), show does walk when it is asked to.

"git show master maint" will also be affected with this, no?

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/log.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 707fd57..cf68130 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -416,6 +416,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  	rev.diff = 1;
>  	rev.always_show_header = 1;
>  	rev.no_walk = 1;
> +	rev.diffopt.show_rename_progress = 1;
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
>  	opt.tweak = show_rev_tweak_rev;
