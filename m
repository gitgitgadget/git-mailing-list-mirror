From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Sun, 23 Sep 2007 15:20:48 -0700
Message-ID: <7vhcllc9bz.fsf@gitster.siamese.dyndns.org>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZZp6-0002ws-Uw
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507AbXIWWUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459AbXIWWUy
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:20:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbXIWWUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:20:53 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AE70B13ACC4;
	Sun, 23 Sep 2007 18:21:11 -0400 (EDT)
In-Reply-To: <85myvdktb3.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	23 Sep 2007 22:42:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58988>

David Kastrup <dak@gnu.org> writes:

> A lot of shell scripts contained stuff starting with
>
> 	while case "$#" in 0) break ;; esac
>
> and similar.  I consider breaking out of the condition instead of the
> body od the loop ugly, and the implied "true" value of the
> non-matching case is not really obvious to humans at first glance.  It
> happens not to be obvious to some BSD shells, either, but that's
> because they are not POSIX-compliant.  In most cases, this has been
> replaced by a straight condition using "test".  "case" has the
> advantage of being faster than "test" on vintage shells where "test"
> is not a builtin.  Since none of them is likely to run the git
> scripts, anyway, the added readability should be worth the change.
>
> A few loops have had their termination condition expressed
> differently.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>
> Ok, this is not really what we have been talking about except in one
> case, but I think it is actually more of an improvement.

Gaah, didn't I say I do NOT think it is an improvement?

> I consider breaking out of the condition instead of the
> body od the loop ugly,

Well, as we all know that we disagree on this point, stating
what you consider one-sidedly here is quite inappropriate.

> and the implied "true" value of the
> non-matching case is not really obvious to humans at first
> glance.

It is more like "if you do not know shell".

In other words, I am somewhat disgusted with the first part of
your proposed commit log message, although I like what the patch
does ;-).

> -while case "$#" in 0) break ;; esac
> +while test "$#" != 0
>  do
>      case "$1" in
>      -a)

And let's not quote "$#".
