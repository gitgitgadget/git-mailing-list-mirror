From: Chris Packham <judge.packham@gmail.com>
Subject: Re: re-running merge on a single file
Date: Fri, 12 Mar 2010 15:43:03 -0800
Message-ID: <a038bef51003121543t52a864ddlab345dd1bcf6c906@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	 <201003112129.52596.markus.heidelberg@web.de>
	 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
	 <m3hbomla3u.fsf@localhost.localdomain>
	 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
	 <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
	 <4B99E309.2070603@viscovery.net>
	 <7viq92rpsr.fsf@alter.siamese.dyndns.org>
	 <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
	 <7v3a05p29w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 00:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqEVd-0007k9-Br
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 00:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755Ab0CLXnH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 18:43:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45905 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385Ab0CLXnF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 18:43:05 -0500
Received: by pwi1 with SMTP id 1so1066380pwi.19
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 15:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cUZgENEoidSKFB6Fznw1UxoY4UVQMd/ipsnwVgXJ6JA=;
        b=DrgTDKsdjs9wx9cj5Lc3ZXFItSdlXCxbWKOeiYAn+pPCfLo3CZjbrhgIbHn86VAPia
         w0Wt2d52mhQxWAl5t44OUm0BWlHqozh/xrLPMAKD4KTGAVCqbuOEb+u2TfttH9JPVjo8
         RxaqYyWpQREwEbsnIJoPKdLt/PqKJ8nc3JCCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bgniEMHJ1/+7hd8la1J3OCibdVoABvyTi8zFGnr6ZzbIVUsmIRVzC03JwtHsLmtW3j
         lT6f301/mRt1QfLBVYhZ9cU1W3+B0Bz7uCERymFzQtN5RjXIcy9TBrRVyjQFW9oI6rPh
         x8HK+W29AASr88EoBmC5TtkeqanzJwMWqGVVs=
Received: by 10.114.119.3 with SMTP id r3mr384307wac.16.1268437383263; Fri, 12 
	Mar 2010 15:43:03 -0800 (PST)
In-Reply-To: <7v3a05p29w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142070>

On Fri, Mar 12, 2010 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> ... I'm lazy and my
>> projects rules allow broken commits so ...
>
> We cannot fix, nor it is our job to fix, lazy people or undisciplined
> projects ;-)

=46air call. I don't think the maintainers of human-nature-v1.0 are
interested in patches :)

Actually on another note wasn't there an idea of being able to say
that a particular set of commits is known to break bisect-ability?
Ideally I'd want one commit that comprises the merge from upstream, at
this point the build targets from upstream should build happily but
the targets we've added we know are broken. Then I come along and fix
the targets we've added, maybe doing commits sub system by sub system
to make review easy. Finally whatever work is left to actually make
our targets build successfully is in another commit. From a bisect
point of view I'd want to say that the merge and sub system commits
are intentional breakages and that bisect should really look at this
whole series as a single uber commit. I guess this is information that
could go into notes that bisect could then take into account when
making its next jump.

> Having said that you can still retry your merge, which was _mostly_ O=
k.
>
> =C2=A0(1) First, check out the original commit before the merge. =C2=A0=
You may have
> =C2=A0 =C2=A0 built a few more commits on top of it, so "git log --fi=
rst-parent"
> =C2=A0 =C2=A0 may help to find that commit. =C2=A0Suppose you found t=
hat merge commit
> =C2=A0 =C2=A0 and we call that $merge; then:
>
> =C2=A0 =C2=A0 $ git checkout $merge^1
>
> =C2=A0(2) Then you retry that merge:
>
> =C2=A0 =C2=A0 $ git merge $merge^2
>
> =C2=A0 =C2=A0 which would conflict the same way you saw.
>
> =C2=A0(3) If you have rerere enabled, then the conflicts would be alr=
eady
> =C2=A0 =C2=A0 resolved in your working tree at this point, but not in=
 the index, so
> =C2=A0 =C2=A0 you can reproduce the conflicted state with "checkout -=
m".

Mental note: Need to learn more about git rerere. Sounds like what I
need to do the job.

> =C2=A0(4) If you didn't have rerere enabled, then you would have a lo=
t of
> =C2=A0 =C2=A0 conflicted files in the working tree. =C2=A0Inspect the=
m by comparing with
> =C2=A0 =C2=A0 $merge:
>
> =C2=A0 =C2=A0 $ git diff $merge
>
> =C2=A0 =C2=A0 Since we are assuming that most of the resolution was g=
ood, and you
> =C2=A0 =C2=A0 know what paths you want to fix your earlier resolution=
 for, you
> =C2=A0 =C2=A0 would want to take what is in $merge for most of the pa=
ths. =C2=A0You can
> =C2=A0 =C2=A0 run checkout on paths that you know were good in $merge=
, like so:
>
> =C2=A0 =C2=A0 $ git checkout $merge -- include/ drivers/
>
> =C2=A0 =C2=A0 and repeat this step to narrow it down to the paths you=
 are
> =C2=A0 =C2=A0 interested in.
>
> =C2=A0(5) After you fix the resolution and make a commit,
>
> =C2=A0 =C2=A0 $ git diff $merge
>
> =C2=A0 =C2=A0 will show that your earlier incorrect resolution is rep=
laced by a new
> =C2=A0 =C2=A0 correct resolution.
>
> After that, you can rebase your branch on top of HEAD to conclude.
>
> Note that recent git can use "checkout -m path" to reproduce conflict=
s
> even after you ran "git add path".

OK I'll look out for that in future. This won't be the last time I'm
doing a big merge.
