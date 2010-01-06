From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] Makefile fixes
Date: Tue, 5 Jan 2010 22:20:03 -0600
Message-ID: <20100106042003.GA20532@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20100101090556.6117@nanako3.lavabit.com>
 <7vpr5onir5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 05:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSNNb-0007J3-7E
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 05:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043Ab0AFEUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 23:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844Ab0AFEUH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 23:20:07 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:62564 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab0AFEUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 23:20:06 -0500
Received: by ywh6 with SMTP id 6so17127808ywh.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 20:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JhCSBuWn3aSZN5UOQ7Q5IKcubQ12sKkpYcU6A4bGr9w=;
        b=rl0vD9TznJtJ1XY1GiUNJX5jntxIsXhPyWF4eXBdh6u67OTEtG9S0AWgXUlNgIkS0F
         qVjnrG3HZs4yTuSnwKdxkQ+7TL2vY0Q0aFvtCb4I5jTt9tTpdX3LFk9E4oBmdcZ/wfm9
         k9HYfT45kaWObx0KSptuyW+C3o8myfi7GIa8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ULM+W7wTo5yUO97BOGpUx0xVejS1zMiojZdf/J5S+0p7NcMZxZLyHZpawJ2fC7aJCY
         0pr7b6yInmjzeuCv88LmnkRQksW6Q+DViJzjtWJNQsQSMaJCblPaAkbYohXyaRWRPTqv
         D5H8p9+f39g3MGELp3zfa8e4i35JcYoA3umMg=
Received: by 10.101.179.23 with SMTP id g23mr4709386anp.171.1262751605380;
        Tue, 05 Jan 2010 20:20:05 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm19239935iwn.5.2010.01.05.20.20.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 20:20:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr5onir5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136239>

Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
>> Junio, could you tell us what happened to this thread?
>>
>> Makefile improvements.  No discussion.

These had some issues and instead of following up, I simply forgot
about them.

> I took 4/4, and after looking at them again, I think 2/4 looks sensible,
> too.

I also think the patch for 2/4 looks sensible, but the commit message
does not make much sense.  Optimization flags do not affect
compilation of assembler code as far as I can tell.  It would have
made more sense to say something like "Since the only .S file in git
does not have any #ifdefs, leaving the dependency out was mostly
harmless."  (Will resend.)

> I was puzzled by 3/4 and I still am; the dependency rules are the same for
> %.o and %.s yet the patch changes only %.s.  Either it leaves the same
> breakage for %.o (which is much more important in practice), or the
> problem Jonathan has with %.s may have other causes, but it was unclear to
> me.

The Makefile lists dependencies for each .o target elsewhere.  While
cleaning up those other dependency rules, I noticed there was nothing
analogous for the .s targets.  You can reproduce this by running
"make var.o var.s && touch cache.h && make var.o var.s".

Of course, I should have mentioned this in the commit message.  Will
resend as well.  Sorry to leave these standing for so long.

Sincerely,
Jonathan
