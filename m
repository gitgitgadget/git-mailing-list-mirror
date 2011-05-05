From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 5 May 2011 07:47:43 +0200
Message-ID: <BANLkTik6pcz696xJyoOju8a3ToResLF+3w@mail.gmail.com>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
	<7vk4e6c5rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 07:47:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHrPh-0006fr-3B
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 07:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab1EEFrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 01:47:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35160 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1EEFro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 01:47:44 -0400
Received: by fxm17 with SMTP id 17so1300384fxm.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 22:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hH4KSsd08OXNAdeCz31z/72tEslwWOEgh3Jt3tUWmeQ=;
        b=Egg+nclRasz9XKXVTf1W4jKZps1O7stQeBs/geAN6xWc6XhUyFavLwvbFqEh+1h0Z/
         CTyUg+TxQSGaJRaDCWQTqNEwBh8lhcWxOxwMpNSFl3dq1inP7gAcjzUyV5HYiwFxc51o
         eVmkUK06iHeZ0uMSplu7BDSpa5WyPzZFxaBCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pUo6wHcn07k2aDj5lZ8fyrmEK1OFJjxN2q9tfWmBpn4DZUmxjP9QMRS/KrRV+CkGBK
         N6O2pWvolxF1I0lmvfNgEgNEh2blGzmvormQuATcQx56yqHNCas4rMLG9W2M0xJztDsz
         7i6Mu0Ydw9ZPLVNTYKBDOKloyoAZUMxx+TzUk=
Received: by 10.223.59.81 with SMTP id k17mr2231709fah.94.1304574463361; Wed,
 04 May 2011 22:47:43 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Wed, 4 May 2011 22:47:43 -0700 (PDT)
In-Reply-To: <7vk4e6c5rh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172799>

2011/5/5 Junio C Hamano <gitster@pobox.com>:
> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>
>> @@ -33,6 +39,8 @@ struct grep_pat {
>> =C2=A0 =C2=A0 =C2=A0 size_t patternlen;
>> =C2=A0 =C2=A0 =C2=A0 enum grep_header_field field;
>> =C2=A0 =C2=A0 =C2=A0 regex_t regexp;
>> + =C2=A0 =C2=A0 pcre *pcre_regexp;
>> + =C2=A0 =C2=A0 pcre_extra *extra;
>
> I don't think pcre will forever stay the _only_ thing that wants to h=
ook
> an extra information to this structure. =C2=A0That is why I included =
"pcre_" in
> the field name in my earlier "how about doing it this way" suggestion=
=2E

I would also suggest to share the space between regex_t and the
(pcre*,pcre_extra*) tuple, like i did in my patch titled 'prepare for
re-using the space...' from May 2. Sacrificing one bit to indicate
that this is a pcre compiled pattern should not hurt, because there
are bits left.

Bert
