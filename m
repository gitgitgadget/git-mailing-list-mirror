From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] pkt-line: show packets in async processes as "sideband"
Date: Tue, 1 Sep 2015 15:31:41 -0700
Message-ID: <CAGZ79kYoWWc34GOxyAi5WvYf=UQvt--qwEr_m+bZwKO-uVqkiw@mail.gmail.com>
References: <20150901202215.GA17370@sigill.intra.peff.net>
	<20150901202412.GA8020@sigill.intra.peff.net>
	<xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKJF2epU=2gb7jFWni2tBu03dYGgttvZeW40ra=r2iiA@mail.gmail.com>
	<20150901222639.GD7862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWu5i-0003i6-AR
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbbIAWbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:31:42 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34833 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbbIAWbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:31:42 -0400
Received: by ykax124 with SMTP id x124so5564587yka.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SIkt2VEaXQ8TmN3J/UZYVtdVcv/MJo6+g93bmso2RO4=;
        b=P1gGk6sYLIoLs1xIUUgykmP/QQYoEQcMjNz6Bg+WTm7IEWNxkmwsU0Qe7LQrd6G+Ac
         5ssiY98FEc5TDahKjr+t4kCLyUDTZF3vO/ri3GH0vzpkzDVhwr26IRvGpm7dTe66N1UM
         3mY2QpKPcdT4OTgygey8RpH58JAh4EGlCLEGp0TmJv76f7qwclD+YnyWsZvt3xqt0VgR
         SYZDXvUgLQFH3nJvoUW37KZjviiMtWU8OUgt7Kiq8wlFZRebg+Q/5BuXdJByrJc0afHH
         dx/7p4Hzf30Hx3G0Es2IrCU4W0Tkmm5OY0Zpwp5ycgDQv5q8X/k58y8PWbfGMo74svB1
         GwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SIkt2VEaXQ8TmN3J/UZYVtdVcv/MJo6+g93bmso2RO4=;
        b=BSiIl2f8i9jPGe+0yXGwRaSE6XgBeo3T8HX2D0xI1FzPM4NUgNhaTjJdYzdM/R+Kj2
         2yPNjHjPlbTgTqlwLL9zOdKbFYOeEvn2NVb/HgIG3zcWqrRTVLM+SmdLlL7lD5ldfBNl
         lUfy0pac9AorfPQPlLzGD4NqnKk2NkPUw6xez7B3B1fRs1zyETNNs/VhU7iocz7nZ3P0
         i2HWXbP3NRJsCaHAtDOMAfTVqs8LmfvjzLiWAbGLkTaikfR8mXhJDAa92tuumASFrRr2
         9wPcdqbBcR6aNM8Qxd08pQXZuVHP2WCPSZqATXbhEJssllyNxB4eY9yEFYzE7tUQPFqk
         hM3g==
X-Gm-Message-State: ALoCoQnGQbNNQNznTheUrregB/ytAN8OhxPLQ9eSL5HEx4Ge2p4vxBCEYmPlWmo5c9Z7W++CmtJF
X-Received: by 10.129.90.138 with SMTP id o132mr12623204ywb.32.1441146701576;
 Tue, 01 Sep 2015 15:31:41 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 15:31:41 -0700 (PDT)
In-Reply-To: <20150901222639.GD7862@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277061>

On Tue, Sep 1, 2015 at 3:26 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 01, 2015 at 03:23:06PM -0700, Stefan Beller wrote:
>
>> > Hmm, does Stefan's thread-pool thing interact with this decision in
>> > any way?
>>
>> I do not plan to actually fetch from inside the thread pool, but each thread
>> is just a proxy for starting a new process doing the fetch and getting
>> the output
>> in order.
>
> Ah, right, I think I misunderstood Junio's question. Yes, if we start
> calling cmd_fetch() from inside the threads, things may get confusing.
>
> I'll see how painful the thread storage approach would be.

I think that may be part of the thread pool API eventually.

I don't plan on relying on thread local storage, which is why I did
not add it there,
though I guess it can be added in there quite conveniently.

>
> -Peff
