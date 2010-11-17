From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.2 4/4] gitweb: Minimal testing of gitweb caching
Date: Wed, 17 Nov 2010 14:37:31 -0800
Message-ID: <7vk4kbefv8.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <1288607092-31458-1-git-send-email-jnareb@gmail.com>
 <201011130035.50229.jnareb@gmail.com> <201011130101.51116.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 23:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIqdW-0002gW-UG
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 23:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935557Ab0KQWht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 17:37:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935070Ab0KQWht (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 17:37:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 781F12435;
	Wed, 17 Nov 2010 17:37:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LndIuP5nXf5OpuMn7eMMq11twIk=; b=Y0PrGv
	WJlQjKILcZ1gcnrk51YUSf5ZG02zywgZ4X1rlMZMRO9mh15CSSl8JDs9QqQ9uEI2
	jpeTFULD8CNBGMc/u8rCmZVOqyTEE59wHi2O8ILoZLvsxmoQXcqHRDGKzDXtNGMv
	XVAc5XJcOvYlvojSf3TbiDLC7Jzu+BZ0RxpRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kn0ylz4DdNocueoEnGW+t2IfCpis6N7y
	CTyNpcuF5v0SVnJoyM8f9tvyN6snKXKXANjdaYGwjATFFiGc4aIPmoWhxpCx3aFn
	LkDwTBwSAh5qfoQR7pqwp1OZCuzOoFFhM4ZsOik9NugmeFq5qXw/e7j6vb+R9SP4
	2YHzOSapxoQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09D882431;
	Wed, 17 Nov 2010 17:37:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2EB3D2430; Wed, 17 Nov 2010
 17:37:41 -0500 (EST)
In-Reply-To: <201011130101.51116.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 13 Nov 2010 01\:01\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4EC885D0-F29B-11DF-A532-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161635>

Jakub Narebski <jnareb@gmail.com> writes:

> +gitweb_enable_caching () {
> +	test_expect_success 'enable caching' '
> +		cat >>gitweb_config.perl <<-\EOF &&
> +		our $caching_enabled = 1;
> +		our $minCacheTime = 60*60*24*7*30;     # very long expiration time for tests (a month)

Does your month have 210 days in it?

> +		our $maxCacheTime = 60*60*24*7*30*365; # upper bound for dynamic (adaptive) caching

Likewise, is this 210 years?  Does this bust 32-bit time_t somewhere?

> +		our $cachedir = "cache";               # for testsuite to clear the right thing
> +		# required, because otherwise some tests might intermittently not pass
> +		our $backgroundCache = 0; # should turn off cacheWaitForUpdate() / "Generating..."
> +		#our $cacheDoFork = 0;

leftover....
