From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: Fix actionless dispatch for non-existent
 objects
Date: Mon, 09 Jan 2012 13:30:35 -0800
Message-ID: <7v8vlgef7o.fsf@alter.siamese.dyndns.org>
References: <20120107104552.26867.41282.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 22:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkMnl-0008G5-An
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 22:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab2AIVaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 16:30:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab2AIVai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 16:30:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7272B71DA;
	Mon,  9 Jan 2012 16:30:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8boS3xkCmTPNEhYdGx4dGlVP4Bg=; b=KMCK8O
	rM5wtg1SCk/2mN0L+cOmz7Ylg74J7lnHRfT2vLag0WH/dWCSLm3om4RDl3OtpR4a
	sSQETcfCH2XLxTo78vTVym8hCLpmPaDwwdFYT3aqJVLxwFppQZcgoslazDkByghQ
	MNQq8fc8agd72gkcgyYfWWmrdZFBDnMmS3D+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDh3o3wggOu6jX7ySe1AYb/G07Ic1huv
	VGxCJCh8SXsHdcser9Ed9qJ3yjX6Dp5ZnNBKhAn5UrUGEdrusYDmXZo/tWTAN+Al
	62MdMql12kB631pG1jRYfss8pVSjTXvZsDRFTLrYyiE+XSyKqFMc7MbhYJHLvl7M
	5KBCKUQhTBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A1D371D9;
	Mon,  9 Jan 2012 16:30:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEF0271D8; Mon,  9 Jan 2012
 16:30:36 -0500 (EST)
In-Reply-To: <20120107104552.26867.41282.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Sat, 07 Jan 2012 11:47:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B8D25F0-3B09-11E1-A36A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188191>

Jakub Narebski <jnareb@gmail.com> writes:

> When gitweb URL does not provide action explicitly, e.g.
>
>   http://git.example.org/repo.git/branch
>
> dispatch() tries to guess action (view to be used) based on remaining
> parameters.  Among others it is based on the type of requested object,
> which gave problems when asking for non-existent branch or file (for
> example misspelt name).

Ok. "gave problems" is a bit unclear to see why explicitly calling
die_error() is an improvement, though. What is the nature of the
"problems"? Giving a server error 500 because later codepaths tried to
call an undefined subroutine?

> Now undefined $action from dispatch() should not result in problems.

Again, unspecified "problems" here. I'd like this sentence to end with
"should not result in X but gives an explicit '404 not found' error".

Thanks.
