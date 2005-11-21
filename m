From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 17:44:42 +0100
Message-ID: <4381F97A.9010105@op5.se>
References: <20051121162540.4722.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 17:59:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeEnR-0005b7-V1
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 17:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVKUQor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 11:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVKUQoq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 11:44:46 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:64898 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751034AbVKUQoo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 11:44:44 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 2C27C6BD01
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 17:44:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051121162540.4722.qmail@web31812.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12457>

Luben Tuikov wrote:
> It is often the case that "since <mine> head forked from
> <his> head" (quoting the manual page of git-format-patch),
> for various projects, some patches have been accepted and
> some have not.
> 
> I was wondering about the value of
> 
>   git-format-patch <commit-ish>
> 
> to output/prepare a diff patch between the indicated commit
> and its parent.  As opposed to the current behaviour giving
> all changes between the indicated commit and HEAD.
> 
> So in effect the form above would become the trivial:
> 
>   git-format-patch <commit-ish>..HEAD
> 
> and
> 
>   git-format-patch <commit-ish>
> 
> would give the diff patch between the indicated commit and
> its parent.
> 

Please don't. git-format-patch is generally used to send in a series of 
patches ranging back from HEAD, so this would mean less userfriendliness 
in the most usual case.

Here's the "sed -n 90,100p" commentary from git-format-patch:
----%<-----%<----
# Backward compatible argument parsing hack.
#
# Historically, we supported:
# 1. "rev1"     is equivalent to "rev1..HEAD"
# 2. "rev1..rev2"
# 3. "rev1" "rev2   is equivalent to "rev1..rev2"
#
# We want to take a sequence of "rev1..rev2" in general.
# Also, "rev1.." should mean "rev1..HEAD"; git-diff users are
# familiar with that syntax.
----%<-----%<----

Perhaps the man-page needs to be updated with this info.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
