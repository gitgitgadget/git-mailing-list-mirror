From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Sat, 28 Apr 2012 00:35:36 +0200
Message-ID: <4F9B1F38.8040406@gmail.com>
References: <20120426223422.GC22261@camk.edu.pl>	<1335518725-19728-1-git-send-email-zbyszek@in.waw.pl> <xmqqaa1x9mdi.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, Kacper Kornet <draenog@pld-linux.org>,
	git@vger.kernel.org, Lucian Poston <lucian.poston@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 00:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNtlT-0004fA-Ma
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 00:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab2D0Wfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 18:35:42 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56583 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab2D0Wfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 18:35:42 -0400
Received: by wgbdr13 with SMTP id dr13so1170570wgb.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mWUcoZfSpbBEvrDm2j/o5o+ocDZGbK/1bz0kGaFumrE=;
        b=f0qpJfJjnkCa2hS9/22A6u0oeLTWfyi6XtSK+jcMR3XV573YqREon6QZ0sP4u9MNYb
         arVKJzSKG4jTyOrPiXGNUV8mcePPJPMATuqwTX1moxv745tp/S+G9/8LRHL9UEw+ay0s
         Q1a/kN4y72VwGF/V/d2zYYDpJmD1MPuzOEjalOAtWapCZwLwQNcElaUMsnx4jJnfDAk7
         kb4i2VNlKQeDLCY+MJUMNF+8DSkzd46NtZR4/2r3eGkdcrsBVfL8L6Q5xuzlzoOYtonL
         AOfvXroDToIQOScnkaax13AcypPhFPoCbIeWfE4ZSeyCxnqo1IxHxVCIC+X+kigyu9iX
         JJSg==
Received: by 10.216.138.142 with SMTP id a14mr6674704wej.58.1335566140800;
        Fri, 27 Apr 2012 15:35:40 -0700 (PDT)
Received: from [82.56.30.188] (host188-30-dynamic.56-82-r.retail.telecomitalia.it. [82.56.30.188])
        by mx.google.com with ESMTPS id k6sm7787055wie.9.2012.04.27.15.35.38
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 15:35:39 -0700 (PDT)
In-Reply-To: <xmqqaa1x9mdi.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196486>

Hi Junio, Zbigniew.

On 04/27/2012 06:21 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
>> mksh does not allow $COLUMNS to be set below 12. Quoting mksh(1)
>> $COLUMNS is "always set, defaults to 80, unless the value as reporte=
d
>> by stty(1) is non-zero and sane enough". This applies also to settin=
g
>> it directly for one command:
>>
>> $ COLUMNS=3D30 python -c 'import os; print os.environ["COLUMNS"]'
>> 30
>> $ COLUMNS=3D20 python -c 'import os; print os.environ["COLUMNS"]'
>> 20
>> $ COLUMNS=3D10 python -c 'import os; print os.environ["COLUMNS"]'
>> 98
>=20
> I wonder if this is an easier workaround, though.
>=20
> 	env COLUMNS=3D10 $cmd
>=20
It works for me:

  $ mksh -c 'COLUMNS=3D10 env | grep COLUMNS'
  COLUMNS=3D113

  $ mksh -c 'env COLUMNS=3D10 env | grep COLUMNS'
  COLUMNS=3D10

  $ dpkg -l mksh
  ...
  ii  mksh  40.2-2  MirBSD Korn Shell

HTH,
  Stefano
