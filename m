From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset --hard/read-tree --reset -u: remove unmerged new
 paths
Date: Wed, 15 Oct 2008 23:27:46 -0700
Message-ID: <7vprm1jbq5.fsf@gitster.siamese.dyndns.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
 <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
 <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
 <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
 <7v3aixqzrn.fsf@gitster.siamese.dyndns.org>
 <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0810151615550.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 08:29:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqMMM-0001nL-MI
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 08:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbYJPG2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 02:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYJPG2H
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 02:28:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYJPG2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 02:28:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 319E38912A;
	Thu, 16 Oct 2008 02:28:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A4D5589127; Thu, 16 Oct 2008 02:27:58 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810151615550.3288@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Wed, 15 Oct 2008 16:16:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97208BD8-9B4B-11DD-9DED-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98348>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 15 Oct 2008, Junio C Hamano wrote:
>>
>> When aborting a failed merge that has brought in a new path using "git
>> reset --hard" or "git read-tree --reset -u", we used to first forget about
>> the new path (via read_cache_unmerged) and then matched the working tree
>> to what is recorded in the index, thus ending up leaving the new path in
>> the work tree.
>
> Looks good to me. And from my tests, I think "git checkout -f" didn't have 
> this problem at all, because it ends up using not got read-tree, but doing 
> its own "reset_tree()" that uses unpack_trees().
>
> I do wonder if "git reset" should perhaps be written in those terms, 
> instead of just being a wrapper around git read-tree. But the patch looks 
> fine.

Let's do this for 'maint' and I'll let others think about possible
improvements, then ;-).
