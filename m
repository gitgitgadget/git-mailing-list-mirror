From: Johan Herland <johan@herland.net>
Subject: Re: Fwd: Errors when diff'ing arbitrary upstream remotes are not
 intuitive if git pull --all hasn't been done
Date: Fri, 25 Oct 2013 09:03:41 +0200
Message-ID: <CALKQrgc0u8TA4mXc+2Hv+Fyo8EYNuiickF_janeCxkzFn+xAvA@mail.gmail.com>
References: <CAGH67wSf_RQigCmqRZKOpHdV9ELqE=078mkpwA4dfnUr=AvGVQ@mail.gmail.com>
	<CAGH67wRwb1A9CzAfod_XLRVFBRyoEron8tmM+NbMGOeKDVf2Hg@mail.gmail.com>
	<20131025061407.GE11810@sigill.intra.peff.net>
	<20131025061459.GA23524@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "yaneurabeya ." <yanegomi@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:03:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbR5-0004Sg-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3JYHDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:03:48 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:47399 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3JYHDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:03:47 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VZbQv-0006y0-It
	for git@vger.kernel.org; Fri, 25 Oct 2013 09:03:45 +0200
Received: from mail-pd0-f173.google.com ([209.85.192.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VZbQv-0009MQ-AU
	for git@vger.kernel.org; Fri, 25 Oct 2013 09:03:45 +0200
Received: by mail-pd0-f173.google.com with SMTP id r10so3554824pdi.18
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 00:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HE5WBmT4xqg0Bv3laWhehTtKxCUPBheypF+3sVmm7QY=;
        b=N9/sergxhMhhbNNMNn+QznONDW1fXtMAlqAwKylvlvX94MwIYfxJBItkott3qrKoZ4
         /3i2aqUhD/LxKslXV5kAGHmuv+8TKxFrv6J68I1IjPvreSIq/QxZQK3EV79Y0JuXUup1
         f+rcWVxgJryoCpx5l3vqv1/Sy8opFxvlITy/FoRIIxfGsJsaNijmWmQaLT75+aLgevvk
         J5xl9T4fzSWQcZkAkDhyzh1PZLdlDJhItR6LoKmjecf123HzCT8K0IGJVkCAX+S1QcZq
         BVoq6Fdu3tdEUzJXdhELZNpISit3e3Jf8KxhzufwCfJeWxvu+TNESYWbATao/VJE0eS8
         xJWg==
X-Received: by 10.66.159.132 with SMTP id xc4mr9113794pab.27.1382684621339;
 Fri, 25 Oct 2013 00:03:41 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 25 Oct 2013 00:03:41 -0700 (PDT)
In-Reply-To: <20131025061459.GA23524@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236687>

On Fri, Oct 25, 2013 at 8:14 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 25, 2013 at 02:14:07AM -0400, Jeff King wrote:
>> >     Could this error message be improved for interactive commands by
>> > first checking to see whether or not the path starts with a remote,
>> > then recommend that the remote be pulled?
>>
>> That might be worth doing. We cannot definitely say the branch exists
>> without hitting the network (which we would not want to do in the
>> general case), but I think it is reasonable for git to give suggestions
>> (we could also give a "did you mean X..." for near-typos, as we do for
>> typo-ed commands like "git dif".
>>
>> If you do try it, please don't just check for the remote name, but
>> actually complete the right-hand side of the fetch refspec for each
>> remote. They are equivalent in the default config, but aren't
>> necessarily so (and there has been talk of adjusting the layout of
>> remote refspecs). I don't recall offhand what functions we have to help
>> you, but I believe Johan (cc'd) was working in this area recently and
>> might be able to say more.

Actually, I don't think there's much refspec stuff to be done here.
When running "git diff $remote/$branch", there are 3 possible
outcomes:

 - $remote is not a valid remote name, the user probably meant
something different (like "nested/branch"). The current error message
is fine.

 - $remote is a valid remote name, but $branch has not (yet) been
fetched from there. Suggest the user run "git fetch $remote"

 - $remote/$branch is a valid remote-tracking branch. The diff works! No errors.

So, AFAICS, the patch should simply:

 1. Split the input on the first '/' into $remote/$branch, and use the
preceding part ($remote) as a potential remote name, and the following
part ($branch) as a potential branch name. (Although it is
theoretically possible to have remote names containing slashes, I
don't think anybody uses them, and we have considered disallowing
them, mainly because of this very issue: it makes "$remote/$branch"
parsing (even more) ambiguous)

 2. See if a remote called $remote exists. If it does, suggest to the
user to run "git fetch $remote". If $remote does not exist, leave the
current error message in place.

Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
