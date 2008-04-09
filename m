From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git bisect on multiple cores
Date: Wed, 09 Apr 2008 10:07:25 +0200
Message-ID: <vpq63ure9j6.fsf@bauges.imag.fr>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
	<20080409071750.GA23211@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: A B <gentosaker@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 10:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjVN0-0002CV-4L
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 10:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYDIIIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 04:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbYDIIIj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 04:08:39 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:54313 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbYDIIIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 04:08:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m3987eSg016435;
	Wed, 9 Apr 2008 10:07:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JjVL3-0003Uz-UD; Wed, 09 Apr 2008 10:07:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JjVL3-0005MQ-Rl; Wed, 09 Apr 2008 10:07:25 +0200
In-Reply-To: <20080409071750.GA23211@diana.vm.bytemark.co.uk> ("Karl
 =?iso-8859-1?Q?Hasselstr=F6m=22's?= message of "Wed\, 9 Apr 2008 09\:17\:50
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 09 Apr 2008 10:07:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79086>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2008-04-08 12:58:47 +0200, A B wrote:
>
>> git bisect is really cool. I use it for the first time. Just a
>> thought, if you have a multiple core computer, can't you make git
>> build new versions in the background while testing the previuos
>> version? Alright, if you build 2 versions, one of them will never be
>> tested, but you will perhaps save some time by letting it build in
>> the background?
>
> Adding parallelism to a binary search scales very badly -- I'd say
> about logarithmically, but I haven't thought hard about it. If it's
> possible to use the extra cores to speed up the build+test cycle,
> that's vastly preferable.

Probably logarithmically with the number of cores. But for reasonable
machines, this number is relatively low, so the log is not so costly.
=46or a binary search, using just 2 cores, you can try the next in the
list in case of a "git bisect good" for example, and if the hypothesis
is true, you've just gained a factor 2 (assuming it happens 50% of
times, that should be a 50% speedup). Similarly, you should get a
factor 2 with 3 cores.

And as said before, you can also try trisection or N-section. But no,
I won't claim this is simple to implement ;-).

--=20
Matthieu
