From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Surprising interaction of "binary" and "eol" gitattributes
Date: Thu, 05 Mar 2015 17:38:28 +0100
Message-ID: <54F88684.3020905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:39:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYnj-0003fR-6M
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbbCEQjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:39:01 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65241 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803AbbCEQiq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:38:46 -0500
X-AuditID: 12074413-f79f26d0000030e7-93-54f886863cd0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.8A.12519.68688F45; Thu,  5 Mar 2015 11:38:30 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25GcSoi032509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 5 Mar 2015 11:38:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqNvW9iPEYNlkLouuK91MDowenzfJ
	BTBGcdskJZaUBWem5+nbJXBnNGyZx1Qwi62iaetylgbGWyxdjJwcEgImEm/3zGCGsMUkLtxb
	z9bFyMUhJHCZUeLlgj3MEM4LJon/ly6CdfAKaEv82bYQKMHBwSKgKjF7lSRImE1AV2JRTzMT
	iC0qECRx6PRjqHJBiZMzn4DZIkA1u55dZQOxhQWcJdo7J4PZzALqEn/mXWKGsOUlmrfOZp7A
	yDsLSfssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESTMI7
	GHedlDvEKMDBqMTD+2Hz9xAh1sSy4srcQ4ySHExKorw/qn6ECPEl5adUZiQWZ8QXleakFh9i
	lOBgVhLhPdgClONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDuaQVq
	FCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFWHwxMMZAUjxAe0+CtPMWFyTmAkUh
	Wk8x6nIsaN8/k0mIJS8/L1VKnHcxSJEASFFGaR7cCljqeMUoDvSxMC8bSBUPMO3ATXoFtIQJ
	aImWGNiSkkSElFQDo1HGgnUfpggEPv7lP2XS2WS+uRkKd82u/S/UZC7csOLPbdaqPXy9dqu9
	fy4oDSoyWXf7kt9+EbEdkkIL1jxmifoXyez0at4eW22tBW+vF6X+1zwf9Pj524OuNbuUY+KF
	6+M+7tjj6HyzYbrcgnVWZ7ZvLCmVS4zzneSjsTxO3jpiTkGIwkSjDUosxRmJhlrM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264850>

I would expect that the following .gitattributes file

    *       eol=crlf
    *.png   -text

would leave EOL translation turned off for PNG files. In other words, I
would expect that explicitly setting "-text" would take precedence over
the fact that setting "eol" implies that a file should be considered to
be "text".

I would even more strongly expect

    *       eol=crlf
    *.png   binary

to turn off EOL translation for PNG files.

But in fact, in both of the above cases, EOL translation is turned *on*
for PNG files.

I propose that "-text" should override any setting for "eol" (which
would of course fix both problems, since "binary" is equivalent to
"-diff -merge -text"). What do people think?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
