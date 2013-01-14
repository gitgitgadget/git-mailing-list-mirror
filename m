From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Mon, 14 Jan 2013 06:12:54 +0100
Message-ID: <50F393D6.2010603@alum.mit.edu>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com> <50F17DB0.2050802@alum.mit.edu> <20130112182649.GC4624@elie.Belkin> <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucTF-0004Cn-B7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab3ANFUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:20:00 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:61485 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750787Ab3ANFT7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:19:59 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 00:19:59 EST
X-AuditID: 12074414-b7f9b6d0000008b3-ff-50f393d9c3ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.01.02227.9D393F05; Mon, 14 Jan 2013 00:12:57 -0500 (EST)
Received: from [192.168.69.140] (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5CsdX025674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:12:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqHtz8ucAg+dPhSx2zt3HanF1i49F
	15VuJouG3ivMFm9vLmF0YPXYOesuu8fFS8oeu0+zeiz72sni8XmTXABrFLdNUmJJWXBmep6+
	XQJ3xswPm9kKDrNXNJ47wNLA2MLWxcjJISFgIjH3/SooW0ziwr31YLaQwGVGiXl7wrsYuYDs
	M0wSs2eeYwFJ8ApoS6zZP40VxGYRUJW4sayJGcRmE9CVWNTTzARiiwoESCxeco4dol5Q4uTM
	J2C9IgJqEhPbDrGADGUW6GOU+HJpBViDsICXxOf3/awQm9czSjS8sgOxOQXMJH5cmwsWZxbQ
	kXjX94AZwpaX2P52DvMERoFZSHbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	Fnq5mSV6qSmlmxghAS6yg/HISblDjAIcjEo8vJtLPgcIsSaWFVfmHmKU5GBSEuUN7wcK8SXl
	p1RmJBZnxBeV5qQWH2KU4GBWEuENrQPK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0t
	SC2CycpwcChJ8IoDI1lIsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ
	8QDtZQZp5y0uSMwFikK0nmLU5dj+u/05oxBLXn5eqpQ47+dJQEUCIEUZpXlwK2Dp7BWjONDH
	wrzcIKN4gKkQbtIroCVMQEvOXngPsqQkESEl1cC4Nitgqcbto7K35S5oHF/972xd6vY3Xb8b
	V5cbL86JcWzXyHkvMPPBybTYw+WPpaMl4qIrKnLfvk4LfdSaxnTAP/fifun/VTvK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213432>

On 01/13/2013 11:20 PM, Junio C Hamano wrote:
> After a quick survey of various distros, I think it is very unlikely
> that we will see "distros move on to newer cvsps, leaving cvsimport
> broken" situation. If anything, it is more like "distros decide to
> ignore the new cvsps, until it is made to work with cvsimport" [*1*].

A better predictor of the distros' decisions is probably which other
packages depend on cvsps.  As one data point: on Debian squeeze and on
Ubuntu precise, only two packages depend on cvsps (git-cvs and
bzr-cvsps-import) and one suggests it (chora2, "a code repository
viewing component for horde framework").  So also by this standard they
are unlikely to feel a lot of pressure to update quickly to cvsps3.

> I think it is probably sensible to [...]
> 
> Agreed?

Yes, I agree that what you propose is a good strategy.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
