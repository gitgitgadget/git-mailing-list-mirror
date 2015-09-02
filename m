From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 02 Sep 2015 08:16:59 -0700
Message-ID: <xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<20150901224431.GA9353@sigill.intra.peff.net>
	<20150902074826.GK30659@serenity.lan>
	<20150902080529.GA19248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:17:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX9mg-0006yV-0d
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbbIBPRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:17:04 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34505 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbbIBPRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:17:01 -0400
Received: by padhy1 with SMTP id hy1so14807443pad.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=G5SjajprSUrvUpdLkk+L5pCfMzdlljI2blDVTu4ClTQ=;
        b=uNvCjK3TV/yetH1bswPjs4EJr9O2VQ4FsABwUy7toRgcqggAPfe+C+FM4DXzqF7QnT
         QAdlu3+PWRkkX18+kAjoKuN9lZo/fxKKgZs4HPwFXMdeFZ1hiHsQZnEQKQ8aBLxva2Kn
         v9bQIMkOiCukCynbt6Qncaqi6wTLEjwLfPo/N23/fyI3fHEfZfqvQ8crYb8qWzxXh3Z8
         6tNLJJ3SOqWswXYrPuR+wGKfP8UdtVvRNBHnoPY0m6dEpTJbQM3orhINi5JLxQ1LrtOi
         LuCEHte7Dwy8VqdQ8NpfZvJoTDK3NRGegN+Mny0zQPfuJ7xpzABqr0FdGNO62ChlmJhZ
         ghRg==
X-Received: by 10.68.232.104 with SMTP id tn8mr56110646pbc.155.1441207020811;
        Wed, 02 Sep 2015 08:17:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id ea13sm22165340pac.30.2015.09.02.08.16.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 08:16:59 -0700 (PDT)
In-Reply-To: <20150902080529.GA19248@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Sep 2015 04:05:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277096>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 02, 2015 at 08:48:26AM +0100, John Keeping wrote:
>
>> On Tue, Sep 01, 2015 at 06:44:31PM -0400, Jeff King wrote:
>> > [1] I do think the error message for "relative-local is nonsense" could
>> >     perhaps be more explanatory, but I couldn't come up with any better
>> >     wording. But if you have ideas, feel free to switch it.
>> 
>> My only suggestion would be to reuse the "unknown date format: %s"
>> message and avoid having a special message in this case.
>
> Heh, that was what I was trying to avoid. I wanted to avoid "I do not
> understand our request" and have it more like "I understand what you're
> _trying_ to do, but it doesn't make sense".
>
> I guess "relative dates do not depend on timezones, so -local is
> meaningless" would be the closest thing.
>
> I don't think it is that big a deal whichever way we go, though.

I somehow thought that the discussion was about raw-local, not
relative-local, but anyway, I think it would make more sense to
allow both of them.  If you define the meaning of "-local" as:

    Pretend that the event in question was recorded with your
    timezone, and show the timestamp using the specified format sans
    -local suffix.

that explains what happens for all the other formats well, and it
also makes sense for what would happen to raw and even relative, I
think.
