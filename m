From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Howto request: going home in the middle of something? v2009
Date: Tue, 21 Apr 2009 15:43:32 +0200
Message-ID: <237967ef0904210643m2b99dccapbfd10386128c478b@mail.gmail.com>
References: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 15:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwGHb-0008JC-Vs
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 15:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbZDUNnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 09:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZDUNne
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 09:43:34 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:32972 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbZDUNnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 09:43:33 -0400
Received: by ewy24 with SMTP id 24so1594712ewy.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eTpwJCkmopDfVq7vh3CU06LmJ1h0ewlfQwh3IGLOyJc=;
        b=dsyKvdvjEi5ezWQtmuozAYMZSnrXYMueZL++rLI8EkYXS6R602jtxPQoONGiuGKWYY
         LgjSR+8utvzjgB+wA8VXdlKAmIRvUP5bumRJ880tQvEouEeIE3VdDNg8F+6GkXGQg7kZ
         0eRrrp8OZdrrIq3bZGQ0f+T/f+qnflGX78nPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lQYFsImNanJJYwEQIuDo/jHy1cOm9fcpU4mzbLhQHFbeS1cGc4LDLu4j7TzKIibobr
         5K/a8CpuCAzi9YMgqorhsNll3KB4JLS78Z5B5mrueBrxOGrYbsJb5h0VKC7muJmvAeDy
         EgsOoQkXC3iWmBtERDNTbgDKUFo4jlLBqdkkA=
Received: by 10.210.66.1 with SMTP id o1mr6088661eba.77.1240321412086; Tue, 21 
	Apr 2009 06:43:32 -0700 (PDT)
In-Reply-To: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117132>

2009/4/21 Patrick Doyle <wpdster@gmail.com>:
> Hello,
> I've developed a work habit of keeping my source code repository on a
> USB stick and carrying that back and forth with me between work and
> home. =C2=A0(I typically have small, branchless, single-developer
> projects.) =C2=A0When I arrive at the other machine, I do
>
> $ git pull
> (code, commit, code, commit, etc...)
> $ git push
>
> Occasionally at the end of the day (if I'm at work) or at the end of
> the night (if I'm at home), I'm in the middle of something that I wan=
t
> to continue, and I end up making a "work-in-progress" commit
>
> $ git commit -a "WIP"
>
> just so I can pull that in the next day/evening and continue where I
> left off. =C2=A0But that leaves a bunch of "WIP" commits in my histor=
y. =C2=A0I
> started looking around for a better way to do this, and came across a
> 2007 discussion (at
> http://kerneltrap.org/index.php?q=3Dmailarchive/git/2007/10/18/347020=
/thread)
> where the OP really wanted (as do I) do be able to do something like
> this:
>
> $ git stash
> $ git push
> $ git stash-push
> (travel to other site)
> $ git pull
> $ git stash-pull
> $ git stash apply
> (continue coding and committing as before)
>
> There were a number of different suggestions, such as:
>
> $ git commit -b temp -a -m "Hold for transport home"
>
> Then when I get home I do this:
>
> $ git fetch work
> $ git merge work/temp
> $ git reset HEAD^
> =C2=A0# code code code
> $ git commit -b temp -a -m "Hold for transport to work"
>
> When I'm finished at home and want to carry on at work:
>
> $ git fetch --force home
> $ git merge home/temp
> $ git reset HEAD^
> =C2=A0# start coding for the day
>
> ... or using git-bundle
>
> That discussion dates back to 2007. =C2=A0Is there a new, improved, 2=
009
> way of accomplishing this?
>
> --wpd

man git-stash? or you can just git reset --soft HEAD^ away your wip com=
mit.

--=20
Mikael Magnusson
