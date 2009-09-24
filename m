From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] git-submodule should obey --quiet for subcommands
Date: Thu, 24 Sep 2009 10:15:51 +0100
Message-ID: <57518fd10909240215n30e6336eo2fc344d810c8b38c@mail.gmail.com>
References: <57518fd10909210946p425d275fy76362a4b2ccc0e05@mail.gmail.com> 
	<57518fd10909231433i773aff78kae6b763d0a533279@mail.gmail.com> 
	<20090924143130.6117@nanako3.lavabit.com> <57518fd10909240034p668f858bh17fc20715b4838c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 11:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqkQz-0004bo-UB
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 11:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbZIXJQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbZIXJQI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 05:16:08 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:46977 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZIXJQH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 05:16:07 -0400
Received: by ywh4 with SMTP id 4so1716486ywh.33
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Z27gmVyHEKqmS2OSiR0u9e7SkUnnGqKvBtUtppoJo5c=;
        b=wlGvtV3JerRmNvbm/900KOZqquyFgxAPX0/OlXUBLP7esbrJl9kMR4W2a2UstdRpUV
         wXpsxqwEwxkP+l0DBl3OaDeqZ8DDJCz0JMpGNNq+uC9u0HwB2ke1c1GVzJDLAU+wAK5J
         +8+bXG+FPuTm2pZmrcraKFQAchaqMch8VBW+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=bMlMAJLoxW4m7CxqieK1IZzYBvKnyouUkYIgjJAriHScBiQGSNlczKeCcFy7SVwmU4
         3Ex8t4UzAdkXcRgA0BqtU4nySykWmEAZSZkufLHYiva6kAZjC6LcMSpyNItawpLgEewK
         TI/NzBuqI0sVtsdcRGZ04FxQDsgaELgiWFFJc=
Received: by 10.150.242.3 with SMTP id p3mr6284132ybh.22.1253783771087; Thu, 
	24 Sep 2009 02:16:11 -0700 (PDT)
In-Reply-To: <57518fd10909240034p668f858bh17fc20715b4838c3@mail.gmail.com>
X-Google-Sender-Auth: c7ddf7e5ce119c66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129033>

On Thu, Sep 24, 2009 at 8:34 AM, Jonathan del Strother
<maillist@steelskies.com> wrote:
> On Thu, Sep 24, 2009 at 6:31 AM, Nanako Shiraishi <nanako3@lavabit.co=
m> wrote:
>> Quoting Jonathan del Strother <maillist@steelskies.com>
>>
>>> No takers? =C2=A0Perhaps I should explain my interest in this patch=
 : we
>>> use Capistrano to deploy our Rails app which contains a bunch of
>>> submodules. =C2=A0It's done over ssh, so the 'git submodule update'=
 step
>>> during deployment spews something along the lines of :
>>>
>>> Receiving objects: 0% (0/401), 1.55 MiB | 424 KiB/s
>>> Receiving objects: 1% (4/401), 2.15 MiB | 612 KiB/s
>>> Receiving objects: 2% (8/401), 2.90 MiB | 510 KiB/s
>>> ....
>>> ..
>>
>> Does 'git clone' itself do that to you, too, or do you see these out=
put on separate lines only when running 'git submodule clone'? I never =
used 'git submodule clone' but with 'git clone' these lines seem to ove=
rwrite one after another and they never bothered me. Could your termina=
l emulator be broken?
>>
>
> No, git clone has the same problem when run under Capistrano, but it
> obeys --quiet.
>
> That said, I always assumed that, say, 'ssh -t myhost git clone foo'
> would have the same problem (ie printing each progress update on a ne=
w
> line), but I see it works correctly. =C2=A0Looks like Capistrano is e=
ating
> the \r somewhere. =C2=A0I still think my patch is valid, but I'll
> investigate into Capistrano some more & see if I can fix it there.
>
> Jonathan
>

=2E.. thinking about it, it's obvious why Capistrano doesn't handle the
\r properly - it's running commands in parallel on multiple machines,
and echoing any output from the commands (prefixed with the machine
name) back to the user in realtime.  So it would be kinda tricky for
\r to work as expected there.
