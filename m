From: Stefan Beller <sbeller@google.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Thu, 19 Feb 2015 14:21:10 -0800
Message-ID: <CAGZ79kaPhuCXgYvZ49NwVRvrKLVJLTWd0oWHv3jX31sOVCWKVQ@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 23:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOZTA-0004fW-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 23:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbBSWVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 17:21:12 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39488 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbBSWVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 17:21:11 -0500
Received: by iecvy18 with SMTP id vy18so3662114iec.6
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 14:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ppbneQOUS5JwZej7M3ViiMS5Wt1tiePEAqFM+s9pxOA=;
        b=QGfKxhjSL1As+Qwg21QeOFcP+Z6VubDNX14ZxIMwhPt4w1YDnTBHYJO1JkDYiv2R0m
         jjXvIlg9XAF2QcffoguqzWLgj0fEGFFnix9eqZeYhlGUPK9KMBLzaWvKQhbuN1200lzN
         mYeKKNio+vh7cgoPKAXC1M+vDYv9ejsk74I2MLk0JvSOP9c3vpaUKvoQm0NCP/svIhND
         WgdT/iy0NGvwo80rzBWdh4kb9TzPTeRc3ALengFiD2JlrR5qzRNkYiAYan5S5GHW4lgK
         vD1BRXAlBgYS92M+eyPB/+LSZPHKaaesRXiuHkVSJHSpZO93UUztRN6t/8/yiZQWmMl3
         Bmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ppbneQOUS5JwZej7M3ViiMS5Wt1tiePEAqFM+s9pxOA=;
        b=GC3V0UPg96g0yvvc7SHz5i8D7G2t41Lvng3fUe2nyZBrLteK87EWajhd6M1+3E3KdO
         8EizP2CfQYLiLJv9xjRMw7UrBobRbiRXwRRWK/KU29baMP4sX6UQrmCHWvoUvx3DgRYh
         U13QO/SyZpdEf1XCJ15JlRg1TuxZoSDpLYvswNRGW1I7vzF8mK3l+xPrWKOLGTeaiv81
         L2zPPScXv7pr01T7lh0mZoOxSMpOd4N6FlMHdP8yHiKqXjHiIppmFf3TPAy2HXwMXy3Y
         csCmx/3/8lU5GVM9zon0nuLdP61tOTSiUGuLRFdabKEMownMN/703ecJhDlfv7pxXJJD
         yZKQ==
X-Gm-Message-State: ALoCoQl7/pwxezcAUeypYuJHDaQ+CDSI3FPcEgToheUsPdad9l3gNCbGd7y17QMl9qr9tJRTmUne
X-Received: by 10.42.29.133 with SMTP id r5mr7685601icc.17.1424384470763; Thu,
 19 Feb 2015 14:21:10 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 19 Feb 2015 14:21:10 -0800 (PST)
In-Reply-To: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264116>

On Thu, Feb 19, 2015 at 1:26 PM, Stephen Morton
<stephen.c.morton@gmail.com> wrote:
> I posted this to comp.version-control.git.user and didn't get any response. I
> think the question is plumbing-related enough that I can ask it here.
>
> I'm evaluating the feasibility of moving my team from SVN to git. We have a very
> large repo. [1]
>
> [1] (Yes, I'm investigating ways to make our repo not so large etc. That's
>     beyond the scope of the discussion I'd like to have with this
>     question. Thanks.)

What do you mean by large?
* lots of files
* large files
* or even large binary files (bad to diff/merge)
* long history (i.e. lots of small changes)
* impactful history (changes which rewrite nearly everything from scratch)

For reference, the linux
* has 48414 files, in 3128 directories
* the largest file is 1.1M, the whole repo is 600M
* no really large binary files
* more than 500051 changes/commits including merges
* started in 2004 (when git was invented essentially)
* the .git folder is 1.4G compared to the 600M files,
   indicating it may have been rewritting 3 times (well this
   metric is bogus, there is lots of compression
   going on in .git)

and linux seems to be doing ok with git.

So as long as you cannot pinpoint your question on what you are exactly
concerned about, there will be no helpful answer I guess.

linux is by no means a really large project, there are other projects way
larger than that (I am thinking about the KDE project for example)
and they do fine as well.

Thanks,
Stefan
