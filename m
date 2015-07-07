From: John Keeping <john@keeping.me.uk>
Subject: Re: undocumented core.sharedRepository=2 set by git init
 --shared=world
Date: Tue, 7 Jul 2015 12:52:05 +0100
Message-ID: <20150707115205.GD18226@serenity.lan>
References: <20150706192547.GA15396@kitenet.net>
 <b9f56a351da062698ad629d77d3752b7@www.dscho.org>
 <20150707091044.GC18226@serenity.lan>
 <b1139f60dde3533e12d13e4b0f6584f2@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <id@joeyh.name>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 13:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCRQG-0005Km-SU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 13:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbbGGLwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 07:52:21 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34092 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756857AbbGGLwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 07:52:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id EA013866022;
	Tue,  7 Jul 2015 12:52:18 +0100 (BST)
X-Quarantine-ID: <4L1dHyR79A7t>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4L1dHyR79A7t; Tue,  7 Jul 2015 12:52:17 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 03F05866029;
	Tue,  7 Jul 2015 12:52:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <b1139f60dde3533e12d13e4b0f6584f2@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273497>

On Tue, Jul 07, 2015 at 01:32:13PM +0200, Johannes Schindelin wrote:
> Hi John,
> 
> On 2015-07-07 11:10, John Keeping wrote:
> > On Tue, Jul 07, 2015 at 10:14:28AM +0200, Johannes Schindelin wrote:
> >> Hi Joey,
> >>
> >> On 2015-07-06 21:25, Joey Hess wrote:
> >> > joey@darkstar:~/tmp>git init --shared=world testrepo
> >> > Initialized empty shared Git repository in /home/joey/tmp/testrepo/.git/
> >> > joey@darkstar:~/tmp>grep shared testrepo/.git/config
> >> > 	sharedrepository = 2
> >> >
> >> > This magic value of 2 seems to be undocumented, as is the magic value of 1
> >> > that's equvilant to "group".
> >> >
> >> > I think it would be better to have git init put in "world" or "group" and not
> >> > these magic values. Anyway, I suppose they ought to be documented too.
> >>
> >> The rationale can be found here:
> >> https://github.com/git/git/blob/v2.4.5/builtin/init-db.c#L413-L418
> >>
> >> 		/* We do not spell "group" and such, so that
> >> 		 * the configuration can be read by older version
> >> 		 * of git. Note, we use octal numbers for new share modes,
> >> 		 * and compatibility values for PERM_GROUP and
> >> 		 * PERM_EVERYBODY.
> >> 		 */
> >>
> >> I am sympathetic to your wish, of course, and I am sure that you
> >> understand why we cannot simply break other people's setups to satisfy
> >> it.
> > 
> > That comment was added in 94df250 (shared repository: optionally allow
> > reading to "others"., 2006-06-09) which was in 1.4.1.  I suspect that is
> > now sufficiently old that it no longer matters.
> 
> I understand your point of view. With my maintainer hat on I have to
> say, though, that things like that require a major version change.
> Users tend to appreciate such a careful maintenance.

However, there has been a major version since the new syntax was
introduced (in the same commit mentioned above), so this only affects
users who initialize a repository with (say) 2.6.0 or later and then try
to use 1.4.0 or earlier to operate on it.

That means using two versions of Git released more than 9 years apart to
operate on the same repository.  IMHO even careful maintenance can
declare that an unsupported configuration.
