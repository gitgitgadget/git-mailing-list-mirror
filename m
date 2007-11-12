From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Mon, 12 Nov 2007 14:39:16 -0800
Message-ID: <7vve87142z.fsf@gitster.siamese.dyndns.org>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	<7vabpliz13.fsf@gitster.siamese.dyndns.org>
	<46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
	<7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
	<47380019.1000704@viscovery.net>
	<Pine.LNX.4.64.0711120950370.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Yin Ping <pkufranky@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhwY-0003s0-Ue
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbXKLWjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbXKLWjb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:39:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56014 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbXKLWja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:39:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 304E42F2;
	Mon, 12 Nov 2007 17:39:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9951C94B17;
	Mon, 12 Nov 2007 17:39:45 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711120950370.4362@racer.site> (Johannes
	Schindelin's message of "Mon, 12 Nov 2007 09:51:43 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64727>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 12 Nov 2007, Johannes Sixt wrote:
>
>> Junio C Hamano schrieb:
>>
>> > I am not saying that it is wrong to use submodule to track such groups 
>> > of source trees whose versions are very closely tied together.  At 
>> > least not yet.
>> 
>> In KDE, the supermodule will actually just be a container that binds the 
>> submodules together. The essential development will happen in the 
>> submodules, and the supermodule will receive a commit quite frequently. 
>> In this case, there will often be only a few or a few dozen commits 
>> listed, and I anticipate that the integrator who is going to make the 
>> commit (to the supermodule) will probably like the summary. So I'm all 
>> for it.
>
> I like it, too.  And we can make the number of shown commits configurable, 
> just like for the merge summary.

Very good point.  In the case J6t uses for his illustration
above, changing the submodule bound to the superproject is more
or less like merging.

> But I'd rather see the code in wt-status.c than in
> git-submodule.sh.

I do not have a strong preference either way, but submodule-loving
people may want to say "git submodule shortlog <path>" or whatever
from the command line.  

Making a standalone function that takes two commits from the
subproject and produces the output, and calling that function
from both git-submodule (to implement the above "shortlog"
subcommand) and from wt-status.c (to show what Yin wants to add,
only when "status.submodule" is set), would be a reasonable
implementation. 
