X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stephan Feder <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 18:33:12 +0100
Message-ID: <45706758.2020907@b-i-t.de>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org> <45704EA3.40203@b-i-t.de> <20061201165418.GD18810@admingilde.org>
Reply-To: sf@b-i-t.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 17:34:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201165418.GD18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32949>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqCGz-0005TH-Cq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 18:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031664AbWLARdX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 12:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031663AbWLARdX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 12:33:23 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:21712 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1031664AbWLARdW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 12:33:22 -0500
Received: (qmail 17827 invoked by uid 1011); 1 Dec 2006 17:33:20 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.52828 secs); 01 Dec 2006 17:33:20 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 1 Dec 2006 17:33:20
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 6B14823347; Fri,  1 Dec 2006 18:33:14
 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 04:47:47PM +0100, Stephan Feder wrote:
>> No so different. The way I see it is that "I" (meaning with submodules 
>> implemented as I proposed) could pull regularly from "your" repositories 
>> (implemented as you proposed) and work with the result (including 
>> submodules). Could you do the same?
> 
> Sorry, but with all that many people proposing things I am a bit lost
> now.  Sometimes I thought you want exactly the same thing as I do,
> sometimes I think we are talking in totally different directions.

We are in agreement about two fundamental parts of the implementation 
and their meaning:

1. A submodule is stored as a commit id in a tree object.

2. Every object that is reachable from the submodule's commit are 
reachable from the supermodule's repository.

Please confirm.

We now argue about how to work with that repository _object_ model.

>> >For me a submodule is responsible for everything in or below a certain
>> >directory.  So by definition when you change something in this
>> >directory, you have to change it in the submodule.
>> 
>> But you do not consider the case where you cannot change the submodule 
>> because you do not own it.
> 
> I do not understand you here.
> The submodule is part of the supermodule, and the one who sets up the
> repository owns the whole thing, including all submodules, just like all
> the files which are part of the project.

If you mean by "owns the whole thing" what I stated above in 2. the we 
agree.

> If you mean the upstream repository of the submodule, then yes, this is
> of course completely separated from the submodule and may be owned by
> someone else.  Consequently, this upstream repository of course does not
> need to change when someone introduces changes in the supermodule.

I think we still agree.

>> For example, git has the subproject xdiff. If git had been able to work 
>> with subprojects as I envision, and if xdiff had been published as a git 
>> repository (not necessarily subproject enabled), it could have been 
>> pulled in git's subdirectory xdiff as a subproject.
> 
> This could have been done if submodule support would have been available
> at the time xdiff was introduced, yes.
> 
>> There would not have been a separate branch or even repository for
>> xdiff in the git repository.
> 
> What separate branch or repository are you talking about?

That's it: There is no need for a separate branch or repository. If you 
have the subproject's commit in the superproject's object database (and 
we really have that, see 1. and 2. above), why do you _have to_ store it 
elsewhere?

>> All changes to xdiff in git could have been committed to the git 
>> repository only.
> 
> Yes, but if it would have been integrated as a submodule it obviously
> would have been committed to the xdiff submodule inside the git
> repository.

No. The xdiff submodule would only exist as part of the git repository. 
You could, f.e., access the xdiff commit in git HEAD as HEAD:xdiff// 
(again my proposed syntax). HEAD:xdiff//~2:xemit.c would give you the 
grandparent of xemit.c in the xdiff submodule. And so on. You can even 
have submodules that have themselves submodules.

> So the changes are really part of the git repository, but you could go
> to the "git/xdiff" directory and only see the changes in the submodule,
> without the normal supermodule history.

See above.

>> Independently, they could have been published to upstream and be put
>> into the xdiff repository by its author.  But the last part is what
>> only the owner of the xdiff repository is able to decide.
> 
> Of course, everything still works like normal git repositories.

OK.

>> >You can't change the submodule contents in the supermodule without also
>> >changing the submodule.
>> >This is just like you can't commit a change to a file without also
>> >changing the file.
>> 
>> There is a difference. I would say: If you commit a change to a file in 
>> one branch, it need not be changed in all branches.
> 
> But you need to change _at_least_ one branch.
> Otherwise you cannot commit to a branch.

But only the supermodule's branch.

> So if you change something in a submodule, you have to change one branch
> in the submodule.

No.

> If you call git-checkout in the supermodule this will result in
> something like a git-reset in the submodule.

If you mean the submodule repository created by init-module I 
understand. But why create this "helper repository at all"?

>> >No, this is the benefit you get by introducing submodules.
>> >Why would you want to introduce a submodule when it is not linked to the
>> >supermodule?
>> 
>> Because the submodule must be independent of the supermodule.
>> 
>> I see where you are coming from. You have one project that is divided 
>> into subprojects but the subprojects themselves are not independent.
>> 
>> What I would like to solve is the followng: You have a project X, an 
>> this project is made part of two other projects Y and Z (as a submodule 
>> or subproject or whatever you want to call it). The project X need not, 
>> must not or cannot care that it was made a subproject. But in projects Y 
>> and Z, you must be able to bugfix or extend or modify the code of 
>> projectX, and you must be able to push and pull changes between all 
>> three projects (of course we are only talking about the code part of 
>> project X).
> 
> Of course.
> 
> So if you wanted to check out everything, you could have something like
> ~/src/X, ~/src/Y/X, and ~/src/Z/X.
> All of these would be GIT repositories, all of them have their
> independent branches.
> 
> What I am saying is just that if you update Y, and the new Y contains an
> updated version of X, then ~/src/Y/X/.git/refs/heads/master will be
> changed by the pull, resulting in the new version of X being checked out
> in ~/src/Y/X (alongside all the other updates inside ~/src/Y).
> This of course is independend from ~/src/X or  ~/src/Z/X.
> 
>> Do you see where your solution makes that impossible, and that with more 
>> changes to the repository layout?
> 
> No ;-)
> 

Sorry, have to leave for home so I must leave that uncommented. 
Hopefully I can join in during the weekend.

Regards

