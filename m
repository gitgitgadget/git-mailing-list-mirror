From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 22:13:33 -0700
Message-ID: <7vtz1456de.fsf@alter.siamese.dyndns.org>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
 <20090723012207.GA9368@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <20090723031843.GA9152@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907222041341.21520@localhost.localdomain>
 <alpine.LFD.2.01.0907222050500.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqcu-0005HY-AP
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbZGWFNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbZGWFNj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:13:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZGWFNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:13:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52EF4E760;
	Thu, 23 Jul 2009 01:13:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F249EE75E; Thu, 23 Jul 2009
 01:13:34 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907222050500.21520@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 22 Jul 2009 21\:10\:49 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94F0CC78-7747-11DE-B885-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123838>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 22 Jul 2009, Linus Torvalds wrote:
>> 
>> But I'll see if I can dig up my non-binary-search patch and see if I can 
>> make it go faster. My machine is fast, but not so fast that I can't 
>> measure it ;)
>
> Oh. We actually merged a fixed version of it. I'd completely forgotten.

As the commit message of 628522e (sha1-lookup: more memory efficient
search in sorted list of SHA-1, 2007-12-29) shows, it didn't get any great
performance improvements, even though it did make the probing quite a lot
less memory intensive.

Perhaps you can spot obvious inefficiency in the code that I failed to
see, just like you recently did for "show --cc" codepath?
