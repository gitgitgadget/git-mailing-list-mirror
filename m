From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: merging unmanaged working tree
Date: Mon, 15 Mar 2010 19:49:10 -0400
Message-ID: <32541b131003151649v1a1265f1ke3ccac9cc930f9c8@mail.gmail.com>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl> <46a29168.6d880e7c.4b9e296c.483a1@o2.pl> 
	<87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl> <32541b131003151222r32244cf4o6182545e3a1eb1aa@mail.gmail.com> 
	<87eijlw4cn.fsf@kotik.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrK2S-0005UX-Q5
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965810Ab0COXtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:49:31 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:46655 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965013Ab0COXta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 19:49:30 -0400
Received: by gxk9 with SMTP id 9so2180755gxk.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8weuhs0Poh/O3qK95xK9s7EmbNCONfO48sa/FpeODwg=;
        b=ka7oNycPWGiFdJwySqzNLvR9NjTubvwRr9hv8DoID4cA7/R1b2rxHbKWP8xwK+iW51
         IOjb+1gxGpvHhm+8BrQda4YzzLQiBY1oLa4QwmsCpP1CLuNe/NOZMVbZAsNAulEH9wDs
         +498pmzilBcKPAPQhP9b1/qjfk8Sy7v3bpAdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RDwTOuNqP3yEyPofGPaDp+hjGlOAhJzfn4p1Eamh/SdUNgdXdLMJLxqHFyOSIxba80
         5bBWRi9EyGQ3saq/DtWBC6WpXCthBqVEyb7F2oahgZxw26G8QHAqvlxTGEXiF0uEAnXb
         q0EM8Xr175zC4rKo+5yfQVHM79ka7+J0TIHbk=
Received: by 10.150.208.3 with SMTP id f3mr3706383ybg.146.1268696970093; Mon, 
	15 Mar 2010 16:49:30 -0700 (PDT)
In-Reply-To: <87eijlw4cn.fsf@kotik.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142281>

2010/3/15 =C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl>:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> a) Look at 'git clone --depth' so you can clone only the most recent
>> version of the files, not the *entire* repo. =C2=A0This lets you do =
commits
>> on any computer you want with the pen drive plugged in, but saves
>> space.
>
> I've tried this one. It works (but why the --depht 1 gives two
> revisions?) but even thoug the main repository and the portable one h=
ave
> common commits I can't pull changes back from the mobile to the main
> one. Is there any wise trick to make git try a little harder?

I don't know; I haven't used shallow clones (ie. --depth) very much.
git's implementation of them seems a bit half-hearted.  The man page
says "A shallow repository has a number of limitations (you cannot
clone or fetch from it, nor push from nor into it), but is adequate if
you are only interested in the recent history of a large project with
a long history, and would want to send in fixes as patches."  There is
no technical reason for this limitation, as far as I know.

It does give a hint as to what you could do instead of push/pulling,
however: you could use git format-patch to extract the changes from
your shallow copy, and git am to import the patches back into your
main copy.  Seems like a pain though.

>> b) Keep your .git directory on your main PC's disk, and the working
>> tree on your pen drive. =C2=A0Look at the GIT_DIR environment variab=
le in
>> 'man git'. =C2=A0Then when you bring the pen drive back to your PC, =
you
>> have the full repo available. =C2=A0(If you use 'git clone --referen=
ce'
>> when making the new repo, the extra .git directory should take only
>> minimal space.)
>
> This one's nice and seems to be most space efficient as far as flash
> space is concerned. However, I'd be able to sync only with the machin=
e
> that holds the portable GIT_DIR while the previous method, if only
> there was a way to make git work with shallow clones, could work with
> different hosts if I synec my No1 desktop with them too.

Maybe you could do something like:

      git clone -s ~/myrepo /pendrive/myrepo

This will give you a .git dir in /pendrive/myrepo, but all the
*objects* in the git repo will actually be borrowed from ~/myrepo.
This will make git virtually unusable on /pendrive/myrepo *unless* you
mount the disk on a PC that has ~/myrepo in the original location.  On
any such computer, you could be able to do normal git operations in
/pendrive/myrepo, including pulling changes from there to ~/myrepo.

As you do git operations on /pendrive, /pendrive/myrepo/.git will
slowly accumulate objects that you might have to clear out over time
(ie. after pushing them to the parent repo).

> I've just invented yet another method. Push the content to the pendri=
ve:
>
> $ git commit -am branching
> $ git archive --format tar HEAD | tar -C /media/pendrive/project -xf =
-
> $ git log -1 > /media/pendrive/project/HEAD # to remember
> [...]

Yeah, I guess you could do that, but at that point you're basically
not using git anymore.

Have fun,

Avery
