From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 10:27:13 -0700
Message-ID: <7vej4aqsge.fsf@gitster.siamese.dyndns.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
 <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
 <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
 <20080826074044.GA22694@cuci.nl>
 <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com>
 <20080827091800.GB484@cuci.nl> <48B54A3D.3080708@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYOor-0003x5-BK
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbYH0R11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYH0R11
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:27:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYH0R10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:27:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 21A596A6DC;
	Wed, 27 Aug 2008 13:27:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7C3246A6D8; Wed, 27 Aug 2008 13:27:16 -0400 (EDT)
In-Reply-To: <48B54A3D.3080708@gnu.org> (Paolo Bonzini's message of "Wed, 27
 Aug 2008 14:36:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A11388C-745D-11DD-BECC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93904>

Paolo Bonzini <bonzini@gnu.org> writes:

>>> But it's harmless to have both.
>> 
>> Considering the fact that daemon authors might not get pointed at their
>> mistakes as soon as possible, it is harmful to try and hide those facts.
>
> Agree.  OTOH what about opening fd's 0/1/2 to /dev/null only in
> git-shell.c, now that it's not a builtin anymore?

Hmm, why git-shell?

It is either run by ssh (via command="" option in authorized_keys file),
by init/login (if in /etc/passwd), or by gitosis (and its equivalent).

Wouldn't these callers already give it a sane environment (and if a
lookalike to gitosis forgets to do so, wouldn't Stephen's argument not to
hide the issue from the daemon writers apply)?
