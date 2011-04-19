From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Renaming a repo
Date: Tue, 19 Apr 2011 20:13:24 +0200
Message-ID: <4DADD0C4.4010106@dbservice.com>
References: <BANLkTiknSbWrskhGLWUBEq1=9KV4hC3ttA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:43:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCFtn-0000tX-U2
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 20:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab1DSSni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 14:43:38 -0400
Received: from office.neopsis.com ([78.46.209.98]:41833 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab1DSSni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 14:43:38 -0400
X-Greylist: delayed 1806 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Apr 2011 14:43:37 EDT
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.087,BAYES_00: -1.665,TOTAL_SCORE: -1.578,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 19 Apr 2011 20:13:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTiknSbWrskhGLWUBEq1=9KV4hC3ttA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171810>

On 4/19/11 8:02 PM, Hilco Wijbenga wrote:
> Hi all,
>
> I have a hosted Git repo. As such I don't have the ability to touch
> the bare repo itself (should that be relevant). I would like to rename
> it though. I'd like to know if my approach below is valid.
>
> 1. The current repo is 'abc.git'
> 2. git clone abc.git
git clone --mirror abc.git
> 3. Create new hosted repo 'xyz.git'
cd abc; git push --mirror xyz.git

then you are done.
> 4. git clone xyz.git
> 5. Copy abc/{.git,*} into xyz/
> 6. Replace all occurrences of 'abc.git' with 'xyz.git':
> 6.a. .git/logs/HEAD:00...00 41..53 Hilco Wijbenga<...>  1299100781
> -0800      clone: from git@...:abc.git
You can ignore the reflog.
> 6.b. .git/logs/refs/heads/master:00...00 41...53 Hilco Wijbenga<...>
> 1299100781 -0800 clone: from git@...:abc.git
> 6.c. .git/config:  url = git@...:abc.git
> 6.d. .git/FETCH_HEAD:41...53              branch 'master' of ...:abc
> 7. git push origin master
FETCH_HEAD is also mostly irrelevant, as next time you fetch it'll be 
overwritten.
> There are no errors or warnings and a subsequent git clone and git log
> also seem to work. Is the repo in a consistent state or will I
> experience problems in the future?

No idea. But what you did seems much more complicated than necessary.

tom
