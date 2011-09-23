From: Junio C Hamano <gitster@pobox.com>
Subject: Re: credential helper tests
Date: Fri, 23 Sep 2011 15:26:16 -0700
Message-ID: <7v7h4yuc8n.fsf@alter.siamese.dyndns.org>
References: <20110923221513.GA3087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ted Zlatanov <tzz@lifelogs.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 24 00:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ECZ-0008KL-Bp
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 00:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab1IWW0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 18:26:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab1IWW0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 18:26:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D7634693;
	Fri, 23 Sep 2011 18:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L0Zec9cO2tchLstE5iiYOqWrPYY=; b=LyABaB
	7ZpEn7xmhrY3jxGoRHyyvTioE78SEzLIbq/mDyrhdJE/EugyT2+l6DZCuDjZw5jH
	2DRft6vjVyak5KyuE+G/Tn4ih3I+nXmt0sVqO204/hH7/mSTgIj7a/LLXTbKcANe
	iIaUUqfxSOSOCjRNjE2lI7gglmK/Cz0nJkRKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnNWlqDm1ogQTGiTF9TEbGCFCTX7pVUj
	pFF4VwZZcSWsY3XuSesXJNk2ymK2LArH2dLoPCtzn+ZBqL3tFV2FgpGm9Z6YxV/F
	h56pI2Go8Z03nwaz5nl1u4ueuEL9A7y6RlzkwkOi1kCzpa8z/XjJupy/p5qqF0VA
	fvv1IeQKvYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F292E4692;
	Fri, 23 Sep 2011 18:26:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 600D14691; Fri, 23 Sep 2011
 18:26:18 -0400 (EDT)
In-Reply-To: <20110923221513.GA3087@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 23 Sep 2011 18:15:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EA34224-E633-11E0-963D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182008>

Jeff King <peff@peff.net> writes:

> Since we've had a few credential helpers posted to the list recently, I
> really want to try them all out. This can be a little bit tricky for
> automated testing, though, for two reasons:
>
>   - they run on lots of platforms with lots of dependencies
>
>   - they interact with parts of the systems that are opaque to git. So
>     we can't make a test that reliably simulates "and then the user
>     types 'foo' into a dialog box" across all platforms.
>
> Instead, I came up with a separate test script that is intended to be
> run interactively with the user. It runs the helpers through a battery
> of tests, and tells the user what to expect and what to input to any
> dialogs or prompts.
>
> I've run it already on the helpers I've written. I plan on running it
> with the helpers that have been posted, as well. But I also wanted to
> make it public so that authors could use it as a development aid.
>
> It's not integrated with git's tests at all. In theory it could be part
> of t/, but disabled unless the user asks for it. However, I'm not sure
> that makes much sense. It's intended to test helpers that aren't
> necessarily even shipped with git, and wouldn't necessarily even need
> git to run.

Perhaps throw it in somewhere under contrib/ hierarchy?
