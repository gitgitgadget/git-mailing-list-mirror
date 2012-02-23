From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 11:17:19 +0100
Message-ID: <4F46122F.2040409@kdbg.org>
References: <4F46036F.3040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:17:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Vjr-0001gF-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110Ab2BWKRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:17:23 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31287 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932088Ab2BWKRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:17:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 26911130089;
	Thu, 23 Feb 2012 11:14:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D00CC19F67A;
	Thu, 23 Feb 2012 11:17:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.26) Gecko/20120124 SUSE/3.1.18 Thunderbird/3.1.18
In-Reply-To: <4F46036F.3040406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191347>

Am 23.02.2012 10:14, schrieb Nikolaj Shurkaev:
> I wanted to generate several files with some statistics using "git log
> -z" command.
> I did something like this:
> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0
> --max-chars=1000000 ~/1.sh
> 
> If I put
> echo "started"
> into the file  ~/1.sh I see that the file is called only once instead of
> multiple times.

That is because xargs calls the program with as many arguments as
possible, unless directed otherwise. Put this in the script:

	echo "started $*"

and repeat. Then try this:

 ... | xargs -0 -n 1 ~/1.sh

-- Hannes
