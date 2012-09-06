From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] git-merge: Honor pre-merge hook
Date: Thu, 06 Sep 2012 12:48:42 +0200
Message-ID: <50487F8A.4050803@alum.mit.edu>
References: <cover.1346851863.git.git@drmicha.warpmail.net> <dc8ebcd7f7b80ff930c04b5a407361ba8f2f077f.1346851863.git.git@drmicha.warpmail.net> <50476FFE.5070602@alum.mit.edu> <50485BD3.5020802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Zdm-0004Yb-2M
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 12:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637Ab2IFKsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 06:48:46 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:50171 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757399Ab2IFKsp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 06:48:45 -0400
X-AuditID: 1207440c-b7f616d00000270b-b1-50487f8c15bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F8.6D.09995.C8F78405; Thu,  6 Sep 2012 06:48:44 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86AmgFb022687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 06:48:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <50485BD3.5020802@drmicha.warpmail.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqNtT7xFgsGGLocWaF6eZLbqudDNZ
	NPReYXZg9midPInZ4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDM2HzvPWLBcrmLShpVMDYwz
	JboYOTkkBEwk/k3awQRhi0lcuLeerYuRi0NI4DKjxOYZ55kgnGNMEs8+TgKr4hXQljgycysr
	iM0ioCqx4MtHRhCbTUBXYlFPM1iNqECIxJpvUxgh6gUlTs58wgJiiwjoS1w79wSsl1nAWmJ3
	H0RcWMBC4u2Z9VDLrjFK3Fz+DizBCXTelHPvGSEadCTe9T1ghrDlJba/ncM8gVFgFpIds5CU
	zUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSPjy7GD8tk7mEKMA
	B6MSD++vfPcAIdbEsuLK3EOMkhxMSqK8x2s9AoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8NZX
	A+V4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8H+qAGgWLUtNTK9Iy
	c0oQ0kwcnCDDuaREilPzUlKLEktLMuJB0RpfDIxXkBQP0N6TIO28xQWJuUBRiNZTjLocdz+u
	uM8oxJKXn5cqJc7LDEw3QgIgRRmleXArYMnqFaM40MfCvPdARvEAEx3cpFdAS5iAlgSngC0p
	SURISTUwtoZorYz7zrS/LPdAzty/JU9Zd/e/6npSyua1e+bNrm1bhJzja9fcrIr4PdHNmeGx
	yn7piHvT9/xqadWqebgkTE1+Ypy94ttDt0PWVjXZGW0O/v3ZSm1S0/GZS3KEpjz/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204874>

On 09/06/2012 10:16 AM, Michael J Gruber wrote:
> Michael Haggerty venit, vidit, dixit 05.09.2012 17:30:
>> On 09/05/2012 03:39 PM, Michael J Gruber wrote:
>>> git-merge does not honor the pre-commit hook when doing automatic merge
>>> commits, and for compatibility reasons this is going to stay.
>>>
>>> Introduce a pre-merge hook which is called for an automatic merge commit
>>> just like pre-commit is called for a non-automatic merge commit (or any
>>> other commit).
>>
>> What exactly is an "automatic merge commit"?  Is it any merge that
>> doesn't have a conflict?  A merge that doesn't invoke the editor?  A
>> merge done as part of another operation (e.g., pull)?  I don't see the
>> term mentioned in the git-merge or githooks man pages.
>>
>> I think it would be good if you would define this term in the
>> documentation files that your patch touched, and perhaps in the githooks
>> section about "pre-commit" as well.
> 
> "git merge" can go three ways:
> 
> F: fast forward: no commit is created, only a ref is changed
> A: automatic: true merge (non-ff) without conflicts (i.e. chosen
> strategy can perform the merge); a new commit is created
> C: merge with conflicts: no commit is created but the index is prepared
> (partially) for a merge commit
> 
> In case F, no commit hook is run (talking only about pre-commit/pre-merge).
> 
> In case A, no commit is run so far but my patch proposes pre-merge to be
> run.
> 
> In case C, pre-commit (!) is run so far and after my patch.

Thanks for the explanation.  I hope you will explain this briefly in the
patch to the docs.

>> Secondly, though it is impossible (for backwards compatibility reasons)
>> for the pre-commit hook to be invoked for automatic merges, no such
>> considerations prohibit the pre-merge commit from being invoked for
>> non-automatic merges.  In other words, both hooks, pre-commit *and*
>> pre-merge, could be invoked for non-automatic merges.  Would this be
>> preferable?
>>
>> It depends on what pre-merge scripts are likely to be used for.  If they
>> will tend to be used for merge-specific actions, then it might be more
>> convenient for *all* merges to be vetted by them.  On the other hand, if
>> they tend to do the same actions as pre-commit hooks, then having
>> non-automatic merge commits go through both hooks would tend to be more
>> annoying than helpful.  Specifically, one of the scripts would probably
>> have to check whether the merge is a non-automatic merge, and if so do
>> nothing (i.e., letting the other script take care of it).  This would
>> also require an easy way for a script to determine whether a commit is a
>> non-automatic merge commit.
>>
>> Have you considered this?
> 
> Your second paragraph explains why I did it the way I did. One can
> easily have pre-merge call pre-commit, or have them be different. One
> can not easily have only pre-merge called for a non-automatic merge
> commit, but that is because of backward compatibility. The way *I* would
> like it is:
> 
> - call pre-merge for any non-ff merge commit (automatic or not)
> - call pre-commit for any non-merge commit (#parents <=1)
> 
> But that would break compatibility.
> 
> So I hope my patch is the best approximation to the above which keeps
> compatibility and is simple to handle in most situations.

I can understand your reasoning and won't object.  But before I shut up,
I will point out a third alternative that is arguably closer to your
"ideal":

- For non-merge commits, call pre-commit
- For automatic merge commits, call pre-merge
- For non-automatic merge commits:
  if pre-merge exists, call pre-merge (only)
  else if pre-commit exists, call pre-commit (for backwards comptibility)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
