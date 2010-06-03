From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 16:00:09 +0000
Message-ID: <AANLkTinUrK3zdFCWashnGquEtVovmihT1qYQAM5gHk5X@mail.gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 18:00:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCqB-0007SY-LL
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab0FCQAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 12:00:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54443 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab0FCQAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 12:00:11 -0400
Received: by yxl31 with SMTP id 31so115462yxl.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BKrt+JGzpWCVrLNHcyF8o1vvZeHLjVL2d1nSwwx2UoA=;
        b=fhMPwMrgsS47fCG54Bb0pR7L3RENXTYeGA+3k3I5PgaZIMY6dsj7bGdeJf+8s2ifbm
         Z47CsXti4ylSMEFzJbwtJZRT5BIfexPHK7hnMnDvwPNVjrhYKAqiX037BTc1uW9S0h4E
         xulUrPWi1GzZbkw+6W0JUZTy/ZzdwMoMh1zz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yq+qWFk+qlVTrz2pwSqLNNRqywrn+6nQuVd5Xw5JSG3Xu7+/DO4sJygvKxzkxRwuPy
         FtASAUBmgpKLmQ2QGHPjarjI89TXG+BkCSCsnk8eisWI1VVLMra9QCM7P791YVHnrfYS
         sUF+w19+jRjpckYkqvUIF3DSN3eRA4Ldg3QBI=
Received: by 10.42.6.205 with SMTP id b13mr10142053icb.16.1275580809650; Thu, 
	03 Jun 2010 09:00:09 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 3 Jun 2010 09:00:09 -0700 (PDT)
In-Reply-To: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148340>

On Thu, Jun 3, 2010 at 13:55, Pavan Kumar Sunkara
<pavan.sss1991@gmail.com> wrote:
> +sub evaluate_gitweb_config {
> + =C2=A0 =C2=A0 =C2=A0 # die if there are errors parsing config file
> + =C2=A0 =C2=A0 =C2=A0 if (-e $GITWEB_CONFIG) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do $GITWEB_CONFIG;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die $@ if $@;
> + =C2=A0 =C2=A0 =C2=A0 } elsif (-e $GITWEB_CONFIG_SYSTEM) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do $GITWEB_CONFIG_=
SYSTEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die $@ if $@;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}

I think I mentioned this before, but why not *optionally* use
Config::Any (or something similar) and if it doesn't exists fall back
on do(), and document this, along with a way to disable Perl
execution.

It'd be completely compatible, but admins could then allow someone to
edit a gitweb config file without opening themselves up to that
someone having permission to execute code as the webserver.

Check out Gitalist (the Catalyst rewrite of Gitweb) for some prior
art.
