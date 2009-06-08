From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Merge into locally modified files?
Date: Mon, 8 Jun 2009 19:19:37 -0400
Message-ID: <9e4733910906081619u19f12220g7fab11c94b9aa8a5@mail.gmail.com>
References: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 09 01:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDo82-0007Do-UP
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 01:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZFHXTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 19:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZFHXTg
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 19:19:36 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:62258 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbZFHXTg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 19:19:36 -0400
Received: by qyk3 with SMTP id 3so190942qyk.33
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vmsJyOuUMXPEDj1weOQEqoTHcKPqqITkT5gFFMgWk0A=;
        b=IN3h24qMPvRHHq5PF0B5eASCEcvW0Zx1cA3tXIK4gqaTbCoDUemcmk/1tXhbeI+jiJ
         OjEqVmOlFvPejCLzrQ0peKztA2Ku4jwoiGUUAyKiz//Hut5Z54uTRWNapWc/8TnRZfp4
         OuSusWMexI60CvLRk5AtxdrkeSy+njoZos7qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MX3V+MuHD6v/HlYeb5IisJLAmD7T1nVfwfx1YkJbApBiIOzzK/n6Ty1gYQ2u372IE4
         HlqewdTEb/o9/9dZKmIoouf9I/qYecYhbbBKGgo1J2N3FC+AjOBNZmAbrNXAL7rCd02s
         EllBgXDy8PsgCGkIHZNSccPgJ3QpSpo6w+pKU=
Received: by 10.220.90.144 with SMTP id i16mr4197887vcm.14.1244503178015; Mon, 
	08 Jun 2009 16:19:38 -0700 (PDT)
In-Reply-To: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121129>

On Mon, Jun 8, 2009 at 1:30 PM, <skillzero@gmail.com> wrote:
> If I have some local changes to a file that I don't want to commit
> (e.g. temp debug changes like printf's) and I see somebody else has
> pushed some changes to that file, how do I merge their changes to the
> file while trying to preserve my local changes (and conflicting if
> it's not possible)?
>
> After a git fetch, I tried 'git checkout --merge origin/master <path
> to my locally modified file>', but that just overwrote my local
> changes.

I use stgit to do this all of the time. stgit is all about patch
stacks. You just add your debug stuff to a stgit patch and then you
can push/pop it.

stg new debug-patch
=2E.make debug edits..
stg refresh

git fetch origin
stg rebase origin/master
=2E.. fix conflicts, you get prompted...

you're done.


>
> I'm converting people from CVS to git and this is a common thing
> people do with CVS. They have some local changes and see that the
> server has some other changes so they do 'cvs up' and it tries to
> merge changes from the server into the locally modified file. The
> local changes are often things that will never be committed. I know
> git tries to avoid things you can't undo, but like a 'git checkout
> <file>' that can't be undone, is there a way to say "merge what you
> can and generate conflict markers for things you can't?".
>
> I think what I want to do is the equivalent of rebasing for local
> modified files rather than committed files.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
