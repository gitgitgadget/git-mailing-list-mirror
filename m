From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 10:24:46 -0700
Message-ID: <7vk3jqzush.fsf@alter.siamese.dyndns.org>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
	<CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 19:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8vrT-0004uA-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 19:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518Ab3HLRYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 13:24:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725Ab3HLRYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 13:24:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E48638C1E;
	Mon, 12 Aug 2013 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=voLvRralXs1C0galZmvWzKaM/vI=; b=EFyeNN
	qyX6FmevKoZ5O70qKYKuqzhQFyILQVvvRHvat29f98mNK7EbzS5lOyWTSUAucDNW
	C/CU0rpxBORciOctgYRUd+S63XY6y2Cli6p14wln6xp5KPo/bgpaxGtml7h568NM
	PmrkhqLan/Zv15XKIQ0wOUqALaA98DYMlJXaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tBM2qRss15wtF381A6YlKlrQSf3Xd3LY
	hwiGRoIxlZx3GW48MHdhaLCYuN05i+hzLcNr+kgnVfs5ZFYcNmLZrNf1mehPtii0
	xAlvrD8x9bwlJwrDNwDnFbeI1HthOhRMK1WBig+WIjeePFgLa4JxgJYF0Es6fJAX
	ztofL38TzyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B32238C1D;
	Mon, 12 Aug 2013 17:24:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F305738C18;
	Mon, 12 Aug 2013 17:24:47 +0000 (UTC)
In-Reply-To: <CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 12 Aug 2013 20:23:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 168375BC-0374-11E3-A6C4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232202>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 12, 2013 at 7:14 PM, David Jeske <davidj@gmail.com> wrote:
>> IMO, the current warning during checkout of a detached-head is
>> misplaced. It should be removed, and instead there should only be a
>> warning after detached-head commit, since this is the only time there
>> is a danger of losing something.
>
> That would annoy me as I often work on top of detached HEAD on purpose
> and only create a branch when I want to save something. If the warning
> is to be moved, it should warn at the next checkout.

Don't we already do that?

    Warning: you are leaving N commits behind, not connected to
    any of your branches:

        ... list of commits to be lost ...


    If you want to keep them by creating a new branch, this may be a
    good time
    to do so with:

     git branch new_branch_name xxxxxx

    Switched to branch 'master'
