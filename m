From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout,
 --update-ref=<ref> support into porcelain.
Date: Mon, 1 Aug 2011 07:11:35 +1000
Message-ID: <CAH3AnrqdOZZ4p2kEFJq17_mK4wkbJE-yJBTg-G06Wdev90oMGw@mail.gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD2vCGnejSj=Nwkb+kGCpwUaggh5j2V6zBu0iWqNZwvS3Q@mail.gmail.com>
	<CAH3AnrqasW=ZSix0YBgxHg8ca2X+YOvSWknbG2mjsy0NaqV+Mw@mail.gmail.com>
	<201107312207.58818.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 23:12:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QndJC-0007E9-FK
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab1GaVLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 17:11:37 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46945 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab1GaVLg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 17:11:36 -0400
Received: by vxh35 with SMTP id 35so3757698vxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/80VOW8sdR4jIWhIGdPn/tLNB1t6NsJChXR28Y2QRZQ=;
        b=vTpAPFzPjAMoW1b+LNMcsOAav7gntTooIiG6qrcIYrKUbxE6+UFBzsQxocStSLselM
         JE019wjAaseaWSzukhGF0P+AhzOGsLY+R3JrOgIqQZhI8zkgNXuv3fUG1alTQWwq96m3
         ZuKfy03SCTXXVqHBZZkmO7JbMoxC8a/aE5cEY=
Received: by 10.52.33.135 with SMTP id r7mr2288739vdi.441.1312146695468; Sun,
 31 Jul 2011 14:11:35 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 31 Jul 2011 14:11:35 -0700 (PDT)
In-Reply-To: <201107312207.58818.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178277>

On Mon, Aug 1, 2011 at 6:07 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Sunday 31 July 2011 21:40:35 Jon Seymour wrote:
>> On Mon, Aug 1, 2011 at 5:21 AM, Christian Couder
>>
>> <christian.couder@gmail.com> wrote:
>> > On Sun, Jul 31, 2011 at 1:55 PM, Jon Seymour <jon.seymour@gmail.co=
m>
> wrote:
>> >> + =C2=A0 =C2=A0 =C2=A0 if test -n "$BISECT_UPDATE_REF"; then
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval=3D"$eval echo '$BISECT_=
UPDATE_REF' >
>> >> '$GIT_DIR/BISECT_UPDATE_REF';" + =C2=A0 =C2=A0 =C2=A0 fi
>> >
>> > I don't like this very much. In fact I realize that the eval thing=
 we
>> > use is buggy because the result of 'eval "eval"' will be the resul=
t of
>> > the last command in "eval", so we won't detect if one of the first
>> > command in "eval" failed.
>>
>> How about I fix the eval stitching so that it uses && rather than ; =
to
>> connect each statement with a final true at the end so there is no
>> dangling &&?
>
> Yeah, please fix it in a separate bug fix patch.
>

Next roll-up will contain this as patch 2:

-               eval=3D"$eval bisect_write '$state' '$rev' 'nolog'; "
+               eval=3D"$eval ${eval:+&&} bisect_write '$state' '$rev' =
'nolog' "

There is a no-checkout-v10 tag on github with the current iteration
(https://github.com/jonseymour/git/commits/no-checkout-v10).
This also contains the v8a patch.

I'll repost on request or once others have had the chance to give feedb=
ack.

jon.
