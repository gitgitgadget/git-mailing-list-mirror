From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 04 Mar 2008 12:48:26 +0100
Message-ID: <47CD370A.3070404@viscovery.net>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041044120.22527@racer.site> <7vk5ki91zj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Bremner <bremner@unb.ca>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	469250@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVdt-0007YU-59
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbYCDLsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756894AbYCDLsb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:48:31 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5982 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbYCDLsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:48:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWVca-0002sO-0N; Tue, 04 Mar 2008 12:47:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2273C546; Tue,  4 Mar 2008 12:48:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5ki91zj.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76070>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Tue, 4 Mar 2008, David Bremner wrote:
>>
>>> It looks like line 435 of builtin-commit.c disables stdin for hooks 
>>> (with the disclaimer that I first looked at the git source ten minutes 
>>> ago).
>>>
>>> 	   hook.no_stdin = 1
>>>
>>> I'm not sure if this was by design, but just so you know, this breaks 
>>> people's hooks.  In particular the default metastore pre-commit hook no 
>>> longer works.  I didn't find anything relevant in the docs [1].
>> Pardon my ignorance, but what business has metastore reading stdin?  There 
>> should be nothing coming in, so the change you mentioned should be 
>> correct, and your hook relies on something it should not rely on.
> 
> It is not metastore.  It is an interactive hook that reads from the user
> who is sitting on the terminal and invoked the git-commit program.

Are you saying stdin should not be directed to /dev/null, or that an
interactive hook is required to do

    exec < /dev/tty || { echo 2>&1 "not interactive"; exit 1; }

before it reads from stdin?

-- Hannes

