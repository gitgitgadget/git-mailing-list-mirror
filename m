From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug was
 fixed
Date: Tue, 21 Jul 2009 19:41:17 -0700
Message-ID: <7vy6qhwib6.fsf@alter.siamese.dyndns.org>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
 <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
 <20090721202848.GA3453@localhost.localdomain>
 <7vprbtbwhu.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0907212030180.30629@xanadu.home>
 <7v4ot5zfqe.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0907212118550.30629@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Bacik <josef@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 04:41:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTRlw-0007W0-Vz
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbZGVCl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZGVClZ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:41:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZGVClZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:41:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F095F8D2;
	Tue, 21 Jul 2009 22:41:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3DB21F8D0; Tue,
 21 Jul 2009 22:41:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0907212118550.30629@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 21 Jul 2009 21\:20\:24 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25805892-7669-11DE-88F7-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123733>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 21 Jul 2009, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > Why not simply automatically inverting the meaning of good and
>> > bad based on which commit is the ancestor of the other initially?
>> 
>> Because neither may be an ancestor of the other?
>
> In most cases it has to be, no?

Not necessarily.

I think it depends on your workflow.  When you bisect a topic branch that
forked from 'master' some time ago, it is not unreasonable to start it
with

	$ git bisect start topic master

instead of

	$ git bisect start topic $(git merge-base master topic)

Recent bisect would force you to check the merge base first as a sanity
check, but I think you already need to have determined what good and bad
means at that point if you take the route you suggested.
