From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cannot remove remote branch name
Date: Mon, 04 Jan 2010 18:18:29 -0800
Message-ID: <7vskal9tvu.fsf@alter.siamese.dyndns.org>
References: <hhu694$3v9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 03:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRz0X-0001ck-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 03:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0AECSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 21:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108Ab0AECSi
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 21:18:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab0AECSi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 21:18:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA9B8E415;
	Mon,  4 Jan 2010 21:18:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3T2ETaNSiG4rjRc8Jx+ERTMb9Js=; b=G2mDSY
	DLHl/NxESdCeakspP1a1Ki3YE/kmHOjUeCPPFwkK6dUoSQxll2TSWpWkB36O+8Fo
	yz0Cg5ZdbFCN0100oacz4MpFJL8ul9xcovp2ZXeYAsOyixioTP0KD4m1cMMcoKGH
	fSJegQnr5UgDNWzabp/G6lxgp/IETedvxztLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mKiLBzBYgyMfRgr9E5akB+HPhSPxWY3u
	cVl3nzHeqi5AJoSBxheRMeLcbxCAU8+7eC6/7bfF8Nz/BtkcQcMSS/I2vQQr2dCY
	7SZuLxXgWk0GAE5GsFT7MlqDI32WscS7/FsIo83cWzdUDeytS/sTwa6P35ePwOuL
	pQlT/RJ3IDY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19F418E414;
	Mon,  4 Jan 2010 21:18:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66D448E413; Mon,  4 Jan
 2010 21:18:31 -0500 (EST)
In-Reply-To: <hhu694$3v9$1@ger.gmane.org> (SungHyun Nam's message of "Tue\,
 05 Jan 2010 10\:57\:18 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FEA0398-F9A0-11DE-A8AC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136154>

SungHyun Nam <goweol@gmail.com> writes:

> How I can remove remote branch name if it already removed
> in remote side?
>
> $ git branch -a
> * master
>   remotes/origin/HEAD -> origin/master
>   remotes/origin/master
>   remotes/origin/test
> $ git branch -D -r test
> error: remote branch 'test' not found.
> $ git branch -D -r remotes/origin/test
> error: remote branch 'remotes/origin/test' not found.
> $ git branch -D remotes/origin/test
> error: branch 'remotes/origin/test' not found.

Hmm, you tried "test" and then "remotes/origin/test"?

The way I would have guessed what to give the command is:

 1. "branch -D -r test" wouldn't make sense, as git wouldn't know 'test'
    of which remote I am trying to remove;

 2. "-r" already tells git that I am talking about remote, so perhaps
    "branch -D -r origin/test" would work without me saying "remotes/".

"git branch -[dD]" doesn't go over the network, so it doesn't matter if it
is already removed on the remote side or not.
