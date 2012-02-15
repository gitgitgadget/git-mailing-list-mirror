From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Wed, 15 Feb 2012 16:14:38 +0100
Message-ID: <CAA01CsoW-32kOtD2g==2FDcYaxfSVD4Xdy1bYG_wJBWDNept4A@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<CACsJy8DBG2A91=ppCOC6Hf6aYM2soUXXdsY0GU9hr2xqjj4RYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 16:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxgZA-00070F-IH
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 16:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2BOPOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 10:14:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57135 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab2BOPOi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 10:14:38 -0500
Received: by iacb35 with SMTP id b35so1558853iac.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 07:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HvEZabGPLuReYq3E5PMCdZMLM+/tk6cZD2CKen9bVvs=;
        b=UgL3KAaG496wJfYR0BhpZL8jSfdldkIkQKpeynjsuXnWXxHDTLM7rYoeyuOJyyHHZy
         gIbpJvbOjZmm73sRx+vBJNqi71rAWAOexvAgYuQoWK+YGCH0dgA5UFBxRNJVs4Gvtt0k
         qnrQc5cOMZP392rIqO3M/fg3Jn2h2RLn0NJpc=
Received: by 10.42.145.131 with SMTP id f3mr39954084icv.8.1329318878239; Wed,
 15 Feb 2012 07:14:38 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Wed, 15 Feb 2012 07:14:38 -0800 (PST)
In-Reply-To: <CACsJy8DBG2A91=ppCOC6Hf6aYM2soUXXdsY0GU9hr2xqjj4RYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190831>

On Wed, Feb 15, 2012 at 12:01 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Wed, Feb 15, 2012 at 3:57 PM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> Indeed, after gc the times went down:
>> 10s -> 2.3s (subdirectory)
>> 17s -> 9.5s (whole repo)
>>
>> 2 seconds is much better and I'd say acceptable for me. But my quest=
ions are:
>> - why is it so slow with not packed repo?
>> - can it be faster without repacking?
>
> gc does more than just repacking. If you still have the un-gc'd repo,
> Try these commands one by one, and time "git status" after each:
>
> =A0- git pack-refs --all --prune
> =A0- git reflog expire --all
> =A0- git repack -d -l
> =A0- git prune --expire
> =A0- git rerere gc

It will take some time but hopefully I'll have the stats for tomorrow.


> I'd be more interested in why auto-gc does not kick in (or whther it =
should).

I don't have any specific options set, so default values should be used=
=2E

I'm using git-svn though, so my workflow looks like this:
   git svn fetch + git svn rebase
   ... git operations like commit, cherry-pick, rebase ...
   git svn dcommit

Not sure if that matters. I remember that I've seen auto-gc being run
several times in the past - I think after svn fetch/rebase.

I'm also using git-new-workdir and have 2 extra workdirs.


>> - even with packed repo, the time on small subdirectory is much high=
er
>> than I'd expect given time on whole repo and subdirectory size - why=
?
>
> Hard to say without measuring. I just notice that I missed your mail
> with profiling results. I will have a look, but just in case, is the
> repository publicly available?

Unfortunately it's not public. I can do some measuring if someone
tells me what to do.


--=20
Piotr Krukowiecki
