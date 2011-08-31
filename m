From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: [PATCH] Teach dcommit --mergeinfo to handle multiple
 lines
Date: Wed, 31 Aug 2011 13:43:39 -0700
Message-ID: <4E5E9CFB.4060600@vilain.net>
References: <20110831124839.69c70486@robyn.woti.com> <20110831202131.GA27307@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bryan Jacobs <bjacobs@woti.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 31 22:53:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyrmS-0004wV-G3
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 22:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1HaUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 16:52:59 -0400
Received: from uk.vilain.net ([92.48.122.123]:54539 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab1HaUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 16:52:58 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Aug 2011 16:52:58 EDT
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 10015824C; Wed, 31 Aug 2011 21:43:43 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id EB80C807A;
	Wed, 31 Aug 2011 21:43:40 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.1) Gecko/20110830 Thunderbird/6.0.1
In-Reply-To: <20110831202131.GA27307@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180504>

On 8/31/11 1:21 PM, Eric Wong wrote:
>> --- a/Documentation/git-svn.txt
>> +++ b/Documentation/git-svn.txt
>> @@ -211,8 +211,9 @@ discouraged.
>>   	Add the given merge information during the dcommit
>>   	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn server versions can
>>   	store this information (as a property), and svn clients starting from
>> -	version 1.5 can make use of it. 'git svn' currently does not use it
>> -	and does not set it automatically.
>> +	version 1.5 can make use of it. To specify merge information from multiple
>> +	branches, use a single space character between the branches
>> +	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)

This interface seems regrettably stupid.  Like, do I need to consider 
the existing revisions that are already listed in the property?  Is it 
really impossible to derive the changes that were merged and generate 
the list automatically?

But so long as it makes something previously impossible possible, it is 
a good change - my feeling is that it should be called something like 
--mergeinfo-raw or --mergeinfo-set to leave room for a possible 
--mergeinfo-add which knows how the lists work and adds them (which is 
what I'd expect a plain --mergeinfo switch to do).

Sam
