From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 00:51:01 +0100
Message-ID: <vpqtyggk9i2.fsf@bauges.imag.fr>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102060104.37146.johan@herland.net>
	<vpqaai8oqkc.fsf@bauges.imag.fr>
	<201102070022.51403.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 00:54:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmEQl-0003Vl-8U
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 00:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab1BFXyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 18:54:06 -0500
Received: from imag.imag.fr ([129.88.30.1]:62307 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015Ab1BFXyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 18:54:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p16Np1r5008066
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Feb 2011 00:51:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmENh-000217-Ro; Mon, 07 Feb 2011 00:51:01 +0100
In-Reply-To: <201102070022.51403.johan@herland.net> (Johan Herland's message of "Mon\, 07 Feb 2011 00\:22\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 Feb 2011 00:51:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166215>

Johan Herland <johan@herland.net> writes:

>> For tags, it's clearly different. If I have origin/v1.7.4, I don't see
>> much reason to have _also_ v1.7.4 as a local tag. And if I have only
>> origin/v1.7.4 and push it as origin/v1.7.4, then someone pulling from
>> it will get origin/origin/v1.7.4, and so on.
>
> Wrong. If you have origin/v1.7.4, it's because v1.7.4 already exists in the 
> origin remote, so there's no point in trying to push it back. On the other 
> hand, if you have v1.7.4 locally (but not origin/v1.7.4), you should 
> (assuming this is intended to be a public tag) consider pushing it to the 
> "origin" remote, thus causing origin/v1.7.4 to appear in your repo.

(I made a bad choice by repeating "origin" several times)

What happens if I pull from "remoteA" and then push to "remoteB"?

With branches, I'd create a local "master" from remoteA/master, and
then push my local "master" as "master" on remoteB. People looking at
my repository remoteB won't notice where it's comming from because it
had to be local for me at some point.

With tags, we probably don't want to force people to explicitely
create local tags to be able to push them.

Take the example of the interim maintainer cited somewhere else in
this thread. If Shawn fetches from Junio, he'll get a junio/v1.7.4
tag, and on my side, I do not want to end up having
shawn/junio/v1.7.4, especially if this means that people fetching from
me would end up with a me/shawn/junio/v1.7.4 ...

> As Nicolas mentioned elsewhere in the thread, having separate tag namespaces 
> does not prevent us from also warning about ambiguous tag names on
> fetch. 

It does not "prevent", but I think it makes it a mis-feature. Distinct
namespaces (as opposed to warning/errors on duplicate at fetch time)
are useful when the same short name can refer to several things (like
v1.7.4 Vs gitgui-v1.7.4 (which doesn't exist yet), and then it's not
a problem to have twice the same short name.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
