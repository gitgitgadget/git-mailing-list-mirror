From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: Test that every revision builds before pushing changes?
Date: Fri, 27 Mar 2009 12:30:07 +1100
Organization: I know I put it down here, somewhere.
Message-ID: <8763hviwgw.fsf@rimspace.net>
References: <87myb8aja1.fsf@rimspace.net> <49CB39E5.5060000@op5.se>
	<87ljqs7ioz.fsf@rimspace.net> <49CB4ED8.4060205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 02:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln1GY-00083t-HH
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 02:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759221AbZC0BwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 21:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934062AbZC0BwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 21:52:09 -0400
Received: from main.gmane.org ([80.91.229.2]:60234 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933866AbZC0BwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 21:52:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ln1Eq-0007oc-2t
	for git@vger.kernel.org; Fri, 27 Mar 2009 01:52:04 +0000
Received: from sdcarl02.strategicdata.com.au ([203.214.67.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 01:52:04 +0000
Received: from daniel by sdcarl02.strategicdata.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 01:52:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sdcarl02.strategicdata.com.au
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:THMDmn1T1mRiCjJHL/XEM/YDnsg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114838>

Andreas Ericsson <ae@op5.se> writes:
> Daniel Pittman wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>> Daniel Pittman wrote:
>>>> I would like to ensure that my commits are fully bisectable before=
 I
>>>> commit them to an upstream repository, at least to the limits of a=
n
>>>> automatic tool for testing them.

[...]

>>> The manual step comes at merge-time; Someone has to be responsible =
for
>>> merging all the topics that are to be included in the release branc=
h
>>> and make sure it builds and passes all tests after each merge.
>>
>> Ah.  You have not quite grasped what I was looking for: I was after =
a
>> tool to help automate that step, rather than a workflow around it.
>
> Oh right. Sorry, I'm stuck in continuous-integration land where peopl=
e
> tend to want the server to take care of such things.

We have that also; I am primarily motivated by avoiding trivial breakag=
e
in the CI server, as well as bisection.

>> For example, the responsible person for that testing could use the
>> hypothetical (until someone tells me where to find it):
>>
>>     git test public..test make test

[...]

> Something like this?
> --%<--%<--
> #!/bin/sh
>
> git stash
> revspec=3D"$1"
> shift
> for rev in $(git rev-list "$revspec"); do
> 	git checkout $rev
> 	"$@" || break
> done
> --%<--%<--
>
> Run it as such:
> ./git-test.sh public..test make test

Thank you, that points me in the right direction, and I can obviously
season the rest of it to taste =E2=80=94 reverse that revision list, fo=
r
example.

Thank you also to Wincent Colaiuta, who provided a similar script albie=
t
with significantly more detail.

[...]

> It doesn't handle merges very nicely, btw, but I guess this should be
> run prior to merging anyways.

Once I have the framework I can quietly work my way through fixing nast=
y
issues one way or another.  Thanks.

Regards,
        Daniel
