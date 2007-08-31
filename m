From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 01:12:37 -0700
Message-ID: <7vabs82kcq.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1d8-0008Bt-Lb
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbXHaIMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbXHaIMq
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:12:46 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:32942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbXHaIMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:12:45 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B520812B982;
	Fri, 31 Aug 2007 04:13:01 -0400 (EDT)
In-Reply-To: <20070831080651.GA17637@mellanox.co.il> (Michael S. Tsirkin's
	message of "Fri, 31 Aug 2007 11:06:51 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57129>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> +.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
>> +
>>  test-%$X: test-%.o $(GITLIBS)
>>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>
> Add a comment here?

I did not see a particular need for that.  What would you say
there?

>> Warning: 1 path touched but unmodified. Consider running git-status.
>
> BTW, shouldn't the warning go to standard error?

No, usually you are under PAGER, so we need to send this to
stdout.  We do this only when we are generating textual diff
which will be consumed by patch or git-apply.  They both know
how to ignore such a non patch material.
