From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] commit -c/-C/--amend: reset timestamp and authorship to committer with --reset-author
Date: Thu, 05 Nov 2009 12:34:56 +0900
Message-ID: <20091105123456.6117@nanako3.lavabit.com>
References: <1257304811-26812-1-git-send-email-erick.mattos@gmail.com>
	<7vpr7ykbh8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 04:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5t7u-0000JN-IM
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 04:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbZKEDez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 22:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbZKEDez
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 22:34:55 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60740 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbZKEDey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 22:34:54 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 13B7811B854;
	Wed,  4 Nov 2009 21:35:00 -0600 (CST)
Received: from 6562.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id IEU55YKKU2T5; Wed, 04 Nov 2009 21:35:00 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=k6lQrPhCCJOIlDMj+fNwlj9kTUaBGwk6Iz9CysnYPfyGJJ8nYBWw1Raxa5g8gnkB2UWRO/0Or8RfSxTRiZ1znxUZ9eSIh3Si7vQEtPbmgB7LqQmNPQ33ibEsVECGi3TCdW3nBdN8MH/fbazaKU9/P7wSXB/ikb88BmgtAnPsDVY=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vpr7ykbh8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132195>

Quoting Junio C Hamano <gitster@pobox.com>

> I had an impression that we have already established that setting the
> author with --author="Somebody Else <s@b.e>" and committing with the
> current time does not make much sense from the workflow point of view long
> time ago in this thread.
> <snip>
> But allowing this combination, even though it might not make much sense,
> is just giving extra length to the rope, so it may not be such a big deal.

It may be wise to forbid a combination of options if it 
encourages mistakes or a wrong workflow, but I don't think 
using --author and --reset-author with 'git commit --amend' 
is such a case.

Imagine somebody other than you (eg. me) were the maintainer, 
and a message by Szeder was sent with a good commit log message.

 http://article.gmane.org/gmane.comp.version-control.git/132029

Then you sent a replacement patch that solves the same problem 
in a more elegant way, but without anything that is usable as the 
commit log message.

 http://article.gmane.org/gmane.comp.version-control.git/132041

If I were the maintainer, I would find it very convenient if I can 
work like this:

 % git am -s 132029   --- first I apply Szeder's version

Then I see your message. Replace the code change but use Szeder's
log message.

 % git reset --hard HEAD^
 % git am 132041   --- your version with no usable log message
 % git commit --amend -s -c @{2} --author='Junio C Hamano <...>'

> Sorry, but I cannot help feeling a bit frustrated and mildly irritated.

Don't try to be perfect and feel stressed out, and please take 
a good rest.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
