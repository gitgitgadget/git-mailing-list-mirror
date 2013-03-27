From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 12:26:30 -0700
Message-ID: <20130327192630.GF28148@google.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:27:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKw00-0007LH-8y
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab3C0T0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:26:36 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48653 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3C0T0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:26:35 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so2303810pad.31
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=b5ckFnbrk3kAjsCUnDrhevdTI1FvtL/rvMrcG2/rV3A=;
        b=yuJBUYJq2FMjBAX3TeojN3R+EADnw+nQZv50SLrWLGqd87Zx4rN/g7YOaMCGSVLBs4
         1ETLAus/RkRHoIKpIkdfRU0qSXzxopiMILD8w8EP7XiOKfoR4bS0vlkYctP+P7Cqxk6k
         81MEVPq4YLIlOU97lIEaWI4VFFrQS5VnuvgHaRvI/FJFDsLAEM1piswjFR+20wDUzP8y
         /qbPDhNvpzfQch5zf9F7TuC/4Md90daLZA/c03lEq+RUEFAQUZKSxzwsPc/dIBYQID4v
         7e2mKx2r4bswOh3tvlvGsuG3d2CvGJvE6qpmu2e56kjm7fwWl02mwF3KX26oWPn8MSZq
         g95A==
X-Received: by 10.68.42.134 with SMTP id o6mr31453134pbl.52.1364412395133;
        Wed, 27 Mar 2013 12:26:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id i9sm24472499paa.7.2013.03.27.12.26.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 12:26:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219309>

Ramkumar Ramachandra wrote:

>                        Even then, working with one worktree embedded
> inside another is something git never designed for: it explains why I
> have to literally fight with git when using submodules

Do you mean that you wish you could ignore subrepository boundaries
and use commands like

	git clone --recurse-submodules http://git.zx2c4.com/cgit
	cd cgit
	vi git/cache.h
	... edit edit edit ...
	git add --recurse-submodules git/cache.h
	git commit --recurse-submodules
	git push --recurse-submodules

, possibly with configuration to allow the --recurse-submodules to be
implied, and have everything work out well?

I think something like that is a goal for submodules in the long term,
with a caveat that there are complications in that different projects
(the parent project and subproject) can have different contribution
guidelines, review and release schedules, and so on.

If submodules are not working for you today, you may find some of
Jens's submodule improvement patches interesting, or you may want to
look into alternatives that make different assumptions, such as
entirely independent repositories and tools like "mr" that iterate
over them.

Hope that helps,
Jonathan
