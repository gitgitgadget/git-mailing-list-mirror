From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 5/6] http-push: check path length before using it
Date: Sat, 20 Nov 2010 12:28:51 +0800
Message-ID: <AANLkTikJz+SigzqFdeP+rZR3FS06U1exDb59AsRFTQAj@mail.gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
	<1290170790-2200-2-git-send-email-rctay89@gmail.com>
	<1290170790-2200-3-git-send-email-rctay89@gmail.com>
	<1290170790-2200-4-git-send-email-rctay89@gmail.com>
	<1290170790-2200-5-git-send-email-rctay89@gmail.com>
	<1290170790-2200-6-git-send-email-rctay89@gmail.com>
	<20101119183339.GB26187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 05:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJf4N-0007Cc-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 05:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab0KTE2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 23:28:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61299 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab0KTE2x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 23:28:53 -0500
Received: by eye27 with SMTP id 27so3165704eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 20:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jzKdHZ/0oR3PsxOKaINXDZgs/q8v602dyhwS8mPSoVk=;
        b=aJbljrJOWegn/vUC0R2I3WpEBt94c/mO5PaFpJ/SFbAC4umuRgdWwRUgKPqVPmDAXU
         xrgC9o7gkL/W+EPAE8bZNFEOZ3jMYTB+Pumr3GmU8NXktSyc9r81vu5vHgcoYGdOi69v
         SWQqWeNSB5PDbceRuXQOPVhV8awKwWZ1hvnic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MOj52BQwP9FAYz6q5N3turGYV+GqqYZQjjVR4vehVrzLsXfhn5QkTjAP2IHAaqIpRS
         GpF8Ba46CfA82f7hc7moMH3nqzIDEwehiaZJKLcQiZeGEdEvLnbeRbq7StE7ZoWjLo40
         RKkjuxPyvWuwTpXRmWylVCXypbDiw1fRJrLCI=
Received: by 10.213.35.73 with SMTP id o9mr20434ebd.2.1290227331674; Fri, 19
 Nov 2010 20:28:51 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Fri, 19 Nov 2010 20:28:51 -0800 (PST)
In-Reply-To: <20101119183339.GB26187@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161821>

Hi,

On Sat, Nov 20, 2010 at 2:33 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> [snip]
> ... or here. =A0So perhaps:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (path) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const =
char *url =3D repo->path;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!u=
rl)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0url =3D repo->url;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (st=
rncmp(path, url, repo->path_len)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0error("Parsed path '%s' does not match url: '%s'\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0path, url);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0path +=3D ...

Looks much cleaner, thanks.

> By the way, is the error behavior correct? =A0This prints a message w=
ith
> "error: " and then continues anyway.

Yeah, this fits in with the exiting xml code paths - they just
indicate errors and continue.

--=20
Cheers,
Ray Chuan
