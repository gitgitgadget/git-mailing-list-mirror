From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: Git completion not using ls-remote to auto-complete during push
Date: Thu, 18 Jun 2015 13:29:33 +0200
Message-ID: <1434626973-4801-1-git-send-email-szeder@ira.uka.de>
References: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Stefan=20N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:30:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Y1L-0007vQ-1B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbbFRLaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 07:30:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41074 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850AbbFRLaG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 07:30:06 -0400
Received: from x590cb72b.dyn.telefonica.de ([89.12.183.43] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Z5Y1C-0003n5-6n; Thu, 18 Jun 2015 13:30:03 +0200
X-Mailer: git-send-email 2.4.3.429.gcd1050e
In-Reply-To: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1434627003.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271997>

Quoting Robert Dailey <rcdailey.lists@gmail.com>
> I do the following:
>=20
> $ git push origin :topic
>=20
> If I stop halfway through typing 'topic' and hit TAB, auto-completion
> does not work if I do not have a local branch by that name (sometimes
> I delete my local branch first, then I push to delete it remotely). I
> thought that git completion code was supposed to use ls-remote to aut=
o
> complete refs used in push operations. Is this supposed to work?

It's intentional.  Running 'git ls-remote' with a far away remote can
take ages, so instead we grab the refs on the remote from the locally
stored refs under 'refs/remotes/<remote>/'.

See e832f5c096 (completion: avoid ls-remote in certain scenarios,
2013-05-28).  The commit message mentions that you can "force"
completion of remote refs via 'git ls-remote' by starting with the full
refname, i.e.  'refs/<TAB>', however, that seems to work only on the
left hand side of the colon in the push refspec.

G=C3=A1bor
