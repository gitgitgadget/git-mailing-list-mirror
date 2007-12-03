From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size limitation
Date: Mon, 03 Dec 2007 15:24:44 -0800
Message-ID: <7veje3e4zn.fsf@gitster.siamese.dyndns.org>
References: <20071201160113.GA20849@nomad.office.altlinux.org>
	<7vlk8e42qb.fsf@gitster.siamese.dyndns.org>
	<20071203215007.GA14697@basalt.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKfO-0005f0-87
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 00:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXLCXYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 18:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXLCXYu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 18:24:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38576 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbXLCXYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 18:24:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CDBAA2F2;
	Mon,  3 Dec 2007 18:25:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 657A59C9CB;
	Mon,  3 Dec 2007 18:25:08 -0500 (EST)
In-Reply-To: <20071203215007.GA14697@basalt.office.altlinux.org> (Dmitry
	V. Levin's message of "Tue, 4 Dec 2007 00:50:07 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66977>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On Sat, Dec 01, 2007 at 11:46:52AM -0800, Junio C Hamano wrote:
>> On Sat, Dec 01, 2007 at 07:01:13PM +0300, Dmitry V. Levin wrote:
>> 
>> > When checking buffer for NUL byte, do not limit size of buffer we check.
>> > Otherwise we break git-rebase: git-format-patch may generate output which
>> > git-mailinfo cannot handle properly.
>> 
>> I think this is tackling a valid problem but it is a wrong solution.
>> The change penalizes text changes which is the majority, just in case
>> there is an unusual change that has an embedded NUL far into the file
>> (iow, exception).
>
> Penalizes?
> Average file size in the linux-2.6.23.9 kernel tree is 10944 bytes,
> FIRST_FEW_BYTES limit is 8000 bytes.

I really wish we were living in a simpler time, back when I could just
say "we optimize for the kernel" and did not have to be worried about
getting laughed at.
