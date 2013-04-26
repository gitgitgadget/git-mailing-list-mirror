From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 10:51:00 +0200
Message-ID: <vpqwqrpfzez.fsf@grenoble-inp.fr>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeNB-0005fh-Kk
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab3DZIvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:51:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56849 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757622Ab3DZIvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:51:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3Q8oxCt031569
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Apr 2013 10:50:59 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UVeMu-0004hX-Tj; Fri, 26 Apr 2013 10:51:00 +0200
In-Reply-To: <CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	(Jiang Xin's message of "Fri, 26 Apr 2013 16:41:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Apr 2013 10:51:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3Q8oxCt031569
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367571064.1915@oecuK8MMDqdeqRazUJGhAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222514>

Jiang Xin <worldhello.net@gmail.com> writes:

> Maybe we can do like this:
>
> 1. Set the default value of 'clean.requireForce' to false.
> 2. Show a error message and do nothing, if there is not 'clean.requireForce'
>     setting, but the user called with a '--force' flag.
>     ( like a transition for the change of push.default in git 2.0)

Perhaps introducing a new value for 'clean.requireForce':

$ git config --global clean.requireForce ask
$ git clean
will remove ...
are you sure [y/N]?

The error message when clean.requireForce is unset and --force is not
given could point the user to clean.requireForce=ask.

Then, maybe, later, this could become the default. But I tend to like
the non-interactive nature of most Git commands, so I'm a bit reluctant
here. My way of doing the confirmation dialog is

$ git clean -n
would remove ...
$ git clean -f

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
