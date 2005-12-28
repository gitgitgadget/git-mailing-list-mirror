From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/4] short circuit out of a few places where we would
 allocate zero bytes
Date: Tue, 27 Dec 2005 20:22:42 -0800
Message-ID: <43B21312.50603@zytor.com>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121243.GA3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 28 05:23:07 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErSq9-0005a6-UV
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 05:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVL1EWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 23:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVL1EWq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 23:22:46 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59835 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932466AbVL1EWp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 23:22:45 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBS4MgC3006994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Dec 2005 20:22:43 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224121243.GA3963@mail.yhbt.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL 
	autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14092>

Eric Wong wrote:
> dietlibc versions of malloc, calloc and realloc all return NULL if
> they're told to allocate 0 bytes, causes the x* wrappers to die().
> 
> There are several more places where these calls could end up asking
> for 0 bytes, too...
> 
> Maybe simply not die()-ing in the x* wrappers if 0/NULL is returned
> when the requested size is zero is a safer and easier way to go.
> 

Better yet, either always return NULL or allocate 1 byte in that case, 
to get consistent behaviour.

	-hpa
