From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 09:08:16 +0200
Message-ID: <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 09:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2MBm-0006yr-HJ
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 09:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbXFXHHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 03:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbXFXHHM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 03:07:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:55068 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbXFXHHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 03:07:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5O7793x005151;
	Sun, 24 Jun 2007 09:07:09 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db104ed.pool.einsundeins.de [77.177.4.237])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5O778nG028016
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jun 2007 09:07:08 +0200 (MEST)
In-Reply-To: <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50773>


On Jun 23, 2007, at 11:04 PM, Alex Riesen wrote:

>> git-transplant.sh <onto> <from> <to>
>>
>> transplant starts with the contents of <onto> and puts on top of
>> it the contents of files if they are touched by the series of
>> commits <from>..<to>.  If a commit touches a file the content of
>> this file is taken as it is in the commit. No merging is
>> performed. Original authors, commiters, and commit messages are
>> preserved.
>>
> [...]
> # detached head
> git checkout $(git rev-parse onto) && git format-patch --stdout
> --full-index from..to|git am -3

No. This one tries to apply the _changes_ between from..to. What I
need is the resulting _content_ of files modified between from..to.

The _changes_ are already wrong because they are relative to the
history. But the history was messed up by git-cvsimport, as I tried to
explaine in my first mail in this thread. So the changes derived
from the wrong history are useless.

transplant only checks if a file is modified by a commit. If it is
it takes the _content_ of the file in that commit. The changes from
the parent commit, which you can find by format-patch, do not matter.

I believe it's more like git-filter-branch, but I wasn't yet abel to
tell git-filter-branch how to do the job.

	Steffen
