From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] mailmap: debug: fix out-of-order fprintf() arguments
Date: Mon, 15 Jul 2013 08:18:32 -0700
Message-ID: <7vwqordf7b.fsf@alter.siamese.dyndns.org>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
	<1373871253-96480-6-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UykXw-00042h-0L
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab3GOPSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:18:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757662Ab3GOPSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:18:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8133631634;
	Mon, 15 Jul 2013 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x/IaEp5zT9xPMuLA+JksdV/0L4E=; b=aBQhB8
	on+bOC0/Jnsq7y5/o2VgLD4Z9RGKrNA1NULfgE+6YLdIqChnu+3Ix18cqeZDFj+A
	xQ4vb6a1207sw/iFxmaQe/hypuc5GGyLtF85vJOA30oA+SGMOBtIkk27+q2ghFA3
	g2ycd90Lv+xGLAyoxqTSBvbFySRoLsd9Tj5dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EbAWCjjapRODX21sqtv2CNMLnyouRqtq
	BiKn5Z9vt/Cf8BzKjVtm4jeZrSWV3LYOZARugfA+OWRffHYKlSGKJsVxy9n0M6Eb
	/Ru5AByZCmZtH/kPImf6edKE+sSUvPnnv8OPdavo/D5jHIdzN9gNEWoBzKt7sX2Y
	Ai7GRcT6Xyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 764CA31633;
	Mon, 15 Jul 2013 15:18:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D04A831630;
	Mon, 15 Jul 2013 15:18:33 +0000 (UTC)
In-Reply-To: <1373871253-96480-6-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 15 Jul 2013 02:54:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D068143E-ED61-11E2-BC98-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230476>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Resolve segmentation fault due to arguments passed in wrong order.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks.  Shows that the debugging support hasn't been in use for
quite a long time X-<.

> ---
>  mailmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mailmap.c b/mailmap.c
> index a7e92db..0516354 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -309,7 +309,7 @@ int map_user(struct string_list *map,
>  	struct mailmap_entry *me;
>  
>  	debug_mm("map_user: map '%.*s' <%.*s>\n",
> -		 *name, *namelen, *emaillen, *email);
> +		 *namelen, *name, *emaillen, *email);
>  
>  	item = lookup_prefix(map, *email, *emaillen);
>  	if (item != NULL) {
