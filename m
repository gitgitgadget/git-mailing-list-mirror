From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Documentation about "push.default=upstream" is confusing
Date: Mon, 10 Feb 2014 11:06:00 -0800
Message-ID: <xmqqd2iuss87.fsf@gitster.dls.corp.google.com>
References: <20140209163157.GA7652@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Rohloff <lundril@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 10 20:06:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCwBT-0007qx-CA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 20:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbaBJTGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 14:06:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbaBJTGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 14:06:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A99106B19D;
	Mon, 10 Feb 2014 14:06:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SSJFqRoB9ayKjD59TkX2+EUQx8=; b=jj753a
	POQINgIbY4+Gvk3W6DE8qxxNH3HiEs95q/DfDo6Gnis2i0ttl03sR16F6PH3QojE
	cVvHeau/Vk/gPJelljGUy7SecYuIE1bQpl5btL0Oxw28gxNPKLOCcyZfDKZWMWVT
	deOlnP03VvSywsdc8WabJouku6stM5ahWOuBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h545FHOQiKVn8FuSpJ5soXZoTn7rW/FD
	8SNF4oJEEoFVZ53HqYVZ92eftMaLGK1off9S2B4Ejf2kh5yz4ddFpawtDwiF1V4S
	2Jq/OYgC9uIlRAbix3NhsR1jIRWElil8usqBNzZDnph3JuTIXMhFVnHVR6FNB2Z+
	xNQGXcmL8dM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC326B19C;
	Mon, 10 Feb 2014 14:06:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 975336B197;
	Mon, 10 Feb 2014 14:06:14 -0500 (EST)
In-Reply-To: <20140209163157.GA7652@localhost> (Ingo Rohloff's message of
	"Sun, 9 Feb 2014 17:31:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 69A8140E-9286-11E3-BB60-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241923>

Ingo Rohloff <lundril@gmx.de> writes:

> To handle that I setup several remote tracking branches called:
>   repo1_master   (tracks repo1/master)
>   repo2_master   (tracks repo2/master)
>   reap3_master   (tracks repo3/master)
>
> Now without "push.default=upstream" I would have to either always explicitly
> do something like:
>   git push repo1 repo1_master:master
>   git push repo2 repo2_master:master

If you think about your interaction with people who are only looking
at "repo1" alone, you _are_ using a centralized workflow.  You are
not the only one who update their 'master'; other people push there
to update that 'master' and you pull it in to keep you up to date
and further build your changes on top.  Such an interaction with
other people by using repo1 as the shared meeting point is well
served by the push-to-upstream mechanism, and that kind of
interaction is called "centralized workflow".  The illustration from
you is running one centralized workflow with each of the three
repositories.

The de-centralized workflow the message hints (but does not talk
about) is different.  It is not uncommon to pull from one place and
then to push the result out to your own publishing branch
(e.g. clone from anna, fetch to keep up to date with her, work on
it, publish to your repository to tell her to fetch from you), and
push-to-upstream is not very well suited for that topology.  You may
clone her "for-bob" branch, but you do not push it back to her
repository to update her "for-bob" branch.
