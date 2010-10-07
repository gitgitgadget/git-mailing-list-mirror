From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 19:41:01 +0200
Message-ID: <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net> <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net> <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:41:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uT9-0006qP-JG
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab0JGRlX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 13:41:23 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34754 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0JGRlW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 13:41:22 -0400
Received: by pvg2 with SMTP id 2so37953pvg.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=/30t241HbT2/f1OD7dRJ+z+1S9+sAkuRxMbe+lcHC64=;
        b=OBMmQHs4GzLUXZE2tOSYgi8IDxzIBL4ggvXIACl9E50Go42m3uRRhs/sM1pRGOVj+0
         lLpRx+Rz+uYv+Rj7+9RCDeBG3rGP4r+ll+1Uepa6/2b3tun7dhTbFTMXYKseDXUnw3dF
         CgiHL6WdpSaBMNzxsMvO6d5sFVP25s5gUxlhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bmgGD3+NUMSC7fdn+wryOW/NEfLUVT3+ngj20nQlOfz3CZY9Hn8Xp4M3Pgz/cyOmZ9
         podAp4wMOabS/TERMgVAS3aNHszayzK6bnw1lVvYyWJCfNACqPhYDjwBAZNZQsDz6W16
         xUCaskkQr2jatkG3De4/ewfUN63zmUH95wzps=
Received: by 10.114.110.2 with SMTP id i2mr1226215wac.193.1286473281787; Thu,
 07 Oct 2010 10:41:21 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 7 Oct 2010 10:41:01 -0700 (PDT)
In-Reply-To: <20101007172939.GA12130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158413>

On Thu, Oct 7, 2010 at 7:29 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 07, 2010 at 07:18:18PM +0400, Kirill Likhodedov wrote:
>
>> Thanks for pointing that out.
>> I confirm that on Mac OS X that happens for rev-list as well.
>>
>> # git log --pretty=3Dformat:foo%x00bar HEAD -1 | od -c
>> 0000000 =A0 f =A0 o =A0 o =A0\0 =A0 b =A0 a =A0 r
>> 0000007
>>
>> # git rev-list --pretty=3Dformat:foo%x00bar HEAD -1 | od -c
>> 0000000 =A0 c =A0 o =A0 m =A0 m =A0 i =A0 t =A0 =A0 =A0 2 =A0 3 =A0 =
6 =A0 0 =A0 1 =A0 a =A0 2 =A0 c =A0 3
>> 0000020 =A0 e =A0 4 =A0 6 =A0 4 =A0 a =A0 4 =A0 4 =A0 7 =A0 9 =A0 f =
=A0 1 =A0 7 =A0 7 =A0 4 =A0 e =A0 3
>> 0000040 =A0 6 =A0 e =A0 a =A0 5 =A0 b =A0 9 =A0 5 =A0 8 =A0 b =A0 4 =
=A0 6 =A0 0 =A0 5 =A0 2 =A0 1 =A0\n
>> 0000060 =A0 f =A0 o =A0 o =A0\n
>> 0000064
>
> Ugh. Even worse, it does print with --graph, which uses a slightly
> different code path.
>
> =A0$ git rev-list --graph -1 --format=3Dfoo%x00bar HEAD | cat -A
> =A0* =A0 commit 81d866a6a213d5524ce389369377ba3529461e1b$
> =A0|\ =A0foo^@bar$
>
> I am inclined to call the rev-list behavior a bug, and the fix is
> probably:
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index efe9360..3b2dca0 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -147,8 +147,10 @@ static void show_commit(struct commit *commit, v=
oid *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (revs->commit_forma=
t !=3D CMIT_FMT_USERFORMAT ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf.len)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(=
"%s%c", buf.buf, info->hdr_termination);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf.len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fwrite(=
buf.buf, 1, buf.len, stdout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 putchar=
(info->hdr_termination);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_release(&buf);
> =A0 =A0 =A0 =A0} else {

This gives me a bit of a deja-vu: 1fb5fdd

Also, fwriting like that to stdout might be a bit troublesome on
Windows because the string won't end up going through our
ANSI-emulation.
