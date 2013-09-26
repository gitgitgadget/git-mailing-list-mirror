From: John Keeping <john@keeping.me.uk>
Subject: Re: Question about "git log --cherry"
Date: Thu, 26 Sep 2013 21:21:53 +0100
Message-ID: <20130926202153.GC27238@serenity.lan>
References: <CAC9WiBjLqdqSKgLv_M6FPx3a2J-+ZKAQnk9OGn3h5SfqSpiT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 22:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPI4d-0005Ks-9B
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab3IZUWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 16:22:00 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48785 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab3IZUV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:21:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 53C9FCDA5DA;
	Thu, 26 Sep 2013 21:21:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZalKeuCWdzCC; Thu, 26 Sep 2013 21:21:58 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 08245CDA5FC;
	Thu, 26 Sep 2013 21:21:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAC9WiBjLqdqSKgLv_M6FPx3a2J-+ZKAQnk9OGn3h5SfqSpiT3g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235431>

On Thu, Sep 26, 2013 at 06:35:57PM +0200, Francis Moreau wrote:
> I'm trying to use "git log --cherry ..." in order to display new, kept
> and removed commits between two branches A and B.
> 
> So commits which are only in B are considered new and should be marked
> with '+'. Commits which are in both branches are marked with '=' but
> only commit in branch B are shown. Eventually commits which are in A
> but not in B anymore should be marked with '-'.
> 
> So far I found this solution:
> 
>   $ git log --cherry-mark --right-only A...B
>   $ git log --cherry-pick  --left-only   A...B
> 
> but I have to call twice git-log. This can be annoying since depending
> on A and B, calling git-log can take time.
> 
> Is there another option that I'm missing which would do the job but
> with only one call to git-log ?

Does this do what you want?

    git log --cherry-mark --left-right A...B |
    sed -e '/^commit / {
        y/<>/-+/
    }'
