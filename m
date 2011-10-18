From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep
 patterns
Date: Tue, 18 Oct 2011 00:55:44 -0700
Message-ID: <7vvcrmhgxr.fsf@alter.siamese.dyndns.org>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <7vd3duixdg.fsf@alter.siamese.dyndns.org>
 <20111018072655.GA22309@elie.hsd1.il.comcast.net>
 <7v8voiiwfo.fsf@alter.siamese.dyndns.org> <vpqpqhug31l.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 18 09:55:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4Wh-0001mu-AS
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab1JRHzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:55:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab1JRHzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:55:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E213F1D;
	Tue, 18 Oct 2011 03:55:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xwk7lIqhIImkyAQzZUY0ZON9OYw=; b=XOI8Wd
	NOGVljyrNzH6VsgoMkWer+V9cTF7MAVNkTQ4d6vIowfi2ORe3+Gimj76ufgJGVTP
	1tgxmEt3t20irkJX9fcN5/TQ12Xuj+5gCGK926DKzWQPgYCfCj4kpY1TDpSyN2Cc
	FbQ8KDFUDhhmqUtI9uQiG8LnN2jVv1nS9l3+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M28Sktnign7LAdV5fF0rGY8jlFjQERHZ
	TUexkTPqQefkRVN/JA8D4TWf563THCEeeiAGaFaaWR+3PM5JNGucMGlYue3iQQYr
	0iof0hTVYuB04RfNSU8Fw/PmFS9mA+s1H9OY8Zi1OrCotVR6c7XK5/cg9toHc4e5
	T4rcCGri7gY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E2523F1C;
	Tue, 18 Oct 2011 03:55:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17D123F1B; Tue, 18 Oct 2011
 03:55:45 -0400 (EDT)
In-Reply-To: <vpqpqhug31l.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 18 Oct 2011 09:41:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96117AE4-F95E-11E0-B898-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183872>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> +git_check = $(shell git ls-files >/dev/null 2>&1; echo $$?)
>>>> +ifeq ($(git_check),0)
>
>> Hmm, how would this punish anybody exactly (I just took the structure
>> from the way how the auto-depend is done)?
>
> The "shell git ls-files" is ran unconditionnally, hence a small
> performance penality even if you don't run ctags.

You mean it is run once whenever you type "make <RETURN>"?  Doesn't the
same argument apply for the auto-depend thingy against "make doc<RETURN>"?
