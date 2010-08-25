From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compiling git with makepp patch
Date: Wed, 25 Aug 2010 15:53:17 -0700
Message-ID: <7v8w3upan6.fsf@alter.siamese.dyndns.org>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
 <4C71A53F.2020108@t-online.de> <20100824043220.GA20037@burratino>
 <4C758016.8070104@t-online.de> <m262yyuzk4.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: occitan@esperanto.org, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:53:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOqf-0001yA-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0HYWxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:53:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab0HYWxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 18:53:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5614DD0A26;
	Wed, 25 Aug 2010 18:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hEjDqh96CUMSZl01atB0t2d/LQg=; b=UEzcjn
	MifPT1hQ5Q1KhadSS/u3V18i5ViPvmOl1HPhgat3eQU4MIO/qwUZwHqM9AK2+udy
	t52HXAl6EfUEU8ClV24NtoszaXtfua8x+37pdHFt+6IyQhXBAUxzohEZn46rXV2q
	y4qAE8kPN8iXUzOKyDQwzh4dWWQqmp0s2JGUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F7lFPUKMgYrhZjkH6Mu+k3Hrln1QLceI
	UF8IwJxeK+ekEIHtWXGrLGD0gbdtLb/DB75+uP9vz9J+VsYtTjxRcDNP/pPQ3Rcw
	gmQhJFmixE+uKE2T8Nw6YSmelO9xAhFkAtHhylENrP9za60BY773iuSeXBnl8IAd
	PkvslXWl6vY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E21F7D0A24;
	Wed, 25 Aug 2010 18:53:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF1F0D0A22; Wed, 25 Aug
 2010 18:53:19 -0400 (EDT)
In-Reply-To: <m262yyuzk4.fsf@igel.home> (Andreas Schwab's message of "Wed\,
 25 Aug 2010 23\:56\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 914E54EE-B09B-11DF-A7A8-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154493>

Andreas Schwab <schwab@linux-m68k.org> writes:

>>> GNU make, unlike, say, pmake, reads all the rules before it runs
>>> anything iirc.  So you can have
>>>
>>>   -include foo
>>>
>>>   foo:
>>> 	echo bar:>foo
>>> 	echo '	echo hi'>>foo
>>>
>>> and it will cope okay.
>> While that is not the usual use-case for -include, the file might very
>> well define some macros, and the rest of the makefile, indeed the foo-rule
>> itself might depend on those macros.
>
> GNU make will restart reading all makefiles when any of them was remade.

I am not sure about the "reread" part, but shouldn't all POSIX compliant
make be topology driven (i.e. " reads all the rules before it runs
anything")?
