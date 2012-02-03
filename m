From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Breakage in master?
Date: Fri, 3 Feb 2012 15:05:30 +0100
Message-ID: <CABPQNSbQTF1UiDuOZkX-KrTQ7oFyVvx6FxZ85c9uCF2FFUtTSg@mail.gmail.com>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
 <20120202174601.GB30857@sigill.intra.peff.net> <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
 <4F2BE759.4000902@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 15:06:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJmL-0000Ew-5f
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 15:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab2BCOGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 09:06:12 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65046 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab2BCOGL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 09:06:11 -0500
Received: by dadp15 with SMTP id p15so2760363dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=XFtq0ZJYOoR8Rim0obLIX6k0hr9mnBC4qviO2FrVxa8=;
        b=Qm/8TMup9I6pzGw4dHx3tk/OtnDH7yX7D5E/bUPTBx3EhOKvm0vSnGiuI1xnIga4na
         VUEnk8LpAVx/WiUkXAN21GU04mlElKHTI0GaxMZWe6AHh+hbn0nvrI6NzLgT6GlPS5UU
         0amaRLLFH+RM7F8Lhdr5yno/BOnPyQkk8GnTQ=
Received: by 10.68.73.234 with SMTP id o10mr18021091pbv.90.1328277970179; Fri,
 03 Feb 2012 06:06:10 -0800 (PST)
Received: by 10.68.222.165 with HTTP; Fri, 3 Feb 2012 06:05:30 -0800 (PST)
In-Reply-To: <4F2BE759.4000902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189775>

On Fri, Feb 3, 2012 at 2:55 PM, Joel C. Salomon <joelcsalomon@gmail.com=
> wrote:
> On 02/03/2012 07:28 AM, Erik Faye-Lund wrote:
>> On Thu, Feb 2, 2012 at 6:46 PM, Jeff King <peff@peff.net> wrote:
>>> vsnprintf should generally never be returning -1 (it should return =
the
>>> number of characters that would have been written). Since you're on
>>> Windows, I assume you're using the replacement version in
>>> compat/snprintf.c.
>>
>> No. SNPRINTF_RETURNS_BOGUS is only set for the MSVC target, not for
>> the MinGW target. I'm assuming that means MinGW-runtime has a sane
>> vsnprintf implementation.
>
> That doesn't sound right; MinGW defaults to linking to a fairly old
> version of the Windows C library (MSVCRT.dll from Visual Studio 6,
> IIRC). =A0According to <http://mingw.org/wiki/C99> there exists libmi=
ngwex
> with some functions (especially those from <stdio.h>) replaced for
> Standard compatibility, but it's "far from complete". =A0(Is msysGit =
using
> it anyway?)

I'm not entirely sure what you are arguing. On MinGW, calling
vsnprintf vs _vsnprintf leads to different implementations on MinGW.
This is documented in the release-notes:
http://sourceforge.net/project/shownotes.php?release_id=3D24832

"As in previous releases, the MinGW implementations of snprintf() and
vsnprintf() are the default for these two functions, with the MSVCRT
alternatives being called as _snprintf() and _vsnprintf()."

I don't see how this is contradicted by your argument of a third,
C99-ish implementation. I'm pretty sure the "far from complete"-part
is about the C99-features anyway.
