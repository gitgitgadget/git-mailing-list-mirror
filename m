From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 16 Jan 2008 18:11:36 -0800
Message-ID: <7v63xtmc9z.fsf@gitster.siamese.dyndns.org>
References: <478E9C59.9070008@nrlssc.navy.mil>
	<7vir1tmey8.fsf@gitster.siamese.dyndns.org>
	<478EB430.1040604@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFKEq-0005J3-Sg
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYAQCLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYAQCLs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:11:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbYAQCLr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 21:11:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFBC6166A;
	Wed, 16 Jan 2008 21:11:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AAE51669;
	Wed, 16 Jan 2008 21:11:43 -0500 (EST)
In-Reply-To: <478EB430.1040604@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 16 Jan 2008 19:49:36 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70812>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>>  We would need to tell the user that the index is not where
>> it is when we detect the error, though.
>
> The new index we are trying to rename will be deleted.
> Are you saying we should 
>   warn the user that the index is now out of sync?

Yeah, something like that.  But I think that once this happens
there is no easy and sane recovery path for the user, as the
most likely cause of the failure there would be the user running
out of quota, so "git reset HEAD" which may be the way to
recover from that failure would not have enough room to create a
new index file anyway.
