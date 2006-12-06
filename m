X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 10:51:18 +0530
Message-ID: <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 05:21:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YM997Goi45LwCJXADs3pnHGLt31wzlMjhm4JLuPVhuKyNpdWSc9g6NSF9CR/qeO/g8EWRLbA1G8SDwmQgv1Qt12Xpem2diFWEQHp9AFvGqlBfFjA+jBIDG1K3haqDF3JZJKuGNt1smhgfM6TD+T8Xgj976pTApn9ejcKaSADfYI=
In-Reply-To: <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33404>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrpDf-0005B5-SC for gcvg-git@gmane.org; Wed, 06 Dec
 2006 06:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760125AbWLFFVU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 00:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760131AbWLFFVU
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 00:21:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:14402 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760125AbWLFFVU (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 00:21:20 -0500
Received: by nf-out-0910.google.com with SMTP id o25so444604nfa for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 21:21:18 -0800 (PST)
Received: by 10.48.48.1 with SMTP id v1mr1689343nfv.1165382478542; Tue, 05
 Dec 2006 21:21:18 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Tue, 5 Dec 2006 21:21:18 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/6/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>
> > I have a git.git clone using --use-separate-remote. That means i have
> > the master branch created by default. Now i need to build git from the
> > pu branch too. So i created git branch pu remotes/origin/pu.
> >
> >
> > How how do i track the pu branch using git pull. What i mean is the
> > master local branch is tracked by default using git pull. Is there a
> > way to track the local pu branch too.
>
>         $ cat >.git/remotes/origin <<\EOF
>         URL: ...kernel.org/pub/scm/git/git.git
>         Pull: refs/heads/master:refs/remotes/origin/master
>         Pull: refs/heads/next:refs/remotes/origin/next
>         Pull: +refs/heads/pu:refs/remotes/origin/pu
>         EOF
>
> Then you would checkout 'pu' by having a matching local branch:
>
>         $ git branch pu remotes/origin/pu
>         $ git checkout pu ;# this is your refs/heads/pu
>         $ make
>
> Hacking on it can be done in this branch as usual.  When you are
> interested in the latest 'pu' from me:
>
>         $ git checkout pu ;# this is your refs/heads/pu
>         $ git fetch ;# most of the time git pull would also be fine...
>
> and then:
>
>         $ git rebase remotes/origin/pu
>
> The 'rebase' in the last step is because my 'pu' rewinds freely;
> otherwise you would do "git merge remotes/origin/pu" instead.
>


Okey what i was looking for was a .git/config that will imply as a
part of git pull origin that local

master is to track remotes/origin/master
pu  should track remotes/origin/pu.

I almost felt the branch.<name>.merge was for that.

What is this git-repo-config used for. I am trying to understand


branch.<name>.remote and branch.<name>.merge usage.

