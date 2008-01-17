From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 16 Jan 2008 17:13:51 -0800
Message-ID: <7vir1tmey8.fsf@gitster.siamese.dyndns.org>
References: <478E9C59.9070008@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJL4-0008HV-6c
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYAQBOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbYAQBOI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:14:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYAQBOH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:14:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 13DE84A6C;
	Wed, 16 Jan 2008 20:14:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 87EBE4A6B;
	Wed, 16 Jan 2008 20:14:03 -0500 (EST)
In-Reply-To: <478E9C59.9070008@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 16 Jan 2008 18:07:53 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70800>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> Shouldn't we be doing this? I think if quiet is set,
> then a failed rename will go undetected since we
> won't enter print_summary to have lookup_commit fail.

But then it's a bit too late, isn't it?  We already have
successfully made the commit and updated the HEAD to point at
it.  We would need to tell the user that the index is not where
it is when we detect the error, though.

> run_hook also is not checked for failure.

I think you mean the final post-commit one, but that is
deliberate.  post-commit is not meant to affect the outcome of
the command.
