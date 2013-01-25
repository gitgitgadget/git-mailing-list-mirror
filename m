From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Fri, 25 Jan 2013 09:48:23 +0000
Message-ID: <20130125094823.GW7498@serenity.lan>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org>
 <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
 <5101B0A5.1020308@tu-clausthal.de>
 <7vpq0u8bxd.fsf@alter.siamese.dyndns.org>
 <CAJDDKr5O70tTfwuipWcYVJL6gM3bUyQh-22yVO89xn8OFsQOpw@mail.gmail.com>
 <7vvcal683y.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4oerSq16rYt2iKNtQNK79L+jOiKROhEW_yiBPKjkVhuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyfv4-0001og-70
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab3AYJte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:49:34 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:58587 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab3AYJsh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:48:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 004F8866004;
	Fri, 25 Jan 2013 09:48:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUFkS0wU8QQs; Fri, 25 Jan 2013 09:48:35 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 5B4B5CDA60A;
	Fri, 25 Jan 2013 09:48:35 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 28DF2161E5A8;
	Fri, 25 Jan 2013 09:48:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id neWwqiuCltUo; Fri, 25 Jan 2013 09:48:35 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 1CDB8161E279;
	Fri, 25 Jan 2013 09:48:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr4oerSq16rYt2iKNtQNK79L+jOiKROhEW_yiBPKjkVhuQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214534>

On Thu, Jan 24, 2013 at 11:54:25PM -0800, David Aguilar wrote:
> On Thu, Jan 24, 2013 at 11:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Is there a way for me to programatically tell what merge.tool and
> > diff.tool could be enabled for a particular source checkout of Git
> > regardless of what platform am I on (that is, even though I won't
> > touch Windows, I want to see 'tortoise' appear in the output of such
> > a procedure)?  We could generate a small text file from the Makefile
> > in Documentation and include it when building the manual pages if
> > such a procedure is available.
> 
> That's a good idea.
> Here's one way... (typed into gmail, so probably broken)
>
> LF='
> '
> mergetools=
> difftools=
> scriptlets="$(git --exec-path)"/mergetools
> 
> for script in "$scriptlets"/*
> do
>     tool="$(basename "$script")"
>     if test "$tool" = "defaults"
>     then
>         continue
>     fi
>     . "$scriptlets"/defaults
>     can_diff && difftools="$difftools$tool$LF"
>     can_merge && mergetools="$mergetools$tool$LF"
> done

I don't think this will work since the names of the valid tools are not
necessarily the same as the names of the scriptlets - this is the exact
issue that prompted my patches to git-difftool yesterday.

The best option I can see given what's currently available is something
like this:

-- >8 --

sed -n -e '/^list_merge_tool_candidates/,/^}/ {
        /tools=/ {
                s/.*tools=//
                s/"//g
                s/\$tools//
                s/ /\n/g
                p
        }
}' git-mergetool--lib.sh |sort |uniq |while read -r tool
do
	test -z "$tool" && continue
	( . git-mergetool--lib && setup_tool $tool
        	# Use can_diff and can_merge here.
	)
done

-- 8< --


John
