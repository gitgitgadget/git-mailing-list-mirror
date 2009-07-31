From: Allen Johnson <akjohnson78@gmail.com>
Subject: Re: merge confusion
Date: Fri, 31 Jul 2009 09:32:50 -0400
Message-ID: <6786ed4f0907310632t2435f7d9y9151febea7844ca@mail.gmail.com>
References: <24755682.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: thepurpleblob <howardsmiller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 15:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWsER-0004Sd-JE
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 15:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbZGaNcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 09:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZGaNcy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 09:32:54 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:57909 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbZGaNcx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 09:32:53 -0400
Received: by fxm17 with SMTP id 17so1369479fxm.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sc8LlYNwru2SrX8l9uOOq0LGHrU0YJ66PmwGRVxFD64=;
        b=SBpXVIsnSmcYg4vDAVNnvIXtyOZ93wMv62xYcCswdS0ezKfLqCy322+Xi8cWQlCaD6
         CYUq+B88oq3vejLg4W0dBIF9lb9Wn2ZaAU4Wc1it8CNtTdqrWV6iLzHMfXBaW8lh2sQt
         sb+V2vI1YwbqCN+gXW/qoqTm/KMCENWvCJf6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UZX2UlmUKhXfw+ouDfcA/elpYR58HgDzXEpAXeIj7GoJJcqeK526b81iy+f5Ox5EPs
         EMVGJWideRO4+vTPrgGbOH60wKkt1i+BVBwpPi1coHAqcq5qOTKF8IrtGFX56z1jI5N+
         5DA8zXIxfVE9cxY714vahAebzCDf7pT5LurLg=
Received: by 10.223.126.69 with SMTP id b5mr1487704fas.54.1249047170759; Fri, 
	31 Jul 2009 06:32:50 -0700 (PDT)
In-Reply-To: <24755682.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124562>

I think in this case you should do a `git fetch` instead. Doing a pull
is the same as performing a fetch and merge.

With a `fetch`, your remote branch is up-to-date while your tracking
branch is left untouched. You can later check the differences between
the two branches and merge when you're ready.

$ git fetch # update remote branch heads
$ git diff origin/branchname # show what is different between your
local branch and the remote
$ git merge origin/branchname # only when you're ready

=46or me, it's easier to keep my personal branches separate by using a
topic branch that doesn't track a remote branch. Then, optionally,
merge in differences from whatever remote tracking branches as needed.

$ git branch -t development origin/development # tracking remote
development branch
$ git checkout -b mystuff development # my personal stuff

Now a `git pull` won't affect `mystuff`.

Allen

On Fri, Jul 31, 2009 at 8:35 AM,
thepurpleblob<howardsmiller@googlemail.com> wrote:
>
> I had some unexpected behaviour doing a merge today. I wonder if anyb=
ody can
> tell me where I have gone wrong. This is the sequence...
>
> * clone a remote repo
> * created a local branch to track one of the remote branches
> * did work on the local branch and then created another 'feature' bra=
nch
> from that
> * time elapsed and at some point(s) I pulled from the remote but did =
not
> merge the original local branch
> * finished feature, checkout local branch and merge in feature.
>
> What I didn't expect is that all the subsequent changes on the tracke=
d
> remote branch got merged in too. Which I didn't want.
>
> So the question is - is that what's supposed to happen (ie. if you do=
 any
> merge the tracked branch 'fast forwards' the remote) and, if so, if I=
 want a
> branch that stays a branch (doesn't ever merge with the remote) how w=
ould I
> do that?
>
> Thanks!
> --
> View this message in context: http://www.nabble.com/merge-confusion-t=
p24755682p24755682.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
