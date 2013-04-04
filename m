From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 04 Apr 2013 09:44:46 -0700
Message-ID: <7vip42jldt.fsf@alter.siamese.dyndns.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
 <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnHq-0006lO-Uj
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762945Ab3DDQou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:44:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762781Ab3DDQot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:44:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B710A137C1;
	Thu,  4 Apr 2013 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+F83FJ3bQfHbTJkmy2lQUw8P6cU=; b=lGJIOC
	az/rzURZpqmA7NXOliuKpsckzTDS5EJrDzP5TfeWA7EKy6HgIIdpYfAaK+3KAvEM
	XYbATGPEw/Wto8RdP1kM/24CE7cRkTaGfSlhHXF35keLPsipUJ376wGI+chz1U6I
	U6NKDWREdCypxCulTgSx8EKKvUzT6na8AoCQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i/JbPfm00cwYzm1LcUR6vdGaGqo1sFdh
	AW2rMaK44P4OZVsdP1NtiKR2ZRHjx5I03EPKnWHM/ew5XyhHiow4pXUMq331b+FC
	tFYy+dNSK/0sPISG6+lw+NDcNiHjbaskBXTvDTOvRi92XsU8e6x14WlBplxrKLps
	wQlbZz2Vm24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD595137C0;
	Thu,  4 Apr 2013 16:44:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC650137BC; Thu,  4 Apr
 2013 16:44:47 +0000 (UTC)
In-Reply-To: <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 4 Apr 2013 09:30:20 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6495CC8-9D46-11E2-9112-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220032>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Ideally we shouldn't do this, as it's not recommended in mercurial
> documentation, but there's no other way to push multiple bookmarks (on
> the same branch), which would be the behavior most similar to git.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

In the previous round you wanted me to exclude this one to force
split head at the remote, and I saw you and Max Horn discussing
(rather, shouting at each other ;-) why it is needed/desirable.

Have you changed your mind and you want this as part of the series,
or is it just you forgot to exclude it?

>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index b54de1e..b784c54 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -722,7 +722,7 @@ def do_export(parser):
>              continue
>  
>      if peer:
> -        parser.repo.push(peer, force=False)
> +        parser.repo.push(peer, force=True)
>  
>      # handle bookmarks
>      for bmark, node in p_bmarks:
