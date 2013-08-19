From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:20:20 +0200
Message-ID: <5211D544.8080706@kdbg.org>
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
X-From: git-owner@vger.kernel.org Mon Aug 19 10:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKhV-0006AV-5c
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab3HSIU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:20:29 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:20293 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750810Ab3HSIU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 04:20:29 -0400
Received: from [10.67.83.65] (178.115.251.65.wireless.dyn.drei.com [178.115.251.65])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E8A4A7EB0;
	Mon, 19 Aug 2013 10:20:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1376894300-28929-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232534>

Am 19.08.2013 08:38, schrieb Steffen Prohaska:
> +test_expect_success EXPENSIVE 'filter large file' '
> +	git config filter.largefile.smudge cat &&
> +	git config filter.largefile.clean cat &&
> +	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&

Shouldn't you count to 2049 to get a file that is over 2GB?

> +	echo "2GB filter=largefile" >.gitattributes &&
> +	git add 2GB 2>err &&
> +	! test -s err &&
> +	rm -f 2GB &&
> +	git checkout -- 2GB 2>err &&
> +	! test -s err
> +'

-- Hannes
