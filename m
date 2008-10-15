From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix mkpath abuse in dwim_ref/sha1_name.c
Date: Wed, 15 Oct 2008 14:22:43 -0700
Message-ID: <7vabd5r1ss.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0810140923x5cf58bb9x5acd1517a19e9847@mail.gmail.com>
 <7viqru6a1r.fsf@gitster.siamese.dyndns.org>
 <20081015062039.GA3775@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDqf-0004Nu-SR
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYJOVWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbYJOVWw
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:22:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbYJOVWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:22:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 471238A9B3;
	Wed, 15 Oct 2008 17:22:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DAA038A9AD; Wed, 15 Oct 2008 17:22:45 -0400 (EDT)
In-Reply-To: <20081015062039.GA3775@blimp.localdomain> (Alex Riesen's message
 of "Wed, 15 Oct 2008 08:20:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B83C5C2-9AFF-11DD-8161-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98331>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Oct 15, 2008 01:17:52 +0200:
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>> >
>> > Otherwise the function sometimes fail to resolve obviously correct refnames,
>> > because the string data pointed to by "ref" argument were reused.
>> >
>> But your patch instead rewrites the computation of str2 by bypassing the
>> call to "another_function_that_uses_get_pathname()" and duplicating its
>> logic, which I do not think is a viable approach in the longer term.
>
> There is not enough logic to bypass there. It's just a dumb sprintf!

But didn't you lose call to cleanup_path()?
