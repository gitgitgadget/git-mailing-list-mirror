From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 06 Feb 2012 10:31:20 -0800
Message-ID: <7vliof7r0n.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <7vty34a6fd.fsf@alter.siamese.dyndns.org>
 <20120206051834.GA5062@sigill.intra.peff.net>
 <7vk440a5qw.fsf@alter.siamese.dyndns.org> <4F2F9661.2020606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 06 19:31:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuTLc-0002bf-3t
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 19:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab2BFSbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 13:31:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab2BFSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 13:31:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3275D7171;
	Mon,  6 Feb 2012 13:31:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7qbFgW/TT7FV5s7s1yDj5qQXM4w=; b=G0GsOQ
	NjipriJ2Dff89hGAVozaHYXWPGUHvkHdUXPx8328gq4caLLILzcW5D8T1ZWSYoK6
	pCDBNlLqtesLt9cp+joqEpVQ1uA3Q43Ek8D7P2v7fo+t8bmaKr3whbVrufbSfTlt
	TqBhB/i+AM6s4gG2Cf8ZkCAvgnR9sV71bCT/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gbAdpD1kTutd4dD66JR9rwG2TKQecDbQ
	JXMKVC8MhKD5zUC973z2d985t3tGqboa8FyXP3/2RKonX563vS74CYxiUdNh96bG
	C7g6fYpA34ipmfj4llp7pGSU3ojpgF4iAhJhWB7cLbhS0H9f7CnLBxDo1NYUYxOj
	rX3Pet9OOdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A7F47170;
	Mon,  6 Feb 2012 13:31:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9FF2716F; Mon,  6 Feb 2012
 13:31:21 -0500 (EST)
In-Reply-To: <4F2F9661.2020606@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 06 Feb 2012 09:59:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4824E14-50F0-11E1-9AF9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190087>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> So we are breaking the equivalence between these three only when HEAD
>> points at an unborn branch.
>
> You are thinking too much like a developer and not like a user.  For a user,
>
>     git checkout -b foo
>
> is a short-hand for
>
>     "create and check out a branch at my current state"
>
> and the interpretation of what that means when I am on an unborn branch
> seems unambiguous.

Ok, that is a very good explanation.

Care to come up with a patch to Documentation/git-checkout.txt?  The
description there strongly implies that <start point> is an existing
commit.  Not much is said about what the lack of <start point> mean when
it describes "checkout -b", and a standalone description of <start point>
says "The name of a comit at which to start... Defaults to HEAD".  These
need to be loosened and described in terms of the closer-to-the-user "at
my current state".
