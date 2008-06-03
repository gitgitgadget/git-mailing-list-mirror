From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 13:35:31 -0700 (PDT)
Message-ID: <940824.46903.qm@web31808.mail.mud.yahoo.com>
References: <b77c1dce0806030600x520d35edxbe6e732ce6cc4ad6@mail.gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dFA-000444-Cg
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYFCUfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYFCUfj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:35:39 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:33897 "HELO
	web31808.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752443AbYFCUfi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 16:35:38 -0400
Received: (qmail 47828 invoked by uid 60001); 3 Jun 2008 20:35:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=A4kGvtYThOr6Dj5IdThvttaHItEmECNuXPpD+IKo5yJg5mLuN/AlGjN+loVfjF4+iWK0LcA8zULEVk6ruwMadlB4S1Xt2V57WeWuLjZMevSL0LIliqq2JzVZEmSFcCANOkU6rjS1QiucTq5pw5GjPPZG4rxhiPg8X6bLahHcUEU=;
Received: from [99.159.44.58] by web31808.mail.mud.yahoo.com via HTTP; Tue, 03 Jun 2008 13:35:31 PDT
X-Mailer: YahooMailWebService/0.7.199
In-Reply-To: <b77c1dce0806030600x520d35edxbe6e732ce6cc4ad6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83706>

--- On Tue, 6/3/08, Rafael Garcia-Suarez <rgarciasuarez@gmail.com> wrote:
> From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
> Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
> To: "Jakub Narebski" <jnareb@gmail.com>
> Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
> Date: Tuesday, June 3, 2008, 6:00 AM
> 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
> >>> I'd rather remove this, correct it, or
> make it optional (this is very
> >>> fork-heavy).
> >>
> >> Not sure how to do the same thing in pure Perl.
> >
> > I was thinking about extending git-blame porcelain
> format (and also
> > incremental format, of course) by 'parents'
> (and perhaps
> > 'original-parents') header...
> 
> OK, I see. That would be nice. Also: currently taking
> "$full_rev^"
> directs the user to the parent commit, but it would be more
> user-friendly to point at the previous commit where the
> selected file
> was modified instead.

The intention was that it shouldn't necessarily be the (strict) parent
of the change (changed segment), since it may or may not have changed
in the strict parent commit.  The intention was that it "starts"/"opens"
the parent commit so that "git" would start from there and find the actual
change/commit where that line/segment has changed.  And it has worked
pretty fine for me when data-mining (something I do quite often) code
evolution.

My commit 244a70e608204a515c214a11c43f3ecf7642533a was really derived
from a command line, which I had started to use quite often and had
been "looking for" for quite some time.

> >> We could however cache the results of
> git-rev-parse, since the same
> >> rev is likely to appear many times in the list.
> >
> > ...but starting with cache of git-rev-parse results,
> or optionally
> > allowing extended sha-1 syntax (including
> <hash>^) in hash* CGI
> > parameters in gitweb would be a good idea.
> >
> > But as I wrote, I'm fine with the patch as it is
> now.
> 
> I've sent a new version (take 2) with caching. And
> comments, as Lea suggested :)

Yes, hashing is good if it speeds up lookups without altering
intended functionality.

Thanks everyone!
    Luben
