From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: A system administration use case for git
Date: Thu, 23 Apr 2009 12:38:09 +0200
Message-ID: <49F04511.3070601@viscovery.net>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com> <20090423095533.GE13989@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 12:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwwLM-0004rx-AU
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 12:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbZDWKiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbZDWKiN
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 06:38:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37766 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbZDWKiN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 06:38:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LwwJm-0007aJ-Tw; Thu, 23 Apr 2009 12:38:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5120F4E9; Thu, 23 Apr 2009 12:38:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090423095533.GE13989@pengutronix.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117329>

Uwe Kleine-K=F6nig schrieb:
> There is a practical problem though:  The filelist has to be sorted i=
n a
> way that is not provided by ls, so:
>=20
> 	ukleinek@cepheus:~/gsrc/linux-2.6/usr$ for f in $(ls -A); do printf =
"100644 %s\x00" $f; git hash-object $f | perl -n -e 'chomp; for $c (spl=
it(/(.{2})/)) { printf("%c", hex($c)) if $c }'; done | git hash-object =
-t tree -w --stdin
> 	a0a6efb3f1de956badc7607c7d372cc325a18846

Does ... $(LANG=3DC ls -A) ... make a difference for you?

But note that this is still not the whole story because, IIUC, in tree
objects directories are sorted as if they had a slash appended; i.e.
directory "foo" is sorted *after* file "foo.c", but *before* file "foo0=
".

-- Hannes
