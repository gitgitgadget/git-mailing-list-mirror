From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Buglet in i18n?
Date: Sat, 23 Oct 2010 11:32:47 +0000
Message-ID: <AANLkTi=Q91mQ9ucLZw1E+1MuA+niXJFvmx1xw8JVYuuH@mail.gmail.com>
References: <4CC13AC1.7080402@viscovery.net>
	<AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
	<20101022083450.GA8289@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 13:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9cLX-000362-1U
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 13:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0JWLct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 07:32:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40513 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab0JWLcs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 07:32:48 -0400
Received: by fxm16 with SMTP id 16so1432061fxm.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8xMKt0tqpIWqFJuIdb3qp5MIFxr6Z4peBx5sfY3db0U=;
        b=hhPFfrWz80GfzsmfNOqjbY95CnF6JP5rU69jXmq63pCQv4OGkcjEZq6R7sdr8MK2P0
         M7gR3j5fDfZ+ymn4zh1sXin8kY9w8+jXj3R6152xrlzvRhJQGbWkB/yA6EcKeBzFLObN
         hGmmRne3k7aD6LzHW2GD3KQbhI3/UbJPH5lEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FfATTekEKBdwIMJ/+HBoWvSqzImXu+EVonsBlbdK3m1OmDptlbj31SkX0c47g26qm6
         0ThCsEuiglfbjHJOVlhN3d96kgV6TbOvZZFM9Ci1RIQEAE4KN3T1taIP2peMG7MfEho4
         i2mu+q3Ge3TfznMOT+zlR4C1Om3CDzAk0970E=
Received: by 10.103.192.8 with SMTP id u8mr4795958mup.20.1287833567538; Sat,
 23 Oct 2010 04:32:47 -0700 (PDT)
Received: by 10.223.115.5 with HTTP; Sat, 23 Oct 2010 04:32:47 -0700 (PDT)
In-Reply-To: <20101022083450.GA8289@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159778>

On Fri, Oct 22, 2010 at 08:34, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext () {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf "%s" "$1"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval_gettext () {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext_eval=3D"printf '%s=
' \"$1\""
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf "%s" "`eval \"$gett=
ext_eval\"`"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> This looks wrong. =C2=A0Consider a simplified example:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval_gettext 'foo "bar baz"'
>
> Now eval_gettext is supposed to just interpolate $variable
> substitutions, right? =C2=A0In particular, the quotation marks
> ought to be preserved.
>
> But instead, what gets evaluated is:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s' "foo "bar baz""
>
> which splits as
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s' 'foo bar' 'baz'
>
> which is equivalent to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s' 'foo bar'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s' 'baz'
>
> with output
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0foo barbaz

Indeed. It's a bug.

> Maybe something like this would do it?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext_eval=3D$(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s\n' =
"$1" |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sed '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s/[`\\"]/\\&/g
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01 s/^/printf "%s" "/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0$ s/$/"/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval "$gettext_eval"

That prints:

    foo "bar baz"

(with double quotes)

But what we want is:

    foo bar baz

But what we're getting is:

    foo barbaz

Have I got that right, sorry, not thinking clearly right now :)
