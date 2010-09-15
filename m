From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH (bugfix)] gitweb: Add and use prep_attr helper
Date: Wed, 15 Sep 2010 20:40:41 +0000
Message-ID: <AANLkTi=o2PFB=JkO5wYHCLAHCO=Ebe63mAc6WB8GfktH@mail.gmail.com>
References: <201009152234.14253.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 22:41:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovynf-00019W-7I
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab0IOUkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 16:40:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44618 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0IOUkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:40:42 -0400
Received: by gyd8 with SMTP id 8so183750gyd.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zbwk/cWKbGNjJ4ksKToYQHZyjA+AvLpvqSWCRsSf7qg=;
        b=qr5ZXEkWVKFOWxhXxoie9f3vmIDZJoG9RRx9GP03QzycW/e8njiIKx8exvlRvuvRQH
         BYF87LuqdySHeOUzhVWhH80Fa6D7GrOeA8fnwooO9wt5vnEq5rw7FpdT4GrWmxdD5zvq
         xCIU5LXZjILRQldWdTm25RLb7u6f6VZsykHlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=giMDpFVgqIp285TrBOtLmCMmoBDSpS+qvaeC1JVGEfgYn5wSIa5e/Pzeb+lvRQKdff
         BgicgWLQc13h26L6DSH9u+ulh3H9BhEeALKy3iRqK4w1LAn22krBJI5v7CvkMPdxNSYj
         2CFXqIvI6xKjAxZKnWRyYHCWk1Z/VMMSQYL7w=
Received: by 10.100.13.15 with SMTP id 15mr2499908anm.86.1284583241333; Wed,
 15 Sep 2010 13:40:41 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 15 Sep 2010 13:40:41 -0700 (PDT)
In-Reply-To: <201009152234.14253.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156247>

2010/9/15 Jakub Narebski <jnareb@gmail.com>:
> One of features of CGI.pm module is HTML generation. =C2=A0The HTML
> generation subroutines / methods automatically escape values of
> attributes of HTML elements... but in older versions didn't do it
> fully, not removing / replacing control characters. =C2=A0Control
> characters are forbidden in XML / XHTML, and some browsers
> (e.g. Firefox) do not skip over them but display error instead of pag=
e
> in strict XHTML mode (XHTML DTD + application/xml+html mimetype).
>
> This issue was noticed by Uwe Kleine-K=C3=B6nig and resolved to be a
> problem with control characters in XHTML output by =C3=86var Arnfj=C3=
=B6r=C3=B0
> Bjarmason in format_search_author() subroutine.

=46WIW this looks good to me, but perhaps instead of using "?" for
everything in ASCII from \0 to " " it would be better to display the
human-readable escape sequence, like "\r" or "\b".

Gitweb already does this (although I don't have a link handy) if you
check in a file with Windows newlines, it'll display "\r" in a little
box.

Maybe that should be done everywhere? I don't know.
