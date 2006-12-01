X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stephan Feder <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 16:47:47 +0100
Message-ID: <45704EA3.40203@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org>
Reply-To: sf@b-i-t.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 15:51:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201145817.GY18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32938>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqAcp-0000QM-0l for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031336AbWLAPr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031267AbWLAPr7
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:47:59 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:55002 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1030905AbWLAPr5
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:47:57 -0500
Received: (qmail 3857 invoked by uid 1011); 1 Dec 2006 15:47:56 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.424848 secs); 01 Dec 2006 15:47:56 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 1 Dec 2006 15:47:55
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id C853423347; Fri,  1 Dec 2006 16:47:49
 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 02:51:49PM +0100, Stephan Feder wrote:
>> If you work in the supermodule, even if it is in the code of the
>> submodule, you only commit to the supermodule. The submodule does not
>> "know" about these changes after step 1.
> 
> I think we are using totally different definitions of "submodule".

No so different. The way I see it is that "I" (meaning with submodules 
implemented as I proposed) could pull regularly from "your" repositories 
(implemented as you proposed) and work with the result (including 
submodules). Could you do the same?

> For me a submodule is responsible for everything in or below a certain
> directory.  So by definition when you change something in this
> directory, you have to change it in the submodule.

But you do not consider the case where you cannot change the submodule 
because you do not own it.

For example, git has the subproject xdiff. If git had been able to work 
with subprojects as I envision, and if xdiff had been published as a git 
repository (not necessarily subproject enabled), it could have been 
pulled in git's subdirectory xdiff as a subproject. There would not have 
been a separate branch or even repository for xdiff in the git repository.

All changes to xdiff in git could have been committed to the git 
repository only. Independently, they could have been published to 
upstream and be put into the xdiff repository by its author. But the 
last part is what only the owner of the xdiff repository is able to decide.

(Ok, ok... the example sucks badly because xdiff has been massively 
changed for its usage in git so the changes would not be integrated by 
upstream. But you can imagine where you use a library essentially as is, 
only if you discover bugs you fix them immediately in your repository 
and keep those fixes in your version of the library, even on upgrade, 
until the bugs have been fixed by upstream.)

> You can't change the submodule contents in the supermodule without also
> changing the submodule.
> This is just like you can't commit a change to a file without also
> changing the file.

There is a difference. I would say: If you commit a change to a file in 
one branch, it need not be changed in all branches.

> Then the supermodule just records the current content of the entire
> tree.  The only new thing is that instead of simple files there are now
> submodules and that are also recorded.

Yes, and that is all you need. If the changes are to be part of a branch 
of the submodule, they have to be pulled. That is an independent operation.

>> Why do you mix up supermodule and submodule? The way I see your proposal 
>> you cannot change submodule and supermodule independently. That is a 
>> huge drawback.
> 
> No, this is the benefit you get by introducing submodules.
> Why would you want to introduce a submodule when it is not linked to the
> supermodule?

Because the submodule must be independent of the supermodule.

I see where you are coming from. You have one project that is divided 
into subprojects but the subprojects themselves are not independent.

What I would like to solve is the followng: You have a project X, an 
this project is made part of two other projects Y and Z (as a submodule 
or subproject or whatever you want to call it). The project X need not, 
must not or cannot care that it was made a subproject. But in projects Y 
and Z, you must be able to bugfix or extend or modify the code of 
projectX, and you must be able to push and pull changes between all 
three projects (of course we are only talking about the code part of 
project X).

Do you see where your solution makes that impossible, and that with more 
changes to the repository layout?

Regards

Stephan

