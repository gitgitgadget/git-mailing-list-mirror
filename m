From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] sparse checkout: do not eagerly decide the fate for
 whole directory
Date: Wed, 11 May 2011 19:03:18 +0700
Message-ID: <BANLkTimxpUwu3SQ9XNv1fUaM-0UwqPNUrg@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340464-14829-3-git-send-email-pclouds@gmail.com> <BANLkTikgNR1G5_TO3rmMZy3fN2PNF2Pqjg@mail.gmail.com>
 <BANLkTimDO7yRyiBt7xS5Hy7-iT5SUDwJtA@mail.gmail.com> <7vliyegm98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	skillzero@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBsb-00073x-C0
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab1EKQBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 12:01:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40175 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab1EKQBh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 12:01:37 -0400
Received: by fxm17 with SMTP id 17so474750fxm.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=vSehnxvybJUIYyKMaVjTkYBpIhz/2uUesRutS1Obbc0=;
        b=s99gKBX8n6JzycpPnGfyXiACgcbtQ7W+KNysAM44qOGU3hh8/UOlnFPzRPSa8f5HTh
         rSonvQAIUqvMOvsg6z3pbJ3CjmplinyGLApT/QoEv0kT2CaMFVuz466HWolWSWJiBEaV
         8WAcnfNygoYsjDw/XDbDnhHOPuN5M2b/w5k0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IK536gwmrqRQRfLrIEKVL14ZxuzUzO+Umw9ZwUXlAmd8DFePoQ8oLIgP34eogk9fKD
         PzAATOHe51CbhbZA/rDds/PVBPKJf4ZtFTcq66gF6Bej6nj9MasNC/8XcuJK/IyPT+BK
         7mZATC8Gs78Vsz2j7qyEVaPPt51DPuTi6u+f0=
Received: by 10.223.86.130 with SMTP id s2mr2063483fal.115.1305115428204; Wed,
 11 May 2011 05:03:48 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Wed, 11 May 2011 05:03:18 -0700 (PDT)
In-Reply-To: <7vliyegm98.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173399>

On Wed, May 11, 2011 at 6:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>>> + =C2=A0 =C2=A0 =C2=A0 /* If undecided, use parent directory's dec=
ision in defval */
>>> What means "use parent directory's decision"? Could you make this
>>> comment more clearer?
>>
>> Take the example patterns in commit message, we know that we match
>> directory "t" (pattern 1). When we check t/0001-init.sh, no patterns
>> match it. But because it's under "t", so we consider it matched. On
>> the other hand, t/t0000-basic.sh will match pattern 2 and override
>> parent directory's decision.
>
> Somebody ask about the comment you wrote, and you had to explain it.
> Doesn't it tell us something about the readability of the comment?
>
> After all the request was "Could you make it clearer?"

He did not reply whether my further explanation was good enough. Maybe =
this?

excluded_from_list() can't decide whether the entry matches given
patterns. If the current directory is matched before (ie. in defval),
then by default the entry is also matched.
--=20
Duy
