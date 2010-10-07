From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 20:19:01 +0200
Message-ID: <AANLkTikkZaCQKFTnQ=k2Ajp_6mVRd6mrP1P7bEASEGgd@mail.gmail.com>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net> <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net> <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net> <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
 <vpqaamp3n6d.fsf@bauges.imag.fr> <20101007175358.GD12130@sigill.intra.peff.net>
 <AANLkTinu6fhd9DwfJpjiaxOUu_MrTym_RepR9f44=vrv@mail.gmail.com> <20101007181349.GD18518@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:19:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3v3z-0000EC-QZ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab0JGSTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 14:19:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab0JGSTY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 14:19:24 -0400
Received: by wyb28 with SMTP id 28so357662wyb.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=tirEM0OE6s7007vjzSCS7Sfgp/A147slaYUbiiy8MaM=;
        b=m5u1Llb/jxl9ldzQQSL2K8TYJeifO65Kw/70PxqraLdHkAkqWMcajab9R6BQKI5RdE
         ROLLEzB6RgwDM9ijpXKq64nhCUehQilye/oTBpOh453P/zH6VkguDH80MOZmjL8zm9Ad
         6ytxc3R2v73w63ju+JV8dCaFtUyLiSP6KHD48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ulkQ2qlnVr038f2EL2lkOS08NImb/WJvMkrOO8C+qrucjCKvF3lkp5wr3g4uS8le8o
         OJEFATBwYGaIc3fzl4lWdAAUDY1mwKwyfCsKm0NNE56GCYYlPvQR1Lbaw2ABuwbKd2kZ
         XThrZCv40PEzeGk9mz4ese5TBV1xmu7c4nHRs=
Received: by 10.216.188.135 with SMTP id a7mr2660721wen.39.1286475561994; Thu,
 07 Oct 2010 11:19:21 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 7 Oct 2010 11:19:01 -0700 (PDT)
In-Reply-To: <20101007181349.GD18518@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158425>

On Thu, Oct 7, 2010 at 8:13 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 07, 2010 at 08:05:20PM +0200, Erik Faye-Lund wrote:
>
>> >> I don't know which one would be most portable, but if fwrite is t=
he
>> >> problem, then
>> >>
>> >> =A0 printf("%*s%c", buf.buf, buf.len, info->hdr_termination);
>> >>
>> >> should do the trick.
>> >
>> > It does work, but you have to cast the buf.len size_t to an int.
>> >
>> I'm not sure how portable it is, though. This is what K&R has to say
>> on the matter: "characters from the string are printed until a =B4\0=
=B4 is
>> reached or until the number of characters indicated by the precision
>> have been printed". To me it's not clear if that means that either
>> cases can terminate the printing when the precision has been
>> specified.
>
> I take it back. It doesn't actually work (I thought I had done this j=
ust
> recently, but clearly not). Try:
>
> =A0#include <stdio.h>
> =A0int main()
> =A0{
> =A0 =A0char buf[] =3D "123456789";
> =A0 =A0buf[2] =3D '\0';
> =A0 =A0printf("%.*s\n", 5, buf);
> =A0 =A0return 0;
> =A0}
>
> It prints just "12" for me.
>
> -Peff
>

Yeah. When I read K&R a bit closer, I find this:

"A number specifying a minimum field width. The converted argument
will be printed in a field _at least this wide_, and wider if
necessary. If the converted argument has fewer characters than the
field width _it will be padded_ on the left (or right, if left
adjustment has been requested) to make up the field width."

So it seems to me that an implementation that doesn't padd with space
(which might have been the case for you here, hard to tell without
inspecting stdout closer) violates K&R. There's also an example
showing how the string should be padded in the early parts of the
book.

So we're back to not having a solution that works on Windows. And
looking at our winansi emulation code, we don't have a fprintf-type
code-path at all (one that takes a length), so I think fprintf is the
best we can do for now.

I'll see if I can come up with something a bit more long term...
