From: Stephen Bash <bash@genarts.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 10:59:30 -0400 (EDT)
Message-ID: <6211a2de-a545-41c3-9fb5-e7e3033b45f4@mail>
References: <4FA3E31A.6060606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	git@vger.kernel.org, Rich Pixley <rich.pixley@palm.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 04 16:59:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQJz7-00076a-ES
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 16:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab2EDO7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 10:59:49 -0400
Received: from hq.genarts.com ([173.9.65.1]:41331 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000Ab2EDO7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 10:59:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 9FD66BE7E44;
	Fri,  4 May 2012 10:59:36 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgNgEnJTbSIQ; Fri,  4 May 2012 10:59:30 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B96D1BE7E43;
	Fri,  4 May 2012 10:59:30 -0400 (EDT)
In-Reply-To: <4FA3E31A.6060606@op5.se>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197026>

----- Original Message -----
> From: "Andreas Ericsson" <ae@op5.se>
> Sent: Friday, May 4, 2012 10:09:30 AM
> Subject: Re: Newbie grief
> 
> On 05/03/2012 08:58 PM, Rich Pixley wrote:
> > On 5/1/12 16:30 , Felipe Contreras wrote:
> > > Show all the hg commands of what you are trying to do, and we can
> > > show you how you can achieve the same in git, but much more
> > > easily.
> >
> > hg init foo
> > for i in `yes | head -4000`; do (set -x ; d=`date +%s.%N` ; hg
> > clone foo foo-$d; (cd foo-$d && date > bar && hg add bar && hg ci
> > -m $d)); done
> > for i in foo-*; do (set -x ; (cd $i && hg push -f)); done
>
> ... snip ... 
> 
> The hg recipe creates 4000 branches which I for some reason can't
> find the names of so I have no idea how to interact with them. The
> git recipe names them explicitly to foo-$i/master in the foo/ repo,
> since git doesn't allow pushing of commits without a ref.

If my hg-foo isn't too out of date...  The hg recipe creates 4000 "heads" on a single branch, rather than 4000 branches (see the 'hg heads' command).  This is basically the point Rich is arguing I believe.  hg allows for multiple tip commits all with the same branch name (IMO this is important because hg branch names are permanently recorded in their version of the commit object).

This is a *fundamental* difference in the implementation of the two tools (and causes confusion because now "branch" has two slightly different meanings).  However, IMHO, philosophically it all boils down to the same thing: development has forked and has to be merged.  Whether that fork has a name or not is up to the tool.  In hg it doesn't *have* to have a name (multiple heads per branch), in git it does (single head per branch).

I personally find Git's enforcement of naming a good thing: either the change I just made should be incorporated into the original branch, or there is a reason for it to stay separate.  In the latter case I should name it in a meaningful way so I (and other team members) remember why it is being kept separate (similar to why we use meaningful variable names).  In the former, I fetch and then merge or rebase as appropriate before pushing back upstream.

HTH,
Stephen
