From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodules or separate repos?
Date: Mon, 25 Apr 2011 21:57:57 +0200
Message-ID: <4DB5D245.6030800@web.de>
References: <BANLkTinAC2Thuf_z_-DMEHotgF-tqpQYZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Treibton <mtreibton@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:58:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QERv8-0000z8-4i
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 21:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab1DYT6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 15:58:00 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:53716 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289Ab1DYT57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 15:57:59 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id A54B819CE1DD2;
	Mon, 25 Apr 2011 21:57:57 +0200 (CEST)
Received: from [93.240.99.96] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QERuv-0007EO-00; Mon, 25 Apr 2011 21:57:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <BANLkTinAC2Thuf_z_-DMEHotgF-tqpQYZw@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+n+HHmJTpUcf/Pms20P1bQfGN24fxjUtpAon7r
	R0fw2EF6MQ4XsU2gCmVHZYvP428BTbPq7FDZBS6l9FRvBeByr2
	d6YZ8GWZb9HG5N0rTtTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172041>

Am 25.04.2011 12:35, schrieb Michael Treibton:
> ive recently converted a project that was in svn to use git - and
> that's gone well.
> 
> in doing this ive been wondering if i can't split up the respository
> more.  currently we have this:
> 
> project/
>     core/
>     modules/
>         moduleA/
>         moduleB/
> 
> Which i think is fairly typical of most projects.
> 
> i was wondering how feasible it would be to split out "moduleA" and
> "moduleB" into their own repositories? to me that makes sense.

In my experience that only makes sense when one of the following
conditions is met for "moduleA" and "moduleB":

* they are developed by someone else

* they contain code shared between superprojects

* they consist of huge and/or many files that would hurt performance
  of everyday git commands.

(See https://git.wiki.kernel.org/index.php/SubprojectSupport for a
more complete discussion of submodules and other subproject
techniques)

I can't see that splitting up the repository just because you can is
buying anything - except extra overhead for everyday development. So
I think you have to have a good reason to do that (but you didn't
mention any ;).

> but by
> themselves neither "moduleA" or "moduleB" would compile without the
> core.

That rather looks like an argument against splitting them off. Even
though we have submodules depending on the presence of other
submodules at my dayjob, they almost never depend on anything in
the superproject (the only exception being a file containing a
project version which is then to be used for all build artifacts,
but that is a convention used in all our superprojects).

> And if they were separate repositories, how would this work from a
> development point of view?  what about a release of the project? would
> there be a makefile which pulled in a known version of tarball
> released from each moduleX repository?

That depends on the technique you choose. But I really can't answer
that question until you share your motivation for having separate
repositories in the first place.
