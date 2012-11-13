From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Tue, 13 Nov 2012 18:55:09 +0000
Message-ID: <50A2978D.6080805@ramsay1.demon.co.uk>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Douglas Mencken <dougmencken@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:57:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYLfe-0000Vd-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab2KMS5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 13:57:01 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:33883 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2KMS47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:56:59 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id ECC1EA0C07F;
	Tue, 13 Nov 2012 18:56:58 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 61066A0C081;	Tue, 13 Nov 2012 18:56:58 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Tue, 13 Nov 2012 18:56:57 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209655>

Douglas Mencken wrote:
> *Any* git clone fails with:
> 
> fatal: premature end of pack file, 106 bytes missing
> fatal: index-pack failed
> 
> At first, I tried 1.8.0, and it failed. Then I tried to build 1.7.10.5
> then, and it worked. Then I tried 1.7.12.2, but it fails the same way
> as 1.8.0.
> So I decided to git bisect.
> 
> b8a2486f1524947f232f657e9f2ebf44e3e7a243 is the first bad commit
> ``index-pack: support multithreaded delta resolving''

This looks like the same problem I had on cygwin, which lead to
commit c0f86547c ("index-pack: Disable threading on cygwin", 26-06-2012).

I didn't notice which platform you are on, but maybe you also have a
thread-unsafe pread()? Could you try re-building git with the
NO_THREAD_SAFE_PREAD build variable set?

HTH.

ATB,
Ramsay Jones
