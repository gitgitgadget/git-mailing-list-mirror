From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit 
	right after init
Date: Thu, 26 Mar 2009 09:54:56 +1100
Message-ID: <fcaeb9bf0903251554o5c6d390cmbb81d06f9886f8e2@mail.gmail.com>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> 
	<20090325113510.GB4437@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmc1i-0007xP-4q
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZCYWzP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 18:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZCYWzO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 18:55:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:30208 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbZCYWzN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 18:55:13 -0400
Received: by wf-out-1314.google.com with SMTP id 29so294591wff.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JvwKOKjSFHKOqUeB/zUyyrgQ75nVk5Wt53qiip7iEAk=;
        b=ZlhrX49M78Y9m2+qtk/t2zRKLkHDhNGs42IdkWJsIUsSHVLmUqKwqijCsNe4KsfkEK
         QmywtdhTpJRh8u8yzhoImh/7fDVPJwjcwv5mQEnfeR6U8bwTfzh1H+kecU+pd17aYhYj
         fXDXXdczW006D1nm2e3WZ2/k5EOQFfI9SsWpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Uqizw79wRtGV7EXJ8po1buYMgvk1oN7Fat7SkRwwsq4kRwxcFSqOrAyJ7i426nls0o
         1nS1EZVES7BD2zvGU31SGbGrpbMbdEFO78CaNU172+fDF4VUNReAtcb4n9hpswiq10YI
         XgcWdiS/R9X+n+6uzrkQEzSGPC06R0Ai3hppQ=
In-Reply-To: <20090325113510.GB4437@coredump.intra.peff.net>
Received: by 10.142.140.6 with SMTP id n6mr59402wfd.13.1238021711228; Wed, 25 
	Mar 2009 15:55:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114688>

2009/3/25 Jeff King <peff@peff.net>:
> On Wed, Mar 25, 2009 at 09:58:40PM +1100, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> -'git init' [-q | --quiet] [--bare] [--template=3D<template_director=
y>] [--shared[=3D<permissions>]]
>> +'git init' [-q | --quiet] [--bare] [--template=3D<template_director=
y>]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--shared[=3D<permissions>]] [-=
m|--import [<message>]]
>
> What happened to --import=3D? Whether or not "--import <arg>" works, =
the
> --long-opt=3D form should always work.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(arg, "-=
-import") || !strcmp(arg, "-m")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (i+1 >=3D argc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import_message =3D "Initial commit";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import_message =3D argv[2];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> This is the wrong way to do optional arguments. It means that
>
> =C2=A0git init --template=3Dfoo --import
>
> is different from
>
> =C2=A0git init --import --template=3Dfoo
>
> I think what you want is:
>
> =C2=A0else if (!strcmp(arg, "-m")) {
> =C2=A0 =C2=A0if (i+1 >=3D argc)
> =C2=A0 =C2=A0 =C2=A0die("-m requires an import message");
> =C2=A0 =C2=A0import_message =3D argv[2];
> =C2=A0 =C2=A0i++;
> =C2=A0 =C2=A0argv++;
> =C2=A0}
> =C2=A0else if (!strcmp(arg, "--import"))
> =C2=A0 =C2=A0import_message =3D "Initial commit";
> =C2=A0else if (!prefixcmp(arg, "--import=3D"))
> =C2=A0 =C2=A0 =C2=A0import_message =3D arg+9;
>
> That is, --import has a message or not depending on the '=3D', and "-=
m"
> always has a message. If you want "-m" to optionally have a message t=
hen
> it must be used as
>
> =C2=A0git init -mfoo

Right. Should not work late (or send it in the same night). Will rework=
=2E
--=20
Duy
