From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 17:25:59 -0800
Message-ID: <CAE1pOi1O10XeROv+sQRwAAVQ0PneMZTOaEfny-Oz2Sp+=z+aiA@mail.gmail.com>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
	<201202091453.38564.mfick@codeaurora.org>
	<CAE1pOi387-bimYEG4bjFOjaCwhPeDyLRj7wOJgyuKSCrZ9kBFg@mail.gmail.com>
	<201202091634.36563.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 02:26:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvfFW-0002x2-Er
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 02:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700Ab2BJB0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 20:26:01 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58682 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab2BJB0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 20:26:00 -0500
Received: by yhoo21 with SMTP id o21so1257275yho.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 17:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EARJ4XfbaDPpdiVOdiXpWz8wF+c08q6UeOKIswvScw4=;
        b=gXgzTjocXDQJNon4VqlIHkK8+sPIOr+4Njbw9H9bqqCIjiROsV8DZ93RXSfIgg6J5s
         V/TjunTCCkl+oaWI9pYmegJf4YfGxRXeHjsPfumALGV5qLz9KhPc9Aj8OBIri3UUFlPx
         8uGxexpn4q3viKGWFC0E3Bp/1vqyqQqOfDyNc=
Received: by 10.101.143.14 with SMTP id v14mr1877452ann.1.1328837160015; Thu,
 09 Feb 2012 17:26:00 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 17:25:59 -0800 (PST)
In-Reply-To: <201202091634.36563.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190362>

On 9 February 2012 15:34, Martin Fick <mfick@codeaurora.org> wrote:
> On Thursday, February 09, 2012 04:24:47 pm Hilco Wijbenga
> wrote:
>> On 9 February 2012 13:53, Martin Fick
> <mfick@codeaurora.org> wrote:
>> > On Thursday, February 09, 2012 02:23:18 pm Hilco
>> > Wijbenga
>> >
>> > wrote:
>> >> For the record, our (Java) project is quite small.
>> >> It's 43MB (source and images) and the entire
>> >> directory tree after building is about 1.6GB (this
>> >> includes all JARs downloaded by Maven). So we're not
>> >> talking TBs of data.
>> >>
>> >> Any thoughts on which FSs to include in my tests? Or
>> >> simply which FS might be more appropriate?
>> >
>> > tmpfs is probably fastest hands down if you can use it
>> > (even if you have to back it by swap).
>>
>> I don't have quite that much RAM. :-)
>
> But I am sure that you have that much disk space which you
> can allocate to swap, if not you already couldn't build it.
> And tmpfs swapping is still likely faster than a persistent
> FS (it will not need to block on syncs). =C2=A0If you are
> benchmarking, it is likely worth you effort since that will
> probably mark the upper performance bound,

I found [1]. Is that sort of what you had in mind? That would be quite
tricky. I have a group of some 60 projects, each with their own
"target" directory which would have to be mounted on tmpfs. And the
"target" directory is created by Maven, not by me. Not to mention that
I shut down my computer at the end of the day. :-)

I think I would prefer a somewhat more persistent solution. I
certainly have enough space for a very big swap partition. So the
whole of ~/my-project would fit on tmpfs. I'm just not sure about
making it persistent at the end of the day.

[1] http://code.google.com/p/chromium/wiki/LinuxFasterBuilds
