From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Support generate poison .mo files for testing
Date: Wed, 22 Aug 2012 19:37:04 +0700
Message-ID: <CACsJy8Dp5FZd9Ko6o18r5TeS5dfbjv61wOmP1452zyvHfX5LMQ@mail.gmail.com>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org> <1345613246-4053-1-git-send-email-pclouds@gmail.com>
 <7vboi3b2n8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 14:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ABq-0004d8-1C
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 14:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab2HVMhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 08:37:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54605 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2HVMhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 08:37:35 -0400
Received: by ialo24 with SMTP id o24so821627ial.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yHta9EW6E/dTSEiMRaW1XaMpYxm2mLAVJfCH3ndScJo=;
        b=MAvSOlGRT7en4Bth0tlhr36UcDO8k3fAu9768ux+xaZQXoIztceOIS6dJI1qh2l+MC
         vlRwAF45qQP8FvbQTRvhjdC4Q+Sl3lEHsJUjoZxwvP/UUAhtg1Ia8NmeJdUCdSxmtsyt
         w2mvNo7tq9b9aNzwEOWIBM9KNC2/LL9cxUSnFlKH1CChwY4SB5up+wdv5e2r2GFeUGPJ
         BL3bNkcNE+dftRWKvfp6OO1Tw3rw2jrpPsvPy94u+VzsNRybxuMOvyLl+g+75vDpMYuy
         tHm7kXwksSiD2nVKCfnWoSaxaaVTQlzaTgI3LHlALfQsGg7xB4Mouw8W5m7cNZLaXqZR
         LQKA==
Received: by 10.50.220.194 with SMTP id py2mr2006182igc.15.1345639054652; Wed,
 22 Aug 2012 05:37:34 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Wed, 22 Aug 2012 05:37:04 -0700 (PDT)
In-Reply-To: <7vboi3b2n8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204014>

On Wed, Aug 22, 2012 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> test-poisongen does a similar job to gettext poison feature except
>> that it does it at build time. Gibberish .mo files are generated for
>> all supported langauges and put in po/build/poison-locale. Target
>> "poison-locale" is for this.
>
> What is the significance of this locale being "Gibberish"?
> Currently, for any string, we give "### gettext poison ###" or
> something but the only thing we care about in the poison mode is
> that it is different from the message id, no?  I was wondering if
> these phony translations can be something simple like "Add QQ at the
> beginning of the message id string" and still can catch mistakenly
> marked messages that come from the plumbing layer, or something.

I'm gradually getting there, partly thanks to your question about
grepping "tracked" in another thread. This patch does not really
generate random strings. It repeats the pattern "* gettext poison *"
for evey character that can be replaced. But a better way could be
replacing "tracked" with "t r a c k e d". We know the rule so we can
recreate the that string from "tracked" in test_i18n*. Or reverse the
upper/lower case, whichever is easier for the recreation by test_i18n*

>>  mode change 100644 =3D> 100755 t/test-lib.sh
>>  create mode 100644 test-poisongen.c
>>  mode change 100644 =3D> 100755 wrap-for-bin.sh
>
> Thanks.  I suspect two mode changes weren't intentional?

It's an emacs hook gone bad.
--=20
Duy
