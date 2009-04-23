From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] tests: remove xargs in favor of --stdin where possible
Date: Thu, 23 Apr 2009 20:07:19 +1000
Message-ID: <fcaeb9bf0904230307h2d4ee691y412e9cf31e4e90c3@mail.gmail.com>
References: <1240468281-23815-1-git-send-email-pclouds@gmail.com> 
	<7vfxfzwytx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 12:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwvri-0003c6-9I
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 12:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbZDWKHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 06:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbZDWKHg
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 06:07:36 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:13617 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbZDWKHf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 06:07:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so291960and.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Viy4Tz6PzSCVYAFFrUwTjeN10KYsx8Fykh1vMHLfP/s=;
        b=Ikenpzo0rLOyAWibL6kJtHN4oiKcHlpB3ERH+BJe0HYdk/rd/GnWdukHDDV5md3sZ+
         bF/MxxDfhYeh7bB+ep/sVbn2igXqwQccFJXCgEJpPdHmdqriVsZhINsjtVyd9CP37UgQ
         gCLdkyoXiDFrfwkArscRc9964Iw78qyAIPbL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aFoQ+VgQrrloF9Wd1G3guBn8ODyDDbzVyvfrnwsqT3+2so8VOyG3KA661EBBLh8SKS
         4lrLX1N7fPh4B6idyXq1Wsno4Cg3l1FCJMzRXjvsm06e7vjkWCaX0VlLfGKyty01qudk
         /j5KxcV8NZRAkpM73PyNUrSnT/jXNfLqor9I0=
Received: by 10.100.178.9 with SMTP id a9mr735017anf.11.1240481254255; Thu, 23 
	Apr 2009 03:07:34 -0700 (PDT)
In-Reply-To: <7vfxfzwytx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117327>

2009/4/23 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0Patch "Convert to use quiet option when available" reminds me =
I had a similar
>> =C2=A0patch to remove (mostly) xargs usage from tests.
>
> The reason being...?
>
> =C2=A0(1) xargs is not universally available, or portable enough?
>
> =C2=A0(2) people may learn from tests, and we should demostrate our a=
bility?
>
> =C2=A0(3) something else?

I worked on busybox win32 port, less commands meant less work for me. S=
o (1).

> The tests may not break with your change because none of them may use
> problematic characters (especially "\n" and '"'), but update-index --=
stdin
> without -z is not suitable for reading from output from "find" withou=
t -0
> option (on the other hand, "update-index -z --stdin" is good for read=
ing
> output from "find -0"; but for portability we avoid GNUism "find -0")=
=2E

It can't be as safe as find -0| update-index -z, but it would be
equivalent to find|xargs, isn't it? Both separate arguments by \n.
--=20
Duy
