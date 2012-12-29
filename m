From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 02:34:30 -0800
Message-ID: <20121229103430.GG18903@elie.Belkin>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Totkl-0006mK-Vj
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab2L2Kei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 05:34:38 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:35277 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2L2Keh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 05:34:37 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so5153559dad.36
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=t1P5geWsdYiAXuElPpWeDtMWd1jF8lde5m5EBdaA0BM=;
        b=KnEI9Z0zSmc53lVzKfk0vYRgc8Yle4EiFnFY4GdB+/i7PJHZhrkw5x4AqfmB2C/NAM
         /55AqKtba0RIMM/nzhrTZJpJ1SbqaqGMjjScP4LQEkxUqzKj7+oJVw4pvhmWzmh9Q2Le
         v7UgF08CU9T+8ENKSWXrYRg/7/bK/C1CM+EM5KGHNIFgD+g+um7/LHWTMnImRYpb+PvC
         SK+dMK+tewJ42iNKf3U+DsgoevGoO2FH0JE7VIQfITTbnW3Uz8kMpUE9tT7ROA84OoHf
         3IAOpxCUQ4iqGP8yhBv4HW13mnLyDtSzr1bhld8RZYfZU5mgyaXEMi9ucF5zwrmNkM0X
         hntQ==
X-Received: by 10.66.76.8 with SMTP id g8mr106022332paw.40.1356777276547;
        Sat, 29 Dec 2012 02:34:36 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o5sm21990031paz.32.2012.12.29.02.34.34
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 02:34:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121229102707.GA26730@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212304>

Jeff King wrote:

> I can't reproduce here. I can checkout v3.2.35, and I guess that the
> patch you are applying comes from f5f1654, but I don't know your
> local modification to sound/usb/midi.c.

No local modification.  The unstaged change after "git am --abort" to
recover from a conflicted git am is a longstanding bug (at least a
couple of years old).

The patch creating conflicts is

	queue-3.2/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch

from git://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-3.2.y-queue.git

[...]
>>   $ git am --abort
>>   Unstaged changes after reset:
>>   M       sound/usb/midi.c
>
> What does your index look like afterwards? Does it have a null sha1 in
> it (check "ls-files -s")?

$ git diff-index --abbrev HEAD
:100644 100644 eeefbce3873c... 000000000000... M	sound/usb/midi.c
$ git ls-files --abbrev -s sound/usb/midi.c
100644 eeefbce3873c 0	sound/usb/midi.c
