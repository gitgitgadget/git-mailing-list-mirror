From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 14:46:43 +0530
Message-ID: <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 28 10:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL8xl-0004sf-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 10:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab3C1JRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 05:17:08 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:43987 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab3C1JRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 05:17:06 -0400
Received: by mail-bk0-f53.google.com with SMTP id e19so2128939bku.40
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3FxojeBjXM8SYhnvL5xW3e/xJ8xkrdNE7jjymqF8SjI=;
        b=TyaL1SlLotYMb7I2MM3IpPThn3AhRPbD9unIw8QLhXGrTgztKqaX3oyeGV1erJ5NoT
         Q+6moHQSbpO9ttNXfOVWIrB1+f1yS8mZPskk35Ncz7i1oGeQfTMAJtN+M34ohzEyN9dF
         1pYHG16RG0FA1FsblWV5aQCU7JgCx0wtuKp9J7dRQ96Y4QEfXqka3Y8okv2+DI/wV9TE
         5pgfO3h7cDFQY6+eskAOIG9TMtfmMlfvl0RpOCGiISbhTTKECcH4sM9ScxLnfRQGg22G
         aNbEy2Mr0VB5sEo7WV1c9ICagjU/CPPEw0TBZ2WSjpe+VntV0uGofi1j/kPsqqSeyG6l
         d4LA==
X-Received: by 10.205.74.136 with SMTP id yw8mr3260259bkb.129.1364462224687;
 Thu, 28 Mar 2013 02:17:04 -0700 (PDT)
Received: by 10.204.36.10 with HTTP; Thu, 28 Mar 2013 02:16:43 -0700 (PDT)
In-Reply-To: <51537A7B.7050206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219377>

Jens Lehmann wrote:
> Unless you acknowledge that submodules are a different repo, you'll
> always run into problems. I believe future enhancements will make
> this less tedious, but in the end they will stay separate repos
> (which is the whole point, you'd want to use a different approach
> - e.g. subtree - if you want to put stuff from different upstreams
> into a single repo without keeping the distinction where all that
> came from).

I acknowledge that it's a different repository.  It's just that I
think that our current design has too many seams: why do you think
it's impossible to make it seamless?

git-subtree is not an answer to anything.  Dumping all the history
into one repository has its limited usecases, but it is no solution.

> What else than a commit object should that be??? Submodules are
> there to have a different upstream for a part of your work tree,
> and that means a commit in that repo is the only sane thing to
> record in the superproject. A lot of thought has been put into
> this, and it is definitely a good choice [1].

Linus argues that it shouldn't be a tree object, and I agree with
that.  I don't see an argument that says that the commit object is a
perfect fit (probably because it's not).

> How? The "submodules suck, we should try a completely different
> approach" thingy comes up from time to time, but so far nobody
> could provide a viable alternative to what we currently do.

My argument is not "submodules suck; we should throw them out of the
window, and start from scratch" at all.  I'm merely questioning the
fundamental assumptions that submodules make, instead of proposing
that we work around everything in shell.  We don't have to be married
to the existing implementation of submodules and try to fix all the
problems in shell.

> And apart from that, let's not forget we identified some valuable
> improvements to submodules in this thread:
> [...]
> All of those are topics I like to see materialize, and you are
> welcome to tackle them.

Allow me a few days to think about changing the fundamental building
blocks to make our shell hackery easier.

Thanks.
