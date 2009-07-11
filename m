From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/3] Make index preloading check the whole path to the
 file
Date: Fri, 10 Jul 2009 19:53:26 -0700
Message-ID: <7veisorkux.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
 <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain>
 <7v8wixw7s0.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907092028480.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 04:53:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPSid-0000WD-8R
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 04:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbZGKCxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 22:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbZGKCxf
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 22:53:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbZGKCxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 22:53:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 27195277C6;
	Fri, 10 Jul 2009 22:53:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 37CEC277C3; Fri,
 10 Jul 2009 22:53:28 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907092028480.3352@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 9 Jul 2009 20\:29\:05 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06214A7A-6DC6-11DE-8895-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123092>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 9 Jul 2009, Junio C Hamano wrote:
>> 
>> I must be missing something very obvious, but how would this call behave
>> on an uninitialized cache defined above, or do we need reset_lstat_cache()
>> on it before the first use?
>
> Neither.
>
> It should be memset() to zero. Good catch.

I actually was hoping to hear "Didn't you notice that this is the first
function run by the pthread and its stack is zeroed by thread creation" or
something clever like that ;-)

Squashed in.  Thanks.
