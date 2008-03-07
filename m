From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] unquote_c_style: fix off-by-one.
Date: Fri, 7 Mar 2008 10:25:44 +0100
Message-ID: <20080307092544.GA22069@chistera.yi.org>
References: <20080306212819.GA10873@artemis.madism.org> <7vbq5ra4gu.fsf@gitster.siamese.dyndns.org> <20080307004401.GA13642@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 13:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXbd3-0008LI-4I
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 13:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYCGMYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 07:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYCGMYN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 07:24:13 -0500
Received: from gluck.debian.org ([192.25.206.10]:54885 "EHLO gluck.debian.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbYCGMYL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 07:24:11 -0500
Received: from localhost ([127.0.0.1] helo=chistera.yi.org)
	by gluck.debian.org with esmtp (Exim 4.50)
	id 1JXbPS-0005c2-ML; Fri, 07 Mar 2008 05:10:47 -0700
Received: from userid 1000 by plumber with local (Exim 4.69) 
	  id 1JXYpk-0005ku-40; Fri, 07 Mar 2008 10:25:44 +0100
Content-Disposition: inline
In-Reply-To: <20080307004401.GA13642@artemis.madism.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76485>

* Pierre Habouzit [Fri, 07 Mar 2008 01:44:01 +0100]:

> On Thu, Mar 06, 2008 at 10:10:41PM +0000, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:

> > > Thanks to Adeodato Sim=C3=B2 for having caught this.

> > > Signed-off-by: Pierre Habouzit <madcoder@debian.org>

> > Thanks.  I would have appreciated a comment that said something abo=
ut what
> > external breakages this one caused, so that we can have an entry in=
 "bugs
> > fixed" list.

> > A quick audit of the existing callers suggests that it is fast-impo=
rt.

Yes, it's fast-import. In particular, trying to rename a file whose nam=
e
contains spaces:

  R "file 1.txt" file 2.txt
                ^
                unquote_c_style() eats that space, thus fast-import
                fails with:

                fatal: Missing space after source: R "file 1.txt" file =
2.txt

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- In Italy, for 30 years under the Borgias they had warfare, terror,
  murder, bloodshed, but they produced Michelangelo, Leonardo da Vinci,
  and the Renaissance. In Switzerland they had brotherly love - they ha=
d
  500 years of democracy and peace, and what did that produce? The
  cuckoo clock.
                -- Harry Lime in =E2=80=9CThe Third Man=E2=80=9D

