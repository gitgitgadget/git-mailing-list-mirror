From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 07 Jul 2010 17:30:57 -0700
Message-ID: <7v39vustku.fsf@alter.siamese.dyndns.org>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
 <7viq4rxnro.fsf@alter.siamese.dyndns.org>
 <201007072220.18824.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 02:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWf1I-0003u9-N7
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 02:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab0GHAbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 20:31:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab0GHAbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 20:31:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE9A0C2742;
	Wed,  7 Jul 2010 20:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Vd6rsbtOFhSav6OH39HKj6vpv0=; b=c2k3sR
	F1aLYNsJrpvsmHX74FkFrXvh+M5WPgp9n9MB2x3La72OuXeuNEqsC/icMc6+AvpZ
	gOUBIEeJLZFzLiyc2ZQMR4HayauN1KuSoohr+5MsRHe/RrRKj/rlUUWXnr3AxN+H
	SNL9Kf48gPov37vleQsCdNn/9qaDyAin8t+8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wc8as9GDqE/Wr6z3uSpAAq6QwUKbrjuA
	YpdslTuTZR+BXqBh9MZRff3JvqqDZfx91Hbg8Ow+CpQklm+0ikQvviGaU/trLa+j
	W5VttCiMOCFzX674NQ5173A4Q7s86Tz9QJ1I2fDNuJjMWroEpqZ65174cTLWepdM
	IddpzlFG808=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78551C273E;
	Wed,  7 Jul 2010 20:31:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74DD9C273D; Wed,  7 Jul
 2010 20:30:59 -0400 (EDT)
In-Reply-To: <201007072220.18824.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 7 Jul 2010 22\:20\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1840FEE2-8A28-11DF-9B86-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150520>

Jakub Narebski <jnareb@gmail.com> writes:

>> > +install-modules:
>> > +	install_dirs=$(sort $(dir $(GITWEB_MODULES))) && \
>> > ...
>
> For example with the following Makefile:
>
>   GITWEB_MODULES += GitwebCache/SimpleFileCache.pm
>   GITWEB_MODULES += GitwebCache/Capture.pm
>   GITWEB_MODULES += GitwebCache/Capture/SelectFH.pm
>   GITWEB_MODULES += Gitweb/Config.pm
>   
>   all:
>   	@echo $(sort $(dir $(GITWEB_MODULES)))
>
> running 'make' results in:
>
>   Gitweb/ GitwebCache/ GitwebCache/Capture/


Try replacing that with:

	all:
        	install_dirs=$(sort $(dir $(GITWEB_MODULES))) && \
                echo $$install_dirs

perhaps?

Hint: dq.
