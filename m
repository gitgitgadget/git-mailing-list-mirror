X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Wed, 6 Dec 2006 11:20:24 +0100
Message-ID: <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com>
References: <4576680B.7030500@gmail.com>
	 <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>
	 <45769417.70601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 10:20:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YvWh6AvfXlbEkIq+xJvkE1MeLJYXEyczXQcEqOZ2tsSukXWWyt4xV5K35TkL9LFgHkA2403SfikCdZipH5PrBl5Isd1f7LUk6t/zeMj0aeW1DsiSxNEI5pdpEJ8+kh8LJoazcgoxb5lwYWw7mw4iaTXlrZFZ3pRwN/21Fna4tSs=
In-Reply-To: <45769417.70601@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33426>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grtt9-0001s4-1j for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760446AbWLFKU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760443AbWLFKU2
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:20:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:29920 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760444AbWLFKU1 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 05:20:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so95089uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 02:20:25 -0800 (PST)
Received: by 10.78.204.20 with SMTP id b20mr413693hug.1165400424958; Wed, 06
 Dec 2006 02:20:24 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 6 Dec 2006 02:20:24 -0800 (PST)
To: "Liu Yubao" <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
> Alex Riesen wrote:
> > On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
> >> I'm confused how to revert changes in working tree:
> >>
> >> $ git fetch
> >> $ git merge "sync with origin" HEAD origin
> >> ....conflict....
> >
> > You may want to consider git pull. It'd do exactly the same
>
> It's said somewhere "git pull" has strange behaviour and fetch+pull
> is recommended.

So why do you use fetch+merge?

> sorry, I made a mistake, that should come from "git merge",

so, you just have an unresolved merge.
It was discussed on this mailing list very recently
(and actually is being discussed), so just look at
the archives.

> > They problem is the exec-bit which windows does not
> > have and cygwin failed to correctly workaround the
> > limitation.
> >
> > Do a "git repo-config core.filemode false" to almost
> > disable the checks for exec bit.
> >
>
> It has been set. I guess the cause is a interrupted merge
> operation that leads to textual difference.

yes, though what I can't understand is why don't you have
unmerged entries... Maybe it comes from playing with
all these commands you mentioned in the original mail.

> After run "git reset --hard", all deleted files come back, but I reach
> the old state:
> $ git status

When? Immediately after git reset --hard? Then you very
likely have no permission to write (or lost it somehow) into
the working directory, otherwise I don't see could this be
possible. git reset --hard rewrites everything.

> HEAD: commit 088406bcf66d6c7fd8a5c04c00aa410ae9077403
> master: commit 088406bcf66d6c7fd8a5c04c00aa410ae9077403
> origin: commit ff51a98799931256b555446b2f5675db08de6229
> "git diff --cached" shows nothing;

which is correct.

> "git diff" shows many diffs:

and this is not. You do have changes, which could not be reset.
I fail to see why. Are you sure you haven't accidentally repeated
the merge after doing git reset --hard? And what was _exactly_
