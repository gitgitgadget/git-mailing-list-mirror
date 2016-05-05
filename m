From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Thu, 5 May 2016 12:20:37 -0700
Message-ID: <20160505192036.GA22726@google.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
 <20160504232642.GC395@google.com>
 <CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
 <20160504235914.GD395@google.com>
 <xmqqmvo4bcwf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:21:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayOpl-0002Ys-3i
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbcEETVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:21:09 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35281 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbcEETVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:21:07 -0400
Received: by mail-pa0-f54.google.com with SMTP id iv1so38887207pac.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b42tFCxUaLEGvCF1WgF4h0rq+pk80LLjO40ebKXX5Tc=;
        b=ZZB7xh57CADrRSJDTEPg4kfyyit22hrXDX6Jl6Tf47EmwvhOV8B/Vo//WMqkZ44zMY
         TABIKQLHqYz6nC/zbwx9K+FzdBABfYHCzbdZfodPT0CW9Hj7RWoqnUJI6VqqPx/Crvs3
         +0I5kJ2LEjeWzn44UeseqYm99Lg5lRiDynFJzLVWb7jwCBZ+kAfPqlD/VBlg4k/r0yz9
         Tevk8n1tD/a0a1HwH7Th45wZR9BLd9YI/jZBTwDno/4CgWiWKnQ3/ZwMj5w2D4Xyg/I3
         3m0NUL2BFYzDvCyAPNUu6DVWN7wdKnEixKOkJFIw5OG72sh/kOUjsRxSMSrjtQVxaFhR
         I6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b42tFCxUaLEGvCF1WgF4h0rq+pk80LLjO40ebKXX5Tc=;
        b=IcMLTUB1y+pwQqJTUBj8AdBdNN5FyLPDnndW8Eqy3wge2q92AxlOFLHkbz18KuYrps
         +H1ObIGOLRE/Zr5zjjn0ouzLpln5OTS9DHirX1KL/uy01rOJ14FE154m6ZGK1t+aZpZ3
         khUsdTEglb3B57F8VH0uXei4sQwVfb/9+oC3x0YE5Z0mzribinz0D4UbYRIHmVaOW0dR
         YhTGHdfwBmeXfwgzX5J1oF3rsCCXzBXgRkDP9SHyHKY99Oa6ln1CWIsuZjab7o+QOjCj
         H/djOB5xBsW6y2zlZJw3XzeLgOTaYJYmBGxCoxUt2kXcT70yxDvXPswoDSpmqblv7nv1
         pBNA==
X-Gm-Message-State: AOPr4FVv6ymSpLt90epVv3SG45VmZb8PEeRDKuWqhdxmoWasD72iA3YBfDRsvHB7a5wnEA==
X-Received: by 10.66.237.66 with SMTP id va2mr22998957pac.2.1462476066950;
        Thu, 05 May 2016 12:21:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b4e5:604e:91a7:f7e7])
        by smtp.gmail.com with ESMTPSA id m184sm15489148pfb.22.2016.05.05.12.21.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 12:21:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmvo4bcwf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293665>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I mean low level as in implementation detail.  The human user would
>> wonder "what is incompatible about them?  Why are you stopping me from
>> what I am trying to do?"
>
> Maybe s/incompatible/inconsistent/ is what you are after?  Why are
> you stopping me from what I am trying to do?  Because you are asking
> to do two contradicting things.  Do you want to nuke everything, or
> do you want to keep everything outside what you specified?
>
> After being saved countless times from a stupid mistake
>
>     $ git commit -a -s foo.c
>
> that was caused by habitually typing "-a", when I do want to limit
> the changes to record to a specific path (or two) with similar
> safety, I do not think "what is incompatible about them" is a valid
> question.

Yes, 'inconsistent' works better than 'incompatible'.  Stepping back,
what I meant is that when I pass an invalid set of command line
arguments, it's difficult to give advice back because it's not obvious
what I intended to do.

When I say "git submodule deinit --all -- foo/", I'm most likely trying
to deinit all submodules within the foo subdirectory.  That's a
perfectly consistent thing to want --- it just doesn't match what the
command is expecting.  It is more helpful for the command to tell me
what it is expecting me to do instead instead of just telling me that what
I gave it is wrong.

The ideal would be something like "git check-attr"'s error_with_usage.
It tells in a targetted way where my error was and also gives a guide
of what to do instead.

	$ git submodule deinit --all lib/
	error: paths with --all do not make sense
	usage: git submodule deinit [-f | --force] (--all | [--] <path>...)

Thanks,
Jonathan

-- >8 --
Subject: git-sh-setup: add error_with_usage helper

When given an impossible set of options, this allows a command to
print a targetted message followed by a short usage string that tells
the user both (1) what part of their command wasn't supported (what
went wrong) and (2) what correct usage looks like (what to do
instead).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-sh-setup.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a..2b56636 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -63,6 +63,11 @@ say () {
 	fi
 }
 
+error_with_usage () {
+	printf >&2 'error: %s\n' "$*"
+	usage
+}
+
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
