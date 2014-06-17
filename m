From: =?UTF-8?Q?Wojciech_Przyby=C5=82?= <przybylwojciech@gmail.com>
Subject: Re: Potential bug in git client
Date: Tue, 17 Jun 2014 10:38:11 +0100
Message-ID: <CAKY5LXzGo5CTTnVL86GduO-bXaqNPuBSj=K3jUu4Kz=g6HHFYw@mail.gmail.com>
References: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
	<53A0079B.1030602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:38:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwpqK-0007RE-Qn
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 11:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbaFQJiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 05:38:13 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:65102 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932656AbaFQJiM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 05:38:12 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so8506462qcv.10
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=BsY3jrq5h6eUOBiZULye58euec62sm+9v4ZvRlVFNzU=;
        b=arsMgU1Je0rHP7VnZ5gg3YujAhyuhGtpLZDPHER3QmEnx2RazOB1XgGaDX3vzTEor/
         0UUd9FVjgKZmoA4r9Gc/eeqKgKpvllH/1WFM12zO5JVA5JBjceGgZqQmuWVDBN2jBHCL
         NZDwupzLmV5aupTub+xXvWDJgtzYAkUbA0IFPwN18u0sPCzu4DUP6UrWd/5NI5sUDJJE
         ulah2aQXjIonD6tV6d62msrlhuYjRBjesOSbUPypr8loaqxm3fi1HOTLaDOMTwZNFdXK
         PndQgjmWFz18YmF93XxM8K1v1oNQSdFmrtMlHdY2EOC12evJwdH3j05TiV8wQBT4k7ND
         WwEg==
X-Received: by 10.140.85.166 with SMTP id n35mr31940800qgd.67.1402997891292;
 Tue, 17 Jun 2014 02:38:11 -0700 (PDT)
Received: by 10.229.149.196 with HTTP; Tue, 17 Jun 2014 02:38:11 -0700 (PDT)
In-Reply-To: <53A0079B.1030602@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251858>

Hi
Thanks, it's exactly what I was after.

BTW
Just looking at ubuntu packages (I was using 12.04LTS) and it looks
like in a recent LTS release (14.04LTS) they still have git version
1.9.1, and only on utopic ubuntu (the newest one) git is 2.0.0.
Anyway, it's probably good time to upgrade.

Many thanks for your reply.

Cheers
Wojciech

On 17 June 2014 10:17, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/11/2014 12:21 PM, Wojciech Przyby=C5=82 wrote:
>> When I was tagging, I think I might have discovered a git client bug=
=2E
>> [...]
>> HOW TO REPRODUCE:
>> - Clone a repo into 2 separate directories. Presume there is a tag
>> "v0.1" already in there and it is set on say 10 commits ago.
>>
>> - In first directory change the tag to a different place and push it
>> to the server:
>> git tag -d v0.1
>> git tag v0.1
>> git push --tags origin master
>>
>> - In second directory try to update the tag...
>> git pull --all --tags
>> git fetch -all --tags
>> THIS DOES NOT WORK, tag is still at old place, but it says "Already =
up-to-date".
>>
>> - I noticed when I use:
>> git fetch --tags
>> it works fine and updates the position of the tag, or if I remove ta=
g
>> from local git manually (rm .git/refs/tags/v0.1) and update again.
>>
>> Is it a bug or I am doing something wrong? I use git version 1.7.9.5=
=2E
>
> Tag fetching changed quite a bit in v1.9.0.  Here is a similar test
> using Git 2.0.0:
>
> $ git init main
> Initialized empty Git repository in /home/mhagger/tmp/tagexp/main/.gi=
t/
> $ cd main
> $ git commit --allow-empty -m Initial
> [master (root-commit) fdcd35b] Initial
> $ git tag t
> $ git commit --allow-empty -m Second
> [master 88f7d4a] Second
> $ cd ..
> $ git clone main clone1
> Cloning into 'clone1'...
> done.
> $ git clone main clone2
> Cloning into 'clone2'...
> done.
> $ cd clone1
> $ git tag -d t
> Deleted tag 't' (was fdcd35b)
> $ git tag t
> $ git push --tags origin master
> To /home/mhagger/tmp/tagexp/main
>  ! [rejected]        t -> t (already exists)
> error: failed to push some refs to '/home/mhagger/tmp/tagexp/main'
> hint: Updates were rejected because the tag already exists in the rem=
ote.
>
> So, it is impossible to overwrite tags on the server by pushing with =
the
> --tags option.  But we can use a force push:
>
> $ git push origin +refs/tags/t
> Total 0 (delta 0), reused 0 (delta 0)
> To /home/mhagger/tmp/tagexp/main
>  + fdcd35b...88f7d4a t -> t (forced update)
> $ cd ../clone2
> $ git pull --all --tags
> Fetching origin
> From /home/mhagger/tmp/tagexp/main
>  - [tag update]      t          -> t
> Already up-to-date.
>
> So, the tag is now updated but with a visible display of what happene=
d.
>  Similarly with fetch:
>
> $ git update-ref refs/tags/t HEAD^
> $ git fetch --all --tags
> Fetching origin
> From /home/mhagger/tmp/tagexp/main
>  - [tag update]      t          -> t
>
> Is this closer to the behavior that you want?
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
