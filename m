From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v3 2/3] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Sun, 24 Aug 2014 18:03:24 +0200
Message-ID: <E4460202-E37A-498E-8062-DCCD9AE8E38C@zib.de>
References: <1408637110-15669-1-git-send-email-prohaska@zib.de> <1408637110-15669-3-git-send-email-prohaska@zib.de> <xmqq1ts9qy24.fsf@gitster.dls.corp.google.com> <0342479D-7C9F-42E6-9B79-745AEDE57EB5@zib.de> <xmqqmwawpldt.fsf@gitster.dls.corp.google.com> <xmqqiolkpjtq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 18:04:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLaHA-0002Og-UJ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 18:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbaHXQEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 12:04:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:48652 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbaHXQEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 12:04:11 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7OG3XAB013266;
	Sun, 24 Aug 2014 18:03:33 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd082.dynamic.kabel-deutschland.de [95.91.208.130] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7OG3Ue5013107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Aug 2014 18:03:31 +0200 (CEST)
In-Reply-To: <xmqqiolkpjtq.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53FA0CD5.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FA0CD5.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FA0CD5.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255796>

On Aug 22, 2014, at 6:31 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
>>>> +	if (limit == -1) {
>>>> +		const char *env = getenv("GIT_MMAP_LIMIT");
>>>> +		limit = env ? atoi(env) * 1024 : 0;
>> 
>> ... this should then be changed to atol(env), and ... 
> 
> In the real codepath (not debugging aid like this) we try to avoid
> atoi/atol so that we can catch errors like feeding "123Q" and
> parsing it as 123.
> 
> But it is OK to be loose in an debugging aid.  If I were doing
> this code, I actually would call git_parse_ulong() and not
> define it in terms of kilobytes, though.

Thanks for suggesting this.  I wasn't aware of git_parse_ulong().
I think it makes very much sense to use it, even though it's only a
testing aid.

I'll send a PATCH v5 series.

	Steffen
