From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] git grep shows the same hit repeatedly for unmerged paths
Date: Thu, 06 Dec 2007 00:08:30 -0800
Message-ID: <7v3auggs8x.fsf@gitster.siamese.dyndns.org>
References: <7vsl2gk7e3.fsf@gitster.siamese.dyndns.org>
	<4757A4DD.901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 09:09:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Bn5-0007P1-BP
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 09:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbXLFIIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 03:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbXLFIIj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 03:08:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57932 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbXLFIIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 03:08:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E479D2EF;
	Thu,  6 Dec 2007 03:08:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C0BA9C4E7;
	Thu,  6 Dec 2007 03:08:56 -0500 (EST)
In-Reply-To: <4757A4DD.901@viscovery.net> (Johannes Sixt's message of "Thu, 06
	Dec 2007 08:29:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67268>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> When the index is unmerged, e.g.
>> 
>> 	$ git ls-files -u
>>         100644 faf413748eb6ccb15161a212156c5e348302b1b6 1	setup.c
>>         100644 145eca50f41d811c4c8fcb21ed2604e6b2971aba 2	setup.c
>>         100644 cb9558c49b6027bf225ba2a6154c4d2a52bcdbe2 3	setup.c
>> 
>> running "git grep" for work tree files repeats hits for each unmerged
>> stage.
>> 
>> 	$ git grep -n -e setup_work_tree -- '*.[ch]'
>>         setup.c:209:void setup_work_tree(void)
>>         setup.c:209:void setup_work_tree(void)
>>         setup.c:209:void setup_work_tree(void)
>> 
>> This should fix it.
>
> Does this change the behavior of grep --cached? IOW, listing the same hit
> more than once when --cached is given is a feature, IMHO.

Yeah, --cached should grep for each stage.  It doesn't?
