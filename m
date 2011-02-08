From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 07 Feb 2011 18:16:58 -0800
Message-ID: <7vwrlbqnhh.fsf@alter.siamese.dyndns.org>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org> <4D509B8B.6090607@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 03:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmd8r-0006jf-Ts
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 03:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab1BHCRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 21:17:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab1BHCRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 21:17:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB9B9494A;
	Mon,  7 Feb 2011 21:18:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gP6PCJjliJN35FQ1ZSiCPIpfn7o=; b=yj+Yxu
	ujEKv4O0dk3kQYhfXxgxdqZOrnxjaZ0TsAHkarkrwg5O3oD8Cn/v8pACMx0V7B0D
	GUCi9gKwL02C/NnqDiRzwM3+iqZSOSTNOCwUFVFkcOpgh9oapn1Vpo+zgMfO/ZA+
	FH+Ty7Dx0RiT+yz0fg8iPIJkJK4lb3Z4hJgi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FzbbqIRm7zmsW7GfCRLYOkSDmgvxpRv1
	MQfbZYhX39FfGy4jeTotsZMphYiqofJxYGjlFIvXO25S19lDpAcTb7HxPyAoaq0o
	beuyVEXxt970/FV3kGjRt2VeVac3d3DToPHFfqAH27hJ7HfbE9zqmAev3pnAgHF0
	+CX5tSsr/Fw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7BC664949;
	Mon,  7 Feb 2011 21:18:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2FE44946; Mon,  7 Feb 2011
 21:17:59 -0500 (EST)
In-Reply-To: <4D509B8B.6090607@nextest.com> (Eric Raible's message of "Mon\,
 7 Feb 2011 17\:25\:31 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA489B06-3329-11E0-9629-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166328>

Eric Raible <raible@nextest.com> writes:

> IFUC this shouldn't affect any (correctly written) scripts,
> and so the only downside is that (when run in a subdir) commands
> that are currently spelled:
>
> 	git xxx
>
> would with this change need to be spelled:
>
> 	git xxx .

If xxx is grep (or "add -u") and the script is running the former form,
you already broke it, and I think a script that expects "git grep" to
limit its scope to the current directory is "correctly written".  That is
how these commands were defined and documented to work.

"Adding SP plus dot is just a two-byte change" is not a sensible reason to
break people's scripts.  We need to be honest and say "sorry, but with
this release we are breaking your scripts.  Let us convince you that the
benefit of the resulting consistency outweighs that cost".
