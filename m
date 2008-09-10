From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Tue, 09 Sep 2008 20:31:01 -0700
Message-ID: <7v1vzs1xu2.fsf@gitster.siamese.dyndns.org>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
 <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
 <48C57A92.6060608@freescale.com>
 <20080908212717.GA21338@oksana.dev.rtsoft.ru>
 <7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
 <20080909100628.GA15298@oksana.dev.rtsoft.ru>
 <7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
 <20080909151446.GA10395@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>,
	Becky Bruce <becky.bruce@freescale.com>,
	linuxppc-dev@ozlabs.org, git@vger.kernel.org
To: avorontsov@ru.mvista.com
X-From: git-owner@vger.kernel.org Wed Sep 10 05:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdGRJ-0001i2-Rs
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 05:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYIJDbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 23:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbYIJDbM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 23:31:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYIJDbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 23:31:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAAC55ACBD;
	Tue,  9 Sep 2008 23:31:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CC1475ACBC; Tue,  9 Sep 2008 23:31:03 -0400 (EDT)
In-Reply-To: <20080909151446.GA10395@oksana.dev.rtsoft.ru> (Anton Vorontsov's
 message of "Tue, 9 Sep 2008 19:14:46 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8F50AE4-7EE8-11DD-80B1-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95476>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

> On Tue, Sep 09, 2008 at 07:45:19AM -0700, Junio C Hamano wrote:
> ...
>> ...  It's an interesting idea from git person's point of
>> view (i.e. "would be fun to implement"), but I doubt it would be useful in
>> practice, because:
>> 
>>  (1) You often do not have the identically matching preimage;
>> 
>>  (2) More importantly, it is not unusual for people to *edit* the patch in
>>      their MUA (think of typofixes), after getting it out of git.
>
> Not for rename patches...

a. Why not?  Even if your patch is (totally uninteresting) pure rename, it
   is natural to review the patch before you send out, and it also is
   natural to get tempted to fix typoes, just for a straight normal patch.

b. If you can expect good behaviour out of people, by declaring "Not for
   rename patches" as your guarantee, what's the point of this discussion?

> As for implementing, isn't this as simple as this pseudo code:
>
> if (index_deleted_file == index_new_file)
> 	if (deleted_file != new_file)
> 		printk("warning\n");
>
> In the git-apply?

Implementation is easy (I said "would be fun to code", didn't I? --- by the
way, how did you match "index_deleted_file" with "index_new_file"?).

My point was that it would not be reliable enough to be useful in
practice.
