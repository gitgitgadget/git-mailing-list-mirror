From: Junio C Hamano <gitster@pobox.com>
Subject: Re: file deletion in index lost after checkout -b
Date: Sat, 06 Sep 2008 11:10:32 -0700
Message-ID: <7vej3xrvqf.fsf@gitster.siamese.dyndns.org>
References: <20080901034414.GR6619@jabba.hq.digizenstudio.com>
 <7vljy7xgs5.fsf@gitster.siamese.dyndns.org>
 <20080906171108.GA10924@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2GA-0003ev-9E
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbYIFSKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYIFSKm
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:10:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbYIFSKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:10:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D0BD7668B;
	Sat,  6 Sep 2008 14:10:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 09A397668A; Sat,  6 Sep 2008 14:10:34 -0400 (EDT)
In-Reply-To: <20080906171108.GA10924@jabba.hq.digizenstudio.com> (Jing Xue's
 message of "Sat, 6 Sep 2008 13:11:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1BBC5646-7C3F-11DD-9756-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95085>

Jing Xue <jingxue@digizenstudio.com> writes:

> On Thu, Sep 04, 2008 at 11:12:26PM -0700, Junio C Hamano wrote:
>> [jc: please redirect an answer _meant for you_ off to the list with M-F-T header]
>
> I changed mutt to not use M-F-T with the git list at all. Hope this one
> turns out better.

Thanks; I meant to say "please do not redirect", but you got what I wanted
to say correctly.

>> > The deletion of 2.txt appears lost during 'checkout -b foo', while the
>> > modification and addition were both brought over. Is it a bug?
>> 
>> This behaviour is unchanged since early June 2005.
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/4641/focus=4646
>> 
>> This is exactly the case marked as *0*, which both Linus and I said "it
>> feels somewhat wrong but otherwise we cannot start from an empty index".
>> 
>> We may want to do better this time around, though.
>
> I have since found out that:
>
> 1. file deletions in the working directory but not in index would not be forgotten. That
> makes "file deletions in index" case rather a corner one.
>
> 2. "checkout -b -m" would do the right thing.

Both correct.  1. does not involve case *0*; 2. does not do two-tree
switch but internally uses three-tree switch and uses different codepath.
