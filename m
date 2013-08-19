From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:28:02 +0200
Message-ID: <B58CB9DC-029F-4568-8A27-0C60FFA6766B@zib.de>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de> <1376894300-28929-1-git-send-email-prohaska@zib.de> <5211D544.8080706@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:29:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKpz-00033E-0N
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab3HSI3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:29:14 -0400
Received: from mailer.zib.de ([130.73.108.11]:44703 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3HSI3O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Aug 2013 04:29:14 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7J8S6so005481;
	Mon, 19 Aug 2013 10:28:11 +0200 (CEST)
Received: from kodkod.zib.de (kodkod.zib.de [130.73.68.88])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7J8S5FI005299
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 Aug 2013 10:28:06 +0200 (MEST)
In-Reply-To: <5211D544.8080706@kdbg.org>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232540>


On Aug 19, 2013, at 10:20 AM, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 19.08.2013 08:38, schrieb Steffen Prohaska:
>> +test_expect_success EXPENSIVE 'filter large file' '
>> +	git config filter.largefile.smudge cat &&
>> +	git config filter.largefile.clean cat &&
>> +	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
> 
> Shouldn't you count to 2049 to get a file that is over 2GB?

No.  INT_MAX = 2GB - 1 works.  INT_MAX + 1 = 2GB fails.  It tests exactly at the boundary.

	Steffen
