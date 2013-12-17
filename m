From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 13:47:24 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131217184724.GA17709@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
 <20131217145809.GC15010@thyrsus.com>
 <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vszg8-0005zF-In
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab3LQSr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:47:28 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34793
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332Ab3LQSr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:47:26 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id CEBD2380868; Tue, 17 Dec 2013 13:47:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239398>

Johan Herland <johan@herland.net>:
> However, I fear that you underestimate the number of users that want
> to use Git against CVS repos that are orders of magnitude larger (in
> both dimensions: #commits and #files) than your example repo.

You may be right. See below...

I'm working with Alan Barret now on trying to convert the NetBSD
repositories. They break cvs-fast-export through sheer bulk of
metadata, by running the machine out of core.  This is exactly
the kind of huge case that you're talking about.

Alan and I are going to take a good hard whack at modifying cvs-fast-export 
to make this work. Because there really aren't any feasible alternatives.
The analysis code in cvsps was never good enough. cvs2git, being written
in Python, would hit the core limit faster than anything written in C.

> Although a full-history converter with fairly stable output can be
> made to support this second problem for repos up to a certain size,
> there will probably still be users that want to work incrementally
> against much bigger repos, and I don't think _any_
> full-history-gone-incremental importer will be able to support the
> biggest repos.
> 
> Consequently I believe that for these big repos it is _impossible_ to
> get both fast incremental workflows and a high degree of (historical)
> correctness.
> 
> cvsps tried to be all of the above, and failed badly at the
> correctness criteria. Therefore I support your decision to "shoot it
> through the head". I certainly also support any work towards making a
> full-history converter work in an incremental manner, as it will be
> immensely useful for smaller CVS repos. But at the same time we should
> realize that it won't be a solution for incrementally working against
> _large_ CVS repos.

It is certainly the case that a sufficiently large CVS repo will break
anything, like a star with a mass over the Chandrasekhar limit becoming a 
black hole :-)

The question is how common such supermassive cases are. My own guess is that
the *BSD repos and a handful of the oldest GNU projects are pretty much the
whole set; everybody else converted to Subversion within the last decade. 
 
> Although it should have been made obvious a long time ago, the removal
> of cvsps has now made it abundantly clear that Git currently provides
> no way to support the incremental workflow against large CVS repos.
> Maybe that is ok, and we can ignore that, waiting for the few
> remaining large CVS repos to die? Or maybe we need a new effort to
> fill this niche? Something that is NOT based on a full-history
> converter, and does NOT try to guarantee a history-correct conversion,
> but that DOES try to guarantee fast and relatively worry-free two-way
> synchronization against a CVS server. Unfortunately (or fortunately,
> depending on POV) I have not had to touch CVS in a long while, and I
> don't see that changing soon, so it is not my itch to scratch.

Nor mine.  I find the very idea of writing anything that encourages
non-history-correct conversions disturbing and want no part of it.

Which matters, because right now the set of people working on CVS lifters
begins with me and ends with Michael Rafferty (cvs2git), who seems even
less interested in incremental conversion than I am.  Unless somebody
comes out of nowhere and wants to own that problem, it's not going
to get solved.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
