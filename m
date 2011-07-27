From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 14/18] revert: Introduce --reset to remove sequencer state
Date: Wed, 27 Jul 2011 20:05:37 +0530
Message-ID: <CALkWK0nKMMjT1jg8zENmwbxvFU+5A+BFLVkoDRAOtURNcZ4H7A@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-15-git-send-email-artagnon@gmail.com> <20110727051115.GI18470@elie>
 <CALkWK0k7SvjJ8duNscnwjn4JOjSDqfHN1qH9rnoz5w8TjHgKgA@mail.gmail.com> <20110727142815.GC24785@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm5DP-00021m-B2
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab1G0Of7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 10:35:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46773 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab1G0Of6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 10:35:58 -0400
Received: by wwe5 with SMTP id 5so1476926wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ePrxEEKU3yHxAhPpKfGZDP32+6/sOO2eofI7lH15pHg=;
        b=mWHBm4Y07+MKBkwhoIfvYVMeeLLeYeLBMJZmEMRNSu+fIGEGpEzV+OdEHsY4i2Tg0D
         HzHQ+hIyRseifOtpQS+cL5pwetsIN745y4MeZzQXBBQtfevIOZcVObOpIlOO2nlJqW4V
         KqrVBL90WXqljbjhmReyvCZps9OEH2izKM1CY=
Received: by 10.216.155.134 with SMTP id j6mr100005wek.81.1311777357072; Wed,
 27 Jul 2011 07:35:57 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 07:35:37 -0700 (PDT)
In-Reply-To: <20110727142815.GC24785@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177970>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder writes:
>>> Ramkumar Ramachandra wrote:
>
>>>> + =C2=A0 =C2=A0 if (opts->subcommand =3D=3D REPLAY_RESET) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_sequencer_state=
(1);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>>> + =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start a new cherry-=
pick/ revert sequence */
>>>
>>> Can un-indent by dropping the "else":
>>
>> Actually this was intentional; if we un-indent this now, there'll be=
 a
>> diff indenting it when '--reset' and '--continue' are introduced whi=
ch
>> turns out to be especially ugly :)
>
> Why couldn't it look like this at the end, for example? =C2=A0(As alw=
ays,
> this is just an example; I am not saying "please make it look like
> this".)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->subcommand =3D=3D REPLAY_RESET) =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_sequenc=
er_state(1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->subcommand =3D=3D REPLAY_CONTINU=
E) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... prepare to=
do list for continue ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... prepare to=
do list for a new cherry-pick ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick the chosen commits

Mainly style.  It looks a little unnatural: when more subcommands come
up, I'd like a nice switch-case to dispatch :)

-- Ram
