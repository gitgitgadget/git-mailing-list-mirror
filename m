From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] Use ref transactions for fetch
Date: Tue, 06 May 2014 22:53:08 +0200
Message-ID: <53694BB4.2030904@alum.mit.edu>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>	<53677483.4050409@alum.mit.edu> <xmqq61lig38j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhmMV-0004pO-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbaEFUxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:53:12 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64672 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754191AbaEFUxL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 16:53:11 -0400
X-AuditID: 1207440e-f79c76d000003e2c-1b-53694bb689d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AD.0F.15916.6BB49635; Tue,  6 May 2014 16:53:10 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46Kr8Zr014930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 16:53:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqq61lig38j.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqLvNOzPYoGGviEXXlW4mi4beK8wW
	/ybUODB7LNhU6nHxkrLH501yAcxR3DZJiSVlwZnpefp2CdwZa//dZyrYwFrxa+EylgbGJSxd
	jJwcEgImEr/3LWOEsMUkLtxbz9bFyMUhJHCZUWLa7RMsEM55JomlB76xgVTxCmhLfDp3B6yD
	RUBVomfxDnYQm01AV2JRTzNTFyMHh6hAkMSfs4oQ5YISJ2c+AVsmIqAmMbHtEAtICbOAncTb
	VwogYWEBc4nZUxZD7Z3EKLFn+WpWkASngLXE/Eeb2EDqJQTEJXoag0DCzAI6Eu/6HjBD2PIS
	29/OYZ7AKDgLybZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0
	EyMkmPl2MLavlznEKMDBqMTD++BVRrAQa2JZcWXuIUZJDiYlUd6zrpnBQnxJ+SmVGYnFGfFF
	pTmpxYcYJTiYlUR4b+oC5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxK
	ErzTvYAaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHxG18MjGCQFA/Q3lqQdt7i
	gsRcoChE6ylGXY4LDStamIRY8vLzUqXEeW1AigRAijJK8+BWwFLXK0ZxoI+Fea+CVPEA0x7c
	pFdAS5iAlnAZp4MsKUlESEk1ME5x+j1dq/HOhRlX6vz8Fl6pXHnru7qWmpFSYu839zmsjHIW
	79lXc0Sl//vy6X7pSwk1Jh+57ZP3uAbaqZce7Hc0rLSNFNy411hOPeTD5eTaXoNZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248250>

On 05/06/2014 08:40 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> It would be pretty annoying to spend a lot of time fetching a big pack,
>> only to have the fetch fail because one reference out of many couldn't
>> be updated.  This would force the user to download the entire pack
>> again,...
> 
> Is that really true?  Doesn't quickfetch optimization kick in for
> the second fetch?

Yes, I guess it would.  I wasn't aware of that optimization.  Thanks for
the pointer.

I withdraw my objection to using atomic reference updates for fetch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
