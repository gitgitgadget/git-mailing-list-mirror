From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Mon, 30 Aug 2010 14:51:26 +0000
Message-ID: <AANLkTikbLtfx6xL6K32o_AXqY+qeqKANN5n2g0oYPoi6@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<4C6C01A9.4080306@workspacewhiz.com>
	<AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
	<201008182032.40375.j6t@kdbg.org>
	<AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
	<4C7BC344.9020500@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:51:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5i4-0000kc-C2
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab0H3Ova convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:51:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab0H3Ov1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:51:27 -0400
Received: by fxm13 with SMTP id 13so3269860fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IPbVZsrGvfIi2Lcpv5WFM5NF9Kr/8PgL6hdTyj1OWcc=;
        b=WEd7lwA+6t4UO4f0ske4KOBuSli3teJloBXoA2oy1sxKQgqiLnp9vCnZ0kk5tYhBOH
         5xRmwUD2xbN8ybErmEcvw3pjcnTY1Ju+DHwMAt5VoPUEbfOZlad/zb3TRWRwr04XNbo/
         TxEUQHbnzOi7dRny4OSTVy9tdH5CqNHskkk7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=THA72f8AyTvDFFQp9qVSoQH930AurCmeFHDiQp2bHr2eU8rVB956MNeZj6c/dq2B0/
         AlxldPwN+vEH7GErKWh6TXCVommWx7/IWzX2HBfffyExpeEFNhOel5NNvg9Cwd0oEFFV
         qn1jp2+Tkx3ioVjjxGETq9Uc51wPDkDeQfsnE=
Received: by 10.223.110.73 with SMTP id m9mr3963309fap.25.1283179886464; Mon,
 30 Aug 2010 07:51:26 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 07:51:26 -0700 (PDT)
In-Reply-To: <4C7BC344.9020500@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154818>

On Mon, Aug 30, 2010 at 14:42, Joshua Jensen <jjensen@workspacewhiz.com=
> wrote:
> =C2=A0----- Original Message -----
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> Date: 8/29/2010 1:39 PM
>>
>> On Wed, Aug 18, 2010 at 18:32, Johannes Sixt<j6t@kdbg.org> =C2=A0wro=
te:
>>>
>>> On Mittwoch, 18. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n wrote:
>>>>
>>>> According to some further research at least FreeBSD and NetBSD hav=
e
>>>> copied this GNU extension. You may find their versions easier to
>>>> integrate.
>>>
>>> We already have a GNU fnmatch in compat/fnmatch.
>>
>> Do you have any plan to deal with this? I currently have this
>> monkeypatch to build on Solaris:
>>
>> =C2=A0 =C2=A0 diff --git a/Makefile b/Makefile
>> =C2=A0 =C2=A0 index 62d526a..079fae5 100644
>> =C2=A0 =C2=A0 --- a/Makefile
>> =C2=A0 =C2=A0 +++ b/Makefile
>> =C2=A0 =C2=A0 @@ -863,2 +863,4 @@ endif
>> =C2=A0 =C2=A0 =C2=A0ifeq ($(uname_S),SunOS)
>> =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 COMPAT_OBJS =3D compat/fnmatch/=
fnmatch.o
>> =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 COMPAT_CFLAGS =3D -Icompat -Ico=
mpat/fnmatch
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NEEDS_SOCKET =3D YesPlease
>>
>> One way to deal with it would be a new NONGNU_FNMATCH=3DUnfortunatel=
yYes
>> flag, or the fnmatch_icase() suggestion above which we could bundle
>> and always use. But having next build on systems without GNU
>> extensions would be preferrable.
>
> I am going to deal with this, but I haven't been around. =C2=A0I hope=
 for some
> time this week.

Sure, no rush. I was just wondering whether you had some plan for it,
or whether I should submit a patch to use the fallback on
e.g. Solaris.

> Short of duplicating fnmatch's code and renaming the function, I am n=
ot sure
> how to make this play nice on all systems.

I don't think duplicating the GNU (or *BSD) version into a
compat/fnmatch.c would be a bad thing. See e.g. compat/snprintf.c.

> You added COMPAT_OBJS above, but I think there is no linker
> guarantee it will pick up compat/fnmatch/fnmatch.o over the C
> runtime version? =C2=A0Perhaps the makefile is architected to do so.

It's probably just an artifact of how the Solaris linker works, it
doesn't go through the trouble of undefining an existing fnmatch
symbol or anything.

> The safest alternative is to allocate character buffers, lowercase th=
e
> filename and match arguments into those buffers, and pass them off to
> fnmatch without any special flags. =C2=A0I don't like the idea of a d=
ouble memory
> allocation/free combo per each call to this function, but it would wo=
rk. =C2=A0Is
> anyone opposed to this approach?

Just using the GNU extension and providing a fallback is probably
cleaner and easier to maintain.
