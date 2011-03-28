From: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
Subject: Re: git fast-import --export-marks flag
Date: Mon, 28 Mar 2011 22:47:52 +0200
Message-ID: <4D90F3F8.1020706@codicesoftware.com>
References: <4D90B457.9040607@codicesoftware.com> <AANLkTinpZ=PjGpFozCAWscfms6uWBSO2y+XqCGGqB2KP@mail.gmail.com> <4D90BBC4.2000908@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 22:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4JM0-0004qh-D0
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab1C1Urz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 16:47:55 -0400
Received: from berith.lunarbreeze.com ([216.97.239.175]:53783 "EHLO
	berith.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab1C1Ury (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 16:47:54 -0400
Received: from 151.red-79-158-176.staticip.rima-tde.net ([79.158.176.151] helo=[192.168.2.33])
	by berith.lunarbreeze.com with esmtpa (Exim 4.69)
	(envelope-from <psantosl@codicesoftware.com>)
	id 1Q4JLs-00053E-Tr; Mon, 28 Mar 2011 13:47:53 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D90BBC4.2000908@codicesoftware.com>
X-Enigmail-Version: 1.1.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - berith.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - codicesoftware.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170189>

It's working on 1.7, was broken on 1.6

Thanks,

pablo

On 28/03/2011 18:48, psantosl@codicesoftware.com wrote:
> Hi Shawn,
> 
>> I don't know what you are looking at, but fast-import uses the same
>> mark numbers that were supplied in the input stream inside of the
>> exported marks file. Otherwise as you pointed out, the marks are
>> useless.
> 
> Well, they're useful to run subsequent imports reusing the marks
> generated on the first import.
> 
> But ok, it seems my marks are "overflowing":
> 
>> cat fast-export.dat
> blob
> mark :1
> data 7
> bar.c
> 
> blob
> mark :2
> data 7
> foo.c
> 
> reset refs/heads/master
> commit refs/heads/master
> mark :1583217
> author unknown <pablo@.(none)> 1300813103 +0100
> committer unknown <pablo@.(none)> 1300813103 +0100
> data 8
> initial
> M 100644 :1 src/bar.c
> M 100644 :2 src/foo.c
> 
> commit refs/heads/master
> mark :1583219
> author unknown <pablo@.(none)> 1300813115 +0100
> committer unknown <pablo@.(none)> 1300813115 +0100
> data 5
> move
> from :1583217
> R "src/bar.c" "dst/bar.c"
> R "src/foo.c" "dst/foo.c"
> 
> reset refs/heads/master
> from :1583219
> 
> And the generated marks are:
> 
> :1 d1fe62248992d88f286d03bde972932e0118bf3c
> :2 146a766f34eb1dfb6c4d7b19a45ddf49ef7e5d5b
> :1074276465 52f475aba140ca2d6f6eb8f47ef0cdb9d043fab5
> :1074276467 caf606bb7cc64bab818acbc52b40d545467ddafc
> 
> 
> pablo
