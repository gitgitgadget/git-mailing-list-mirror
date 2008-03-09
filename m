From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] Allow for having for_each_ref() list some refs
 that aren't local
Date: Sat, 08 Mar 2008 19:57:36 -0800
Message-ID: <7vd4q4sg5r.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803081804170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 04:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYCgA-0006dL-T1
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 04:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYCID5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 22:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYCID5w
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 22:57:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbYCID5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 22:57:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37FCD24C7;
	Sat,  8 Mar 2008 22:57:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8EBE724C4; Sat,  8 Mar 2008 22:57:44 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0803081804170.19665@iabervon.org> (Daniel
 Barkalow's message of "Sat, 8 Mar 2008 18:04:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76632>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This is useful, for example, for listing the refs in a reference
> repository during clone, when you don't have your own refs that cover
> the objects that are in your alternate repository.

I hate to ask a question that I myself do not have a good answer to, but
it is a bit worrysome that using these extra refs would cause for-each-ref
to report different refs with the same name (the alternate's master branch
and this one's master branch are both called refs/heads/master).

I think no caller that reads from for_each_ref() keeps track of names that
it has seen and tries clever things like flagging duplicates as errors,
but it still feels like it is inviting trouble.
