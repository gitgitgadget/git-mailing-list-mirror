From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How to make git diff-* ignore some patterns?
Date: Sat, 21 Nov 2009 19:07:38 +0100
Message-ID: <20091121180738.GA14919@atjola.homenet>
References: <4B0817EE.1040000@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:52:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBws4-00041R-Sq
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbZKUSHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2009 13:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756663AbZKUSHj
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 13:07:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:43498 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756699AbZKUSHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 13:07:37 -0500
Received: (qmail invoked by alias); 21 Nov 2009 18:07:42 -0000
Received: from i59F575EF.versanet.de (EHLO atjola.homenet) [89.245.117.239]
  by mail.gmx.net (mp011) with SMTP; 21 Nov 2009 19:07:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18iMooxpVkiZlE2XSnO9Twu9Sqb4B3qAEB66Vcp3H
	x/Gpwo/nGkOxTK
Content-Disposition: inline
In-Reply-To: <4B0817EE.1040000@dirk.my1.cc>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133405>

On 2009.11.21 17:40:14 +0100, Dirk S=FCsserott wrote:
> is there a way to tell "git diff-index" to ignore some special
> patterns, such that /^-- Dump completed on .*$/ is NOT recognized as
> a difference and "git diff-index" returns 0 if that's the only
> difference?

If you don't mind losing that line, you could use a clean filter via
=2Egitattributes:

echo '*.sql filter=3Dmysql_dump' >> .gitattributes
git config filter.mysql_dump.clean "sed -e '/^-- Dump completed on .*$/=
d'"

That way, git will filter all *.sql paths through that sed command
before storing them as blobs, dropping that "Dump completed" line from
the data stored in the repo.

Bj=F6rn
