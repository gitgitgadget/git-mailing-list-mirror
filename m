From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 1/2] Add test to describe expectation of blame
 --reverse with branched history
Date: Thu, 22 Oct 2015 17:37:21 +0300
Message-ID: <20151022143721.GC5722@wheezy.local>
References: <1445485872-21453-1-git-send-email-max@max630.net>
 <1445485872-21453-2-git-send-email-max@max630.net>
 <xmqqk2qfttzy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 16:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpGzk-0000nr-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 16:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbbJVOh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 10:37:27 -0400
Received: from p3plsmtpa11-05.prod.phx3.secureserver.net ([68.178.252.106]:51585
	"EHLO p3plsmtpa11-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964970AbbJVOhZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2015 10:37:25 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-05.prod.phx3.secureserver.net with 
	id YEdL1r0085B68XE01EdPXA; Thu, 22 Oct 2015 07:37:25 -0700
Content-Disposition: inline
In-Reply-To: <xmqqk2qfttzy.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280056>

On Wed, Oct 21, 2015 at 09:19:45PM -0700, Junio C Hamano wrote:
> Let me try.
> 
>  (1) for merges, an edge with '*' denotes the one to the first
>      parent.
>  (2) a commit that touches file.t are in capital
> 
>            c1---a3
>           /    *
>          /    /
>    A0---a1--*a2
>      \      /
>       b1---B2
> 
> Did I draw it correctly?

Yes. Though I would

>> +test_expect_failure 'blame --reverse finds B1, not C1' '
>> +	git blame --porcelain --reverse A0..A3 -- file.t >actual_full &&
>> +	head -1 <actual_full | sed -e "sX .*XX" >actual &&
> 
> "head -n 1" is more POSIXy way to spell this.
> 
> Don't get cute with sXXX in sed script when the usual s/// suffices;
> the only effect of the cuteness is to waste readers' time, who have
> to wonder if there is something interesting going on.

Ok. Will fix it and add the graph.
