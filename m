From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] builtin/checkout: learn -B
Date: Thu, 24 Jun 2010 03:13:25 +0800
Message-ID: <AANLkTinBBuxPKiflz1qMvbuNk8ACSN8IjVcAbefawony@mail.gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
	<1277140782-4064-1-git-send-email-rctay89@gmail.com>
	<1277140782-4064-2-git-send-email-rctay89@gmail.com>
	<1277140782-4064-3-git-send-email-rctay89@gmail.com>
	<1277140782-4064-4-git-send-email-rctay89@gmail.com>
	<7vr5jxegvd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVOA-00009Y-Hg
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab0FWTN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 15:13:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0FWTN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:13:27 -0400
Received: by iwn1 with SMTP id 1so45839iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TvOBHqDOCLayWJU/j+lIL1GPdPqJ//iqN6Yujpiddjs=;
        b=CIG8BA7QsaZkjuzr4RZdH2dBNKhfkHDKyGJEGgyM1b3JMb/96vWzMoxQ3raRCCG8Hr
         /767tYo6YyrHgl8avGSULb+k81x5LruRnd3/kMO7jv3EAYLPKno2BJ82fYkJoEyBYX8/
         mIj0PmYljpxOH2d69HR1r9uVEgH0RXEtF9cdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jWfHavUSn+l3PWMAIcjF/mIoKlinH0MlKCPLUcpqHb5Vn9SJD+w9qLp8GnFYvJOQpb
         o4cDLhygIvSU3PkXmdNmtAVJlewQvOWhoEkVbtzABiecwH1XZE/P1FIRiWlthJ/zMOn0
         3qyGeBkYbWxmdMbM8XUYI+mhk1Sv49Hqc4lqY=
Received: by 10.231.169.9 with SMTP id w9mr9706191iby.58.1277320405799; Wed, 
	23 Jun 2010 12:13:25 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Wed, 23 Jun 2010 12:13:25 -0700 (PDT)
In-Reply-To: <7vr5jxegvd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149531>

On Thu, Jun 24, 2010 at 2:36 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index 261dd90..5849e13 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -31,6 +31,13 @@ were called and then checked out; in this case yo=
u can
>> =A0use the `--track` or `--no-track` options, which will be passed t=
o
>> =A0'git branch'. =A0As a convenience, `--track` without `-b` implies=
 branch
>> =A0creation; see the description of `--track` below.
>> ++
>> +If `-B` is given, <branch> is created if it doesn't exist; otherwis=
e, it
>> +is reset. This is equivalent to
>> ++
>> +------------
>> +$ git branch -f <branch> [<start point>] && git checkout <branch>
>> +------------
>
> It is somewhat sad if these are truly equivalent. =A0In the above seq=
uence,
> "git checkout <branch>" could stop to prevent you from clobbering you=
r
> local changes, but at that point the branch has already been updated.
>
> I was hoping that the check (and stop) can be done first and then the
> branch head is cloberred after you know you will succeed the checkout=
=2E

hmm - would

  git checkout <branch> && git reset --keep <start point>

make the cut?

--=20
Cheers,
Ray Chuan
