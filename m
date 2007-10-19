From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 22:07:05 -0400
Message-ID: <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu> <20071019015715.GW14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihHS-0006Wq-Pa
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618AbXJSCHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966179AbXJSCHR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:07:17 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57085 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966129AbXJSCHO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 22:07:14 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9J276du023307;
	Thu, 18 Oct 2007 22:07:07 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9J275JZ022980
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 18 Oct 2007 22:07:06 -0400 (EDT)
In-Reply-To: <20071019015715.GW14735@spearce.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61600>


On 18 Oct 2007, at 9:57:15 PM, Shawn O. Pearce wrote:

> Michael Witten <mfwitten@MIT.EDU> wrote:
>> On 18 Oct 2007, at 11:47:32 AM, lmage11@twcny.rr.com wrote:
>>
>>> I don't know exactly how git manages the index
>>> internally, but a
>>> shortcut for this would be to simply rename the index entry in  
>>> place.
>>
>> Seems like the shortcut would lose the history and confuse git.
>
> No.  It wouldn't.  The index has no knowledge of history of anything.

I mean to say, if only the index is changed,
then git won't be informed about the necessary
git-{add/rm}'s, as in the following (is this
not so?):

> You're saying that, currently, 'git-mv A.txt path/B.txt'
> does this:
> 	
> 	mv A.txt path/B.txt
> 	git add path/B.txt
> 	git rm  A.txt
>
> So that A.txt is indeed moved to path/B.txt, but now
> A_dirty has been added to the index.
>
> What you want to happen is the following:
> 	
> 	git show HEAD:A.txt > path/B.txt
> 	git add path/B.txt
> 	mv A.txt B.txt
> 	git rm A.txt
