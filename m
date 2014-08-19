From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Tue, 19 Aug 2014 10:26:36 +0200
Message-ID: <7D3A2FB9-F1CA-470C-91CC-8FF28097F812@zib.de>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de> <1407303134-16635-3-git-send-email-prohaska@zib.de> <20140816102703.GD7857@serenity.lan> <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de> <20140817072746.GD23808@peff.net> <C1695CEB-B278-422A-90D6-C3EAD8B6638C@zib.de> <CACsJy8BUBfQeny4iu6nZ+pCy84_=8EEfEHY3pWLpx_1PLCwC5w@mail.gmail.com> <20140819075345.GA7712@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJekv-0006Vd-61
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 10:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbaHSI04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 04:26:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:53745 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbaHSI0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 04:26:55 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7J8Qhpb013232;
	Tue, 19 Aug 2014 10:26:43 +0200 (CEST)
Received: from kodkod.zib.de (kodkod.zib.de [130.73.68.88])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7J8QfvV013045
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 19 Aug 2014 10:26:42 +0200 (CEST)
In-Reply-To: <20140819075345.GA7712@peff.net>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53F30A43.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F30A43.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F30A43.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255449>


On Aug 19, 2014, at 9:53 AM, Jeff King <peff@peff.net> wrote:

>>> For files >2GB on a 32-bit system (e.g. msysgit), filtering with the
>>> previous code always failed.  Now it works.  I created the patch to
>>> change git from 'fundamentally doesn't handle this' to 'works as
>>> expected'.
>> 
>> I deal with similar problem and added $GIT_ALLOC_LIMIT to test large
>> blob code. Maybe we could add $GIT_MMAP_LIMIT? I don't suppose we call
>> xmmap/xmalloc so often that the extra test would slow git down.
> 
> Yeah, I think I'd prefer that approach. We should mmap _way_ less than
> we malloc, and I do not think the malloc check has caused any problems.

I am going to update the patch accordingly.

	Steffen
