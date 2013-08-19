From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:27:08 +0200
Message-ID: <5211D6DC.5090704@kdbg.org>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de> <1376894300-28929-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:27:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKo3-0001nW-3V
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834Ab3HSI1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:27:15 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:56867 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750799Ab3HSI1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 04:27:15 -0400
Received: from [10.67.83.65] (178.115.251.65.wireless.dyn.drei.com [178.115.251.65])
	by bsmtp.bon.at (Postfix) with ESMTP id AD8621003B;
	Mon, 19 Aug 2013 10:27:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1376894300-28929-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232539>

Am 19.08.2013 08:38, schrieb Steffen Prohaska:
> Note that 'git add' exits with 0 even if it prints filtering errors to
> stderr.  The test, therefore, checks stderr.  'git add' should probably
> be changed (sometime in another commit) to exit with nonzero if
> filtering fails.  The test could then be changed to use test_must_fail.

Thanks for this hint. I was not aware of this behavior.

Of course, we do *not* want to use test_must_fail because git add 
generally must not fail for files with more than 2GB. (Architectures with 
a 32bit size_t are a different matter, of course.)

-- Hannes
