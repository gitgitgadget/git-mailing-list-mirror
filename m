From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 09/10] Fix tests breaking when checkout path	contains
 shell metacharacters
Date: Mon, 05 May 2008 10:11:19 +0200
Message-ID: <481EC127.4070808@viscovery.net>
References: <1209879480-16910-2-git-send-email-bdonlan@fushizen.net> <1209879480-16910-3-git-send-email-bdonlan@fushizen.net> <1209879480-16910-4-git-send-email-bdonlan@fushizen.net> <1209879480-16910-5-git-send-email-bdonlan@fushizen.net> <1209879480-16910-6-git-send-email-bdonlan@fushizen.net> <1209879480-16910-7-git-send-email-bdonlan@fushizen.net> <1209879480-16910-8-git-send-email-bdonlan@fushizen.net> <1209879480-16910-9-git-send-email-bdonlan@fushizen.net> <1209879480-16910-10-git-send-email-bdonlan@fushizen.net> <481EB168.1070206@viscovery.net> <20080505075759.GA20537@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Mon May 05 10:12:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsvo2-0004Ib-RC
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbYEEIL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755921AbYEEIL1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:11:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40301 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbYEEILZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:11:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jsvn5-0001Zn-HL; Mon, 05 May 2008 10:11:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 352B86D9; Mon,  5 May 2008 10:11:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080505075759.GA20537@shion.is.fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81241>

Bryan Donlan schrieb:
> On Mon, May 05, 2008 at 09:04:08AM +0200, Johannes Sixt wrote:
>> Bryan Donlan schrieb:
>>> This fixes the remainder of the issues where the test script itself is at
>>> fault for failing when the git checkout path contains whitespace or other
>>> shell metacharacters.
>> Maybe a note along these lines would be in order:
>>
>> The majority of git svn tests used the idiom
>>
>>   test_expect_success "title" "test script using $svnrepo"
>>
>> These were changed to have the test script in single-quotes:
>>
>>   test_expect_success "title" 'test script using "$svnrepo"'
>>
>> (which makes the patch so large). One consequence of this change is that
>> in the verbose test output the value of $svnrepo (and in some cases other
>> variables, too) is no longer expanded, i.e. previously we saw
>>
>>   * expecting success:
>> 	test script using /path/to/git/t/trash/svnrepo
>>
>> but now it is:
>>
>>   * expecting success:
>> 	test script using "$svnrepo"
> 
> Ah, good point. I don't see an easy way to make them show in expanded
> form without breaking space handling, unfortunately, but if a v4 is
> needed I can toss that in.

I don't think there's a lot of value in the original behavior, so IMO you
don't have to resurrect it (it would make the test scripts less readable
again). Just mention the new behavior in the commit message so that
everybody knows that the change is more or less intended.

-- Hannes
