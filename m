From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Sun, 27 Apr 2014 09:12:39 +0700
Message-ID: <CACsJy8ANE+2n6fd-mF5pp+p2sXy_uRzJ2c+O=AiySyre+6KLtg@mail.gmail.com>
References: <20140421204622.GA9532@logfs.org> <20140425182928.GA29904@logfs.org>
 <vpqoazpdz1r.fsf@anie.imag.fr> <20140425201048.GB29904@logfs.org> <20140426071358.GA7558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@logfs.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 04:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeEbJ-0005TA-R4
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 04:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbaD0CNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 22:13:12 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:56814 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaD0CNK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 22:13:10 -0400
Received: by mail-qg0-f52.google.com with SMTP id j5so5520985qga.25
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 19:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k9PYX5ILRPN+Wmv66hqmep524k0b/76ZDzlP6r5i2Fs=;
        b=e5RNotYgnWcCQGgKjFmjkMo4Zass9fKN+SSjJSl78Psx0/tmS1j+Gpyyw08+ywr9lK
         GC7qwgs6LEPhYWj4GOS0a7E0ARVEkI4i2smngz25HgokvDlaZwzG8eQhSEnhaqNq/9we
         9ybYqOMPNAD8EOqm6Pzg6kBUcMnrZsbK9x3Jev40Orv6FCmTzH+n+hEgB2zsjEp2bg4A
         1cel1YRhC6BRH9r7Npa0g1lm6eqdtBNECrB9CGnhrisMSJU9YyLvwkPBKcg/WhakUMJj
         di6ExWy8ookODqWGAsrBwxt/iX0D4QQ0FuouRtuUB3xTDg+7TTh/kfG5E6RMJhfYZATV
         gLFw==
X-Received: by 10.224.25.2 with SMTP id x2mr23436947qab.37.1398564789747; Sat,
 26 Apr 2014 19:13:09 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 26 Apr 2014 19:12:39 -0700 (PDT)
In-Reply-To: <20140426071358.GA7558@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247189>

On Sat, Apr 26, 2014 at 2:13 PM, Jeff King <peff@peff.net> wrote:
> [+cc Duy, whose patch this is]
>
> On Fri, Apr 25, 2014 at 04:10:49PM -0400, J=C3=B6rn Engel wrote:
>
>> A second option is to add a --pager (or rather --no-pager) option to
>> the command line and allow the user to specify
>>     GIT_PAGER=3D"git --no-pager -p column --mode=3D'dense color'" gi=
t -p branch
>
> I think we have "--no-pager" already. But the "-p" is turning _on_ th=
e
> pager, so you could also just omit it. IOW, I really don't understand
> why the original command was not simply:
>
>   GIT_PAGER=3D"git column --mode=3D'dense color'" git -p branch
>
> The whole infinite loop that the original commit solved is caused by
> specifying the "-p". So it sounds like the right solution is "don't d=
o
> that". Am I missing something useful that the "-p" does?

The intent of the commit was "that is a stupid thing to do, but it's
not so obvious from the first glance, do not freeze my system for my
mistake". But if it stops an actual use case, then I agree it should
be reverted.

> I wonder if perhaps the intent was that the user might have set
> "pager.column", in which case the use of the pager is implied. I stil=
l
> think that the right solution is to use "--no-pager" explicitly then.=
 If
> the user is invoking git inside GIT_PAGER, it is up to them to save
> themselves from infinite recursion.
--
Duy
