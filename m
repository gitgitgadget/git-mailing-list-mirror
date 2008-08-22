From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't fail when an existing directory can't be created.
Date: Fri, 22 Aug 2008 15:35:22 -0700
Message-ID: <7vbpzk7k5x.fsf@gitster.siamese.dyndns.org>
References: <87pro1pj3l.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sat Aug 23 00:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfFC-0004zg-NL
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbYHVWfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYHVWfa
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:35:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYHVWf3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 18:35:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D02626444F;
	Fri, 22 Aug 2008 18:35:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ED2136444E; Fri, 22 Aug 2008 18:35:25 -0400 (EDT)
In-Reply-To: <87pro1pj3l.fsf@lysator.liu.se> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Fri, 22 Aug 2008 10:08:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F2794B0-709A-11DD-BCB7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93383>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> This makes it possible to install in a writable directory not owned b=
y
> the current user.
> ---

Sign-off?

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 7a2130a..e6271d8 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -87,15 +87,15 @@ man7: $(DOC_MAN7)
>  info: git.info gitman.info
> =20
>  install: man
> -	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
> -	$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
> -	$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
> +	-$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
> +	-$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
> +	-$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)

Makes me wonder what happens if you failed to create the target
directory.  Is it deemed to be Ok because the later step of installing =
the
contents will fail anyway?
