From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: change semantics of "ignore whitespace" options
Date: Mon, 25 May 2009 11:48:09 -0700
Message-ID: <7vhbz9vx1y.fsf@alter.siamese.dyndns.org>
References: <1243106690-6385-1-git-send-email-gitster@pobox.com>
	<1243106690-6385-2-git-send-email-gitster@pobox.com>
	<20090525110429.GB27070@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 25 20:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fDk-0000f5-54
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 20:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbZEYSsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 14:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbZEYSsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 14:48:09 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41009 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbZEYSsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 14:48:08 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525184810.FQLZ17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Mon, 25 May 2009 14:48:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vuo91b00J4aMwMQ04uo93j; Mon, 25 May 2009 14:48:09 -0400
X-Authority-Analysis: v=1.0 c=1 a=YiFvzzYMgSoA:10 a=5O3U-Pqe05oA:10
 a=PKzvZo6CAAAA:8 a=TxpikGIfs8x3xsmpzWkA:9 a=pqxTpMlK-BgidHqHQWxoiF1Y65EA:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090525110429.GB27070@coredump.intra.peff.net> (Jeff King's message of "Mon\, 25 May 2009 07\:04\:29 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119948>

Jeff King <peff@peff.net> writes:

>> +	if ((XDF_IGNORE_WHITESPACE|
>> +	     XDF_IGNORE_WHITESPACE_CHANGE|
>> +	     XDF_IGNORE_WHITESPACE_AT_EOL) & options->xdl_opts) {
>> +		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
>> +	} else {
>> +		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
>> +	}
>
> We have DIFF_XDL_TST these days;...

Heh, nobody seems to use it though.

Now the part reads

	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
	else
		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);

Thanks.
