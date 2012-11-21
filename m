From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 08:11:52 +0100
Message-ID: <CAMP44s3vO8q+EW2sUUo6tLCQvD0PB4v_hZ9ySZjMD7wG2M8iwQ@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
	<7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:12:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb4Tg-0005qz-3S
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 08:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab2KUHLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 02:11:54 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55869 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab2KUHLx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 02:11:53 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6742159obb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 23:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MPEuOM5+L/qjLgFC6ugvbk9sb+AABt/581fjhUOA6Mk=;
        b=uiXVZ9f07q76t3z183zGDS/a88sFdTEHurqDSL4Hi1qctW1BRLiuJxc5HBtLzq8U0Z
         XSikM5I2XHABHfVSlWY+bxh74ThLdQRT5uSFhIaBU0bXljSsJp2Bqwi8mOH9qw1s2Fr5
         BKQOdOh290pD4GEM3NPfbVOQdskTWtrdvFFz/8Xxh1jVeCjcu2kYhxSWIyOhNEEP+XTb
         3rvlbaBe7DBYhnwy27lJCjjCYo2yf/sUK7JMqW/oqS9uiuasPobHZu46RP8WgKlQUjPI
         k8vvl0L4/PNGVm8vg/sc5EadG4Slp5USc6k5RK21r5n7QHzbK2+zuL6omZ0ckH97CkSf
         gcDg==
Received: by 10.182.21.135 with SMTP id v7mr15617814obe.101.1353481912344;
 Tue, 20 Nov 2012 23:11:52 -0800 (PST)
Received: by 10.60.28.232 with HTTP; Tue, 20 Nov 2012 23:11:52 -0800 (PST)
In-Reply-To: <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210141>

On Wed, Nov 21, 2012 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I see Felipe keeps repeating that there are bugs, and keeps posting
> patches to change fast-export, but I haven't seen a concrete "No,
> the reason why you see these problems is because you are not using
> the interface correctly; the currrent interface is fine.  Here is
> how you can fix your program" from "others".
>
> With such a one-sided discussion, I've been having a hard time
> convincing myself if Felipe's effort is making the interface better,
> or just breaking it even more for existing remote helpers, only to
> fit his world model better.

IIRC you mentioned something about this mailing list being focused on
*technical* merit. I've explained as much as I could, but at the end
of the talk, talk is cheap, the code speaks for itself. I added a new
very very very simple testgit remote helper, so anybody can see what's
going on, and figure out how the interface could be used wrong.

Anybody can modify the bash version of git-remote-testgit and say 'no,
the interface is not broken, here is how you push and pull without
marks'. How hard is it to hack 82 lines of bash code?

But lets assume my testgit is fatally broken, would you, Junio, accept
these patches if I show the same broken behavior with the python
git-remote-testgit?

I'm afraid I have to point out the hard truth; the reason why nobody
is doing that is because a) the interface is truly broken b) if they
try, they most likely would fail, and that would prove they were wrong
in previous discussion, or c) not enough familiarity with the code. I
don't want to point fingers, nor do I intend to offend anybody, but I
cannot find any other explanation of why this patch series, which is
obviously correct (to me), doesn't receive any feedback, even though
in theory, it should be very very very easy to show what's wrong with
the series.

The tests are there, and the remote helper is as simple as it gets.
There's nothing else but fast-export and transport-helper to blame for
the issues. It's that simple.

Cheers.

-- 
Felipe Contreras
