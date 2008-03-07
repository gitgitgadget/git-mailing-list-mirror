From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re-fix get_pathspec()
Date: Fri, 07 Mar 2008 09:48:05 -0800
Message-ID: <7v1w6m2zoq.fsf@gitster.siamese.dyndns.org>
References: <1204879119-7528-1-git-send-email-gitster@pobox.com>
 <alpine.LSU.1.00.0803071252240.19395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXggi-0005QG-Hx
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 18:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079AbYCGRsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758050AbYCGRsT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 12:48:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036AbYCGRsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 12:48:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E0F5C28D1;
	Fri,  7 Mar 2008 12:48:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3F75428CC; Fri,  7 Mar 2008 12:48:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76506>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 7 Mar 2008, Junio C Hamano wrote:
>
>> This miniseries cleans up the interface by making get_pathspec() to die
>> again.
>
> We have a few places where you have to pass a "die_on_error" flag.  Why 
> not imitate that?

Before get_pathspec() was made absolute-path capable, it died on a path
that is outside the work tree, so we know die() there is what the callers
have expected all along.  This miniseries is about fixing the earlier one
that broke that expectation, nothing more.

If enough callers want different behaviours on error, it probably is worth
an API enhancement so that the callers can choose to do their own thing,
but that is a separate topic I haven't seen the need for, and definitely
is not part of this fix.

