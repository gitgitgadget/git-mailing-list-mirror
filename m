From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Mon, 04 Jun 2012 22:30:54 +0200
Message-ID: <vpqk3zmn7k1.fsf@bauges.imag.fr>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vhaurt1m6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:31:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbdvg-0002zp-Hr
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab2FDUbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:31:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59690 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab2FDUbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:31:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54KML7N024549
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 22:22:21 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbdvT-0000mz-48; Mon, 04 Jun 2012 22:30:55 +0200
In-Reply-To: <7vhaurt1m6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Jun 2012 10:42:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 22:22:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54KML7N024549
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339446143.74912@UnyapINe9lZu54uVosKi6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199183>

Junio C Hamano <gitster@pobox.com> writes:

> The description of this and exisitng <newbase> look very odd.  The
> usual way to describe an option that take a parameter in the OPTIONS
> section is to instead do:
>
> 	--onto <newbase>::
> 		Description of what --onto option does and how <newbase>
> 		is used in what it does.
>
> 	--exec <cmd>::
> 		Description of what --exec option does, and how	<cmd> 
>                 is used in what it does.

(to the authors: you can add a trivial patch to fix the --onto doc, and
base your work on it)

> Why is "pick" special?  Don't you want to run the commands after
> "edit", "reword", "squash", "fixup"?

I'd actually say you want to run it after a squash/fixup serie only.

If the result of --autosquash is

pick foo
fixup bar
fixup boz
pick foobar

I think you want to rewrite it as

pick foo
fixup bar
fixup boz
exec make
pick foobar
exec make

The command is typically used to check that each new commit is OK, but
we can forget about the intermediate states as we are precisely getting
rid of them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
