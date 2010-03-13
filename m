From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 09:41:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1003130939240.796@narbuckle.genericorp.net>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net> <4B9BCD6E.4090902@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 13 18:47:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqVRK-0003I8-TI
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 18:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395Ab0CMRrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 12:47:49 -0500
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:41579 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934784Ab0CMRrs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Mar 2010 12:47:48 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Mar 2010 12:47:48 EST
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2DHfRg2006426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 13 Mar 2010 11:41:27 -0600
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <4B9BCD6E.4090902@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142102>

On Sat, 13 Mar 2010, Ren? Scharfe wrote:

> Am 12.03.2010 15:52, schrieb Vladimir Panteleev:

>> That doesn't explain why git displayed the HEAD reflog, though. That
>> seems to happen thanks to the check (revs->def && !revs->pending.nr) in
>> setup_revisions ("HEAD" is the default, as specified in the caller
>> cmd_log_init). It looks like (ideally) git shouldn't rely on whether
>> revs->pending is empty to decide whether to use the default, but rather
>> if a ref was specified by the user or not.
>
> We could add some kind of check there, but with the patch applied I can't
> trigger this second issue any more.  It would be nice to have a test script
> along with such a sanity check.  Any idea how to cause this error, perhaps
> with another type of invalid reflog file?

I actually noticed this last week.  You can reproduce it by doing "git
reflog" on a branch which has been idle for longer than the expiration.
Any 0-byte files in logs/refs/heads would give me this same behavior.

     Dave
