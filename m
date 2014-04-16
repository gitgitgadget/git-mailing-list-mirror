From: alex@bellandwhistle.net
Subject: Re: gitignore vs. exclude vs =?UTF-8?Q?assume-unchanged=3F?=
Date: Wed, 16 Apr 2014 16:07:57 -0700
Message-ID: <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
 <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 01:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaYwA-0000Eh-Ao
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 01:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbaDPXIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 19:08:09 -0400
Received: from selene.fortifiedserver.net ([98.158.151.224]:37954 "EHLO
	selene.fortifiedserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161134AbaDPXIB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 19:08:01 -0400
Received: from localhost.uu.net ([127.0.0.1]:55607 helo=selene.fortifiedserver.net)
	by selene.fortifiedserver.net with esmtpa (Exim 4.82)
	(envelope-from <alex@bellandwhistle.net>)
	id 1WaYvt-0005BC-9U; Wed, 16 Apr 2014 16:07:57 -0700
In-Reply-To: <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
X-Sender: alex@bellandwhistle.net
User-Agent: Roundcube Webmail/0.9.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - selene.fortifiedserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bellandwhistle.net
X-Get-Message-Sender-Via: selene.fortifiedserver.net: authenticated_id: alex@bellandwhistle.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246391>

On 2014-04-16 10:51, Junio C Hamano wrote:
> alex@bellandwhistle.net writes:
> 
>> Any clarification on the differences much appreciated:
>> 
>> http://stackoverflow.com/questions/23097368/git-ignore-vs-exclude-vs-assume-unchanged/23097509
> 
> Please don't force people to refer to external site.
> 
> The .gitignore and .git/info/exclude are the two UIs to invoke the
> same mechanism.  In-tree .gitignore are to be shared among project
> members (i.e. everybody working on the project should consider the
> paths that match the ignore pattern in there as cruft).  On the
> other hand, .git/info/exclude is meant for personal ignore patterns
> (i.e. you, while working on the project, consider them as cruft).
> 
> Assume-unchanged should not be abused for an ignore mechanism.  It
> is "I know my filesystem operations are slow.  I'll promise Git that
> I won't change these paths by making them with that bit---that way,
> Git does not have to check if I changed things in there every time I
> ask for 'git status' output".  It does not mean anything other than
> that.  Especially, it is *not* a promise by Git that Git will always
> consider these paths are unmodified---if Git can determine a path
> that is marked as assume-unchanged has changed without incurring
> extra lstat(2) cost, it reserves the right to report that the path
> *has been* modified (as a result, "git commit -a" is free to commit
> that change).

Thanks June. Great to hear this authoritatively.

IMHO your very helpful explanation about typical use cases, the purpose 
of 'exclude, and assume-unchanged not being a "promise" is missing from 
the docs, or at least not obviously present:

http://git-scm.com/docs

In particular, 'exclude' is spottily documented. I realize the docs are 
structured strictly as an API reference, but it would be great to see a 
comparison of ignore techniques spelled out. FWIW I asked several people 
I think of as experts and none of them felt sure of their answer. :)

thanks again.
