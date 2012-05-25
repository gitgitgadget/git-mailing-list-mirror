From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH 3/3] xdiff: import new 32-bit version of count_masked_bytes()
Date: Fri, 25 May 2012 17:18:00 +0200
Message-ID: <CAA787rkRZudv96wJ4WPFWt7k0Y628dvhxrPes1g6rbw8C_Kiog@mail.gmail.com>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
	<4FB4A4B9.3080009@lsrfire.ath.cx>
	<xmqqmx56rd2r.fsf@junio.mtv.corp.google.com>
	<4FB5460C.10807@lsrfire.ath.cx>
	<CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
	<4FBBF8E9.7020103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 25 17:18:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXwHJ-0005zp-7m
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 17:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab2EYPSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 11:18:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46012 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab2EYPSB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 11:18:01 -0400
Received: by pbbrp8 with SMTP id rp8so1887096pbb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GFWms0Ar4f8dWh/OhicaD79PFhp2hJ5rhfLj6mqLaAk=;
        b=W5Z6Gu6vyLXm+ITPYHASofIKuU4QWlq5/x7VMb6+QlURpgh9WtQqWKfezwZztRUqrW
         cqNEJzZ3KSAkJNxjCaniz154oKJu+fTc82ec1TETCmJcJmpZO2jeZyIp5ntRasI3u3Jy
         0/XKii+vKBN3F5b+iUIR9wAqIdnaQesHXXIt0VTDz08hH4KlP8UPBh3ioS3lpSxU3jzL
         1Hor0cH4W63ubhTL1LwKMwAViyM0YINFWQJ8FczSB+fTqu0Rf7AwIFyXROdgl4Xur38s
         sngoorEJm2QJYiakzbZW0y4rKSLCvZu1TuursBdz9pcVP3mYtgxSHrD+hIhcSWoMVwvn
         Is0g==
Received: by 10.68.190.131 with SMTP id gq3mr11541962pbc.17.1337959080965;
 Fri, 25 May 2012 08:18:00 -0700 (PDT)
Received: by 10.68.26.98 with HTTP; Fri, 25 May 2012 08:18:00 -0700 (PDT)
In-Reply-To: <4FBBF8E9.7020103@lsrfire.ath.cx>
X-Google-Sender-Auth: HB3fZZrLwNz4Ye5GnVvoxB7cdbo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198477>

On 22 May 2012 22:36, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> w=
rote:
> Import the latest 32-bit implementation of count_masked_bytes() from
> Linux (arch/x86/include/asm/word-at-a-time.h). =C2=A0It's shorter and=
 avoids
> overflows and negative numbers.
>
> This fixes test failures on 32-bit, where negative partial results ha=
d
> been shifted right using the "wrong" method (logical shift right inst=
ead
> of arithmetic short right). =C2=A0The compiler is free to chose the m=
ethod,
> so it was only wrong in the sense that it didn't work as intended by =
us.
>
> Reported-by: =C3=98yvind A. Holm <sunny@sunbase.org>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> Does this fix all the warnings, and do the tests pass? =C2=A0I can on=
ly
> reproduce the "shifting to far to the right" warning..

Hi, I finally got around to test this, and it compiles flawlessly with
your three patches. No warnings, and the test suite seems to run
without errors.

Nice work, sir.

Cheers,
=C3=98yvind
