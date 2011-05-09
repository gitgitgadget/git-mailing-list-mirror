From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Tue, 10 May 2011 02:13:29 +0300
Message-ID: <BANLkTim1Di2ABtrv8ncVPT6+vCvq5pD_kw@mail.gmail.com>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
	<1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
	<20110509225307.GG22908@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:13:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZdw-0008Iz-5D
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab1EIXNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 19:13:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62255 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1EIXNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 19:13:30 -0400
Received: by fxm17 with SMTP id 17so3941827fxm.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4UuKAoHEhnuCWz8BKjA/PHpZhJhmSmhRMzHnTR0/Y4w=;
        b=aelGBF5h2vIIzasZuJyOw1GiBDMKVq1I2YQXXHmmXxyz+zO0yd+NWXVCdoGl8+PjKH
         jJ2cRc10HPVilkMcQR5ly4N0j575thFawl91+3rNdvfyBTS3tpc5GdrBzuwtXYmMPUmX
         Eq0hCgelvvjv1PT1FZz5plGGL0jf7Mqea/OFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p24ebW+RkfdL3EkV8VbXhhU9LghVNrncssA4B739VWEKu99g1K+2XGwU9mF8PiFOum
         ze1Qtyb7KUVDVQP3np79g9BA04eeUk5Ton1vscqFfFB3z69tlCM7WQjGfR/gcVdU5K+r
         o5xHIE2tlJmnie5en8lfDphwcTmoLivz+BTkQ=
Received: by 10.223.73.133 with SMTP id q5mr519037faj.127.1304982809428; Mon,
 09 May 2011 16:13:29 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Mon, 9 May 2011 16:13:29 -0700 (PDT)
In-Reply-To: <20110509225307.GG22908@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173285>

On Tue, May 10, 2011 at 1:53 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> v4: more commit message improvements
>
> Thanks. =C2=A0You seem to have ignored most of my review;

I did not ignore it, I replied to your comments. A review doesn't
meant that I should do what you say.

> I'll try to find
> time to clarify the commit message if the consensus is that this
> approach is a good idea.
>
> An alternative possibility if we need this fixed in the v1.7.5.x
> series (do we?) would be cherry-picking the fix from
> sg/completion-updates on top of maint.

Which cannot be done; you need the rest of the cleanups. Otherwise you
would have to make many many intrusive changes.

> To clarify the trade-offs:
>
> =C2=A0- in terms of lines of code, the fix itself in sg/completion-up=
dates
> =C2=A0 and this fix are about the same size. =C2=A0But the sg/complet=
ion-updates
> =C2=A0 version relies on a code cleanup.

It's not:

fc: 1 files changed, 2 insertions(+), 0 deletions(-)
sg: 1 files changed, 8 insertions(+), 0 deletions(-)

That is if I remove the comments I added; Gabor's version doesn't have =
any.

> =C2=A0- the fix in sg/completion-updates is less likely to be broken =
by
> =C2=A0 future changes in the bashcompinit library.

How exactly?

> =C2=A0- this fix is conceptually simpler. =C2=A0In a way, the fix in
> =C2=A0 sg/completion-updates only works by accident.

You are missing other advantages:

- thix fix is less intrusive
- this fix would be easier to remove in the future (kind of comes from
the previous one)
- this fix has been acknowledge by zsh developers
- this fix can be applies both on 'maint' and on top of Gabor's
reorganization without changes

I really don't understand how adding two lines of code that make
something from totally broken to working properly can be so difficult.

--=20
=46elipe Contreras
