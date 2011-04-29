From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a minimal plugin architecture
Date: Fri, 29 Apr 2011 11:29:35 +1000
Message-ID: <BANLkTi=zzMUoU+e=U6RzE7HPz-V=QkW+Hw@mail.gmail.com>
References: <BANLkTi=53dShgcsyTUP2aA+hvm6p+93XrA@mail.gmail.com>
	<alpine.DEB.2.00.1104281808490.7120@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Apr 29 03:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFcWd-0004Iu-2H
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 03:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab1D2B3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 21:29:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54364 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab1D2B3h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 21:29:37 -0400
Received: by ewy4 with SMTP id 4so1004212ewy.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 18:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wn2w3ejrxKFtfxXZgqoc2xiRjO0oo3d4oZsDA3x+Vq0=;
        b=buC0kCJNypgt3OFwUrKAt8Lhx5GelKpAKye+ES4/e5I5tEEKywna+XbEeRWuhk8oAp
         a57pFgzOMRBkuwHyXCp2K+J/8HVyAGUmIpAYJbM/WmzTLXCRUYM4IkirodOLECtW/+Wm
         RqFyrpiDDWIlE/2Izgy9Zgx3mgd+dcwMUj134=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ob7CH2EY+GQQoYOXm2LHqR1MMWQko3OLlrXbd2Osf8a1SOwfCo0SyPmCjLqsNm/ENq
         pIQx6LfTljh+7cUn/9cAPBJO2n/s0fmpLt/BB0CH/l3QEQ6jgo+jPL5SV7bSexxSr1eu
         g9Xylqxgrx2cNS+V262veo8wgTOEsD2jvxEsk=
Received: by 10.14.7.1 with SMTP id 1mr1831979eeo.245.1304040575889; Thu, 28
 Apr 2011 18:29:35 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 18:29:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104281808490.7120@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172421>

On Fri, Apr 29, 2011 at 11:12 AM,  <david@lang.hm> wrote:
> On Fri, 29 Apr 2011, Jon Seymour wrote:
>
>> However, let's start simple, what would a minimal plugin directory
>> look like and, assuming there was one per git-install, where would i=
t
>> be located relative to the prefix?
>>
>> Here's a suggestion for the layout:
>>
>> bin/
>> =C2=A0- all scripts and sh libraries
>> man/
>> =C2=A0- all man pages
>> html/
>> =C2=A0- all html pages
>>
>> What about location?
>>
>> =C2=A0${prefix}/git-plugins
>> =C2=A0${prefix}/lib/git-plugins
>>
>> Or, decided by distribution?
>
> distros are going to change this anyway, so start by accepting that, =
then
> make the default just that, a default, not something hard-coded.
>

Yep. Hopefully whatever the distro decided path would be available via
a git --plugins-path switch?

Might not be necessary if we let plugins install into --exec-path,
--html-path and (proposed) --man-path.

>> Is there support for the idea of adding a --man-path switch to the m=
ain
>> line?
>>
>> What about a --plugins-path, that would answer the question about
>> where plugins should go?
>
> I think it would be better to put it in the config file, nobody is go=
ing to
> add command line options to every command they run.

The intent here is to help package managers and plugin authors to
decide where they place plugin artifacts like scripts and others
resources. Similar to the existing --html-path and --exec-path
options.

>
>> Per Jonathan's and Junio's suggestions, the idea of having a plugins
>> search path seems like a reasonable one, so that users without contr=
ol
>> over the git install can at least customize it themselves.
>
> only if you make sure that the plugins only run as the user, with no =
chance
> of them being invoked as a privilaged user.
>

Sure.

Thank you!

jon.
