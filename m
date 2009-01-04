From: demerphq <demerphq@gmail.com>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 13:31:50 +0100
Message-ID: <9b18b3110901040431j5c318007kcec4694446434764@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <1baa801f0901040207r64195594m64359dbc60a5f662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git mailing list" <git@vger.kernel.org>
To: "Alexandre Dulaunoy" <adulau@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 13:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJSAL-0007mx-QS
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 13:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbZADMbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 07:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbZADMbx
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 07:31:53 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:17405 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbZADMbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 07:31:52 -0500
Received: by qw-out-2122.google.com with SMTP id 3so6014800qwe.37
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 04:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EDB+VDPA8+UTnZtpWz2tCDUexIAXnOgICTP4UrmybYQ=;
        b=rI+bPRPi/8rF2GEMgMH6iqSn5GKCZZkaJ1NwOukk0jW2r6uWGKe3ZbNg0nl3d95TUn
         c42gtSUfxtau+A4b90QsIz3Ne46fvlYWHW0shFpe/LdKSfSYs8kJcva0W7V8To1Wf9mb
         xDwsjGmCd+46RkFRS4vpb3AD7Caas/pVFwhpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HjixJ/joBYAiCDh8Vul1kKOqjEg1dU1FgohVdRapP2N18QjH4CwXv5GGNWhU5092HN
         fSMi+HyOj3j0fYwI/5RID2E/cdhMPZ7rVsk6Bnf7e9wb1sRfbI1GymdJ1F23dX55CYbm
         //c3cZVi+kq/+LdvvxCvyFAnKhZPpr1sF9oTo=
Received: by 10.214.60.1 with SMTP id i1mr15787050qaa.286.1231072310576;
        Sun, 04 Jan 2009 04:31:50 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sun, 4 Jan 2009 04:31:50 -0800 (PST)
In-Reply-To: <1baa801f0901040207r64195594m64359dbc60a5f662@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104510>

2009/1/4 Alexandre Dulaunoy <adulau@gmail.com>:
> On Fri, Jan 2, 2009 at 4:28 AM, Karl Chen <quarl@cs.berkeley.edu> wrote:
>>
>> How about an option to git-branch that just prints the name of the
>> current branch for scripts' sake?  To replace:
>>
>>    git branch --no-color 2>/dev/null | perl -ne '/^[*] (.*)/ && print $1'
>
> I tend to support your request especially that extracting the current
> branch is something that is done regularly. Looking in my own scripts/aliases
> and some of my colleagues, there are plenty of variation using Perl,
> sed, awk, tr
> and Python to extract the current branch.
>
> Using git-symbolic-ref is not obvious, especially that the summary/name
>  of the man page is :
>
> "git-symbolic-ref - Read and modify symbolic refs"
>
> But the description is pretty clear :
>
> "Given one argument, reads which branch head the given symbolic ref refers to
> and outputs its path, relative to the .git/ directory. Typically you
> would give HEAD
> as the <name> argument to see on which branch your working tree is on."
>
> But naturally, as a lazy user, you will pick git-branch especially
> that's the tools is listed
> with the most commonly used git commands with a very attractive description :

I dont think it has to do with lazyness. It has to do with the fact
that parsing git branch gives you a branch name that you can use an an
argument to many other git commands. Whereas git-symbolic-ref doesnt.
It requires additional post-processing that unless you are very git
aware is not at all clear. Like for instance in this thread the
recommendation is to use sed like this:

  git symbolic-ref HEAD|sed s,refs/heads/,,

however, that makes me think "how do i do that on a windows box? does
the presence of git on a  windows box mean that they will necessarily
have sed available? Can i rely on that? Can i rely on the sed rule
being sufficient? And what happens with this command if im not on a
branch at all? Well it turns out that git symbolic-ref HEAD *dies*
with a fatal error on this command.  SO it probably should be:

  git symbolic-ref HEAD 2>/dev/null|sed s,refs/heads/,,

but now its even less portable. Even if sed is available on windows
/dev/null isnt.

Id very much like a proper way to find the usable form of the branch
name as it would make a lot of thing easier. In particular requiring
people use pipes means that there is a portability issue with scripts.
How does one make this happen on a windows box for instance?

Id also very much like a way to find the "upstream" for a branch. IOW,
id very much like to know where I will push to if i issue a "git push"
command, or what i will merge if i do a git pull. There doesnt seem to
be an easy way to find this out currently. And its very useful
information.

Im coming from the point of view of someone trying to make the perl
build process a bit more "git aware". Unfortunately Perl has to build
out of the box on so many platforms that unix-centric tricks like huge
command pipes arent very helpful. They immediately fall down when you
start dealing with oddball platforms like Windows and VMS.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
