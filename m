From: "Bisani, Alok" <alok.bisani@credit-suisse.com>
Subject: RE: git rebase -i onto HEAD~n
Date: Tue, 3 Feb 2009 16:22:22 -0000
Message-ID: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCA0@ELON17P32001A.csfb.cs-group.com>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com>
 <20090203154457.GA6859@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "=?iso-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUO4f-0002ue-PV
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbZBCQXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZBCQXI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:23:08 -0500
Received: from mail-gw18.credit-suisse.com ([198.240.130.183]:61556 "EHLO
	nys17a-3003.corpny.csfb.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751234AbZBCQXH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 11:23:07 -0500
Received: by nys17a-3003.corpny.csfb.com; Tue, 3 Feb 2009 11:22:39 -0500 (EST) 
X-Server-Uuid: 13D18DBC-9E45-4B21-A894-493F5AF71AE6
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20090203154457.GA6859@atjola.homenet>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git rebase -i onto HEAD~n
thread-index: AcmGFnHC2wF1+V5ZQcmkiaZ/ktQBkwAA0E+Q
X-OriginalArrivalTime: 03 Feb 2009 16:22:23.0345 (UTC)
 FILETIME=[9841AE10:01C9861B]
X-WSS-ID: 6596B0B04E081190-06-05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108207>

>On 2009.02.03 15:32:35 -0000, Bisani, Alok wrote:
>> Hi,
>> 
>> Is it possible to use git rebase -i for the following use case, in a 
>> local branch?
>> 
>> $ git reset --soft HEAD~3
>> $ # magically squash HEAD~2 & HEAD, ignoring HEAD~1 (which should be
>> discarded)
>> $ git commit -m "new commit replacing current HEAD~2 HEAD, without the 
>> commit HEAD~1 (to be discarded)"
>> 
>> I get the error below.
>> 
>>     grep: /home/user/project/.git/rebase-merge/done: No such file or 
>> directory
>>     Cannot 'squash' without a previous commit
>
>It would be helpful if you told us what command you used, and what you changed in the editor.
>
>This should do:
>git rebase -i HEAD~3
>
>And in the editor:
>pick HEAD~2
>squash HEAD

Sure. Here is the sequence of commands.

    mkdir gittest; cd gittest/
    git init
    echo "one" > one.txt; git add one.txt; git commit -m "one"
    echo "two" > two.txt; git add two.txt; git commit -m "two"
    echo "bad" > discard.txt; git add discard.txt; git commit -m "discard"
    echo "three" > three.txt; git add three.txt; git commit -m "three"
    git rebase -i HEAD~3

    # Leave editor for ~/gittest/.git/rebase-merge/git-rebase-todo with
    squash 8df4c33 two
    # deleted line with discard
    squash 91f8267 three

    # And get this error
    grep: /home/user/gittest/.git/rebase-merge/done: No such file or directory
    Cannot 'squash' without a previous commit

I guess the error could be introduced after commit -m "two" is first squashed, leaving commit -m "three" parentless, in the (no branch) branch?

Best regards,
Alok

==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================
