From: Allen Johnson <akjohnson78@gmail.com>
Subject: Re: Newbie: Branch management
Date: Wed, 22 Jul 2009 23:15:10 -0400
Message-ID: <6786ed4f0907222015w709475e9ke76b52606ebafac9@mail.gmail.com>
References: <446739.83600.qm@web53410.mail.re2.yahoo.com>
	 <9586f3420907221445k2a8592d2ifacba57f3519f113@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dr. Jennifer Nussbaum" <bg271828@yahoo.com>, git@vger.kernel.org
To: Allan Kelly <allankelly@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTomK-0003Dk-9T
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbZGWDPO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 23:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZGWDPN
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:15:13 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38746 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZGWDPM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 23:15:12 -0400
Received: by fxm18 with SMTP id 18so568992fxm.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 20:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mgJB3SF2KCYYVdHgqvF8nvG5fCvfw+d5eksolM2IbSo=;
        b=u+aHTK48Dxe0oZOmLDvXTqKSVN72cftbl8HPSjUVH2NbaA/cAISCYz1nyuqfKQUod2
         Bho3O9nwn2s4ryhlon7HrLOig33jzIV+1Vc0rZi0ixDGUfoIBDSJmw8OEQaXQy5cK7h+
         sxJUW60TyG08aowV9/2sZfQ0/iFShevObqHcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yHqfidqvbbgZFfDhal22vaCLscKV1NgNNOZekmLlv0VIGEQ9StiZVKZmMxBpnF6djB
         yQAqjvPKsyi9Y2LaN04YrBD9wo7XPEpGEYngSxJrjEY8xSUGQ6di4A8Oij4AtNlVF9Hu
         C9rFIgwqhflbQ5Ua6IoylBb8n0Epczkkh6uIE=
Received: by 10.103.217.5 with SMTP id u5mr849187muq.78.1248318910475; Wed, 22 
	Jul 2009 20:15:10 -0700 (PDT)
In-Reply-To: <9586f3420907221445k2a8592d2ifacba57f3519f113@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123826>

This might work as well. I'm assuming all repositories were cloned
directly from your central (master) repository. Pushing with the
following option should work for you:

$ git push --all

Assuming we are on the laptop repository:

$ git checkout -b laptopstuff
$ ... edit and commits ...
$ git push --all

That will push everything on your laptop repo to the central
repository. Then next time you pull from any of the other repositories
that were cloned from the central repository you'll see a remote
tracking branch for laptopstuff.

Assuming we are on the workstation now:

$ git pull
$ git branch -r

You should now see origin/laptopstuff in the list.

Hope that helps.

Allen

On Wed, Jul 22, 2009 at 5:45 PM, Allan Kelly<allankelly@gmail.com> wrot=
e:
> Hi Jennifer,
>
> Like you I'm quite a new git user so I doubt I can entirely solve you=
r
> problem. However reading your mail, I recall my own initial confusion=
=2E
> Like you, I maintain a main server and various work desktops.
> Essentially I want my work status/environment replicated on-demand
> around these desktops, with the server as the synch-point. Sounds lik=
e
> you.
>
> My observation is that the granularity of git which makes it very
> malleable, is a problem when you want to do "broad brush" things like
> this (and this is the typical Unix "feature-not-a-bug!"). So, I think
> you need to write a few wee scripts as I have done.
>
> I've set up very small scripts to execute a sequence of local and
> ssh-based remote commands to sync things as I expect. For example,
> 'git add .;git commit -a -m "$MSG"; git push;' is fine but the files
> in the origin server directory are out of sync for subsequent
> processing & upload to the web site. This confused me a _lot_. So I
> need 'ssh server_name "cd $SERVER_DIR && git checkout -f"'. Now the
> server dir has the same content as my working dir.
>
> I always call this script 'publish' and have an appropriate version i=
n
> the root of each of my working repos (the post-git compile/upload
> stage differs). Then in vim I routinely execute ':./publish <project>
> <commit msg> <upload Y/N>' from wherever I'm working.
>
> If you want my (very simple!) 'publish' code then drop me a line. It
> may give you a start.
>
> HTH!
>
> Cheers, al.
>
> 2009/7/22 Dr. Jennifer Nussbaum <bg271828@yahoo.com>:
>>
>> Hi,
>>
>> I hope its OK to ask basic questions on this list.
>>
>> Im a recent convert to git and having trouble with branches. I mostl=
y work on projects by myself, and what I want is that all branches of e=
verything Im doing are in sync everywhere.
>>
>> I have a remote repository on my production server that serves as th=
e "main" repository. Then i work on projects on a number of different c=
omputers--my main home computer, my main work machine, several non-main=
 computers :-) ...
>>
>> I've found it very confusing dealing with branches in this environme=
nt. If I have my "master" branch, and decide that i want a "refactoring=
-templates" branch, what Id *like* to do is create that branch, work on=
 it, commit it, and when I say "git push" I want everything that's new =
on that computer to be synced to the "main" repository. And then when I=
 get to the next computer, I want to be able to say "git pull" and have=
 everything on that computer by synced *from* the "main" repository.
>>
>> Instead I get confused by having to push branches separately, and it=
's confusing that when I do a pull it doesnt necessarily get other bran=
ches unless I specify them directly, and so on.
>>
>> I've looked at the docs on branches and there's something i guess Im=
 missing because this still seems very difficult. Can someone giving me=
 advice on the best way to keep this kind of thing organized?
>>
>> Thanks!
>>
>> Jen
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
