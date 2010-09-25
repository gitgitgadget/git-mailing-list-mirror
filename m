From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Commiting automatically
Date: Sat, 25 Sep 2010 13:31:19 +0530
Message-ID: <20100925080117.GC17928@kytes>
References: <loom.20100924T224155-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Sep 25 10:02:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzPib-0004g1-KE
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 10:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab0IYICh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 04:02:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45632 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0IYICf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 04:02:35 -0400
Received: by pvg2 with SMTP id 2so859839pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nVwVlqq1t7v2QxTIxgByAmeqzQAYpJM1vQBhjvN/hno=;
        b=n/ni/BVwZT2aeoW7EAQwIu3yUDCJh0qKdXsZ+C1TSY2pfPgQ4Tscrr8KZ8d/pVtj52
         h4IDsmifdn4w75IZ3EYqZCGg/MmJfw0eTsbRU21X460brGtJbMBgjH80smTG0dNO9rI0
         +RjEKOLUy1hbQJpPbGmi8KzcBRqYsccVdt5GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c9iHwvwHQ9m504oMU4ij6AbPghM+9r8wgE4M+/TIXus84Uk4gPPbHs3AaGSYovZEZS
         KlDSZiOH8918FNbaBM/iuA7vdnMR/2n7CYKmq9y+9ir6eNP9GYaDjqkoBfLofatvNvL7
         Sr3zx8knlL8U/D0e/a9ThjIpqdd7C01wQDBKo=
Received: by 10.142.230.8 with SMTP id c8mr3763892wfh.313.1285401754528;
        Sat, 25 Sep 2010 01:02:34 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i20sm3499380wff.17.2010.09.25.01.02.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 01:02:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100924T224155-693@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157132>

Hi Maartin,

Maaartin writes:
> I'm going to run periodically a process which uses the current working tree and 
> I'd like to protocol what happens. As a part of the protocol I need the exact 
> state of the working tree and that's what is git good for, right? But it must 
> neither disturb my normal workflow nor interfere with my ordinal commits. I 
> could probably use something like
> 
> GIT_DIR=a_special_git_dir
> git reset --soft a_special_branch
> git add -A
> git commit -m "automatic"
> git push

Instead of doing it by hand, I'd recommend using something nicer like
Flashbake to do this [1].

> where the push would go to my ordinary external repository (used as a backup 
> here). I'm quite a beginner and unsure what problem should I expect here.

I suppose you can create another branch without common ancestry and
keep committing there. I'd suggest using contrib/git-new-workdir to
keep a working copy of that branch and using flashbake to commit to it
without interrupting your working branch.

> Even if there were no problems, it's not very nice. It uses an additional 
> repository which is quite strange. Moreover, there's no way to find out how the 
> saved working tree snapshot is related to existing ordinal commits.

The additional repository is eliminated now. You can use the complete
Git infrastructure to play with the commits in your working branch and
your flashbake branch.

-- Ram

[1] http://bitbucketlabs.net/flashbake/
