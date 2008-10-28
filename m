From: "Christian Couder" <christian.couder@gmail.com>
Subject: Re: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Tue, 28 Oct 2008 20:13:48 +0100
Message-ID: <c07716ae0810281213k432d82d8i468f54ae03146b88@mail.gmail.com>
References: <83wsfs1y6v.fsf@kalahari.s2.org>
	 <c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com>
	 <83skqg1uc9.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Hannu Koivisto" <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:56:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuvcQ-0007eH-Ih
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 21:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbYJ1Uzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 16:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbYJ1Uzh
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 16:55:37 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:55978 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbYJ1Uzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 16:55:36 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1354594rnd.17
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aS//PR0+hEd3iW818Q/l/o0lwUx+kqBBH4kd5RQk95Y=;
        b=wyIErkb+j5/WLtwcp3JwyhnVhRHi9r7JXEQE7UJCXDGuMKJ5MZt549UIIOIbYCUluK
         7dog4fGu8tjzwPp3S1Q5M8IqQxNzWdtMi8fa+WknhhzIpz/UmbTS6I4kNLnYONyEzzW9
         ERQST3cazE3zcakRpXIGaRe1YJe5dX3yCc6wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d1uSPmBknlHKIbseEdmr5U4gxAcaSOyyQ/A7UxYhcFiH1aEV4MEYf2CJw6EoL2thV4
         ki3PxB984j0tqeQ1+tZcKHp1Rrzp4nrIbCZSaK8CP6lpOA6jXpV9KXYrCCgz5q6j9dzb
         DOQAtu0cxfDd7re5V+DjEZDsJxvD9JzFHO6NI=
Received: by 10.150.140.6 with SMTP id n6mr5637609ybd.102.1225221228427;
        Tue, 28 Oct 2008 12:13:48 -0700 (PDT)
Received: by 10.150.200.11 with HTTP; Tue, 28 Oct 2008 12:13:48 -0700 (PDT)
In-Reply-To: <83skqg1uc9.fsf@kalahari.s2.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99322>

On Tue, Oct 28, 2008 at 6:51 PM, Hannu Koivisto <azure@iki.fi> wrote:
> "Christian Couder" <christian.couder@gmail.com> writes:
>
>> Hi,
>>
>> On Tue, Oct 28, 2008 at 5:28 PM, Hannu Koivisto <azure@iki.fi> wrote:
>>> Greetings,
>>>
>>> git bisect view uses gitk if DISPLAY environment variable is set
>>> and git log otherwise.  Since gitk doesn't require X server in
>>> Cygwin, that seems like a bit questionable condition in that
>>> environment.
>>
>> Do you know any environment variable that we could use to detect we
>> can use gitk in Cygwin?
>
> I looked around and I believe there is no such variable.  I suppose
> the only case where you cannot use gitk is when the user is logged
> on using ssh, telnet, psexec or similar (well, unless you use some
> non-standard Tcl/Tk build which is configured to use X instead of
> Windows graphics).  Then again, I don't think typical Windows
> programs do any checks for such situations.

We need at least a way to detect we are under Cygwin, because we won't
change the current behavior for all platforms.
Is checking for the CYGWIN environment variable enough?

> So, easy fix: always use gitk unless log is specified.  Harder fix:
> figure out a way to test if the login session is such that
> graphical applications can be run.
>
>> You can use "git bisect view log" to use "git log" even if DISPLAY is set.
>
> I'd rather not use undocumented functionality ;)

In this case you can use any "git log" option after "git bisect view"
(for example: git bisect view -p).

Regards,
Christian.
