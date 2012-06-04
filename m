From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2] Possibility to read both from ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config
Date: Mon, 04 Jun 2012 18:27:47 +0100
Message-ID: <4FCCF013.1020000@ramsay1.demon.co.uk>
References: <20120601214907.Horde.e8FjWXwdC4BPyRyzuIrz5oA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Mon Jun 04 19:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbVv-00068Q-7Y
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab2FDR4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:56:19 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:53537 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375Ab2FDR4S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 13:56:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SbbVo-000517-cE; Mon, 04 Jun 2012 17:56:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120601214907.Horde.e8FjWXwdC4BPyRyzuIrz5oA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199164>

nguyenhu@minatec.inpg.fr wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> I have not tried this patch (or the v3 version, which I haven't read  
>> yet), but
>> is it likely that this has re-introduced the bug addressed by commit 05bab3ea
>> ("config.c: Fix a static buffer overwrite bug by avoiding mkpath()",  
>>> 19-11-2011)?.
>> I don't know the answer, but I suspect that it may have done just  
>> that. >(indeed, it
>> may well have made the bug more likely to appear).
>>
>>
>>> The original that read from $HOME/.gitconfig was simple enough so
>>> having three copies of getenv("HOME") was perfectly fine, but as you
>>> are introduce this much complexity to to decide which two files to
>>> read from, the code added this patch needs to be refactored and
>>> three copies of the same logic need to be consolidated, I would have
>>> to say.
>> I agree. Also, using mksnpath() in the refactored code (rather than
>> mkpath()) would be a good idea. :-P
>>
>> ATB,
>> Ramsay Jones
> 
> Is not mkpath() the same function as mksnpath with char *buff =  
> buf[PATH_MAX] and size_t n = sizeof(buf) ?

I'm sorry but I just can't understand your question. :(

Have you looked at commit 05bab3ea? Is the commit message unclear?

The main difference between mkpath() and mksnpath(), as far as this bug
is concerned, is that mkpath() returns a reference to *recycled* internal
static buffers, whereas mksnpath() does not (you provide your own).

This evening I finally had a look at your patch, well v4 of the patch, and
I can confirm that it does indeed re-introduce the bug. I will reply to the
v4 patch email with more comments.

HTH

ATB,
Ramsay Jones
