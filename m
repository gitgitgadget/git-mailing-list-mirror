From: Sam Vilain <sam@vilain.net>
Subject: Re: From P4 to Git
Date: Mon, 03 Aug 2009 19:49:15 +1200
Message-ID: <4A76967B.7080502@vilain.net>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain>	 <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com> <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 09:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXsIg-0004i0-53
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 09:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZHCHtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 03:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbZHCHtc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 03:49:32 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58974 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbZHCHtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 03:49:32 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 05C5E21C3F7; Mon,  3 Aug 2009 19:49:20 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 04BE721C3A9;
	Mon,  3 Aug 2009 19:49:16 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124688>

Alex Riesen wrote:
>> So it looks like you wouldn't _need_ to split source tree into separate
>> smaller repositories for performance reasons.  Still it might be good
>> idea to put separate (sub)projects into separate repositories.  But
>> I guess you can do that even at later time (although it would be best
>> to do this upfront).
>>     
>
> It looks like they use P4 branches. Which are NOT branches as Git
> understands it (a line of history). The P4 "branches" are just directories
> with some metadata regarding recording where the data in the directory
> were before an act of "branching" (just a server-side recursive copy).
>
> In this case (and this must be, as there are no other branches in P4),
> they'll have to split their repository.

p4's branches are 'close enough'.  My tool travels through the history
of the repository forwards, detects paths where new content was placed
and calls those roots.  When branching is detected (recorded
file-by-file in perforce), it puts the branch source as a new parent. 
When branches are 'integrated', it makes a fuzzy decision based on the
number of outstanding merges it thinks are due, also based on a merge
base calculation on the current view of the derived history.  It allows
manual correction of this fuzzy information, and arbitrary grafting
along the way.  Discrepancies between the fuzzy decision and the actual
integration records are recorded in the commit log along with other
metadata including the commit ID.

Sam
