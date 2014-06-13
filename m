From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Our merge bases sometimes suck
Date: Fri, 13 Jun 2014 12:13:50 +0200
Message-ID: <539ACEDE.8040401@alum.mit.edu>
References: <539A25BF.4060501@alum.mit.edu> <539AC690.6000906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 12:14:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOUg-00032J-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbaFMKNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:13:55 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:51740 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752082AbaFMKNy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:13:54 -0400
X-AuditID: 1207440d-f79c26d000000b51-01-539acee1093f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.80.02897.1EECA935; Fri, 13 Jun 2014 06:13:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB39AE.dip0.t-ipconnect.de [93.219.57.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5DADpKe001540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 Jun 2014 06:13:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <539AC690.6000906@drmicha.warpmail.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqPvw3Kxgg0+TlC3WvDjNbNF1pZvJ
	gcmjdfIkZo/Pm+QCmKK4bZISS8qCM9Pz9O0SuDMWLv3BXDDfuGLb1HWsDYznNLoYOTkkBEwk
	ju/aygphi0lcuLeerYuRi0NI4DKjxJymC8wQznkmiYmvNjGCVPEKaEtcX3IRrINFQFXi0dxT
	7CA2m4CuxKKeZiYQW1QgSGL253nsEPWCEidnPmEBsUUEkiW+ndgFFhcGmrPgxV+weiGBYInJ
	9yeD2ZxAFzU9ngpUzwF0kbhET2MQSJhZQEfiXd8DZghbXmL72znMExgFZiHZMAtJ2SwkZQsY
	mVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQq7w7G/+tkDjEKcDAq8fAG
	vJ8ZLMSaWFZcmXuIUZKDSUmUd/mhWcFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjvNQDleFMS
	K6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvPzAiBQSLEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB0VqfDEwVkFSPEB7JUHaeYsLEnOBohCtpxiNOU7dOdbGxHHi
	yck2JiGWvPy8VClx3v6zQKUCIKUZpXlwi2Ap6hWjONDfwrxPQap4gOkNbt4roFVMQKtuLgZb
	VZKIkJJqYCyXObtmQqOYzIz2fass9ayksydscn10hyt9QUME09G95qGb4/+0V7w+YCZ6JWS1
	JUMHf1hJbqL7Z7c/N4/dsHhlqnIu12XOpntvFX97z5V4LhHgdaH2Sv7d7dp/fk5k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251537>

On 06/13/2014 11:38 AM, Michael J Gruber wrote:
> Michael Haggerty venit, vidit, dixit 13.06.2014 00:12:
>> I've been thinking a lot about merge bases lately and think I have
>> discovered something interesting.
>>
>> tl;dr:
>>
>> When two branches have multiple merge bases,
>>
>>     git merge-base $master $branch
>>
>> picks one merge base more or less arbitrarily.  Here I describe a
>> criterion for picking a "best" merge base.  When the best merge base
>> is used, the diff output by
>>
>>     git diff $master...$branch
>>
>> becomes shorter and simpler--sometimes dramatically so.  I have
>> quantified the improvement by analyzing historical merges from the Git
>> project (see attached image).  Best merge bases might also help reduce
>> conflicts when conducting merges.
>>
> 
> Everytime I looked at our merge base code, my head started spinning. So
> it's admirable you even started this endeavor :)

I haven't looked at the code :-)  My email came only out of reading docs
and experimenting.

> We use merge bases for several things:
> 
> - merging
> - resolving "A...B" rev notation (rev-list and friends), aka symmetric
> difference
> - left/right selection/annotation of commits (rev-list/log)
> - resolving "diff A...B", which may be a handy notation, but is horribly
> misleading because it is a very unsymmetric form of diff
> 
> Out of these four, you seemingly picked the one as pivoting example
> which is most different from any symmetric notion of "...". But in fact,
> "merging" is quite unsymmetric, too, because merging branch into master
> is quite different from the other way round.
> 
> This is certainly obvious to you, bit I thought I point it out for the
> convenience of other readers: You are after optimizing the merge base
> choice for an unsymmetric use case, which covers "diff A...B" as well as
> "merge B into A".
> 
> In these two cases, choosing different merge bases can lead to different
> results. The other two basically use all merge bases anyways.

Correct, the scope of my proposal is for cases when there are multiple
merge bases but one has to be selected.

> [...]
>> I propose that the best merge base is the merge base "candidate" that
>> minimizes the number of non-merge commits that are in
>>
>>     git rev-list --no-merges $candidate..$branch
>>
>> but are already in master:
>>
>>     git rev-list --no-merges $master
>>
>> Since a non-merge commit should embody a single logical change,
>> counting non-merge commits is in some sense counting changes [2].
>>
>> We can put this criterion in simpler form.  Because every candidate is
>> a merge-base,
>>
>>     git rev-list --no-merges $candidate..$branch
>>
>> necessarily includes *all* of the non-merge commits that are on branch
>> but not on master. 
> 
> This is actually true for every merge base candidate (i.e. every commit
> which is both on master and branch).
> 
> [These things are really much easier in set language, A..B being B
> \setminus A, being B intersected with the complement of A etc.]
> 
>> This is a fixed number of commits, the same for
>> every candidate.
> 
> "This" refers to "branch minus master" (commits on branch but not on
> master), which is defined indepently of candidate.
> 
>>  It *additionally* includes the commits that are on
>> master but not yet in branch.  This second number varies from one
>> candidate to another.
> 
> "master minus branch" is independent of candidate also.
> 
> The second number is rather those commits on candidate..branch which are
> not "branch minus master", i.e. "branch minus candidate" minus "branch
> minus master", which is "branch intersected with master minus
> candidate", i.e. those commits on candidate..branch which are also on
> master. [Again this is true for every merge base candidate, not just
> every merge base.]
> 
>>  So if we minimize the number of commits in this
>> output, is is the same as minimizing the number of unwanted commits.
> 
> Now I understand why this statement is true :)

Thanks for the translation to set notation.  It is indeed easier to work
with.

>> Therefore, to get the best merge base, all we have to do is pick the
>> merge base that minimizes
>>
>>     git rev-list --count --no-merges $candidate..$branch
>>
>> There can be ties, but in practice they are rare enough that it is
>> probably not worth worrying about them.
>>
>>
>> Symmetry; generalization to more than two branches
>> ==================================================
>>
>> Interestingly, minimizing the last criterion is the same as maximizing
>>
>>     git rev-list --count --no-merges $candidate
>>
>> because there is a fixed number of commits in
>>
>>     git rev-list --no-merges $branch
>>
>> , and each of those commits is in exactly one of the two counts above.
> 
> That's a cute observation, which in the example above is wrong on first
> glance, but true on second: Visually/subjectively, one easily misses
> commits B and C when counting "X..master", which is not just the commits
> "extending master beyond X", etc.
> 
>> This formulation shows that the best merge base for computing
>>
>>     git diff $master...$branch
>>
>> is also the best merge base for computing
>>
>>     git diff $branch...$master
>>
>> ; i.e., the best merge base is symmetric in its arguments.  It also
>> shows that the concept of "best merge base" can trivially be
>> generalized to more than two branches.
> 
> That symmetry is really surprising, but the argument is convincingly
> correct. Alas, that count back to the roots can be really expensive.

I mentioned the formulation

    git rev-list --count --no-merges $candidate

not because it is necessarily the most efficient way to find the best
merge base, but because it is theoretically useful.  For the
implementation, any of the formulations can be used, because they are
all equivalent.

> Given that the arguments in the previous argument show that everything
> applies to merge base candidates as well, not just merge bases, I'm
> wondering whether we can weave in the weighing (which one is best) with
> our existing merge base algorithm or maybe an alternative algorithm
> using generation numbers or such.
> [...]

That's an interesting idea.  I haven't looked at that code at all, so if
you want to get involved it would be awesome!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
