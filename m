From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Thu, 4 Aug 2011 07:40:12 +1000
Message-ID: <CAH3AnrrMUiWkRk0ocr4RY05qj7GU5hqSkaxy+zYJRx12o=hwNA@mail.gmail.com>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
	<1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
	<7voc07ct9z.fsf@alter.siamese.dyndns.org>
	<20110803185719.GA4275@elie.Hillsp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, j6t@kdbg.org, jnareb@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojAo-0007N5-En
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1HCVkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 17:40:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35843 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab1HCVkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 17:40:13 -0400
Received: by vws1 with SMTP id 1so664961vws.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dgiyEV8KP8ex5kL/LLsgcMw7Qf7WOpXZg9n86qvu+zM=;
        b=dh7J2nXlwO4C5amHMS7R9QV637albUYodK3Ssjy4qFN6Qf2qRCKbx5wijYGWF86KUc
         AwQsWBcptKJafUekiAzEHu82w7oQCfvbLsT659jGC6Yz9VznTW/kku6hrhJl1BiRzj3f
         aDTTRCMCKgsvQlw0SWf3SvkF/r29ODlsMiVoY=
Received: by 10.52.175.162 with SMTP id cb2mr29027vdc.432.1312407612135; Wed,
 03 Aug 2011 14:40:12 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 14:40:12 -0700 (PDT)
In-Reply-To: <20110803185719.GA4275@elie.Hillsp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178624>

On Thu, Aug 4, 2011 at 4:57 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Junio C Hamano wrote:
>
>> Just a minor worry but I would not be surprised if somebody's "test"
>> implementation barfs upon:
>>
>> =C2=A0 =C2=A0 =C2=A0 test "--no-checkout" =3D "--no-checkout"
>>
>> mistaking the string with a dash at the beginning as an option unkno=
wn to
>> it. That is why we often have "z$variable" in our comparison, like s=
o:
>>
>> =C2=A0 =C2=A0 =C2=A0 if test "z$BISECT_MODE" =3D "z--no-checkout"
>
> Hmm.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git grep -e 'test "\$' | wc -l
> =C2=A0 =C2=A0 =C2=A0 =C2=A0712
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git grep -e 'test ".\$' | wc -l
> =C2=A0 =C2=A0 =C2=A0 =C2=A0183
>
> We are very inconsistent about such usage, generally, and of course
> POSIX is very clear about the 'z' not being needed in a three-argumen=
t
> "test" used for string comparison. =C2=A0Is there any platform that i=
s
> usable for git (e.g., that implements "$( ... )") and has that
> problem?
>

Thanks. Applied.
