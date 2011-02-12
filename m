From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: How you can translate things now, and a plan for the i18n series
 going forward
Date: Sat, 12 Feb 2011 12:19:17 +0100
Message-ID: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kev <kev@riseup.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 12:19:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoDVd-0003OS-76
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 12:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab1BLLTV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 06:19:21 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39800 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab1BLLTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 06:19:19 -0500
Received: by bwz15 with SMTP id 15so4015404bwz.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lotUkc4loLUWi3bOe1DxW3kZNMpYIpWyZZqVKxIK5K0=;
        b=ewErih725BG/C9Ph1AVffamRd780yYpeOlM89IPJoaJcG87s8Jg44kEMr6ZRQscMtG
         up9Myme5fwLX2beOs8vFEdl6O6sxyNjDIr40933ptv75FMpT1gFH+iSRov8mH4ETo6pC
         Ou60FilRTW5mLP1GkDinAXm83EucyTyFvxYX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=aSMOYZISqq71zRjOgbK77TZi6x9/XMCcMIc6cVV0eUo7hLDYTKhQJv/6MdzZXoNQX0
         P6udpPeawlx8AmhaqeRz3uNzKmOZx5OrmCZIqwA5HA9Y6IRLV92ySs1C5pV9ppe7haGR
         ZGC7txTVDB+7T/k/8MyRd9xgNCPpHlUqRFLNA=
Received: by 10.204.49.208 with SMTP id w16mr4976788bkf.166.1297509557457;
 Sat, 12 Feb 2011 03:19:17 -0800 (PST)
Received: by 10.204.52.135 with HTTP; Sat, 12 Feb 2011 03:19:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166607>

On Fri, Feb 11, 2011 at 21:22, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> On Fri, Feb 11, 2011 at 21:01, kev <kev@riseup.net> wrote:
>> i understand the ab/i18n has been gettextized and translated to at
>> least a couple of languages.
>>
>> ive found references in the list archives to this, but nothing in th=
e
>> source code. i do see translations of git-gui, however. but im looki=
ng
>> for some clue as to how to translate git itself.
>
> Currently the ab/i18n branch has not been merged to master, so it's
> not available to the general public. =C3=86var has been working on it=
 but
> we haven't heard from him recently on this topic.

Hi both. I've been on a hiatus from Git development, so I haven't
picked up ab/i18n again, but I still plan to and to get it included in
Git.

Meanwhile Kev, if you want to translate Git you can:

    git clone git://github.com/avar/git.git &&
    cd git &&
    git checkout -t origin/ab/i18n

And follow the instructions in po/README. This branch is relatively
out of date and hasn't been rebased on the upstream master in a while,
but most of the strings you'll be translating will still be there once
I do that, so your work won't go to waste.

=46or everyone else, I plan to re-submit ab/i18n, but re-do it so that
it isn't all one huge patch series but can be applied in smaller
steps. Here's the outline of my current plan:

    ** TODO Re-do the i18n series so it can be applied in piecemeal ste=
ps

       I.e. these:

    *** TODO Introduce a skeleton no-op gettext, just the
infrastructure minus the interesting stuff

        I.e. just add:

            #define N_(s) (s)
            #define _(s) (s)

    *** TODO Add no-op C gettextize patches

        This will change "foo" to _("foo") everywhere, but will be a no=
-op
        due to it being macroed out.

    *** TODO Add no-op Shell/Perl gettextize patches

        Due to the nature of these languages these can't be macroed out=
,
        but it's still easy to have a no-op wrapper function.

    *** TODO Add po/README etc.

        The documentation about how to add translations etc.

    *** TODO Add translations

        Add the po/*.po files. Since we have no-op translations everywh=
ere
        we can translate git with xgettext + po editing, even though th=
e
        translations aren't being used yet.

    *** TODO Introduce the real gettext in a later patch + tests

        Once the rest is all in this will be a much smaller change.

I think doing it this way will be much easier for everyone, what do
you think Junio?
