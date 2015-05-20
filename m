From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of "packfile"
Date: Wed, 20 May 2015 12:45:09 -0700
Message-ID: <xmqqd21vnid6.fsf@gitster.dls.corp.google.com>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
	<xmqqwq04745w.fsf@gitster.dls.corp.google.com>
	<20150519222427.GA994@peff.net>
	<xmqqmw0znjfc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 21:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9vZ-0006GR-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbbETTpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:45:12 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36744 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbbETTpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:45:11 -0400
Received: by iepj10 with SMTP id j10so47467521iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Tyoa5JDH75XLwtIpayoqWcnQvkokHe91WtHX1OPNXpU=;
        b=Zd4h2P/q3ui9MdsQDKiWfude6NHX5SpwXLfyDPPYq7bLIch1BNTCchK01vQp3C4kTF
         RDptr8YU7UbfaRO1r3V34a1EJKJVOMDpqKmgQUsSJnV9J6BmfDwZayWy9R/ueWMm+7Jd
         kOcDSfyqtAF6+7KDw9IrR8U2WCQchEq2x9drJKEuf5WOYhd47Wj0Fbht9YT+XpTU8CRZ
         GPO/5KKqITxeolbBtwRzPWezEVhza3yvQfK39mIJ0rYmEPyNLI4K5u3pdIF3is+caRnp
         HSDAx3LWllS3fLCpsJZDAirfUsgta7ZeAjQ1r1zyksuj3iTT0XqQC0Y1JGUCjigSCZxE
         fTGw==
X-Received: by 10.107.134.153 with SMTP id q25mr30595993ioi.27.1432151111088;
        Wed, 20 May 2015 12:45:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id 137sm4779803ioo.29.2015.05.20.12.45.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 12:45:10 -0700 (PDT)
In-Reply-To: <xmqqmw0znjfc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 20 May 2015 12:22:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269508>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Tue, May 19, 2015 at 12:34:03PM -0700, Junio C Hamano wrote:
>>
>>> A quick "git grep packfile" vs "git grep pack-file" inside
>>> Documentation/ directory indicates that we seem to use 'packfile'
>>> primarily in the lower-level technical documents that are not
>>> end-user facing.  Almost half of them are in the release notes
>>> that we won't bother "fixing", so it might make sense to go the
>>> other way around, consistently using "pack-file" that may be more
>>> familiar to end-users.
>>> 
>>> What do others think?
>>
>> If I saw "pack-file" (outside of this discussion) I would think it was
>> wrong. That's just my opinion, of course.
>
> OK, then let's go with these three patches.
>
> Thanks for sanity checking.

By the way, the way we spell these two entities in the glossary is

 "pack" - that which holds collection of objects tightly packed
 "pack index" - that which allows a random access into a "pack"

We may want to do two things:

 (1) add "packfile" as a synonym to the former; I think the origin
     of "pack file" is that it would clarify which one we refer to
     it as an on-disk entity when contrasting a "pack" and its
     associated "pack index", and I even suspect that originally we
     spelled it as two words, later contracted with dash (as seen in
     the pack-heuristics irc lecture given by Linus).

 (2) describe "pack bitmap", which came long after the original
     glossary entries are made.

And if we are going that route, we should fix the SYNOPSIS sections
and usage[] strings of "index-pack" and "unpack-objects" where we
say these commands read from "<pack-file>" (we now read from
"<packfile>").

I am undecided if we want to touch Documentation/technical/.  The
irc lecture in pack-heuristics.txt is a historical recording and it
may be OK to keep it as it is.  pack-protocol.txt consistently uses
"packfile" in prose and uses "pack-file" in EBNF.  From a quick
re-reading of the document, I think it is OK to use "packfile"
throughout there.

One related thing is that there are few mentions of "idx file" to
refer to "pack index" (e.g. show-index and verify-pack documentation
pages); I think this was an attempt to disambiguate "pack index"
from "the Index", but as long as we spell it "pack index", I think
it should be OK, so while we are at it we may want to fix them.  We
can leave "pack .idx file" as-is, but rewriting it to "pack index
file" or just "pack index" may be OK as long as it is clear from the
context.

"git show-index" has this in SYNOPSIS:

	'git show-index' < idx-file

It probably should become

	'git show-index' < <pack-index>
