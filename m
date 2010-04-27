From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 21:38:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004272111540.5630@bbs.intern>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern> <4BD6ACEF.1040909@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 27 21:39:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qdT-0005gk-4w
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 21:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab0D0Tjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 15:39:54 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:37363
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab0D0Tjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 15:39:53 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3RJcV62010428;
	Tue, 27 Apr 2010 21:38:31 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3RJcQGM010415;
	Tue, 27 Apr 2010 21:38:26 +0200
In-Reply-To: <4BD6ACEF.1040909@op5.se>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3RJcV62010428
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.349, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.05, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145937>

On Tue, 27 Apr 2010, Andreas Ericsson wrote:

> On 04/27/2010 07:23 AM, Gerhard Wiesinger wrote:
>> Hello,
>>
>> I'm new to git and I'm looking for the following features:
>> 1.) Metadata for
>> a.) directory versioning (e.g. add/rm, mv)
>
> If you're talking about empty directories, that feature doesn't
> exist and I can't imagine why you'd want it to. If you'd care to
> explain why you want it, I'm sure we can find a different way of
> achieving your goal.

Git focuses on content but I think git should also focus on 
metadata. For example restructuring source code moves (git mv 
file1.c file2.c, git mv dir1 dir2) should be documented also in the 
repository like e.g. subversion and commercial SCM like clearcase do. 
Otherwise we are on "CVS" level.

Empty directories is a special case and sometimes you need just versioned 
empty directies.

>> b.) rights (basic: chmod, chow, chgrp, extended: extended attributes
>> like ACLs and selinux), necessary for versioning e.g. /etc
>
> Sounds like you want a backup-program. Some projects have been
> aimed towards this goal already. I'm sure google can provide
> more information. AFAIR, most of them work with two hook-scripts
> that update a regular file with the meta-data of all tracked
> files. This makes committing and checking out slower than it
> would otherwise be, but since it's doing more I suppose that's
> to be expected.
>
> Adding it to core git would mean re-designing git's basic data
> model, which is obviously not something we're about to do on
> a whim.

No, I'm NOT looking for a backup program. Every admin has the problem of 
versioning config files (for example /etc). Versioning of config files 
makes sense because one can track the changes and e.g. correlate to 
problems. A backup program doesn't have features like history, committer 
and comments on file changes. Therefore git would be a perfect tool also for 
versioning configuration. (Software development doesn't end with the build 
but typically also has deployment&configuration issues).

And when you think about a destroyed machine where you want to 
get your versioned configuration you also want to get the right 
permissions therefore. Otherwise you have for sure a security leak or a 
non working machine.

You can also think on machines where the same config should be used and 
tracked.

>> 2.) Original file dates (checkin date) on clone and pull (and not
>> checkout date)
>>
>
> I expect the solutions that work for 1b will also have this
> "feature", or that it will be easy to patch for it. For a
> source code management system though, this is a very bad
> idea indeed since it messes with the fundamental rules of
> building; A changed file must be rebuilt.
>
> Seeing as this would also require a major change in git's
> data model, this is another of those changes that I doubt
> will be supported in the git core in the foreseeable future.

I agree that a changed file must be rebuilt but in the normal "forward" 
cases that's also guaranteed with commit dates as they are "later". But 
when you get an old version you can't assume anything (e.g. dependencies 
have completly changed, even file structure) and therefore only a clean 
build (e.g. make clean) is IHMO valid.

I think git already has the commit date for the revision the user wants. 
Therefore only a call to "set_date_and_time" is necessary when a file 
is touched (e.g. by switch --use-commit-timestamps, environment variable 
or by config item). Therefor this should IHMO be easy to implement without 
any metadata changes.

Thnx.

Ciao,
Gerhard
