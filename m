From: Sudarshan Wadkar <wadkar@gmail.com>
Subject: Re: Odd remote: error: packfile ./objects/pack/pack-FOO.pack cannot
 be accessed
Date: Fri, 6 Jan 2012 13:31:43 +0530
Message-ID: <CAOoYcj3frMhWt8K6HHBikSF1M_vJjSJ=-ML+yYA2E4MS=H=NkA@mail.gmail.com>
References: <CAOoYcj2pnNtK3RshcJFwiXK356cZz6M38-NG1_uORjknyhdAKQ@mail.gmail.com>
 <CAOoYcj0JO4q0GJRzuexQR6OAng2PdZX8gD7zNYNoOCmCCLqz4Q@mail.gmail.com> <20120103193349.GE20926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 06 09:02:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj4ky-0003mX-64
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 09:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2AFIC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 03:02:27 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:48634 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab2AFIC0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 03:02:26 -0500
Received: by werm1 with SMTP id m1so939630wer.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 00:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1agEEHaiPxMBj6cy3lcpzIPJO+z/5xZAv7w0CrFxJfs=;
        b=PdDnidP6xqWAokt1QtKLtPG+x/eNlniMk6b1yPB4GKj2VMqovuBuwq+X/aNTVxj/7P
         RTC5VMiDcLahI+eIJx010fduRLWHY+N6kc7qJFY8rTITxjqWWfcsQVouUWkSAEPbVpZ1
         UKpK3Hp3s6qOM0sAHi4g9MiWO+tMVLeiQ08wM=
Received: by 10.216.139.155 with SMTP id c27mr2498809wej.37.1325836944204;
 Fri, 06 Jan 2012 00:02:24 -0800 (PST)
Received: by 10.223.156.144 with HTTP; Fri, 6 Jan 2012 00:01:43 -0800 (PST)
In-Reply-To: <20120103193349.GE20926@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188015>

Peff,

Sorry for the delay in reply. Yes, it's the same pack. And if I do `ll
=2E/object/pack/ ` on remote I can see the pack with read perms for all=
=2E
However, I observed that the pack I am getting now, is different from
that in my previous email. I am not sure what caused it to change, as
I did lot of commits/push to the remote. I tested with some test
commits to see if it is caused by a particular branch, but the pack is
still the same. Also, previously, if I would push to the remote in
succession without committing anything, I would get "Everything up to
date". But now, it seems that post-receive hook is called second time
too, and I see the "error : packfile".

Here's a shell copy paste : http://pastie.org/3136111

$ git status
# On branch 0.0.4
nothing to commit (working directory clean)
$ git push ourCloud
Total 0 (delta 0), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
cannot be accessed
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: Successfully deployed master into /var/www/html/myProj-master
remote: HEAD is now at 85534ca Test remote error packfile 2
remote: Successfully deployed 0.0.4 into /var/www/html/myProj-0.0.4
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myProj
 + 85534ca...cff7a3a master -> master (forced update)
$ git push ourCloud
Total 0 (delta 0), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
cannot be accessed
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: Successfully deployed master into /var/www/html/myProj-master
remote: HEAD is now at 85534ca Test remote error packfile 2
remote: Successfully deployed 0.0.4 into /var/www/html/myProj-0.0.4
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myProj
 + 85534ca...cff7a3a master -> master (forced update)
$ vi README.txt #make changes
$ git commit -am 'Test error packfile 3'
 Test error packfile 3
 1 files changed, 0 insertions(+), 2 deletions(-)
$ git push ourCloud
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 294 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
cannot be accessed
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: Successfully deployed master into /var/www/html/myProj-master
remote: HEAD is now at a0e3f87 Test error packfile 3
remote: Successfully deployed 0.0.4 into /var/www/html/myProj-0.0.4
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myProj
   85534ca..a0e3f87  0.0.4 -> 0.0.4
 + 85534ca...cff7a3a master -> master (forced update)

$ ssh -p 7185 wadkar@192.168.1.177
##now on remote##
$ ll repo/bare/myProj/objects/pack/
total 672
-r--r--r-- 1 wadkar wadkar  47496 Jan  2 16:52
pack-ff7bb2bee430b314648c084970f6a6877b837a58.idx
-r--r--r-- 1 wadkar wadkar 634393 Jan  2 16:52
pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
$ logout
Connection to 192.168.1.177 closed.
##back to local##
$ git push ourCloud
Total 0 (delta 0), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
cannot be accessed
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: Successfully deployed master into /var/www/html/myProj-master
remote: HEAD is now at a0e3f87 Test error packfile 3
remote: Successfully deployed 0.0.4 into /var/www/html/myProj-0.0.4
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myProj
 + a0e3f87...cff7a3a master -> master (forced update)
$ git push ourCloud
Total 0 (delta 0), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
cannot be accessed
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: HEAD is now at cff7a3a Fix mapping action from keyword search t=
o API
remote: Successfully deployed master into /var/www/html/myProj-master
remote: HEAD is now at a0e3f87 Test error packfile 3
remote: Successfully deployed 0.0.4 into /var/www/html/myProj-0.0.4
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myProj
 + a0e3f87...cff7a3a master -> master (forced update)
$ ssh -p 7185 wadkar@192.168.1.177
##now on remote##
$ ll repo/bare/myProj/objects/pack/
total 672
-r--r--r-- 1 wadkar wadkar  47496 Jan  2 16:52
pack-ff7bb2bee430b314648c084970f6a6877b837a58.idx
-r--r--r-- 1 wadkar wadkar 634393 Jan  2 16:52
pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
$ logout
Connection to 192.168.1.177 closed.
##back to local##
$ git checkout master
Switched to branch 'master'
$ git status
# On branch master
nothing to commit (working directory clean)
$ echo 'Foo' >> README.txt
$ git push ourCloud
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 305 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack
cannot be accessed
remote: HEAD is now at b220238 Test error packfile 4 (master)
remote: HEAD is now at b220238 Test error packfile 4 (master)
remote: Successfully deployed master into /var/www/html/myProj-master
remote: HEAD is now at a0e3f87 Test error packfile 3
remote: Successfully deployed 0.0.4 into /var/www/html/myProj-0.0.4
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myProj
 + a0e3f87...b220238 master -> master (forced update)

$ ssh -p 7185 wadkar@192.168.1.177
##now on remote##
$ ll repo/bare/myProj/objects/pack/
total 672
-r--r--r-- 1 wadkar wadkar  47496 Jan  2 16:52
pack-ff7bb2bee430b314648c084970f6a6877b837a58.idx
-r--r--r-- 1 wadkar wadkar 634393 Jan  2 16:52
pack-ff7bb2bee430b314648c084970f6a6877b837a58.pack


-Sudarshan Wadkar

"Success is getting what you want. Happiness is wanting what you get."
- Dale Carnegie
"It's always our decision who we are"
- Robert Solomon in Waking Life
"The truth is the truth, so all you can do is live with it."
--Systematic Chaos



On Wed, Jan 4, 2012 at 1:03 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 02, 2012 at 02:48:22PM +0530, Sudarshan Wadkar wrote:
>
>> But when I push, I get this odd error from remote
>>
>> $ git push --verbose --mirror
>> ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
>> Pushing to ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.=
git
>> Counting objects: 5, done.
>> Delta compression using up to 4 threads.
>> Compressing objects: 100% (3/3), done.
>> Writing objects: 100% (3/3), 323 bytes, done.
>> Total 3 (delta 2), reused 0 (delta 0)
>> remote: error: packfile
>> ./objects/pack/pack-17900952dc824651db15369a341eec8d3e8f39d2.pack
>> cannot be accessed
>> remote: HEAD is now at 4d5a6f1 Investigate and report odd error
>> To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
>> =A0=A0 d066a2f..4d5a6f1=A0 master -> master
>
> Is it always the same pack? If so, have you tried looking in the
> objects/pack directory to make sure it's not a permissions problem?
>
> -Peff
