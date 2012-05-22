From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 15:28:32 +0200
Message-ID: <4FBB9480.4010407@alum.mit.edu>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <20120521221417.GA22664@sigill.intra.peff.net> <20120521235219.GA5589@sigill.intra.peff.net> <4FBB0F21.5080608@alum.mit.edu> <20120522041123.GA9972@sigill.intra.peff.net> <4FBB3D2B.4010300@alum.mit.edu> <20120522073740.GA10093@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 15:28:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWp8j-0002KQ-MD
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 15:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab2EVN2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 09:28:37 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:55639 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754106Ab2EVN2e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 09:28:34 -0400
X-AuditID: 12074411-b7f596d000000932-e4-4fbb9482f21a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.6F.02354.2849BBF4; Tue, 22 May 2012 09:28:34 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4MDSWql009438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 May 2012 09:28:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120522073740.GA10093@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqNs0Zbe/wZ2/rBZdV7qZLBp6rzBb
	3H+/jsniR0sPswOLx+W+XiaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74/8Gz4Jj
	fBV7b61jamA8wd3FyMEhIWAicX2BahcjJ5ApJnHh3nq2LkYuDiGBy4wSq+7MZIFwjjNJzLu4
	gR2kildAW2Lnv5XMIM0sAqoSDzf4gYTZBHQlFvU0M4GERQXCJFY/0ICoFpQ4OfMJC4gtIiAr
	8f3wRkYQm1mgnVHi/F47EFtYwElixY+prBCrrjBJHH1yiAkkwSlgLXF29z0miAYzia6tXVDN
	8hLb385hnsAoMAvJjllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81
	pXQTIySUBXcwzjgpd4hRgINRiYfXsXKXvxBrYllxZe4hRkkOJiVRXq9Ju/2F+JLyUyozEosz
	4otKc1KLDzFKcDArifBuagMq501JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2Cycpw
	cChJ8G6eDDRUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSl8cXAOAVJ8QDtrQJp
	5y0uSMwFikK0nmLU5ZjxadE1RiGWvPy8VClx3r0gRQIgRRmleXArYInrFaM40MfCvCtAqniA
	SQ9u0iugJUxAS4Je7ARZUpKIkJJqYEwXyW8v0zvMELNvc03qMoN//Zm/5/xvkF0x+0Jn99KV
	m8o3a+qXd3hsWCXfOvW03Oag3ycW2/y+kFiroe68ZK1cX6bklZyzK1R8WhOY6/eF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198198>

On 05/22/2012 09:37 AM, Jeff King wrote:
> On Tue, May 22, 2012 at 09:15:55AM +0200, Michael Haggerty wrote:
>
>> If it is not too much trouble, please let me know where I can obtain
>> your test repo and what commands you used to get your result.  (Was
>> the local repo already a full clone of the remote, including all 400k
>> references?  How was the remote set up--sharing data or not, local or
>> remote?  Warm or cold disk cache?)
>
> I've put the repo up at:
>
>    https://gist.github.com/raw/2767328/603926240fabb4d3e3abc3c93a1913d91852cc7e/rails.tar.gz
>
> You can reproduce the slow-down with:
>
>    cd rails.git&&
>    git fetch . refs/*:refs/*
>
> which should be a no-op, as we already have all of the refs. I don't
> know if the problem is actually specific to fetch; that was just how I
> noticed it.
>
> When I try it with both 'next' and v1.7.10, I see that the latter is
> much faster.  I did my tests with a warm cache, but the interesting
> number is the CPU time, which is quite different.

I cannot reproduce anything as big as the performance regression that 
you see.  I did find a regression 9.5 s -> 10.1 s caused by

5fa044184 find_containing_dir(): use strbuf in implementation of this 
function

It is fixed by the patch that I just sent to the mailing list [1], which 
sizes the strbuf in that function to strlen(refname) instead of 
PATH_MAX.  Since your experiments suggest that the performance 
regression is related to the size of the repository contents, it could 
be that the same test produces more memory pressure on your system and 
therefore a larger effect.  Please try the patch and tell me if it fixes 
the problem for you.

[1] http://article.gmane.org/gmane.comp.version-control.git/198197

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
