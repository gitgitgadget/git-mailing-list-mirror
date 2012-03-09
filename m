From: Junio C Hamano <gitster@pobox.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Fri, 09 Mar 2012 08:26:33 -0800
Message-ID: <7vfwdh7nba.fsf@alter.siamese.dyndns.org>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
 <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
 <20120308071403.GE7643@sigill.intra.peff.net>
 <4F5867D4.1010904@viscovery.net> <7vpqcndmpa.fsf@alter.siamese.dyndns.org>
 <4F59F212.6030701@ira.uka.de> <4F59F7A2.3030606@viscovery.net>
 <4F5A04BA.8030401@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 09 17:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S62eP-00006a-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 17:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757950Ab2CIQ0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 11:26:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab2CIQ0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 11:26:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A46A45822;
	Fri,  9 Mar 2012 11:26:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qB2qstTwXWtoIWxBov9EeEgf0ro=; b=ujqJ9W
	mWoP8c+THa0cTEJa8Tee32uq+0MhKGfJ4z+Cn44dA9FIcfmB+AdYvvY31by8gDBt
	WEWjffjV/x7jp4DD/Dm0vmwCM3ZIw2HwCtI42rWfHnYOvrPmqrRV6uq4a8pwprsb
	xqWpuz1DjwkTmTmAZ76Arsw/6lfMNh92V4mhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMMDvl5TBQcelxOSoX2A20Ol34k6Jr5B
	eMdt9R114aKTWX3L/wjDXnor5mwQw4OP9R7sb0Rmcciuhlx0tLUt5cfwCOoRkL28
	ppqZd79bXtlNOiFsMEy3Mn0iei7HMz3ma4xmTmt0taLsrhwgHxLfFplT8c4cZDu3
	i9+3+jM64Ls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C18A5820;
	Fri,  9 Mar 2012 11:26:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C6A6581E; Fri,  9 Mar 2012
 11:26:35 -0500 (EST)
In-Reply-To: <4F5A04BA.8030401@ira.uka.de> (Holger Hellmuth's message of
 "Fri, 09 Mar 2012 14:25:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A36AFDD4-6A04-11E1-820D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192726>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> On 09.03.2012 13:29, Johannes Sixt wrote:
>> Am 3/9/2012 13:05, schrieb Holger Hellmuth:
>>> On 08.03.2012 18:30, Junio C Hamano wrote:
>>>> Johannes Sixt<j.sixt@viscovery.net>   writes:
>>>> ...
>>>> I think the underlying mechanism needed to implement the above
>>>> shares a lot with what Jeff called "crazy idea", but where you would
>>>> want to be after such a merge may be different in these two cases.
>>>
>>> I don't think there is much question that you should still be in the same
>>> branch. Not because you necessarily want to be in that branch. But because
>>> it would be surprising if git-merge changed your branch sometimes and most
>>> times not.
>>
>> I don't think that it is so clear-cut.
>> ...
> I see we have different ideas. I envisioned --into to be the equivalent of
> git checkout master
> git merge topic
> git checkout topic
>
> and in that case index and worktree would be topic naturally.

That is why I rewrote it to "git merge-to master" in my response,
and said that there are two slightly different workflow ingredients
that can be implemented with a similar mechanism.
