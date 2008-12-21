From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Memory issue with fast-import, why track branches?
Date: Sun, 21 Dec 2008 13:23:05 +0200
Message-ID: <94a0d4530812210323q2ae392d5o2381fd990be708e8@mail.gmail.com>
References: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
	 <1229847042.798.5.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "John Chapman" <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Sun Dec 21 12:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEMQH-0005MJ-Ts
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 12:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbYLULXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 06:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbYLULXI
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 06:23:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:20859 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbYLULXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 06:23:07 -0500
Received: by fg-out-1718.google.com with SMTP id 19so637488fgg.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2GBWj5A9IXIZBjYFiDfBOUyTxHtXA5tdffoR6CYrArM=;
        b=Yv+XG81NpfYdvy6KJU2C27i1hHQXNs2Bpj4n+GI9zSsiDG8P+Nq2RblwGXQp3AHT3+
         mgBOiC8v8huQLCH06Dx+dGaxTz19zCYtQMLMr6Qjc7XBM3YwdT5tttf1o0cZFDZ9n4b8
         LHaPPYrixx969MANetrgP79PYPfle/VinDKJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fFx0ZrLVH52K3ek/tQIf09gIpxtE3qaob5dQEkwKupXrcX4ydx7PeFamijuSGBIs9G
         6D2Tua9JzTckgXb7/odhWRCm+4HSeY7jq8QnY/QTyJ+akIVaplhmsc/aHqm536jD7eje
         ylEFbLLKHkI0W87TdM9H1dodrPdF+DlJzWuI8=
Received: by 10.86.31.18 with SMTP id e18mr2988950fge.72.1229858585230;
        Sun, 21 Dec 2008 03:23:05 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sun, 21 Dec 2008 03:23:05 -0800 (PST)
In-Reply-To: <1229847042.798.5.camel@therock.nsw.bigpond.net.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103697>

On Sun, Dec 21, 2008 at 10:10 AM, John Chapman <thestar@fussycoder.id.au> wrote:
> My first response was along the lines of "Why the heck are you storing
> sha1's like that!?", until I realised that you're not storing actual git
> sha1's, but mtn's hashes, which does make sense.

Yes :)

> I'm doing something very similar with my perforce scripts, however I am
> doing a bit more magic instead of making so many branches.
>
> Instead of making branches, I make a tag instead, for each and every
> changeset.  Every time I make a new git commit, if I need to do it from
> a tag, I first read the tag and determine the sha1 I should use, and use
> that instead.

Well, simple tags and branches are exactly the same thing: refs. tags
are in 'refs/tags' and branches in 'refs/heads'; 'refs/mtn' are not
really branches.

> Alternatively, you could choose to manage your mapping yourself, and
> write them to a .git/mtg-git-map file.

The advantage of my approach is that the git tools handle all the mtn
sha1's almost as good as git sha1's, I just need to prepend 'mtn/'.

Also, git name-rev finds the mtn revision of a git commit. It' all so
convenient.

The only problem is that fast-import seems to be doing something wrong
with those "branches".

-- 
Felipe Contreras
