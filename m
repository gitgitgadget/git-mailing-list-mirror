From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 14:09:53 -0700 (PDT)
Message-ID: <655725.88869.qm@web31813.mail.mud.yahoo.com>
References: <200806031656.04780.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dmU-00022j-M2
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbYFCVJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYFCVJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:09:58 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:46738 "HELO
	web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751495AbYFCVJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 17:09:57 -0400
Received: (qmail 88965 invoked by uid 60001); 3 Jun 2008 21:09:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=gFKhAJ7V2eZOAZB1R1IcCtwhJqGoOLASQDlFIKessE8npNoDIrGtZ5Nhoh6WBcZi2ND9rRBihIx0wKOGIf18viwn56c66gCUmsyBmBhinYO9g2peNhUp0S9LJkNHJi9f3MeFJeX240sAVwkMVX3Akwp99YmpojJI9Rj/g00Dxpc=;
Received: from [99.159.44.58] by web31813.mail.mud.yahoo.com via HTTP; Tue, 03 Jun 2008 14:09:53 PDT
X-Mailer: YahooMailWebService/0.7.199
In-Reply-To: <200806031656.04780.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83711>

--- On Tue, 6/3/08, Jakub Narebski <jnareb@gmail.com> wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
> To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
> Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>, "Sam Vilain" <sam@vilain.net>
> Date: Tuesday, June 3, 2008, 7:56 AM
> Rafael Garcia-Suarez wrote:
> > 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
> >>> Shameless plug : the sources for perl 5 are
> currently being kept in a
> >>> perforce repository. There is a rough web
> interface to it at
> >>>
> http://public.activestate.com/cgi-bin/perlbrowse with
> excellent blame
> >>> log navigation features (including navigation
> against p4
> >>> integrations).
> >>
> >> By the way, what is the difference between
> '<<' links and 'br' link
> >> in the above mentioned annotate/blame interface?
> > 
> > "br" navigates to another branch from which
> this file has been
> > integrated (in p4 speak.)
> 
> Does it mark merge commits then? Or perhaps branch points? 
> What
> does "branch from which this file has been
> integrated" mean in git
> speak (in the terms of DAG of commits)?
> 
> 
> If the history of a file looks like this
> 
>        ....*---*---A---M---C...
>                       /
>            ....*---B-/               
> 
> and the line comes from "evil merge" M git-blame
> would return M as
> blamed commit.  If the line comes from one or the other
> branch, from
> commit A or B, it makes I think no difference to git-blame;
> git tries
> to be "branch agnostic" (no special meaning to
> first parent; well,
> besides rev~n notation and --first-parent walk option).  I
> guess it
> is not the case in Perforce?

The whole point of git_blame2() was to show which "previous" commit
changed that line/segment and what the commit message was.  This is
important to me when data-mining code evolution, since often enough
I'd like to recollect mine/other's intentions at the time of
changing/adding the code/commit in question.

> 
> [...]
> >> [...].  Will you want to use git-diff-tree
> >> to mark differences from the version we came from
> (marked by 'hp',
> >> 'hpb' and 'fp' URI parameters), or
> would you rather extend git-blame?
> > 
> > I don't know. I'll look at git-diff-tree.
> 
> What I meant here, would you plan on extending git-blame,
> or would you
> use patchset (textual) diff between revision we are at, and
> revision we
> came from.  git-diff-tree just compares two trees (and have
> to have
> patch output explicitely enabled).  Sorry for the
> confusion.

I'd rather stray away from "git-diff-xyz", since there is no context.
Context is found in the commit message which changed the line/segment.
(By "context" I mean the human intention, most likely encoded in the
commit message.)

Thanks everyone!
   Luben
