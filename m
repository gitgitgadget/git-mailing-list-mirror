From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Wed, 12 Dec 2012 11:32:38 -0800
Message-ID: <7vr4mv3w2x.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
 <50BA2892.7060706@web.de> <50BA3412.60309@web.de>
 <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de>
 <7vhao31s9e.fsf@alter.siamese.dyndns.org> <50BE6FB9.70301@web.de>
 <50C89DF3.20303@drmicha.warpmail.net> <50C8BD6B.9010702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tis38-00043h-QY
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab2LLTcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:32:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab2LLTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:32:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 725B3A9CF;
	Wed, 12 Dec 2012 14:32:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/0OpLRSUF3vIIjEfedcpKIwbWS8=; b=LbEWdM
	mYXYC4r5ZCqqewSdU8Z+tDYFPhuUpoyvVMbDoBD3EFO/7C7eyGpG9Z5k5qGIyDO/
	rv+neBJ4iQWd11HkGwC7owRaS6VgiFmHk6sjSsVKdceo/eSrWpDlpvr8qkQMYTMo
	28GSYnQcjeXgdv8f2f06QYJrBOUsIGJJKo1Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=auS+G52bIrB134QB17xr1J1xYHSO35qS
	DRqnmnVgGLLfQZvoCM1K+r/kBSaxiByPd9FRjQ5Te0mhfQKLh9DHHimzul+Xn/n1
	iXyy8pM7PPLWYWU/VO3Hf/vTB1+Wt2B9zM1cyX9hGBmK/DADbVaf5dlFxR4rDonV
	Ge2Xlkf/ICI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EED7A9CE;
	Wed, 12 Dec 2012 14:32:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C55E0A9CC; Wed, 12 Dec 2012
 14:32:39 -0500 (EST)
In-Reply-To: <50C8BD6B.9010702@web.de> (Jens Lehmann's message of "Wed, 12
 Dec 2012 18:22:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0E871E4-4492-11E2-9FAD-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211385>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Especially as I suspect the number of submodule users having
> customized those in .git/config is not that high ...

I thought the point of "deinit" was to say "I am not interested in
having a checkout of these submodules in my working tree anymore".
The user could do "rm -fr submodule && mkdir submodule" to remove it
locally and keep "diff" and "status" from noticing the removal, but
the primary reason the user needs an explicit "deinit" is because
many subcommands of "git submodule" are documented to operate on all
submodules that have been "init"ed when given no explicit submodule
names [*1*].

Your "deinit" is documented not to actually remove the submodule
checkout, but that very much goes against my intuition.  What is the
justification behind that choice?  "We'll remove the configuration,
you remove the tree yourself" will invite the mistake of running
"git rm" on it, which you wanted to avoid with the addition to the
"git rm" documentation, no?


[Footnote]

*1* In reality, the code looks at presense of .git in the submodule
path to decide if it has been "init"ed (cf. cmd_update), but this
implementation of "deinit" does not seem to cause that .git to be
removed, leaving the submodule in "init"ed state from these other
command's perspective.
