From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 06 May 2012 12:39:50 +0200
Message-ID: <vpqtxztlhjd.fsf@bauges.imag.fr>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<201205061221.29592.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 12:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQyt4-0007ZV-Br
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab2EFKkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 06:40:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45902 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab2EFKkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 06:40:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q46AWnR5026905
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2012 12:32:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SQysZ-00086W-HI; Sun, 06 May 2012 12:39:51 +0200
In-Reply-To: <201205061221.29592.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 6 May 2012 12:21:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 May 2012 12:32:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q46AWnR5026905
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336905172.5822@4uTW/lPmMUjPwuVhPSiOXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197165>

Jakub Narebski <jnareb@gmail.com> writes:

> Actually Git porcelain does use 'the index' as a cache (computing),
> i.e. as a place to store redundant information (stat data, sha-1
> for trees with DIRC dircache extension) for faster access.

This is an implementation optimization, that is not supposed to be
visible for the user. Commands refering to the "cache" are not about
stat data cache (e.g. "git diff --cached" is really about the content,
not the stat cache).

>> index: an 'index' is a guide of pointers to something else; a book
>> index has a list of entries so the reader can locate information
>> easily without having to go through the whole book. Git porcelain is
>> not using the staging area to find out entries quicker; it's not an
>> index.
>
> Actually 'the index' is index in that sense; it stores _references_
> from filename to file contents, using SHA-1 identifier of a file/tree 
> contents in place of page number in the book index.  The SHA-1 
> identifier of object which is stored in database of repository, not the 
> index itself.

The implementation is done like this, but the user doesn't really care
about this. For example, git-add(1) says "The index holds a snapshot
of the content of the working tree", not "The index holds a set of
references to sha1sums".

There's no need to expose these two implementation details in the
terminology used in the interface. Indeed, I've often seen people from
other VCS confused by Git's index just because of the terminology.
Because we sometimes call it "cache", they think it is basically a
stat-cache, and wonder why it is shown to the user. I've even seen
Git users think that others VCS didn't have a stat-cache because they
had read that the "cache" was a unique Git feature.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
