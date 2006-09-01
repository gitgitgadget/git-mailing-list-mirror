From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Joining a fixed archive with its continuation
Date: Fri, 01 Sep 2006 13:56:21 +0200
Organization: ARCES - =?ISO-8859-15?Q?Universit=E0_di_Bologna?=
Message-ID: <44F81FE5.1040509@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 01 13:56:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ7dM-000267-V1
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 13:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWIAL40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 07:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIAL40
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 07:56:26 -0400
Received: from arces.unibo.it ([137.204.143.6]:62422 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S1751064AbWIAL4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 07:56:24 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k81CAD8e020274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Sep 2006 14:10:15 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_50,USER_IN_WHITELIST 
	autolearn=unavailable version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1783/Thu Aug 31 22:56:17 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26299>

Hi,

I am trying to follow Johannes (Dscho) suggestions to join a fixed
archive with a new archive, that is its continuation from the latest
working tree.
I am having some trouble with rebase, and any help would be appreciated.
>
> You can "graft" the new onto the old branch:
>   
Yes, grafts are fine... however, if I am to use push/pull for
transferring data between two computers I am working on, I'd like better
a "history rewriting" approach, so that I do not need to manually copy
the grafts.

> NOTE! This is the quickest way if you want to have the history _locally_.
>
> If you want to be able to distribute it (or synchronize it between your 
> laptop and PC _with git!_), you can rewrite the history by either 
> git-rebase, or by using cg-admin-rewritehist if you are using cogito.
>
>   
I have tried using git-rebase (I do not have cg, at least not yet).
However I am encountering some problems...

Everything is fine with the master branch of my continuation archive doing

git rebase fixed-master master

(where fixed-master is the master head of the recovered archive)
This does the trick nicely. I.e. I start with

A---B---C---D    E---F---G---H---I


where D is fixed-master and I is master, and I end up with

A---B---C---D---E'---F'---G'---H'---I'

plus the older tree E---...---I

However I am then in trouble with the other branches of the continuation
archive, which I simply cannot get right...
In fact, E...I has actually a branch, say at G, like in

E---F---G---H---I
         \
          --M---N


And I cannot make an M'---N' based at G'... the best that I am
succeeding in is building an

E''--F''--G''--M'--N'


based on D.

> Ciao,
> Dscho
>
> P.S.: Of course, if you do not insist on a super clean history, you can 
> fake a merge. Just put <40-hex-chars-old> into .git/MERGE_HEAD and commit. 
> This will pretend that your new head and your old head were merged, and 
> the result is the new head. This _should_ even work with git-bisect, but 
> it is slightly ugly.

Before I try, can you better explain me what shall go on in this case?
The man page of commit actually does not say much about commit behavior
during a merge (i.e. with MERGE_HEAD set).

Thanks,

Sergio
