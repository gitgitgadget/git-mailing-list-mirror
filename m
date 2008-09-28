From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Implementation of a "textconv" filter for easy custom diff.
Date: Sun, 28 Sep 2008 11:57:05 +0200
Message-ID: <vpqd4io1tla.fsf@bauges.imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
	<20080928041040.GA24214@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 28 12:00:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjt4V-0005oa-VN
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 12:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbYI1J7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYI1J7A
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:59:00 -0400
Received: from imag.imag.fr ([129.88.30.1]:40368 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbYI1J7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:59:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S9v5t2015085
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 11:57:05 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kjt1V-0005xx-AR; Sun, 28 Sep 2008 11:57:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kjt1V-0004oy-6w; Sun, 28 Sep 2008 11:57:05 +0200
In-Reply-To: <20080928041040.GA24214@coredump.intra.peff.net> (Jeff King's message of "Sun\, 28 Sep 2008 00\:10\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 11:57:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96954>

Jeff King <peff@peff.net> writes:

> Neat. I started on something like this quite a while ago,

Did you publish/send it anywhere?

> We have one major difference in our approaches. In yours, there is a
> new "textconv" attribute that can be used. In mine, I subtly changed the
> meaning of the "diff=foo" attribute to be "use the diff driver named by
> diff.foo.*", and you would set diff.foo.textconv to your command. This
> is a bit simpler to implement, and it provides a better path forward for
> defining sets of diff tweaks.

Yes, that's an interesting approach too.

One point in favor of mine is that the "textconv" thing is no
necessarily limited to diff-ing. That would be really cool to have
"blame" use it too for example (with quite bad performance, but that
would be the first time I see a tool able to do this).

Well, OTOH, one could argue that "blame" is based on diff-ing, and
therefore it's natural to define a diff filter to tell how "blame"
should work.

> For example, one of the limitations of the current syntax is that you
> can't say "Choose automatically whether this is binary or text, but if
> it is text, use this hunk header." But with my scheme it is easy to do:
>
>   in attributes:
>     file diff=foo
>
>   in config:
>     [diff "foo"]
>     xfuncname = "some regex"
>     binary = auto

No sure that would actually be useful in real life, but it doesn't
harm to have it. And the argument "better path forward for defining
sets of diff tweaks" is a good one IMO.

-- 
Matthieu
