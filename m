From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Honor configure's htmldir switch
Date: Sat, 02 Feb 2013 17:27:18 -0800
Message-ID: <7v7gmqb30p.fsf@alter.siamese.dyndns.org>
References: <20130202212504.GA16412@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Christoph J. Thompson" <cjsthompson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 02:28:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1oNH-0006M4-Mh
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 02:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab3BCB1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 20:27:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab3BCB1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 20:27:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACE2C298;
	Sat,  2 Feb 2013 20:27:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=srJtw60PWt8FIAQ4Gsv9eg6pBN4=; b=UBjk+W
	7sXIAu8vXq0XKVA0OBX1sIPz9jkpz26nqsh+70UiiTG7t6yNzMhly4vKh+oZAwm+
	XOybTmHG+juOOMdDnQVBD+B/ZsLjwif57QPlYCGJzMw56cbS95uhXp6vrnGDNiln
	rDGpoNGZ+OPYqGlOKasT3WkPdBcZkGODlmJLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EpWsWRplyB7ALNlgu6xpNr1ZHFjbLhC6
	f6bVxme5jBn/PgSI4b6ptTmTI7XfNqNaKWe1PFcKuqijH1Nwa9cI1+6nS5J0lbIv
	7tThyb703E8Wrrkfc7Sr+d/vraBoIbdPOrIug4qUmQE46CzvilFXeLaqUOJ4izLX
	hdwZlk3PwXw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FD2FC297;
	Sat,  2 Feb 2013 20:27:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9990C296; Sat,  2 Feb 2013
 20:27:19 -0500 (EST)
In-Reply-To: <20130202212504.GA16412@gmail.com> (Christoph J. Thompson's
 message of "Sat, 2 Feb 2013 22:25:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA498F6E-6DA0-11E2-8EC9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215295>

"Christoph J. Thompson" <cjsthompson@gmail.com> writes:

> Honor autoconf's --htmldir switch. This allows relocating HTML docs 
> straight from the configure script.
>
>
> Signed-off-by: Christoph J. Thompson <cjsthompson@gmail.com>
> ---
>  config.mak.in | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.in b/config.mak.in
> index e8a9bb4..d7c49cd 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -19,6 +19,7 @@ template_dir = @datadir@/git-core/templates
>  sysconfdir = @sysconfdir@
>  
>  mandir = @mandir@
> +htmldir = @htmldir@
>  
>  srcdir = @srcdir@
>  VPATH = @srcdir@

Hmph, in the output of "git grep -e mandir config.mak.in", I see

    export exec_prefix mandir

which makes me wonder if we should either export htmldir as well, or
drop mandir from the "export".  Off-hand, I am not sure which is the
right way, but in either case the inconsistency disturbs me.

Thanks.
