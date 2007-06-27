From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Add git-save script
Date: Wed, 27 Jun 2007 18:38:05 +0900
Message-ID: <200706270938.l5R9c583019275@mi0.bluebottle.com>
References: <20070623220215.6117@nanako3.bluebottle.com> <7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com> <7vsl8euryx.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 11:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Tyb-0002rZ-4S
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 11:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbXF0JiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbXF0JiI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 05:38:08 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:39876 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbXF0JiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 05:38:07 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5R9c583019275
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 02:38:06 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:to:cc:date:from:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:user-agent:x-trusted-delivery;
	b=dUKEW/frgkP9jJJRvV5GDNKr5o2jzcRlhJlpLhrDbVGREMoOArNzrFpOP0sh9OHyB
	emA5ifj6HL5K/BrSUvD6Q/ECTYWG5+WqUs+9CwJdOiAzXSZB1EVmeBnVS0C8HYy
Received: from localhost (internal.bluebottle.com [206.188.24.43])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5R9c5bB001021;
	Wed, 27 Jun 2007 02:38:05 -0700
Received: from 85.195.123.29 ([85.195.123.29]) 
	by mail.bluebottle.com (IMP) with HTTP 
	for <nanako3@bluebottle.com@localhost>; Wed, 27 Jun 2007 18:38:05 +0900
In-Reply-To: <7vsl8euryx.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Trusted-Delivery: <833bfeab58a57b998636760ab0057ee7>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51028>

Quoting Junio C Hamano <gitster@pobox.com>:

> I think it would make much more sense to represent a stash like
> this:
> 
>               .------o commit to represent index state
>              /        \
>      ---o---o----------o
>             HEAD       commit to represent worktree state
> 
> That is, "index" and "worktree" state are represented as one
> commit each, both are direct child of the HEAD, with an added
> twist of the latter being also a child of the former.

I do not know if I understand you correctly.
Do you mean that I should create a stash this way?

 i_tree=$(git-write-tree)
 i_commit=$(echo index | git-commit-tree $i_tree -p HEAD)
 w_tree=$( what I did to create w_tree in my previous patch )
 w_commit=$(echo $msg | git-commit-tree $w_tree -p HEAD -p $i_commit)

and when unstashing the stash, I should:

 git-merge-recursive $stash^^{tree} -- $stash^^{tree} $stash^{tree}

I think I can make it work, but if that is not what you meant, please let me know.

> I am not absolutely sure if "git reset --hard" belongs here.
> > You can certainly type one less command in your example sequence
> > ("stash; pull; restore").  But I suspect there may be a case
> > that would be more useful if "git save" did not do the reset
> > itself.  I dunno....
> 
> I now think "git reset --hard" here is fine.

I see.

I will try to update and resend my patch this weekend.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com
