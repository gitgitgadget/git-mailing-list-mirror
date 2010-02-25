From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [PATCH] git-gui: fix "Explore Working Copy" for Windows again
Date: Thu, 25 Feb 2010 23:00:17 +0000
Message-ID: <a5b261831002251500i2628946fo1bc2f7070f682702@mail.gmail.com>
References: <20100223225243.GC11271@book.hvoigt.net>
	 <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com>
	 <a5b261831002240412x30490e25wbec74cdbc1d0ebd2@mail.gmail.com>
	 <201002250114.23322.markus.heidelberg@web.de>
	 <20100225204451.GB12637@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkmh3-0002UX-Oj
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 00:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934446Ab0BYXAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 18:00:22 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:54981 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934441Ab0BYXAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 18:00:20 -0500
Received: by ewy20 with SMTP id 20so1879927ewy.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yLmqzKJ7aqr/auSEuu0cjj4SUl4O2TnpNSZLU/fC4iI=;
        b=MAcAcX4Qmk+q9rsSE1YGMugZ2pnU6YMAJ6RqnYFFcXPTQXZ3sukQLGOHP8XzOnxYJ6
         RWN72oqyWi7QkxV5JhMKTb3Zb2M4nDf+sy011+9+1wyTasClgUJyxp8Yg6k6gOrLDs/f
         /0lKFYydXVCZgKz+lOIQajcq9TbufMWxima38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mYW6sdEarsDqUqMvt0+rzBmKSTwIldxkJvUZxtwzsjLEEuPyspXwaXFBa2D+Y88m9Q
         C+7pkM/I74WOB6F6ouvyvdAdoz2dWLQpGP3c37x90BYBJhFkClebCFtpLq13IJrWdv3E
         PEBbsLSNuV8bIzmuL70RAbxmII3WGzyNEVKtY=
Received: by 10.216.87.13 with SMTP id x13mr492964wee.12.1267138817994; Thu, 
	25 Feb 2010 15:00:17 -0800 (PST)
In-Reply-To: <20100225204451.GB12637@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141077>

On 25 February 2010 20:44, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Thu, Feb 25, 2010 at 01:14:22AM +0100, Markus Heidelberg wrote:
>> It has already been fixed in commit 454efb47 (git-gui (Win): make
>> "Explore Working Copy" more robust, 2009-04-01), but has been broken in
>> commit 21985a11 (git-gui: handle non-standard worktree locations,
>> 2010-01-23) by accidentally replacing too much with a new variable.
>>
>> The problem can be reproduced when starting git-gui from within a
>> subdirectory. The solution is to convert the path name, explorer.exe is
>> invoked with, to a platform native name.
>>
>> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
>> ---
>
> I can confirm that this does fix the issue which is actually also
> apparent on Windows XP. If no objections occur I would apply this to the
> devel branch for msysgit.
>
> cheers Heiko

Agreed - the loss of the [file nativename] around the path is the
fault. Replacement with
eval exec $explorer [list [file nativename $_gitworktree]] &
will be sufficient for all platforms (the [list] protects any spaces
in the path against the eval).

Pat Thoyts
