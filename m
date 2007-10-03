From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] rebase: make the warning more useful when the work tree is unclean.
Date: Wed, 03 Oct 2007 11:02:05 +0200
Message-ID: <vpq1wcca7w2.fsf@bauges.imag.fr>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<7v3awunjup.fsf@gitster.siamese.dyndns.org>
	<49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
	<vpq641qroae.fsf@bauges.imag.fr>
	<7vlkamm16s.fsf@gitster.siamese.dyndns.org>
	<vpqr6keos6e.fsf@bauges.imag.fr>
	<7vd4vxmmxr.fsf@gitster.siamese.dyndns.org>
	<7vejgchijf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 11:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id083-0005Go-Jn
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 11:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXJCJCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 05:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbXJCJCn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 05:02:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:55125 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbXJCJCn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 05:02:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l93926Tf024310
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2007 11:02:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Id07J-0007x7-Ad; Wed, 03 Oct 2007 11:02:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Id07J-0003As-85; Wed, 03 Oct 2007 11:02:05 +0200
In-Reply-To: <7vejgchijf.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 02 Oct 2007 22\:30\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 03 Oct 2007 11:02:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59813>

Junio C Hamano <gitster@pobox.com> writes:

> Instead of letting "update-index --refresh" report paths needing
> updates and merges, use git-status to give more useful output.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I won't be a good judge of the updated behaviour, as I never
>    start rebase in an unclear tree.  Running git-status in a
>    large tree may be too expensive to be worth changing the
>    output.

I see your patch as an improvement too. status is a bit expansive, but
you hit this portion of code only when trying "rebase" by mistake, so
it's acceptable to let git take a bit of time to explain your mistake.

That said, I think it's still worth making the messages of
"update-index" a little more verbose and consistant with "status" (my
previous patch), since I think there are other occurences of
user-visible output of update-index in porcelain git.

Ideally, update-index would be a C function returning a struct
containing all the information about the status, with a function
is_clean(...) and another print_as_status(...), to allow the same
functionality with better performances, but I won't have time to do
this.

-- 
Matthieu
