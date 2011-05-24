From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: combined diff does not detect binary files and ignores -diff attribute
Date: Mon, 23 May 2011 20:59:51 -0400
Message-ID: <BANLkTi=nTZABRPLwq30Khs8KJHRt+jzNbA@mail.gmail.com>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
	<4DDA618E.4030604@drmicha.warpmail.net>
	<BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
	<20110523181147.GA26035@sigill.intra.peff.net>
	<20110523201529.GA6281@sigill.intra.peff.net>
	<BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
	<BANLkTikAS63wZ=VP9s6LE44MBd5T1X3gMA@mail.gmail.com>
	<20110523234934.GC10488@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 02:59:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfyX-0007LO-UN
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab1EXA7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 20:59:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33619 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757964Ab1EXA7w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 20:59:52 -0400
Received: by pwi15 with SMTP id 15so2822257pwi.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 17:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8gNIGoZFfCq5aHr3XZWYuXgsYmZ9y2iVcSmlPUK3+4c=;
        b=T3YmrD5DKHT17LjEg9FxFJeX+8mMalU9bER8O/osJHai0CeYyxhK/fkTPcY6dDxaYL
         naWXFSSNhgVuM9usfKl8LI9uIJ9dhxDA97bgN/hZ2Y5vgwlePwbtYZfYTlZluUjlqmc3
         jvfuz7T3yZRxuDPejSMNKc8++0dcb9pdInlKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TD0Z4XqtKevU1QqOE96XN3BX3vFdbjUMeECIAxgfv/x5yESEdrxB0G6OaYQBO1DJAg
         sHknjufyrkbMoEZ8H0WLPVCukk8jWxXUVBy8LyZBpKJ/0WnZO9vU1TGJ7G2SE343/By8
         6XVbm1iga2Hc5iyTbI7WBFWm92/qi/oQTGWio=
Received: by 10.142.147.10 with SMTP id u10mr1014668wfd.112.1306198791710;
 Mon, 23 May 2011 17:59:51 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Mon, 23 May 2011 17:59:51 -0700 (PDT)
In-Reply-To: <20110523234934.GC10488@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174304>

On Mon, May 23, 2011 at 7:49 PM, Jeff King <peff@peff.net> wrote:
> Hmm, I thought we did preserve the extension. I think it may actually=
 be
> related to me making a fake filespec and not passing the path in.
>
> Does the (totally untested) patch below fix it for you?

Yes.

>> 2. It's not really clear to me when one should use textconv vs a
>> custom diff driver. (Also, --no-textconv isn't documented...).
>
> The motivation for textconv was originally a combination of "when you
> are too lazy to write a full diff driver" and "when you like how git
> formats the diff with pretty colors and word-diff". But now I think w=
e
> can add to that:
>
> =C2=A01. When you want something fancy and git-ish like combined diff=
=2E
>
> =C2=A02. When you want free caching to speed up repeated log viewing =
(try
> =C2=A0 =C2=A0 setting diff.*.cachetextconv to true).

Gotcha.

> Maybe it is worth adding an "advantages of textconv" section to
> gitattributes(5) (the advantage of a full external diff command is th=
at
> it can be more flexible, or even graphical in nature).

Okay.

j.
