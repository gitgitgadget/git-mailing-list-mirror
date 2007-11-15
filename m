From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 11:06:33 +0100
Message-ID: <473C1A29.2010703@op5.se>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>	<7voddv6fxz.fsf@gitster.siamese.dyndns.org>	<buozlxfeu0z.fsf@dhapc248.dev.necel.com>	<995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com> <buotznnesw9.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 11:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isbck-0006mk-54
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 11:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbXKOKGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 05:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953AbXKOKGj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 05:06:39 -0500
Received: from mail.op5.se ([193.201.96.20]:51729 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbXKOKGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 05:06:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EA1181F0871B;
	Thu, 15 Nov 2007 11:06:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WewLRpIVe1OH; Thu, 15 Nov 2007 11:06:35 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id DB0D61F08716;
	Thu, 15 Nov 2007 11:06:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <buotznnesw9.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65102>

Miles Bader wrote:
> Wincent Colaiuta <win@wincent.com> writes:
>> the shorter form without sed is arguably more readable:
>>
>> -		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
>> +		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"
> 
> Er, I suppose -- if you are acquainted with that particular shell
> variable syntax (I suspect knowledge of sed is far more widespread).
> 
> [personally, I know that syntax has something to do with replacing
> something with something else, but really haven't much clue other than
> that, and I always _thought_ it was bash-specific and so avoided using
> any of that stuff.]
> 

It says "remove refs/heads/ from the beginning of the string pointed to
by $head".

It's not a bashism. Some extensions to that syntax are though (I think).
If you want to be sure of portability, use sed instead. git uses this
syntax often enough that it's worth using everywhere, but usually only
in porcelain commands which one can relatively safely assume are run on
at least decently up-to-date developer workstations.

You'll note that stuff that absolutely *has* to reside server-side are
entirely in C.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
