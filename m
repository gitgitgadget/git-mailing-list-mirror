From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] check_ref_format(): tighten refname rules
Date: Sun, 22 Mar 2009 16:19:21 -0700
Message-ID: <7vocvtb0xy.fsf@gitster.siamese.dyndns.org>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0903221539060.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:21:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWyg-0006Zw-Ct
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbZCVXTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbZCVXTa
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:19:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbZCVXTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:19:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4404EA4AC9;
	Sun, 22 Mar 2009 19:19:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5C011A4AC8; Sun,
 22 Mar 2009 19:19:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903221539060.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 22 Mar 2009 15:41:11 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3585770-1737-11DE-BE29-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114201>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 21 Mar 2009, Junio C Hamano wrote:
>
>> Yes, I know that tightening rules retroactively is bad, but this changes 
>> the rules for refnames to forbid:
>
> Tightening rules retroactively is not only bad (if sometimes necessary), 
> but tightening rules without giving the user a chance to recover is really 
> bad.
>
> 'git branch -m' uses check_ref_format() to check the old name.

Because "git branch -d" still allows a malformed funny branch to be
removed with this patch, I would say it is Ok as long as release notes
clearly says what we are tightening the rule for.

It is very probable that some people may have "master@{24}" in their
repositories, but such a branch cannot be accessed with or without this
patch anyway, and it is unlikely they created it because they wanted to.

"git branch wtf-dot wtf." followed by "git branch -d wtf." also works; for
this one, it might make sense to allow "git branch -m" to rename it, but
I do not think it is worth it.
