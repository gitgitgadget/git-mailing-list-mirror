From: Andreas Ericsson <ae@op5.se>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 09:13:18 +0100
Message-ID: <4382D31E.40400@op5.se>
References: <20051122032014.32539.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 09:13:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeTHH-0001Ho-4c
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 09:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVKVINU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 03:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVKVINU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 03:13:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:1415 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S964844AbVKVINT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 03:13:19 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A27576BCFF; Tue, 22 Nov 2005 09:13:18 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20051122032014.32539.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12536>

linux@horizon.com wrote:
> Actually, most indentation-sensitive languages have a simpler solution:
> they don't try to convert whitespace strings to a number like "horizontal
> position"; they just compare strings.
> 
> Each line must either have the same indentation string as some active
> scope, or its indentation must have the current innermost scope as a
> prefix, in which case it introduces a new scope.
> 
> This allows anything except for
> 
> foo		# No prefix
>     bar		# 4 spaces prefix
> 	baz	# tab prefix: illegal!
> 
> The "baz" line would have to begin with 4 spaces to be legal.
> They could be followed by 4 more spaces, or a tab, or any other
> whitespace pattern.
> 

So, would this be considered legal or would it barf on baz?

foo		# No prefix
	bar	# tab prefix
        baz     # 8 spaces prefix

Most people have tabsize at 8. Some don't. Some editors insert spaces
instead of tabs while others don't. If we just match strings we'll
end up with users sending bug-reports by cut'n pasting their perfectly
valid-looking config which mixes tabs and spaces just because it's
been edited by people using different editors.

Real fun would be if the mta sends tabs as spaces. Then there'd
be no way at all of telling if the config *is* valid or not.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
