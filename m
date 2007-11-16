From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] Fix git-tag test breakage caused by broken sed on Leopard
Date: Fri, 16 Nov 2007 14:45:08 +0100
Message-ID: <7A6820DE-C6EE-4E3E-A97F-97766F682B85@wincent.com>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site> <90D416F6-A3CA-43C8-B71F-38EA955A762B@wincent.com> <C9DFAD77-DFEF-47AC-83D5-CFDF245D95E4@wincent.com> <7v4pfm3h6f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 14:45:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It1Vu-0000e1-18
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 14:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbXKPNpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 08:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758474AbXKPNpZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 08:45:25 -0500
Received: from wincent.com ([72.3.236.74]:41956 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757632AbXKPNpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 08:45:25 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGDj9gf020586;
	Fri, 16 Nov 2007 07:45:10 -0600
In-Reply-To: <7v4pfm3h6f.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65225>

El 16/11/2007, a las 6:14, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 096fe33..b54c2e0 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1007,7 +1007,7 @@ test_expect_failure \
>> test_expect_success \
>> 	'message in editor has initial comment' '
>> 	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>> +	test $(grep -e "^#" -e "^\$" actual | wc -l ) -gt 0
>> '
>
> Heh, doesn't grep exit with zero only when it found some lines
> that match the pattern already?  What's that "wc -l" for?


I was just trying to make the minimal change (swapping grep for sed), =20
but if you want a shorter version then we don't even need the "test"; =20
it could just be:

-	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
+	grep -e "^#" -e "^\$" actual

Cheers,
Wincent
