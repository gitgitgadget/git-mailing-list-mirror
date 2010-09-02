From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] git-help: find library man pages again
Date: Thu, 2 Sep 2010 03:55:33 -0500
Message-ID: <20100902085533.GL29713@burratino>
References: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
 <20100902081646.GK29713@burratino>
 <4C7F6354.70108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5c0-0004d4-8y
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab0IBI51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 04:57:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45413 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0IBI50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 04:57:26 -0400
Received: by ywh1 with SMTP id 1so87520ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TTbs7iKsOsHu278BMaHt02RXmKg7+Efm3vsfWJ0vNLs=;
        b=Tj/tGJpi0qSOFxG28kVJpZM5bWEGBv9X/FaSwL5Kxt+RlRr22mNN5YZ9iINzon0UtC
         xk+EBC/5UfudFifGZQcLPH14AuEM7B67tF7fSnRWmaBE3xhStHhqxed1v8aTajzwZVd/
         1Vk3K6ssiugfeVVaWodI723VWSE0RF8PAMgcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ft0ycKakQYnaBVe/a3NunGBPwTMILOUQjneC6+kpDeeKR5bxZ1u2iXIAAIJIN+DnH8
         9ZZ9Vlcv6vu0Qb19q2XIe2C/AobG5Kkbpb0vmckkTvBuYPQrEUJponSuAJLGdBaQuidc
         Q42peknL6fyMAf1tCaLegAd94RITNQkBn3Q6g=
Received: by 10.150.139.11 with SMTP id m11mr5298625ybd.16.1283417845957;
        Thu, 02 Sep 2010 01:57:25 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm737682ybk.13.2010.09.02.01.57.24
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 01:57:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C7F6354.70108@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155114>

Michael J Gruber wrote:
> Jonathan Nieder venit, vidit, dixit 02.09.2010 10:16:

>> Therefore this seems wrong to me (except as a backward-compatibility
>> measure).
[...]
> One heuristic, which I would have left for a later patch because of its
> radicality (and I think we're in some phase of some rc something), is to
> simply not do any checks when calling the viewers. This requires that
> everything is prepended with "git-", which I see you have done in
> builtin/help.c.

Yep, I agree with you in all respects, including the need to do
something else (like the patch you sent) for v1.7.3.

> Still, none-command help pages will not show up with
> "git help -a". So it's not a complete solution.

I think of "git --help -a" as a more complete version of the list
from "git --help" --- that is, it is explaining what subcommands are
available for git.

On the other hand, on platforms where "man -k git" is not available,
as you mention it is the index to the manual.  Maybe "git help" should
check GIT_HTML_PATH to provide a more complete index on such platforms.

Just musing.

> Alternatively, load_command_list() etc. could simply fill up a third
> list "other_pages" (with non-executables) so that "git help -a" could
> list "other help pages" in addition to the commands. I don't think this
> would require any renaming nor Documentation updates.

Looks like you had a similar thought.

> ??? I guess this patch makes sense only after a patch which renames all
> gitfoo.txt to git-foo.txt.

Well, there were ulterior motives to that patch: I keep on mistyping
half-hyphenated manpage names like gitcvs-migration.

I should have included some appropriate Makefile magic for
compatibility symlinks for the old names.  Hopefully at least the idea
was clear.
