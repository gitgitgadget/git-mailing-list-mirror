From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] push: remove dead code in setup_push_upstream()
Date: Wed, 19 Jun 2013 13:01:15 -0700
Message-ID: <7vy5a5yino.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 22:01:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpOZG-0000XY-Mu
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 22:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab3FSUBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 16:01:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756805Ab3FSUBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 16:01:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A924F29B48;
	Wed, 19 Jun 2013 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G4eBWShdTDJzze3yScYJY/JnQuE=; b=DJl66O
	yvbGsT7YOKp1V5UYSVUohG1+Ic+ZNqzqNbFRlAJ2ZWoBs2G0mf2XoiOO8hDTieJS
	00LgSnM8/jbUixBNcUB3U5Zmcr9P9F+dMKIB5kes5/LQKOclUWFvGZgyhlnbd13V
	52yI+5sBU8pI7SWxDWbI95GrtEIsBoWT1+YaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e9UQG55Jv1UzE4lz+ogypZOL5j/Wg6Yd
	snxm0imEETYisTeeSLXeKo4NPve+qjqRnCsxbMpBqFAJnPknXKXxf4khqDxPHp51
	bJk2M6UjZoCFCXIlIUy00UyFyupbYBWfC0nBdmVrrgJnRhd1MTQvLAuzX1eqJbz/
	2YCXEPY/J/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FF8529B40;
	Wed, 19 Jun 2013 20:01:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E6E129B3C;
	Wed, 19 Jun 2013 20:01:16 +0000 (UTC)
In-Reply-To: <1371640304-26019-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 16:41:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 008630B6-D91B-11E2-B7F1-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228420>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Now that simple has been decoupled from upstream in setup_push_simple(),
> remove the dead code in setup_push_upstream().

Good.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/push.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index d8d27d9..783bacf 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -139,7 +139,7 @@ end:
>  	add_refspec(branch->name);
>  }
>  
> -static void setup_push_upstream(struct remote *remote, int simple)
> +static void setup_push_upstream(struct remote *remote)
>  {
>  	struct strbuf refspec = STRBUF_INIT;
>  	struct branch *branch = branch_get(NULL);
> @@ -161,8 +161,6 @@ static void setup_push_upstream(struct remote *remote, int simple)
>  		      "your current branch '%s', without telling me what to push\n"
>  		      "to update which remote branch."),
>  		    remote->name, branch->name);
> -	if (simple && strcmp(branch->refname, branch->merge[0]->src))
> -		die_push_simple(branch, remote);
>  
>  	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
>  	add_refspec(refspec.buf);
> @@ -211,7 +209,7 @@ static void setup_default_push_refspecs(struct remote *remote)
>  		break;
>  
>  	case PUSH_DEFAULT_UPSTREAM:
> -		setup_push_upstream(remote, 0);
> +		setup_push_upstream(remote);
>  		break;
>  
>  	case PUSH_DEFAULT_CURRENT:
