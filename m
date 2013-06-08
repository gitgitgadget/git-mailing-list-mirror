From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 8 Jun 2013 12:27:55 -0500
Message-ID: <CAMP44s1ffOUd3DkphHAj8ZmovBazPFdMgtvEptR6kW9+ZMLLjA@mail.gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
	<CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
	<51B32FFD.5070302@lsrfire.ath.cx>
	<CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
	<51B35414.1090101@lsrfire.ath.cx>
	<CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com>
	<51B36849.3030608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMvq-0000li-F7
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab3FHR16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 13:27:58 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:51450 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3FHR16 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 13:27:58 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so3140851lab.12
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ObEPFH3jj+NpNDKMjIytkmUKIALugkkjqbZ9anAshLs=;
        b=Xqr1Xs+VGKGM4uy4U2ZUBcecyFSeq4YtmLHmSFNXgyjpsmfU9NOykdCVFMo3iUX6Xg
         gwpoqSpE+D+46DXPQAyp2nLhZIzXNYDz0dI9acvUxaDWghYeLl0CI7e8rqnFlHIRqBBP
         AvjX7ztucu9mRB7LxL8Yh7R1iiM0TwuHWKoiOHrDmFTgqCfYVP0G82URgX3LwYwWbHjK
         LuFMYH4PKbjL4UkrPXwlEkxxLl3fNEMwUk6K7/F2DE4YPfFNE8oIK5rzp1iZ516T3Pya
         Xa7hjTAqKcI0jtBmr0ibM9FE+9OHx1eR8vsfJbmwktlcQOcWdHhbdfNdmJQBqBeO4VU+
         rfaw==
X-Received: by 10.152.26.225 with SMTP id o1mr1682886lag.43.1370712475813;
 Sat, 08 Jun 2013 10:27:55 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 10:27:55 -0700 (PDT)
In-Reply-To: <51B36849.3030608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226844>

On Sat, Jun 8, 2013 at 12:22 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:

> Let's find and fix those leaks by freeing memory in the right places.
> Freeing memory just in case in places where we can show that no leak =
is
> triggered by our test suite doesn't help.

It helps; it prevents leaks. The real culprit is the bogus API, but I
don't see that changing anytime soon, so there are two options when
somebody makes a mistake the API allows; leak or don't leak. And you
seem to prefer the leak, even though it provides absolutely no
advantage.

--=20
=46elipe Contreras
