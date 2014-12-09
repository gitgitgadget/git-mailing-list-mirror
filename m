From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Tue, 9 Dec 2014 22:15:31 +0000
Message-ID: <CAFY1edY=Ren9krK1-yFoxt92AAushUyqnbt=69hdXMeiBFAK=w@mail.gmail.com>
References: <5485D03F.3060008@fu-berlin.de>
	<20141209141457.GA18544@peff.net>
	<CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
	<20141209161133.GA17756@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Scherer <m.scherer@fu-berlin.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 23:15:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyT4C-0007wz-F3
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 23:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbaLIWPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 17:15:32 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50432 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbaLIWPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 17:15:32 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so1503886ieb.12
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=784DtwJz4j9IHvRX2ikro3qRi1qf9S8srDu6ABw18fo=;
        b=a7I9jkbDhSNk8F9tpNwuGOXlR9IVc7YF1KbheinaFZZ9uSDhgke/+C9WnjFXzFeTn0
         SeBiRacPa4KHj3LethZO3BaE5aZBcoDf+H9vK7cYc4ay1IzsHQzBiPupHhsnTKUHYXrr
         CAEvln1ETTOCOGF2o/RQkUlAQ7aGEQp1nFTTUAU71ZoMdclaEkdtLSJyz3YWZpyrsvfS
         jG3HEahVwGm+IS5rRVFOC1AdA12GfhFG0jI5n+kxnU/x/f1+WvQvjtpaKio5lOU5xGzk
         mbI6U667rCmtuXRmCMo37KvmnbytjWB0xWSUu8vi2svFDSC6xD6RC5QR1LfyTYzJVcCr
         CefQ==
X-Received: by 10.107.138.131 with SMTP id c3mr947666ioj.0.1418163331262; Tue,
 09 Dec 2014 14:15:31 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Tue, 9 Dec 2014 14:15:31 -0800 (PST)
In-Reply-To: <20141209161133.GA17756@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261169>

On Tuesday, 9 December 2014, Jeff King <peff@peff.net> wrote:
> I actually think filter-branch's "refs/original" is a bit outdated at
> this point. The information is there in the reflogs already, and
> dealing with refs/original often causes confusion in my experience. It
> could probably use a "git filter-branch --restore" or something to
> switch each $ref to $ref@{1} (after making sure that the reflog entry
> was from filter-branch, of course).

Yeah, I'd agree that refs/original can cause confusion.


> Not that I expect you to want to work on filter-branch. :) But maybe
> food for thought for a BFG feature.

I haven't heard much demand for a recover/restore feature on the BFG
(I think by the time people get to the BFG, they're pretty sure they
want to go ahead with the procedure!) but I'll bear it in mind. Mind
you, to make the post-rewrite clean-up easier, I'd be happy to
contribute a patch that gives 'gc' a flag to do the equivalent of:

git reflog expire --expire=now --all && git gc --prune=now --aggressive

Maybe:

git gc --purge

??
