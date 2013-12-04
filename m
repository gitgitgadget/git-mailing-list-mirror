From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 0/4] less ignorance of submodules for ignore=all
Date: Wed, 04 Dec 2013 14:32:46 -0800
Message-ID: <xmqq7gbkjlgx.fsf@gitster.dls.corp.google.com>
References: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com> <52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de>
	<CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
	<20131125174945.GA3847@sandbox-ub>
	<CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
	<20131204221659.GA7326@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoL04-0007Rj-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab3LDWcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:32:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076Ab3LDWcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:32:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 739D05723B;
	Wed,  4 Dec 2013 17:32:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2Ulh/3ZVpu0CpVD5xfEj8KyrEE=; b=wgj+Eg
	HpNACKOKTJjjmr68Ge+8TBUHs1HRh+0KRAtymzsl9Ma9xyZ9OOlRfn8D8NnMgI4Y
	0juG37ydYakjCqnoO/pAMljCUKUqgYYWplh5n8vsgDLqbLsdAVv2DVUcISYv1sH1
	JT5OiRw4Nrmc0LPaM/nIQsFdnOLQK7/BJLJRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qcsKPCLtfB3Fw3rajN4OQ19VATTbxhUd
	/b5uHxHfOZvVtWMNV6mvIIzQJ8LRjxaJBW/LlHM6/wj/iIoPJMRajAlqqr6H/ul5
	qB72vzxejkZ86E7vNsQ1bagjqoMiqNcarQe5n9et2uwHCeIl+zYpFZRXP22Y9Kjd
	CMtWme3+dHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6272D5723A;
	Wed,  4 Dec 2013 17:32:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99DC357236;
	Wed,  4 Dec 2013 17:32:50 -0500 (EST)
In-Reply-To: <20131204221659.GA7326@sandbox-ub> (Heiko Voigt's message of
	"Wed, 4 Dec 2013 23:16:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02283B10-5D34-11E3-803B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238823>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This is my current work in progress. Sergey it would be awesome if you
> could test these and tell me whether the behaviour is what you would
> expect. Once that is settled I will add some tests and possibly clean up
> some code.
>
> Since nobody spoke against this change of behavior I assume that we
> agree on the general approach I am taking here. If not please speak up
> now so we can work something out and save me implementation time ;-)
>
> Whats still missing is:

Before listing what's missing, can you describe what "the general
approach" is?  After all, that is what you are assuming that has got
a silent concensus, but without getting it spelled out, others would
easily miss what they "agreed" to.

I do think that it is a good thing to make what "git add ." does and
what "git status ." reports consistent, and "git add ." that does
not add everything may be a good step in that direction (another
possible solution may be to admit that ignore=all was a mistake and
remove that special case altogether, so that "git status" will
always report a submodule that does not match what is in the HEAD
and/or index).
