From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH 1/2] git-svn: use POSIX::sigprocmask to block signals
Date: Wed, 11 Apr 2012 15:22:56 +0400
Message-ID: <CANiYKX56EnCJu6qTEJC=K7HVquObDXYCxRCPxn2YuJk+MZDmBQ@mail.gmail.com>
References: <cover.1333381684.git.rkagan@mail.ru>
	<9eaaebac91dc2b1a45a4dec77142be0b0b338056.1333381684.git.rkagan@mail.ru>
	<20120410211120.GA27555@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 13:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHvde-0002C3-LY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 13:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab2DKLW6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 07:22:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65356 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab2DKLW5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 07:22:57 -0400
Received: by obbtb18 with SMTP id tb18so1092889obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LqB2nsZR+m6yXxAwt/mIOA/U7doXbUbBEjlQgsdAsb4=;
        b=eQ+82VtWo7ylYCBeBBGcTHiQknKERi4I/zLWTXaj3Wu7V1tyZmQnVHF6LJWPpXhhEO
         rFzFUSHWwQ2r4pD6sXRvHM+q1o0sFBDLHfZH97W3wYxvUJZRwnqjmgvo1Oe0dzCE4XQq
         h+2vCAlkZT+K9S3UMa3EjJyYBgiqR1P26qnTHh2aQoRCGQeZrD9bBULk0ZDJMMky6KUq
         8aL8awx1+ucNp8Av3pCk/tpAJDYPkLkzO6rATV3Av9hmuI8F5PXxVa3bXCSsZWFXaxUQ
         WWvShJZnaPoLJ4y+HM8hugDjEefIzPYxFTowIrmLpKLHeOTnevVxHSxDv9xckSHLs/1j
         YQqA==
Received: by 10.60.36.100 with SMTP id p4mr21267925oej.42.1334143377225; Wed,
 11 Apr 2012 04:22:57 -0700 (PDT)
Received: by 10.182.46.129 with HTTP; Wed, 11 Apr 2012 04:22:56 -0700 (PDT)
In-Reply-To: <20120410211120.GA27555@dcvr.yhbt.net>
X-Google-Sender-Auth: TkysP1CtYDfKt5ZzktBZip-RC3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195167>

11 =C1=D0=D2=C5=CC=D1 2012=9A=C7. 1:11 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=CC=
=D8 Eric Wong <normalperson@yhbt.net> =CE=C1=D0=C9=D3=C1=CC:
> Roman Kagan <rkagan@mail.ru> wrote:
>> + =9A =9A =9A =9A =9A =9A my $signew =3D POSIX::SigSet->new(SIGINT, =
SIGHUP, SIGTERM,
>> + =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A SIGALRM, SIGPIPE, SIGUSR1,=
 SIGUSR2);
>
> Considering your 2/2 patch, can we remove SIGPIPE here?

Doing it in this patch (i.e. before SIGPIPE gets ignored by the second
patch) would be illogical.

I can submit another patch which removes SIGPIPE from the list of
blocked signals (the reason would be mostly aesthetic since blocking
an ignored signal is harmless anyway).

Roman.
