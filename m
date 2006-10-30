X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 17:43:43 -0800 (PST)
Message-ID: <811156.54327.qm@web31808.mail.mud.yahoo.com>
References: <7v3b972bzq.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 01:53:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=JkTmzcI8HgN3aHif0JkqDq+QoFnHaG1czQEj31eFpil3MLTjf8dKE5mpliBFHFFwpVfOfImpyY9QrwjnjDni1tMlbPEudqr/3MDPgjOl1s3G72PotNCBfYRNY0O2rkpxTCxtCRnrIHR0BNewPZOwVZypwUhn1xXQ+kggi87GbKg=  ;
X-YMail-OSG: 3yW4kioVM1mweRUwpaI.2dKRD0rMadWeJKDES7jkFPDWdO2Du9LC_dtSdsePIpYdZvr9CMtd3AiZQLmAuq1mWq_OsexeucCMK4OgePJ.JVdfDDsmyz1I2386WkbZCvoSBmyK_7ywh2n0FT.Cihrt9D.zg.SoEoqcCkCAfxVDD5YfUxYP3ODMQA9I
In-Reply-To: <7v3b972bzq.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30479>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeMBu-0002A9-Ag for gcvg-git@gmane.org; Mon, 30 Oct
 2006 02:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030480AbWJ3Bnp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 20:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWJ3Bnp
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 20:43:45 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:28806 "HELO
 web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1030480AbWJ3Bno (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006
 20:43:44 -0500
Received: (qmail 54330 invoked by uid 60001); 30 Oct 2006 01:43:43 -0000
Received: from [71.80.233.118] by web31808.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 17:43:43 PST
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Before answering 3 questions, I think we need to ask a bigger
> question.  What is the primary target audience of gitweb?
> 
> If it is for git-uninitiated, then staying as close to what GNU
> diff would give would be a better idea.  I would say we at least
> can assume that the user has some familiarity with SCM, and
> knows what kind of information is kept track of and is shown as
> differences between versions, and what files, directories and
> symlinks are, but not how git represents these.  On the other
> hand, if the user uses git to track a project (not necessarily
> the project the user is looking at with gitweb) and is familiar
> with the way git-diff presents these information, deviating from
> git-diff output is distractiing.

I agree.

gitweb's primary audience is the developers who type "git ..."
at shell prompt all the time.

> At least to me /-rw-rw-... part made me feel uneasy for that
> reason.

It made me feel uneasy to see it where it was because it
didn't belong there either way.

> WIth that in mind, I'll think aloud what I would like if I were
> not familiar with git:
> 
>  * "diff --git a/file b/file" would not use /dev/null but
>    ---/+++ does.  If the former is shown as link, it should be
>    visible which side is a link and which side is not for
>    creation or deletion diff; otherwise you would need a second

I'd argue otherwise: trying to click on /dev/null and failing
but succeeding on b/file has already taught something to the
uinitiated user.

OTOH, if one is trying to "click" on /dev/null in gitweb commitdiff
view -- they have other problems to resolve first...

>    to realize it is not a bug that clicking on a/file on the
>    "diff --git" line did not show anything for a creation diff.
> 
>  * I think showing object names in "index xxx..yyy mode" line is
>    not very useful to humans (they are added for tools).  I do

I like to see it because I might need to know the sha in order to
go back to shell prompt and do something with the object.  Instead
of having to git-ls-tree -r .... in order to find it from the sha
of the commitdiff.

>    agree that we would want some clickable handle in combined
>    diff output, but people not familiar with git would not know
>    that "index xxx,yyy..zzz" is where you would find the
>    parents, so that line needs to be munged anyway.

I think gitweb should first and foremost cater to git users.

>    Side note: Even though some git people (Luben, for example)
>    claim they recognize some abbreviated object names, I suspect
>    that are mostly recent commits and not blobs.

Yes, commit-8 for the day, blob-8 for less than a minute
which allows me to move the mouse pointer from to the xterm.

>  * Mode on the "index" line may be useful, but as you say 100644
>    is probably too git specific; however if our audience is
>    git-uninitiated, I doubt -rw-r--r-- is much better (it is
>    UNIXism, which I personally do not mind).  Spelling them out
>    like "regular file", "executable file", or "symbolic link"
>    might be more readable.

It would be more readable, but then it would be more readable.
Ideally I'd like it to be less readable, i.e. less to read.

>  * I think the filename quoting is better left as-is, since it
>    is a way to indicate something funny is going on. 

I agree.

   Luben
