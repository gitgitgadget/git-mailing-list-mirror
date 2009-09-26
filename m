From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git branch -D: give a better error message when lockfile creation fails
Date: Sat, 26 Sep 2009 22:04:49 +0200
Message-ID: <vpqy6o15v6m.fsf@bauges.imag.fr>
References: <20090926033143.GA9917@coredump.intra.peff.net>
	<1253972051-31980-1-git-send-email-vmiklos@frugalware.org>
	<20090926195812.GH14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 22:05:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrdW5-0000Mv-CX
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 22:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbZIZUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 16:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZIZUFD
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 16:05:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60181 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbZIZUFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 16:05:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8QK09xu020588
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 26 Sep 2009 22:00:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MrdVh-0000XN-5u; Sat, 26 Sep 2009 22:04:49 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1MrdVh-000623-4a; Sat, 26 Sep 2009 22:04:49 +0200
In-Reply-To: <20090926195812.GH14660@spearce.org> (Shawn O. Pearce's message of "Sat\, 26 Sep 2009 12\:58\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 26 Sep 2009 22:00:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8QK09xu020588
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254600010.04339@UZDDHus+J9tpE7VISJCqOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129173>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Miklos Vajna <vmiklos@frugalware.org> wrote:
>> On Fri, Sep 25, 2009 at 11:31:43PM -0400, Jeff King <peff@peff.net> wrote:
>> > afterwards). So probably you would need to first refactor
>> > unable_to_lock_index_die() to handle just printing the error without
>> > dying.
>> 
>> I removed the NORETURN macro as otherwise gcc would issue a warning, as
>> it does not realise that unable_to_lock_index_die() never returns.
>
> Please don't.  If you refactor the error message formatting into
> a static function called from the two extern ones, you can still
> centralize the formatting but also keep NORETURN on the method that
> doesn't return.  The annotation is useful and should not be removed.

I guess the lint-trap would be to add a

  die("unable_to_lock_index() should have died already");

at the end of unable_to_lock_index_die().

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
