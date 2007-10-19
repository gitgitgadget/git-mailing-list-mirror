From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 21:47:12 -0400
Message-ID: <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu>
References: <c594999b2337.2337c594999b@nyroc.rr.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: lmage11@twcny.rr.com
X-From: git-owner@vger.kernel.org Fri Oct 19 03:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iigxh-00035Y-VJ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbXJSBrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759767AbXJSBrW
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:47:22 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:53544 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754408AbXJSBrW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 21:47:22 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9J1lIpH013033;
	Thu, 18 Oct 2007 21:47:18 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9J1lCUP019894
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 18 Oct 2007 21:47:18 -0400 (EDT)
In-Reply-To: <c594999b2337.2337c594999b@nyroc.rr.com>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61595>


On 18 Oct 2007, at 11:47:32 AM, lmage11@twcny.rr.com wrote:

> I don't know exactly how git manages the index
> internally, but a
> shortcut for this would be to simply rename the index entry in place.

Seems like the shortcut would lose the history and confuse git.

Anyway,

Let's say you have a file, A.txt, with contents:

	A

You edit this file so that it has contents:
	
	A_dirty

You're saying that, currently, 'git-mv A.txt path/B.txt'
does this:
	
	mv A.txt path/B.txt
	git add path/B.txt
	git rm  A.txt

So that A.txt is indeed moved to path/B.txt, but now
A_dirty has been added to the index.

What you want to happen is the following:
	
	git show HEAD:A.txt > path/B.txt
	git add path/B.txt
	mv A.txt B.txt
	git rm A.txt

Is this correct?

Michael Witten
