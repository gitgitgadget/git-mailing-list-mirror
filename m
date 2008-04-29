From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 16:06:35 -0700
Message-ID: <7v63u05khw.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
 <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
 <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
 <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net>
 <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness>
 <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness>
 <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:07:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqyvO-0003dC-JD
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYD2XGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbYD2XGy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:06:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbYD2XGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:06:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD68F2E36;
	Tue, 29 Apr 2008 19:06:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 11B1B2E34; Tue, 29 Apr 2008 19:06:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> (Johannes
 Schindelin's message of "Tue, 29 Apr 2008 23:55:49 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F40943A2-1640-11DD-95CA-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80765>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 29 Apr 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > It is a simple matter of the word "acyclic" in the term "DAG".  It means 
>> > that whenever you need to refer to a commit, it either comes before or 
>> > after the commit you need it for, not both directions.
>> 
>> I fell in the same "acyclic" fallacy before I realized it was a mistake, 
>> especially after thought about the "rewritten B needs to be used more 
>> than twice as a merge source" issue.  That's why I earlier said the 
>> beauty of your approach is attractive but it "unfortunately" breaks 
>> down.
>
> I do not understand.  The topological order assures that you have 
> rewritten every commit that needs to be rewritten before rewriting the 
> current commit.

Perhaps it would help to go back to the message J6t incompletely quoted,
and try the example with the parent order of Y swapped (i.e. B == Y^2, C
== Y^1)

Recreating X and Y both need to refer to the rewritten B as the parameter
to "merge" insn.  You create X first then you cannot refer to B anymore to
recreate Y.  The other way around you cannot name B to recreate X.
