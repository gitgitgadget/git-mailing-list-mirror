From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: New to git
Date: Sun, 10 Apr 2011 00:41:05 +0200
Message-ID: <vpqy63joxoe.fsf@bauges.imag.fr>
References: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
	<20110408201024.GA15964@sigill.intra.peff.net>
	<BANLkTikCF7Kv2xVYmr3O_P2t1TAzEFxXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marco Maggesi <marco.maggesi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 00:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gqE-0001Wl-Ay
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab1DIWlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 18:41:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33411 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424Ab1DIWlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:41:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p39Mf3ZK025788
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Apr 2011 00:41:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q8gq1-0000BK-LM; Sun, 10 Apr 2011 00:41:05 +0200
In-Reply-To: <BANLkTikCF7Kv2xVYmr3O_P2t1TAzEFxXiA@mail.gmail.com> (Marco
	Maggesi's message of "Sat, 9 Apr 2011 21:15:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 10 Apr 2011 00:41:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p39Mf3ZK025788
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1302993663.87028@iJqy0H1a/VqE3f2Qk/kV/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171210>

Marco Maggesi <marco.maggesi@gmail.com> writes:

> Hi Chris and Peff,
>
> 2011/4/8 Jeff King <peff@peff.net>:
>> But if you are just using the server as a distribution point for a
>> single repository, it can be much simpler. For example, if you alway=
s
>> just want to push and overwrite what is on the server (i.e., like a
>> mirror), you can just use plain rsync outside of git. To avoid mirro=
r
>> lag, you do want to update the objects before the refs. So this:
>>
>> =A0LOCAL=3D/path/to/repo.git
>> =A0REMOTE=3Dserver:path/to/repo.git
>> =A0rsync -a $LOCAL/objects/ $REMOTE/objects/
>> =A0rsync -a $LOCAL $REMOTE
>>
>> would work. And then expose repo.git on the server via http or ftp, =
and
>> clients can clone directly from it.
>
> this is the solution I was looking for (but I where not sure that it
> worked).

It works, but "git push" does something that rsync can't: it will refus=
e
non-fast forward, i.e. refuse to override commits that you don't have
locally.

So, I'll just insist on the "if you are just using the server as a
distribution point" part. If you ever push from two different machines
to the server with rsync, you'll take the risk of loosing data.

If the server runs an HTTP server, an alternative is to push over
WebDAV, it doesn't require Git on the server. It's slow, but safer than
rsync.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
