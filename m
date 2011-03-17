From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 19:48:54 +0100
Message-ID: <AANLkTi=Fnacc9JamGdOEYhHY8PJgaidSLmif_z5Qdfp0@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net> <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
 <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
 <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com> <AANLkTinQYjq=NiHK6MK0tA5AEE7=NCg8kthJT9Xz=xNk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0IKz-00033e-AC
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 19:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab1CQSyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 14:54:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56715 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab1CQSyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 14:54:09 -0400
Received: by gwaa18 with SMTP id a18so1247523gwa.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=OAA1IqKwZiufABEiZ4rwwqQ37RCng/YIgL2RWuEK4jc=;
        b=Xqk4jcmFJwel6Ku63Q+0qLEtNsjrMPhwOEQv2CkmDkprcGrXzvLqzK6DTTf7i1wcFz
         uhs0QNObDKIo851tBE5CAoRW3EjKbUjecDisvwgMhkqb5b4j7P9d9gtBKUxkZuEuabaB
         VOeI7IASAzWshXKdFfA7d5zzPGf8rKcSyCF6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MM2l0mbiytiJKxCt9lipBDqxrjmEVxUR6F5c9Xud1UHhvYRCrLXNZdDqCCgz3gvdKv
         70bTpZluafpmJ5ylD55H5UshGgWo9rMH2C91cg+g6ew58OjhKIGX45UcEjkQi2HRjVFh
         veMZfa/yrUu+w+NxrnnyxV7x6RpDdDVcZwAE8=
Received: by 10.90.83.2 with SMTP id g2mr191723agb.121.1300388048792; Thu, 17
 Mar 2011 11:54:08 -0700 (PDT)
Received: by 10.90.223.11 with HTTP; Thu, 17 Mar 2011 11:48:54 -0700 (PDT)
In-Reply-To: <AANLkTinQYjq=NiHK6MK0tA5AEE7=NCg8kthJT9Xz=xNk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169257>

On Thu, Mar 17, 2011 at 18:58, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> On Thu, Mar 17, 2011 at 10:54 AM, Alex Riesen <raa.lkml@gmail.com> wr=
ote:
>> On Thu, Mar 17, 2011 at 15:10, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
>>> On Thu, Mar 17, 2011 at 4:53 AM, Alex Riesen <raa.lkml@gmail.com> w=
rote:
>>>> What if they just revert the rest? Reset the files to their states=
 before
>>>> merge.
>>>
>>> That's the same as checkout --ours which is sometimes a valid
>>> resolution for a file. So I think "I resolved this file" needs to b=
e
>>> recorded either way.
>>
>> But it is recorded: the file is different now!
>
> Let's say we have:
>
> =C2=A0a---b---c
> =C2=A0 \
> =C2=A0 =C2=A0d---e
>
> $ git checkout c
> $ git merge e =C2=A0# files "foo" and "bar" conflict
> $ git checkout --ours foo =C2=A0# correct resolution for foo

I doubt that'll be a correct resolution. Someone have to look
at the conflict markers, right?

> $ git checkout HEAD bar =C2=A0 =C2=A0# "revert" bar to its pre-merge =
state
> $ git add foo
> $ git commit
>
> In the merge commit, both "foo" and "bar" are identical to their
> pre-merge state. There's no effective difference between the "checkou=
t
> --ours" and "reset the files to their states before the merge".
>
> So again, how do you tell the difference here?
>

The difference may be simple (git diff --name-status c^..),
it just does not help. The merge commit will record the
branches as merged and an attempt by the maintainer to merge
this partial merge commit will just fast-forward. So it was
a stupid idea either way.

How about not to record the merge as a merge commit, but
just resolve as much as possible, commit _only_ what was
resolved, and revert everything else. Including files merged
cleanly, as the last merge by maintainer will have to clean
merge them anyway. And of course, commit as normal:

  $ git merge --squash --no-commit e

The maintainer will have to collect the branches with resolved
conflicts, and fix up the conflicts left.

Could be less work, given good coordination of who resolves what...
