From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 00:04:33 -0400
Message-ID: <CAG+J_DxzcuYiffm6XVX-RQSxeMwy4Yi7CdhCdddAN=xRyJ2b5Q@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
	<1316961212.4388.5.camel@centaur.lab.cmartin.tk>
	<7vaa9r2jii.fsf@alter.siamese.dyndns.org>
	<1317073309.5579.9.camel@centaur.lab.cmartin.tk>
	<e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
	<4E81F080.7010905@drmicha.warpmail.net>
	<CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
	<7v39fhyk21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 06:04:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8lNx-0001dU-GP
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 06:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab1I1EEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 00:04:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52184 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1I1EEe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 00:04:34 -0400
Received: by ywb5 with SMTP id 5so6029007ywb.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+4sbVtbnVIsEPtp+MNkULdzyorjJ7D/SLZJJT6JKEJs=;
        b=uQh3DrQsUIvTck9/9dCxdwJ/fSZ0OGcHymASfRHoIVXgFx98OaimBzx5cSbEYo0a+B
         pXDC9ZWAURpTRhZZuA6TNtfM0loiHxMpNO/unQmJ5ZgXbHbKpw7YVP1aB9cxj4vIFPRR
         kjUzPTczl5uu0fcTxgnRWaam6Q/iJ/aqa9Xsw=
Received: by 10.147.5.21 with SMTP id h21mr1721108yai.26.1317182673628; Tue,
 27 Sep 2011 21:04:33 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Tue, 27 Sep 2011 21:04:33 -0700 (PDT)
In-Reply-To: <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182289>

On Tue, Sep 27, 2011 at 1:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> It seems like a more logical approach would be instead for "git
>> commit" to take a "--root" option that would create a new root commi=
t
>> based on the current index and then point the current branch head to
>> the new root commit. Thus:
>>
>> =C2=A0 $ git checkout -b new_branch old_branch
>> =C2=A0 $ # Manipulate or not
>> =C2=A0 $ git commit --root
>>
>> That's how people think.
>
> This may indeed be an improvement. I suspect that we'd need to think =
about
> it a bit more, but it feels right (perhaps introduce this new option,
> deprecate --orphan from the checkout, and then eventually remove it
> sometime in 1.8.0 timeframe).

Hrm, create new_branch just so you can immediately clobber its SHA1
with the new commit that has no parents. That doesn't seem quite
right. Imagine you use "git commit --root" by accident while on
master, then you have to dig into your reflog?

But it's close. Maybe:

$ git commit --new-root-branch=3D<name>

Which creates <name> with the index as its sole commit and switches
you to that branch? That doesn't feel quite right either.

</thinking out loud>

j.
