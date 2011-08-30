From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Tue, 30 Aug 2011 12:04:54 +0200
Message-ID: <4E5CB5C6.6020403@drmicha.warpmail.net>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 12:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyLBm-0008GF-LQ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 12:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab1H3KE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 06:04:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60968 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105Ab1H3KE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 06:04:56 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 514FB20DF8;
	Tue, 30 Aug 2011 06:04:56 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 30 Aug 2011 06:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=HEHyeqs4big5y8/qFULT4j
	0F54g=; b=OSl+bTtU3v/lyCt72o0Rc09e8ofHPhsLzwsiLfpHDz/fwE/IQZ5q+i
	xvLYYw/Td2EbhLyQx7SEkUJcjscoHvWgOjx7vB2i7Sbq0hOjVNzqETSpDqhYxHRl
	NYOOqpQS5QXFFnHFtaKTmh6qzVKz+2S7u4mAUGzgLQS7QpdgH5I9o=
X-Sasl-enc: 1Sw1sF4761iqxXhK/cOSmyrxdaDw0UJcyQTJ5qoCU9gj 1314698696
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8FA3E4036A2;
	Tue, 30 Aug 2011 06:04:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <1314653603-7533-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180399>

Junio C Hamano venit, vidit, dixit 29.08.2011 23:33:
> "git diff A B -- $pathspec" to compare two tree-ishes knew how to apply
> pathspec to avoid opening trees that fall outside the area of interest,
> but "git diff A -- $pathspec" used unpack_trees() machinery that was meant
> for full-tree merges, and ended up reading the whole tree only to discard
> potentially major part of the work it does.

Seems my analysis wasn't that far off (though, admittedly, unspecific):

MG:
> Well, we have to read the full tree before diffing. But I can't
...
> I meant: The way "git diff" is now, it does that.

JC:
> anything to do with it (iow, your "The way 'git diff' is now, it does
> that" is not just incorrect---we don't read the full tree to begin
> with---but irrelevant).

Anyways, as MR writes:

MR:
> 30s without patch and 0.3s with it. You rock ;)

I agree with all of that ;)

Michael
