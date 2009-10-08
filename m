From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix the exit code of MSVC build scripts on cygwin
Date: Thu, 8 Oct 2009 22:13:18 +0200
Message-ID: <81b0412b0910081313x31f72916p6fddd1a23df154df@mail.gmail.com>
References: <4ACE064B.5020909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, mstormo@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvzQ0-0002kA-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 22:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbZJHUN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2009 16:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139AbZJHUN4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 16:13:56 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:48240 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbZJHUNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 16:13:55 -0400
Received: by fxm27 with SMTP id 27so5881559fxm.17
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8eao0GHxeoVPa22Qgk4y3ynnZVTAtApbZVbfwOHpgt4=;
        b=BbIOnFl6vnQdVnmbm5cM7oV83kDKf6Rc2VMnulHIBhZguZZbrvNpbu1NqW8nFKZiz7
         Ua5ldBgdOFTJ+5CK+L97PAUzDY+j6bKziZGJ+koIgT+b4tlVG9jFZfOfTg53copOq7OQ
         YzxrZFCUIy4+swXxel58MHQkERFc3vZCXY83I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W7rWFjJ7VVbUBNH/CsZAzlImUDXPwXc6XjmtvXbQYfWJf2yParq1U8msdPazpyHHfl
         +MVuhubIXUwCU8RzL9QdOYmDms3sfrXhXVPKEva1HiMlBMPiRdy1xaqQIftLkgjuF6wq
         Iiakfodh1E+vAHp+shml7/aNweLmOkKRvk7FU=
Received: by 10.204.34.65 with SMTP id k1mr103176bkd.111.1255032798460; Thu, 
	08 Oct 2009 13:13:18 -0700 (PDT)
In-Reply-To: <4ACE064B.5020909@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129714>

On Thu, Oct 8, 2009 at 17:33, Ramsay Jones <ramsay@ramsay1.demon.co.uk>=
 wrote:
> diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts=
/clink.pl
> index 0ffd59f..26aec61 100644
> --- a/compat/vcbuild/scripts/clink.pl
> +++ b/compat/vcbuild/scripts/clink.pl
> @@ -45,4 +45,6 @@ if ($is_linking) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push(@args, @cflags);
> =C2=A0}
> =C2=A0#printf("**** @args\n");
> -exit system(@args);
> +system(@args) =3D=3D 0
> + =C2=A0 =C2=A0 =C2=A0 or exit 1;
> +exit 0;

exit(system(@args) !=3D 0);

Yours looks a little verbose...
