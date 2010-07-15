From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Thu, 15 Jul 2010 15:32:57 +0000
Message-ID: <AANLkTin5a39MQurIdXYu-SZVLhNTefbyZmJALT5SrdQF@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<4C364A0B.2020909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 15 17:33:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZQQu-0007Jz-JT
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 17:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933561Ab0GOPdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 11:33:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41345 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933418Ab0GOPdA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jul 2010 11:33:00 -0400
Received: by gyh4 with SMTP id 4so662378gyh.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g/XLJ14ywRNlT+FPzNlKCbi3Pcd4pZH17n6ixMBhrOY=;
        b=Ec40mdn8bgtMCBOURMcR8Mp3um8p21aR7azBaVjPi2z1aI58bBanD5CY+6dlk4U2qA
         rg9t84mExOhi4jSgQ0iAqGXfBapj1kMo+0eSXv8qIWp3FGqZCLPGdtrSv7S8z11nD5hX
         MERgwOprfNOov1DoL8IxyZZRW7VqXfBsXuFUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pK4r3EYvsh7gWpAJq00s6LH93FBaStxEre/nKBZv9A2sK3fSxsxL9wJ9cERtC35htF
         bCLspCtemZ9rlvIO+DFDGOaCgr1C02i3bTRrD3PiVxcMdFD7K89IU2f2ROyO7Rvzu5Jm
         KngSZ3BXor7Xeodrcjm1HdKJ9oQWIMAT2uhXY=
Received: by 10.150.233.21 with SMTP id f21mr10542469ybh.388.1279207977912; 
	Thu, 15 Jul 2010 08:32:57 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 15 Jul 2010 08:32:57 -0700 (PDT)
In-Reply-To: <4C364A0B.2020909@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151084>

On Thu, Jul 8, 2010 at 21:58, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.a=
th.cx> wrote:

> In this particular case the tested functionality is not provided accr=
oss
> all platforms supported by git. =C2=A0It would be better to fix the a=
ctual
> issue, namely that the fallback regex lib we provide doesn't support
> REG_STARTEND.

We're currently providing the GNU regex library, it seems Mac OS X and
=46reeBSD ship with a regex library that has REG_STARTEND (according to
`git log --reverse compat/regex` the current library was added because
of incompatibilities on OSX, but those were since fixed in
310e0216c8).

If the FreeBSD and Mac OS X implementations are good enough we could
just swap the GNU one for the FreeBSD one
(http://www.freebsd.org/cgi/cvsweb.cgi/src/lib/libc/regex/). Is there
any reason not to do this, or would a different regex library be a
better fit?
