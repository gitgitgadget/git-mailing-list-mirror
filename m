From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Wed, 09 Jun 2010 00:19:45 +0200
Message-ID: <4C0EC201.9060309@web.de>
References: <4C0E7037.8080403@web.de> <201006090011.14995.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 09 00:20:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM79i-0002DT-Cd
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 00:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305Ab0FHWTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 18:19:51 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35849 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab0FHWTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 18:19:48 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 23DBB16540808;
	Wed,  9 Jun 2010 00:19:46 +0200 (CEST)
Received: from [80.128.73.122] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OM798-0005iy-00; Wed, 09 Jun 2010 00:19:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006090011.14995.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+2XVAm3QHXV35fH5iHnA5g3jenqnN89uDB6KDV
	KsYI1sZarnC/6pQQ05VS1njQAqXVl5z3hidX+g4bkkENxuxsJA
	4U+4RYbAZ/rU4pSoydcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148728>

Am 09.06.2010 00:11, schrieb Johan Herland:
> On Tuesday 08 June 2010, Jens Lehmann wrote:
>> After thinking some time about peoples expectations and troubles
>> with the recursive scanning of submodules, I came up with this:
>>
>> What about expanding the "--ignore-submodules" option of the git diff
>> family with three parameters:
>>
>> --ignore-submodules=all : Same behavior as "--ignore-submodules",
>>   submodules show never up as modified.
>>
>> --ignore-submodules=untracked : Don't consider submodules as modified
>>   when they only contain untracked files, but do if the commits in the
>>   superproject are different or tracked content is modified.
>>
>> --ignore-submodules=dirty : Don't consider submodules as modified
>>   when their work tree is dirty, no matter why. This is the pre 1.7.0
>>   behavior and doesn't recurse into submodules at all.
> 
> Pardon my ignorance: Does this make "dirty" a superset of "untracked"? Or 
> are they orthogonal. And how does "all" compare to "dirty"? Are they 
> synonyms, or is "all" a superset of "dirty"?

Sorry I didn't make that clear enough: "all" is a superset of "dirty" and
"dirty" is a superset of "untracked".

There are currently (since 1.7.0) three reasons a submodule is considered
dirty:

1) It contains untracked content
2) It contains modified tracked content
3) It contains newer commits than those committed in the superproject

"all" would ignore 1), 2) & 3)
"dirty" would ignore 1) & 2)
"untracked" would ignore 1)


> I agree with adding support for this in .gitmodules, to allow customizing on 
> a per-submodule level.

Yup, and different branches could handle that differently that way too.
