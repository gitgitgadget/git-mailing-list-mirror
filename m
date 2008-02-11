From: Andreas Ericsson <ae@op5.se>
Subject: Re: read_branches_file ()
Date: Mon, 11 Feb 2008 11:00:52 +0100
Message-ID: <47B01CD4.4040004@op5.se>
References: <20080208165008.52630d36@pc09.procura.nl> <20080208170305.069d43d2@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVUE-0008CX-9e
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYBKKBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYBKKBA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:01:00 -0500
Received: from mail.op5.se ([193.201.96.20]:44791 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYBKKA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:00:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B8AFA1F08841;
	Mon, 11 Feb 2008 11:00:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4xRuxkpaNupg; Mon, 11 Feb 2008 11:00:57 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 23CE91F08840;
	Mon, 11 Feb 2008 11:00:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20080208170305.069d43d2@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73497>

H.Merijn Brand wrote:
> -       if (!f)
> +       if (stat (gp, &st_buf) || S_ISDIR (st_buf.st_mode))

Shouldn't this be
	if (stat(gp, &st_buf) || !S_ISREG(st_buf.st_mode))

?

Otherwise, you might end up opening a FIFO, a socket or a
block/char special, which is obviously undesired.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
