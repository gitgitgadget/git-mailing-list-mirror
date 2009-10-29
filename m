From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: date change of commit?
Date: Thu, 29 Oct 2009 17:43:39 +0100
Message-ID: <200910291743.53701.trast@student.ethz.ch>
References: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com> <e4a904790910290555n61bca296g3624c1aced50ed85@mail.gmail.com> <4AE9AAE7.2080404@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex K <spaceoutlet@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	<git@vger.kernel.org>
To: Rogan Dawes <rogan@dawes.za.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Y7V-0007gC-DL
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbZJ2Qoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZJ2Qoy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:44:54 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:15562 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbZJ2Qoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:44:54 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 29 Oct
 2009 17:44:56 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 29 Oct
 2009 17:44:36 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4AE9AAE7.2080404@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131614>

Rogan Dawes wrote:
> Alex K wrote:
> > And how do you actually set those variables? Sorry to ask such a
> > trivial question but it's been an hour that i'm going through the doc
> > for such a simple feature. I thought those were environment variables
> 
> As you suspected, they are environment variables.
> 
> i.e. :
> 
> $ GIT_AUTHOR_DATE="1112911993 -0700" git commit x

Since this was in the context of git-filter-branch, I should point out
that you'll have to use the variables with --env-filter and (like the
manpage says) make sure you export them.

So to change the date of a single commit with SHA1 <sha1>, you could
say

git filter-branch --env-filter '
  if [ $GIT_COMMIT = <sha1> ]; then
    export GIT_AUTHOR_DATE="1112911993 -0700"
    export GIT_COMMITTER_DATE="1112911993 -0700"
  fi
' <other_arguments>

Alex K wrote:
> for such a simple feature

I'm not sure if you're referring to setting the variables or actually
rewriting the commits here, but anyway:

The reason why the latter is so hard is that rewriting "old" history
is a _huge_ hassle for people who already have the previous version of
that history.

That being said, _why_?  The dates are never a guarantee that
something happened earlier or later precisely because they can easily
be modified at commit time.  So nobody should take them as more than a
hint, and there's little use in faking hints.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
