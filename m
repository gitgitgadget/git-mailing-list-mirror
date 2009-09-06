From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sun, 06 Sep 2009 14:32:44 +0200
Message-ID: <vpqfxb0s177.fsf@bauges.imag.fr>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905084641.GA24865@darc.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Sep 06 14:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkGwp-00009B-3L
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 14:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbZIFMeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 08:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbZIFMeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 08:34:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54573 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbZIFMeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 08:34:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n86CT5ZE009121
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 14:29:05 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MkGvE-0004N6-9y; Sun, 06 Sep 2009 14:32:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MkGvE-00008o-8b; Sun, 06 Sep 2009 14:32:44 +0200
In-Reply-To: <20090905084641.GA24865@darc.dnsalias.org> (Clemens Buchacher's message of "Sat\, 5 Sep 2009 10\:46\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Sep 2009 14:29:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n86CT5ZE009121
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252844947.37755@7F5w9enqMS5BAa04TJscDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127853>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sat, Sep 05, 2009 at 12:02:35AM -0700, Junio C Hamano wrote:
>
>> I personally find "add -u" that defaults to the current directory more
>> natural than always going to the root; same preference for "grep".
>> Besides, "add -u subdir" must add subdir relative to the cwd, without
>> going to the root.  Why should "add -u" sans argument behave drastically
>> differently?
>
> Sorry for stating the obvious here, but the following commands affect the
> entire repository, even though they limit themselves to the current
> directory, if passed a '.'.
>
> 	git commit
> 	git log
> 	git diff
> 	git checkout
> 	git reset

You have to add "git add -e", "git add -i" and "git add -p" here.

I completely agree that "git add -u" should have been a full-tree
oriented command, just like other "git add" variants and other Git
commands, from the beginning.

Now, I'm unconfortable with both a behavior change and a config
option. Someone used to the cwd-limited behavior typing "git add -u"
on a machine configured to git the full-tree behavior could be really
annoyed (not even mentionning scripts).

I think it has already been proposed to introduce "git add -a" doing
what "git add -u" do, but for the full tree. The "-a" option here
being analogous to the one of "git commit": roughly, "git add -a; git
commit" would be equivalent to "git commit -a". This would allow a
long deprecation period for "git add -u". I find the proposal
sensible, but IIRC it has already been rejected.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
