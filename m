From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 10:49:44 -0700
Message-ID: <7vlk4lp553.fsf@gitster.siamese.dyndns.org>
References: <20080308171726.GA16129@localhost>
 <alpine.LSU.1.00.0803081850470.3975@racer.site>
 <20080313125229.GA24758@localhost>
 <alpine.LSU.1.00.0803131607030.1656@racer.site>
 <20080313192246.GA30361@localhost>
 <alpine.LSU.1.00.0803132216580.4174@racer.site>
 <20080313224741.GA5000@localhost> <7vhcf9r4qp.fsf@gitster.siamese.dyndns.org>
 <20080314121752.GB3315@localhost> <7vd4pxqoql.fsf@gitster.siamese.dyndns.org>
 <20080314172848.GA5080@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:51:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaE3E-0003HD-W6
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbYCNRuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbYCNRuA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:50:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbYCNRuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:50:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C177133D;
	Fri, 14 Mar 2008 13:49:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DD67B1329; Fri, 14 Mar 2008 13:49:52 -0400 (EDT)
In-Reply-To: <20080314172848.GA5080@localhost> (Clemens Buchacher's message
 of "Fri, 14 Mar 2008 18:28:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77266>

Clemens Buchacher <drizzd@aon.at> writes:

> On Fri, Mar 14, 2008 at 10:21:05AM +0100, Clemens Buchacher wrote:
>> If the file mode or link changed in only one branch, keep the changed
>> version. If the file mode or link changed differently in both branches,
>> report a conflict. If this happens, the user is more likely to be aware of
>> the change in the head branch. Choose the remote version by default, in
>> order to make the user think about the change.
>
> In principle, both decisions are equally right or wrong. However, suggesting
> the remote version (i.e., "b") by default gives more incentive to think about
> it because the file now changed with respect to the head version (i.e., "a"),
> which the user started out with.

This matters only when the conflict is irreconcilable in the work tree,
and as long as we get the most important part right, i.e. marking the path
to be conflicting, that is good enough to make sure that the user does not
commit without thinking.

Besides the change breaks the traditional behaviour of leaving the "a"
side in the work tree.  As you already know, what you have done is as
equally valid as the other side did.  Be assertive and more confident in
what you have done ;-).
