From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: daemon: allow more than one host address given via --listen
Date: Mon, 30 Aug 2010 13:30:49 +0200
Message-ID: <1283167851-18331-1-git-send-email-alexander@sulfrian.net>
References: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 13:31:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq2a6-0001XO-ET
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 13:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab0H3La5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 07:30:57 -0400
Received: from animux.de ([78.46.93.45]:55751 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676Ab0H3La5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 07:30:57 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 53C3380CC3A7; Mon, 30 Aug 2010 13:31:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [87.77.143.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id ED92380CC38F;
	Mon, 30 Aug 2010 11:31:08 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Mon, 30 Aug 2010 13:30:54 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154786>


Hi,
here is a new version of the two patches. The sockets are now in a
socketlist structure that is compatible with ALLOC_GROW().
Also if no socket could be created for one host/ip, git daemon prints
now an error but continues (in both ipv6 and noipv6 builds). Only if
no socket could be created at all, it will die.

Also I removed the string_list_clear (it leave back memory leaks form
the xstrdup'ed-strings). It would be happen just before the exit of the
application and just before the operating system cleans the memory. So
I hope, that it is okay to remove it. If not i will change it, to
really free all lists before exit.

Thanks
Alex
