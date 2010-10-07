From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 20:05:20 +0200
Message-ID: <AANLkTinu6fhd9DwfJpjiaxOUu_MrTym_RepR9f44=vrv@mail.gmail.com>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net> <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net> <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net> <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
 <vpqaamp3n6d.fsf@bauges.imag.fr> <20101007175358.GD12130@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uqy-00054W-BZ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab0JGSFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 14:05:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37876 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab0JGSFm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 14:05:42 -0400
Received: by pzk34 with SMTP id 34so44720pzk.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=ppLkoYnwhVFTloiApcg5T08Bnx2Y8SCyFWb9nDULJAs=;
        b=kxxugKhFNu1BLpuuFEhnSfYYHV0CoBWIukSdXxxzhnjsLwXk2x+wjo94R/iOOS1ni+
         Api2kbOEccuJWetuH1g1Cpi+PUOdyhvV075fO4Kf8XcHn9uUwh8hvyToir4yKuhuG7oM
         E7bugUkKlectNtMTvGQrrbphibgCWRAgqPBMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=TQiD2nNQslTWJ1rOZ07wghdWdggez/GpHHllU1t+qIjOHQXG+4q8lZkce+iwyBw4kr
         P8ezqLe6IVFsWjcHcoHZLrkMN8gM4oFvQ7VsHazhk6lRSK7IS9P0PbMdYA+9n8A0Slrr
         8a6/ZS+kbzb0/delUhdIDHbD/Yq6NtGm0RcQ0=
Received: by 10.114.161.20 with SMTP id j20mr1282896wae.167.1286474741491;
 Thu, 07 Oct 2010 11:05:41 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 7 Oct 2010 11:05:20 -0700 (PDT)
In-Reply-To: <20101007175358.GD12130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158421>

On Thu, Oct 7, 2010 at 7:53 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 07, 2010 at 07:52:42PM +0200, Matthieu Moy wrote:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>> > Also, fwriting like that to stdout might be a bit troublesome on
>> > Windows because the string won't end up going through our
>> > ANSI-emulation.
>>
>> I don't know which one would be most portable, but if fwrite is the
>> problem, then
>>
>> =A0 printf("%*s%c", buf.buf, buf.len, info->hdr_termination);
>>
>> should do the trick.
>
> It does work, but you have to cast the buf.len size_t to an int.
>

I'm not sure how portable it is, though. This is what K&R has to say
on the matter: "characters from the string are printed until a =B4\0=B4=
 is
reached or until the number of characters indicated by the precision
have been printed". To me it's not clear if that means that either
cases can terminate the printing when the precision has been
specified.
