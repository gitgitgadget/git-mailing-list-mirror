From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 2/2] Improve doc for format-patch threading options.
Date: Thu, 23 Jul 2009 07:31:13 +0200
Message-ID: <200907230731.14430.markus.heidelberg@web.de>
References: <1248298771-21075-1-git-send-email-ydirson@altern.org> <1248298771-21075-2-git-send-email-ydirson@altern.org> <1248298771-21075-3-git-send-email-ydirson@altern.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqv2-0001XN-Fg
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbZGWFcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbZGWFcd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:32:33 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57153 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbZGWFcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:32:32 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5BD6810CBD820;
	Thu, 23 Jul 2009 07:31:08 +0200 (CEST)
Received: from [89.59.124.160] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MTqtY-0000JT-00; Thu, 23 Jul 2009 07:31:08 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1248298771-21075-3-git-send-email-ydirson@altern.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+sN//Bdddo0EoGdAYqnxRgpOHUXGYSn7Qv+hLw
	E+ORdtjUrYuu27BLecWV3ZmH2MQ33rfol3tgBH0bmkqiSfQ9+s
	YWOO8Cn428gkIGT5OdWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123842>

Yann Dirson, 22.07.2009:
> This hopefully makes the relationship between threading options of
> format-patch and send-email easier to grasp.

Yes, it does.

> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
>  Documentation/git-format-patch.txt |   22 +++++++++++++++-------
>  Documentation/git-send-email.txt   |   21 ++++++++++++++++-----
>  2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 6f1fc80..687e667 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
> -		   [--thread[=<style>]]
> +		   [--no-thread | --thread[=<style>]]
>  		   [(--attach|--inline)[=<boundary>] | --no-attach]
>  		   [-s | --signoff]
>  		   [-n | --numbered | -N | --no-numbered]
> @@ -124,17 +124,25 @@ include::diff-options.txt[]
>  	second part, with "Content-Disposition: inline".
>  
>  --thread[=<style>]::
> -	Add In-Reply-To and References headers to make the second and
> -	subsequent mails appear as replies to the first.  Also generates
> -	the Message-Id header to reference.
> +--no-thread::
> +	Controls addition of In-Reply-To and References headers to
> +	make the second and subsequent mails appear as replies to the
> +	first.  Also controls generation of the Message-Id header to
> +	reference.
>  +
>  The optional <style> argument can be either `shallow` or `deep`.
>  'shallow' threading makes every mail a reply to the head of the
>  series, where the head is chosen from the cover letter, the
>  `\--in-reply-to`, and the first patch mail, in this order.  'deep'
> -threading makes every mail a reply to the previous one.  If not
> -specified, defaults to the 'format.thread' configuration, or `shallow`
> -if that is not set.
> +threading makes every mail a reply to the previous one.
> ++
> +The default is --no-thread, unless the 'format.thread' configuration
> +is set.  If --thread is specified without a style, it defaults to the
> +style specified by 'format.thread' if any, or else `shallow`.
> ++
> +Beware that the default for 'git send-email' is to thread emails
> +itself.  If you want 'git format-patch' to take care of hreading, you
                                                           ^^^^^^^^
threading
I guess Junio can squash this in.

> +will want to ensure that threading is disabled for 'git send-email'.
>  
>  --in-reply-to=Message-Id::
>  	Make the first mail (or all the mails with --no-thread) appear as a
