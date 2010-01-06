From: Hakim Cassimally <hakim.cassimally@gmail.com>
Subject: Re: git-cherry-pick problem - directory not touched by commit is 
	marked "added by us"
Date: Wed, 6 Jan 2010 11:28:44 +0000
Message-ID: <82cfa8031001060328r21aa8de3s5c2dd5dac005b679@mail.gmail.com>
References: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
	 <1262727434.22597.8.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 12:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSU4K-0008GJ-En
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 12:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab0AFL2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 06:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755322Ab0AFL2r
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 06:28:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:13655 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab0AFL2q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 06:28:46 -0500
Received: by ey-out-2122.google.com with SMTP id 22so638567eye.19
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=OUjQzhDd0tGRaEaz+sEM4bJrWQaOhwMeosVfp5cUiC8=;
        b=pgRX5tXrtxeimovGUoZHeaubK9odvL3eb+sPDwYKctYKJDIF9qp3cmR3+6EjCor28d
         LFxE3PXOT+uwQ3jn8hJ6KmDGK2isiEsPFj4q+CDF+tg+vBqvOMXxXAOAxBhHT/QpxEyy
         jK3Qg3+LWilD93pF6Y9tvuMz+ZkDenhWeqNUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=w186/CrRsXjyVd++lwP9ITOu90oPHx23wgrbC6MspKdxHBBPFIybS2Xjnl7NZvXSMl
         Ac0XrB/BHQgM6i/XkUgH0RIACQ8gbFAo9+NQJ96UT5NaG8hvkhJZBkHl4MyFyUyBRiGq
         WBygnZjpqNLfLfmZ9E6g0qBbwxDg2o+IGOJu8=
Received: by 10.216.90.133 with SMTP id e5mr3337665wef.23.1262777324482; Wed, 
	06 Jan 2010 03:28:44 -0800 (PST)
In-Reply-To: <1262727434.22597.8.camel@denix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136259>

2010/1/5 Sam Vilain <sam@vilain.net>:
> On Tue, 2010-01-05 at 12:33 +0000, Hakim Cassimally wrote:
>> I got into a bit of trouble with a git-cherry-pick last night, and
>> though mugwump
>> and others on #git helped me as far as a workaround,
> Yes, that was me. =A0I'm very confused by the bug, too.
>
> =A0[...]
>> WHAT HAPPENS
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> When I'm in (stable), and try to cherry-pick the change from (experi=
mental),
>> git thinks that I'm making a massive number of changes in a director=
y that
>> wasn't touched by the relevant commit.
> =A0[...]
>> =A0 =A0 (stable) $ git --version
>> =A0 =A0 git version 1.6.6
>> =A0 =A0 # I tried previously on 1.6.0.4 but upgraded in case it help=
ed
>>
>> =A0 =A0 (stable) $ git status
>> =A0 =A0 # On branch stable
>> =A0 =A0 # nothing to commit (working directory clean)
>>
>> =A0 =A0 (stable) $ git show --stat 301afce1
>> =A0 =A0 commit 301afce1c78380276d208077ef4ec76b469c1024
>> =A0 =A0 Author: osfameron <...>
>> =A0 =A0 Date: =A0 Wed Dec 23 23:45:20 2009 +0000
>>
>> =A0 =A0 =A0 =A0 Proof of concept for import module (parse Excel)
>>
>> =A0 =A0 =A0bin/upload_module.pl | =A0142
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>> =A0 =A0 =A01 files changed, 142 insertions(+), 0 deletions(-)
>>
>> =A0 =A0 (stable) $ git whatchanged -1 301afce1
>> =A0 =A0 commit 301afce1c78380276d208077ef4ec76b469c1024
>> =A0 =A0 Author: osfameron <...>
>> =A0 =A0 Date: =A0 Wed Dec 23 23:45:20 2009 +0000
>>
>> =A0 =A0 =A0 =A0 Proof of concept for import module (parse Excel)
>>
>> =A0 =A0 :000000 100644 0000000... c90e261... A =A0bin/upload_module.=
pl
>
> So by here, we know that the commit only affects that single file. =A0=
No
> funny stuff like mode changes of other files.
>
>> =A0 =A0 (stable) $ git cherry-pick 301afce1
>> =A0 =A0 Finished one cherry-pick.
>> =A0 =A0 www/client/css/admin.css: needs merge
>> =A0 =A0 =A0 =A0 <...snip>
>> =A0 =A0 www/client/css/admin.css: unmerged
>> (8e7cd850bf40d1a921b1f62ce0945abd374fa55d)
>> =A0 =A0 =A0 =A0 <...snip>
>> =A0 =A0 ...
>> =A0 =A0 error: Error building trees
>
> Then, wham, these files want to be changed. =A0What is the diff-tree
> inside revert/cherry-pick doing differently to the one in log?

> Hakim, one more useful thing in this situation would be to show the
> state of these files in the index;
>
> =A0git ls-files -s -u

 $ git ls-files -s -u www/client/css/admin.css # only staged/unmerged
  100755 8e7cd850bf40d1a921b1f62ce0945abd374fa55d 2
www/client/css/admin.css

(i.e. when run after the failed cherry-pick)

> Also take the 'git ls-tree -r HEAD', 'git ls-tree -r 301afce1' and 'g=
it
> ls-tree -r 301afce1^' output, and grep for the files in question. =A0=
The
> answer (or at least a bug triage) should be in the output of those
> commands.

  $ git ls-tree HEAD | grep www/client/css/admin.css
  100755 blob 8e7cd850bf40d1a921b1f62ce0945abd374fa55d
www/client/css/admin.css

There's no entry in git ls-tree 301afce1 or 301afce1^1 though.  I'd
guess that's significant, but I don't know what answer it suggests...

(However the file exists in both (stable) and (experimental)...
and is identical in both).

> You can reproduce exactly the merge by making a new branch at the
> position where you were attempting to land the cherry pick before, an=
d
> checking that branch out.

I actually did

  $ cd ..
  $ git clone repo/ repo_backup_4Jan

beforehand, so this should also be an exact reproduction, I think?

> One last test, would be to check that it happens on a clean clone of =
the
> repository. =A0I don't think that you're hitting any repository-local
> behaviour (eg, the ability to mark certain files as "always ignore") =
but
> you never know. =A0These commands are all being run on the same worki=
ng
> copy, right?

And see above, should be an entirely clean clone.

Thanks for the suggestions!

Hakim / osfameron
