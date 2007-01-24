From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 09:06:16 -0800
Message-ID: <45B79208.2080502@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78C55.2030204@zytor.com> <Pine.LNX.4.63.0701241746390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 18:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9laA-0002je-UI
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXAXRG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXAXRG1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:06:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:36179 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXAXRG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:06:27 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0OH6G2S002730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jan 2007 09:06:17 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <Pine.LNX.4.63.0701241746390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.88.7/2486/Wed Jan 24 06:47:09 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_48_96,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37658>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 24 Jan 2007, H. Peter Anvin wrote:
> 
>> Johannes Schindelin wrote:
>>> Granted, for some things this might work. However, I would not wreak 
>>> havoc by changing the format of .git/info/refs, rather put the details 
>>> you wanted into .git/info/refs-details.
>>>
>> It's not clear to me if it would be wrecking havoc.  After all, if a 
>> format can't be expanded *at all*, there is something wrong, and adding 
>> things to the end of a line is a common structured way of expansion. 
>> Hence the original query
> 
> The idea of .git/info/refs is to enable dumb transports to fetch something 
> akin to intelligently. They don't need that information, and frankly, I 
> don't think they should need to understand it.

I don't think adding 10 digits to each line is going to be a sizable 
impact on anything.

> I also expect that they interpret everything after the sha1 as refname, 
> what with our having become quite liberal with refnames (they can contain 
> spaces, tabs, and even a small amount of special K). So I don't see a way 
> to upgrade the file format.

They can also contain newlines, probably, so escaping is obligatory anyway.

> But as should be clear by now, I'd prefer additional information -- that 
> is of no interest to dumb transports anyway -- to be put in an own file.

Yes, but the argument seems to be philosophical.

> That also opens the possibility of, say .git/info/perl/, which contains 
> _only_ serialized perl objects! I imagine this could be a performance 
> booster.

For certain things, I'm sure.

>>> However, for other things (like showing a certain number of commits), 
>>> it _might_ make sense to cache them (e.g. when literally thousands of 
>>> people look at the 100 last commits of linux-2.6.git), but not for 
>>> others (e.g. the 100th last to the 200th last commit of 
>>> git-tools.git).
>> Any query that's within a repository is fairly easily cachable 
>> post-generation.  The front page (and its RSS variant) is a bit of an 
>> exception, because it involves all repositories at once.
> 
> ... and here we have a problem, right? No single update hook can update 
> the _whole_ information.

I don't see a problem.

	-hpa
