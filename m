From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git repository size vs. subversion repository size
Date: Sat, 5 Apr 2008 00:17:28 +0200
Message-ID: <20080404221728.GA30728@atjola.homenet>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sean Brown <seanmichaelbrown@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 00:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhuEY-0000FP-7o
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 00:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYDDWRP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYDDWRP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 18:17:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:37313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751711AbYDDWRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 18:17:15 -0400
Received: (qmail invoked by alias); 04 Apr 2008 22:17:13 -0000
Received: from i577BB809.versanet.de (EHLO atjola.local) [87.123.184.9]
  by mail.gmx.net (mp024) with SMTP; 05 Apr 2008 00:17:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX185VjwLnLA5pkavM1ui2FiGBnoeNNsd3MJf8m6VN+
	E2S9hPPsJMkW8p
Content-Disposition: inline
In-Reply-To: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78821>

On 2008.04.04 18:02:56 -0400, Sean Brown wrote:
> Last night I decided to see what storage size differences I might see
> between an svn repo and a git one.  So I imported a highly used
> subversion repository into git and was shocked to see how huge the gi=
t
> version was.  I used a repo that has a lot of branches and tagged
> releases just to make sure importing into git would in fact keep all
> of the history.  It did keep the history, but the total disk usage wa=
s
> very different:
>=20
> $subversionbox # du -hs ./my_sample_website/
> 67M	./my_sample_website
>=20
> $localhost # du -hs ./git-samplesite/
> 3.6GB ./git-samplesite/

How much of that is in the .git/svn directory? The contents of that
directory are used to map git commits to svn revision and git versions
before 1.5.4 had a quite space consuming file format for that. The new
format is a lot better. If you want to switch completely, you can even
just delete the .git/svn directory, as that's only required as long as
you want to interact with the corresponding svn repository.

And finally, you might want to repack to repository once after the
initial import, to get a smaller repo. Something like:
git repack -a -d -f --window=3D100 --depth=3D100

Bj=F6rn
