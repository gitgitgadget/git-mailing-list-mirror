From: Maaartin <grajcar1@seznam.cz>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 21:35:16 +0100
Message-ID: <4D374B04.80500@seznam.cz>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com> <1290785563-15339-40-git-send-email-pclouds@gmail.com> <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org> <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino> <4D373296.6030101@seznam.cz> <7v4o94u26f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTg==?= =?UTF-8?B?Z+G7jWMgRHV5?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 21:35:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfekX-0006EW-B7
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 21:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab1ASUfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 15:35:20 -0500
Received: from cgc-instruments.com ([83.169.21.132]:43044 "EHLO
	lvps83-169-21-132.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251Ab1ASUfT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 15:35:19 -0500
Received: (qmail 29778 invoked from network); 19 Jan 2011 21:35:17 +0100
Received: from 188-120-198-113.luckynet.cz (HELO ?10.0.3.100?) (188.120.198.113)
  by cgc-instruments.com with SMTP; 19 Jan 2011 21:35:17 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v4o94u26f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165292>

On 11-01-19 20:24, Junio C Hamano wrote:
> Maaartin <grajcar1@seznam.cz> writes:
> 
>> On 11-01-19 13:42, Jonathan Nieder wrote:
>>> Unfortunately the existence of GIT_WORK_TREE makes it tempting to
>>> use without setting GIT_DIR.
>>
>> Maybe I'm asking nonsense, but why should I always use both? On the
>> command line, I either cd to my (alternate) working tree and use GIT_DIR
>> only or the other way round.
> 
> As long as you were at the root level of these two sets of "working trees",
> you don't need GIT_WORK_TREE at all.

Actually I did mostly something like

git --work-tree /tmp/somewhere checkout somebranch -- .
  && winmerge . /tmp/somewhere

at root of my normal work tree as a poor man's replacement for

git difftool somebranch

This is probably no good idea as it mixes up the index. Sorry for
misusing this thread, but a side question: Should I specify
GIT_INDEX_FILE or is there a better way?

Btw., I see that GIT_INDEX_FILE is relative to the work tree instead of
to the git dir. I find it strange as it's normally a part of the git dir.

> We originally had only GIT_DIR and people who wanted to use a working tree
> without an embedded .git (hence having to use GIT_DIR) complained that
> they cannot work from subdirectories while cd'ing around, because you
> declare that you are at the root of your working tree by using GIT_DIR
> (naturally, there is no discovery of .git so we won't know where the root
> is).  GIT_WORK_TREE was added to augment the mechanism to allow them to
> specify where their root is, so that they can set both and then chdir
> around inside their working tree.

That's nice.
