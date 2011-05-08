From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
Date: Sun, 8 May 2011 23:33:46 +0200
Message-ID: <BANLkTikSvU4haNpRmPq8o2P0yB1Y3t0Ahg@mail.gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
	<1304856659-10672-2-git-send-email-avarab@gmail.com>
	<7v1v09un8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 23:33:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBbt-0005H5-Uc
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1EHVdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 17:33:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49629 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1EHVdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 17:33:49 -0400
Received: by bwz15 with SMTP id 15so3558052bwz.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FAWmgW9ddEd+tJEsM1515YnhifeCSfjR+YdXNJR7/dg=;
        b=YG4uTBopWnSU4vAxK+bQcBbODZxXZmaGAKR+99dfWgo2fHqURJ1BCqHflWXps811zJ
         aC8Tzej9yuo1T+NHA2JY8h3znSJhHPTv+xIfp35LOzKmiJBXAplr5l87JD8Rzl2rMOMd
         jJe9RTxYsDV7ushKE5DS25kI7gQJdVkODYkyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YPRQXDRo/g5nfQ55d3qWk1e+zKW2DLhQXDoZC+R8gwmOx0dAQ02iCcxYGC8OdG7BK5
         ivMhpD/9/OTqwD257WWM2Vgh8DgpU7xnaGEPRb3Kx+WdgrV/Cj6RlgL7GfTezM6Q/3Oj
         iu7aY5mzQpH0VDkMUGsIuL0t+SEQjtKZKHMdg=
Received: by 10.204.154.88 with SMTP id n24mr3722078bkw.38.1304890426167; Sun,
 08 May 2011 14:33:46 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Sun, 8 May 2011 14:33:46 -0700 (PDT)
In-Reply-To: <7v1v09un8y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173183>

On Sun, May 8, 2011 at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Add a git-sh-i18n--envsubst program which is a stripped-down version
>> of the GNU envsubst(1) program that comes with GNU gettext for use i=
n
>> the eval_gettext() fallback
>
> Ok up to this point.
>
>> ... instead of using a clever (but broken)
>> printf + eval + printf trick.
>>
>> In a previous incarnation of the gettext series I implemented the
>> eval_gettext() fallback like this:
>> ...
>> This was clever, but ...
>> ...
>> To work around this, and to improve our variable expansion behavior
>> (eval has security issues) I've imported a stripped-down version of
>> gettext's envsubst(1) program.
>
> I do not think the lengthy history of failed experiments above is wor=
th
> explaining. If you really want to say something to justify a new help=
er, I
> think it is sufficient to just explain that it is unsolvable in shell=
=2E I
> tried that in the first 9-line paragraph in:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/170703/f=
ocus=3D170770
>
> In other words, "we tried X that didn't work and we tried Y that didn=
't
> either, we cannot think of any better solution, so we are doing somet=
hing
> else" is not a good justificiation for doing that "something else".
>
> "Anything based on shell is an unpractical solution for this and that
> reasons, so we use this instead" explains that the earlier failures w=
ere
> not because we did not try hard enough. =C2=A0Unlike "tried X and Y b=
ut didn't
> work", dismissing "anything based on shell" as a whole class with cle=
ar
> explanation why it would not work would prevent people from pursuing =
that
> dead-end approach. =C2=A0It also avoids giving quibbling people an ex=
cuse to
> argue against importing envsubst implementation saying "you didn't tr=
y
> hard enough".

I included the failed experiments because I know for sure that those
don't work, but I'm not sure that this is impossible in shell, and it
might be possible in some non-POSIX shell (which we could optionally
take advantage of on certain platforms in the future).

So having the failed examples that we know don't work is valuable for
anyone digging into this in the future.

Or are we sure that this can't work in POSIX (or non-POSIX shells)?

>> With it eval_gettext() is implemented
>> like this:
>> ...
>> Reported-by: Johannes Sixt <j.sixt@viscovery.net>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>
> Ok.
>
>> diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation=
/git-sh-i18n--envsubst.txt
>> new file mode 100644
>> index 0000000..e146a2c
>> --- /dev/null
>> +++ b/Documentation/git-sh-i18n--envsubst.txt
>> @@ -0,0 +1,36 @@
>> ...
>> +Author
>> +------
>> +Written by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>> +
>> +Documentation
>> +--------------
>> +Documentation by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and the git=
-list
>> +<git@vger.kernel.org>.
>
> I do not think we do these individual credits these days in the doc.

I wrote this when that was the convention, but evidently we've changed
that since then.

I'll remove it in the next iteration.
