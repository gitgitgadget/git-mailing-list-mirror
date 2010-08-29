From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an
 ignored directory
Date: Sun, 29 Aug 2010 18:27:22 +0000
Message-ID: <AANLkTimE7LPV0NOdVXZZHgw8=NT061GjjfFYHxVn=X2B@mail.gmail.com>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
	<AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
	<vpqk4noc9ro.fsf@bauges.imag.fr>
	<20100819000052.GA11081@burratino>
	<AANLkTikLUQCnrDAp8c0QBWoGE1XUgXmd8g_19v3HnxJ4@mail.gmail.com>
	<20100825031341.GF11619@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Greg Brockman <gdb@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 20:29:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opmcs-0005nW-Cz
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 20:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab0H2S27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 14:28:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50596 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0H2S26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 14:28:58 -0400
Received: by iwn5 with SMTP id 5so4264233iwn.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d9vRYvCEhf7ySEBx+fYvm3vsUmbRydBkHiyd0DIPRfc=;
        b=TvzQx4rJoVwPul9TS5AnCbQCsOboAQikb132IPLUD1nWaqUvHCbgp9/iJAx3EgCT5Y
         +KaFjtxobdKp9qcUD9NVdQwDW96425S1PdLbL4sgC9jGyfDWpio+PP5/kzAzYh2NB9Dd
         DxdhLSDibYbQRxYxyYEEPxNwtVF/eEgUNcMc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dvNxABOIFC4QSr5uSXbmIUgibSPUlmhGluRWmbKTx5JgkhKaC/gQLFxuFl0Y4ZYbj2
         H8WHfSMVQN/4yRNl38mop6RJl028HQVR/dUyHfNJCDkPSv2Np/HEIutgjcdrtEF3mv2j
         zNntLE/dIeQFSODFGzNL4dtYz9ReMAdfYZSLc=
Received: by 10.231.170.79 with SMTP id c15mr4200383ibz.82.1283106442256; Sun,
 29 Aug 2010 11:27:22 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 11:27:22 -0700 (PDT)
In-Reply-To: <20100825031341.GF11619@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154700>

On Wed, Aug 25, 2010 at 03:13, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I just try to
>> (hopefully mostly helpfully) to point out common things that
>> contradict the docs we have
>
> Thanks for doing so, by the way. =C2=A0One of the best ways to make s=
ure
> the docs are sane is to use them.
>
> When a guideline is unclear, probably I should have been updating the
> docs instead of dispensing advice.
>
> How about something like this?
>
> diff --git a/t/README b/t/README
> index 410499a..f347de7 100644
> --- a/t/README
> +++ b/t/README
> @@ -235,7 +235,9 @@ Do's, don'ts & things to keep in mind
> =C2=A0-------------------------------------
>
> =C2=A0Here are a few examples of things you probably should and shoul=
dn't do
> -when writing tests.
> +when writing tests. =C2=A0If you are editing an existing test script=
 and have
> +the time for it, consider updating the script to follow these guidel=
ines
> +in a separate patch before adding your new test.

That looks good.
