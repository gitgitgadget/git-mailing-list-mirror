From: prohaska@zib.de
Subject: Re: [PATCH] convert: Stream from fd to required clean filter instead of mmap
Date: Wed, 6 Aug 2014 06:32:06 +0200
Message-ID: <683E5A36-1D64-4185-8C81-E7D8EDB72DE9@zib.de>
References: <1407056176-8231-1-git-send-email-prohaska@zib.de> <xmqq4mxsrsao.fsf@gitster.dls.corp.google.com> <36DA9A8E-2F61-4DD3-9F82-427976C710A6@zib.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 06:32:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEstm-0004Tr-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 06:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbaHFEcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 00:32:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:56196 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbaHFEcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 00:32:22 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s764WDo6020943;
	Wed, 6 Aug 2014 06:32:13 +0200 (CEST)
Received: from [192.168.1.200] (95-91-208-111-dynip.superkabel.de [95.91.208.111])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s764WBb1020837
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 6 Aug 2014 06:32:12 +0200 (CEST)
In-Reply-To: <36DA9A8E-2F61-4DD3-9F82-427976C710A6@zib.de>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53E1AFCD.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53E1AFCD.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53E1AFCD.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254841>


On Aug 6, 2014, at 6:22 AM, Steffen Prohaska <prohaska@zib.de> wrote:

> On Aug 4, 2014, at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>>> +	return apply_filter(path, 0, 0, -1, 0, ca.drv->clean);
>> 
>> What's the significance of "-1" here?  Does somebody in the
>> callchain from apply_filter() check if fd < 0 and act differently
>> (not a complaint nor rhetoric question)?
> 
> The decision in apply_filter() to return before the real work is
> taken on the first 0.

Hmm..., actually it's the last 0 that matters.  If no destination buffer
is given, apply_filter() returns whether it would filter or not.


>  Any value for fd would be ok.  The -1 is
> only a reminder that the fd is invalid.


	Steffen
