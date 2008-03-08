From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Add test for filter-branch on a subdirectory that's been added and deleted and re-added
Date: Sat, 8 Mar 2008 13:45:17 -0500
Message-ID: <91DF7A2E-540B-4AD6-91B2-BDB0B04EFC71@sb.org>
References: <1204977007-7267-3-git-send-email-kevin@sb.org> <7vzlt9t5wr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 19:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY43T-00077H-4q
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 19:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbYCHSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 13:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbYCHSpU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 13:45:20 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:34332 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753007AbYCHSpT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 13:45:19 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 86136EF350;
	Sat,  8 Mar 2008 10:45:18 -0800 (PST)
In-Reply-To: <7vzlt9t5wr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76573>

On Mar 8, 2008, at 1:41 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
>
>> Add a currently-failing test for the case when git-filter-branch
>> is run with the --subdirectory-filter referencing a folder that
>> has been added, deleted, and re-added. Such an action should work,
>> but as this test shows it ends up blowing up.
>
> Such a test is a very good incentive to the people involved in the  
> failing
> part of the system to fix, and is greatly appreciated.  However,
>
> * please mark "currently-failing" test with "test_expect_failure";

Ahh, didn't know about that. In retrospect I should have been able to  
guess, though.

> * please hint (after --- lines) if you will shortly be following up  
> with
>   a fix patch yourself, or if you are only reporting a bug.

Ah. Yeah, I'm only reporting a bug. I don't know anything about how  
this stuff works, and the bug doesn't bite me, it bit someone else  
instead, I just thought it deserved to be documented somewhere as a  
failure.

> I can fix-up and forge your Sign-off.

That would be great, thanks.

>> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
>> index 868babc..933157b 100755
>> --- a/t/t7003-filter-branch.sh
>> +++ b/t/t7003-filter-branch.sh
>> @@ -179,4 +179,17 @@ test_expect_success 'Name needing quotes' '
>>
>> '
>>
>> +test_expect_success 'Subdirectory filter on folder with non- 
>> contiguous history' '
>> +	mkdir foo &&
>> +	touch foo/bar &&
>> +	git add foo &&
>> +	git commit -m "Adding foo" &&
>> +	git rm -r foo &&
>> +	git commit -m "Removing foo" &&
>> +	mkdir foo &&
>> +	touch foo/bar &&
>> +	git commit -m "Re-adding foo" &&
>> +	git filter-branch --subdirectory-filter foo
>> +'
>> +
>> test_done
>> -- 
>> 1.5.4.3.487.g5a92
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com


