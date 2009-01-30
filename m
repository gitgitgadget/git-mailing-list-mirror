From: Elijah Newren <newren@gmail.com>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 13:22:36 -0700
Message-ID: <51419b2c0901301222l2b722714v48db0039180d262b@mail.gmail.com>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
	 <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com>
	 <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com>
	 <20090130194727.GA31927@coredump.intra.peff.net>
	 <20090130200307.GA3054@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 21:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSzuF-00081R-DD
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbZA3UWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbZA3UWi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:22:38 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:57563 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbZA3UWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:22:37 -0500
Received: by yx-out-2324.google.com with SMTP id 8so245725yxm.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 12:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JDg293OACAbj4/Z3lMAEPuI0uCHbd6VZOWDK1bjmuqQ=;
        b=XyfI0lL1wscD1q9lIqOuiuynzy39rJ27yOBW1IdzJebmMrQjbksxi5lgKbRRE9hwov
         R/Q/nZ7laVW+A4bP4oB6m+PWIWod292V7caNpXL/uPe9z/wrWrstPJ0rowvK8ZIL4i5Z
         kQChH+fSrF5mSoBuZKHkDpNlRtx/v/c+3SXfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BVeTL+9MFiPGJWnB5cARJw6iCc3scmvJKI26gnAPfmMoV4gUdy08v8TKlnk+SC5mkU
         8aozQFKE3YAQG7vFeyqNHVnN2cm2xBWtmHPVjHkjPsZziiM+V/Heed+qwcIxtpgwmphO
         xrrZ/YAdoPIxhsGtW01nnZr1kDtrGITm4Ljws=
Received: by 10.150.53.12 with SMTP id b12mr10168yba.244.1233346956200; Fri, 
	30 Jan 2009 12:22:36 -0800 (PST)
In-Reply-To: <20090130200307.GA3054@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107870>

On Fri, Jan 30, 2009 at 1:03 PM, Jeff King <peff@peff.net> wrote:
> Ah, OK. I just peeked through the 'eg' source. It looks like you may
> have replicated the same bug that I just fixed in git. :)
>
> You  want to make sure that "eg" is the last process to die (i.e.,
> _after_ the pager). Otherwise after it dies, less has trouble reading
> from the terminal (I don't know for sure, but I assume this has to do
> with the shell making "eg" the process group leader and magic about
> process groups and controlling terminals).
>
> I think perl may even do the wait() for you under ordinary
> circumstances. But, for example, if I kill "eg" with a signal (say, by
> hitting ^C), then it will die but the pager will live on. In git, we
> catch the signal and wait() before dying.
>
> So I don't know for sure that is your problem (it really depends on how
> much magic perl is doing behind the scenes with wait()ing on children,
> and I don't recall the exact details of that). But it is something to
> look into.

Thanks for the tips; I'll try to take a look and see what I can figure out.


Elijah
