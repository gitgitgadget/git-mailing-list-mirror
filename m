From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn mirror in bare repo
Date: Mon, 23 Aug 2010 17:05:16 +0200
Message-ID: <4C728E2C.8080003@drmicha.warpmail.net>
References: <20100823122425.GB12810@nibiru.local> <4C72708B.202@drmicha.warpmail.net> <20100823131348.GC12810@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: weigelt@metux.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 17:05:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnYaT-00079m-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 17:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab0HWPFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 11:05:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43959 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589Ab0HWPFS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 11:05:18 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EBF563B4;
	Mon, 23 Aug 2010 11:05:17 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 23 Aug 2010 11:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OM8q/Qd+ZqnjEzySdowN/3lkZdM=; b=AYAYdiURwWEL2eFu6GCfFQAzL4msORNLFuYkxQeoUbisFgtye3aL1ZdnaRV4Rl92nlA08iAdB/gGoHo9QQB5BBiXDJwdnptP7WeLhqdDtSUhZxfby0QWPke+18SowNWnvg/LgkBO2tUdZ6CaT4TGuHqNGwM1DONsutWxNUplgIg=
X-Sasl-enc: d4bwdqP/teBW30Qpn3ujmGyazSFN0sZHufk0WnXJYp4o 1282575917
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6F9935EC83E;
	Mon, 23 Aug 2010 11:05:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9pre) Gecko/20100806 Lightning/1.0b2pre Lanikai/3.1.2
In-Reply-To: <20100823131348.GC12810@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154228>

Enrico Weigelt venit, vidit, dixit 23.08.2010 15:13:
> * Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Enrico Weigelt venit, vidit, dixit 23.08.2010 14:24:
>>>
>>> Hi folks,
>>>
>>> is it possible to use git-svn w/ an bare repository (eg. using
>>> an temporary workdir when necessary or directly creating tree
>>> and commit objects w/o going through workdir at all) ?
>>
>> No.
> 
> hmm, can it work with an external workdir ?

You can have the workdir anywhere you like by using the core.worktree
setting. So, if you mind the size requirements you can put it onto some
fast tempdir (tmpfs, say). In fact, if all you do is "git svn fetch"
then git svn may not even notice a missing worktree (would have to try).
"git svn rebase" does need a worktree.

> 
>>> I'm running a dozen of mirrors (also from cvs), some from fairly
>>> large and I'd like to get rid of the working copies.
>>
>> Your only option is a different conversion tool. GSoC resulted in a lot
>> of code in this direction, but I'm not sure it can do without a workdir.
>> It is based on svndump
> 
> I guess that requires access to the raw repository (on the server),
> not just unprivileged svn client access, right ?

In fact, Ram's GSoC project started off with svnrdump which is now part
of the subversion code base (i.e. in their trunk). It is basically
"svndump remote", i.e. a client outputting svn dump format.

Michael

P.S.: We usually keep cc's when replying here.
