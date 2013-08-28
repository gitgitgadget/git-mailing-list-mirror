From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 17:25:58 -0500
Message-ID: <CAMP44s0t71X8dhTVmeEoGEbgsUiVWsKYe5eYj=tCN0oB96cSqQ@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
	<xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 00:26:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEoBh-00044u-HY
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 00:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab3H1W0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 18:26:00 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51737 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab3H1W0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 18:26:00 -0400
Received: by mail-lb0-f173.google.com with SMTP id r11so42677lbi.32
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=n2nsrS+0S55bc2EzZtS5qIeFb4YNcBnEyImy90WQGjc=;
        b=VRxat+OjnPjUbRiFOfIuDFed3tFDbwGOsqOCXNmSHzPdyYIKoYar0mET3+GEYDgdln
         zVuu7/88uKcCSVm0zO6jz2CCvOHwqY66foZ2yQDRkQmAMNukDnVCncQOEpWMycoPwTJW
         UTw0248FZDSHOq8qvZJCrKdDyK0Y4NqDw01C0iIfcy63ieu8RxPqEo68f12XKe+M+wja
         6UONTvFaynfCElLSVrMr8wfO6g/LuKARN0A/ki0qRudI3OOt1Y+iKvgHe6x7/4V3qWGj
         tVel0DCHM/gcXVrX397iFhmIs6ttJvEK+uay5T5heaovKJ00GW4Hso6MY33CZY1wtpmH
         ia/Q==
X-Received: by 10.112.154.70 with SMTP id vm6mr526326lbb.1.1377728758561; Wed,
 28 Aug 2013 15:25:58 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 28 Aug 2013 15:25:58 -0700 (PDT)
In-Reply-To: <xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233226>

On Wed, Aug 28, 2013 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>>>> +     bzr log | grep "^committer: " > ../actual
>>>>> +     ) &&
>>>>> +
>>>>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > e=
xpected &&
>>>>
>>>> Git's source code usually says >../actual and >expected, without s=
pace
>>>> after '>'.
>>>
>>> Not that usually:
>>>
>>> % git grep ' > ' t/*.sh | wc -l
>>> 1943
>>
>> Do I really need to quote the paragraph in CodingGuidelines?
>
> Existing violations are not an excuse to make things worse by adding
> more.

1)

By definition following a guideline is not mandatory:
https://en.wikipedia.org/wiki/Guideline

Violation is a too strong word for not following something that is not
mandatory in the first place; deviation is a more appropriate word.

2)

This code is part of the 'contrib' area, and part of the tests, most
of the code in this area doesn't even have tests.

3)

Blindly following guidelines is not a good idea.

cmd >out
cmd >out 2>err
if (n > 1)
cmd1 | cmd2

Clearly, those are inconsistent.

cmd > out
cmd > out 2> err
if (n > 1)
cmd1 | cmd2

Those are not.

=46ortunately since these rules are only guidelines, there's no need to
engage in bike-sheding argumentation if the code deviates from
guideline, specially for this insignificantly trivial issue.

Blocking a patch that would be obviously advantageous for the users on
the basis of a single white-space on the tests which aren't even run
by default is simply stupid.

> I think with these comments we can expect a reroll coming,
> and it should be trivial for any contributor to fix it while at it.

I already send the update, I do not see the need for any more changes,
so no more changes will come from me unless there is valid feedback.

If it makes you happier, apply this:

=46rom 7db40fa6b2780f9b5787c7d38f0d2dac01b175d3 Mon Sep 17 00:00:00 200=
1
=46rom: Felipe Contreras <felipe.contreras@gmail.com>
Date: Sun, 4 Aug 2013 19:27:51 -0500
Subject: [PATCH] remote-bzr: fix export of utf-8 authors

Reported-by: Joakim Verona <joakim@verona.se>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-bzr
b/contrib/remote-helpers/git-remote-bzr
index c3a3cac..08b0b61 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -168,6 +168,7 @@ class Parser:
         if not m:
             return None
         _, name, email, date, tz =3D m.groups()
+        name =3D name.decode('utf-8')
         committer =3D '%s <%s>' % (name, email)
         tz =3D int(tz)
         tz =3D ((tz / 100) * 3600) + ((tz % 100) * 60)
--=20
1.8.4-fc-3-g64bc480

There, there is no more test GUIDEline "violation".

--=20
=46elipe Contreras
