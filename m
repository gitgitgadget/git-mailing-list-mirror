From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 17:28:25 -0400
Message-ID: <32541b130807021428o5dc0eab7p8464a8b8fc6c3a52@mail.gmail.com>
References: <20080702143519.GA8391@cuci.nl>
	 <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
	 <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
	 <20080702181021.GD16235@cuci.nl>
	 <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
	 <20080702211836.GF16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE9tH-0000fU-R1
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbYGBV22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbYGBV22
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:28:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:31930 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbYGBV21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:28:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so447903fkq.5
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bsxIF2nSlOyf1+tHxidlG25m4Vg//R0uxyvQeRwcaE8=;
        b=sVc9tpu0HlLlAg/WjrMABQzTmIkLgMNc3qOBFMxlVP673gC7ZEbQVP/wSoauvJpSEm
         /C5CdVgoWI9338GrAbjGWMdpeCxMwz+NqrYeVGUGGp9MMasuilXyCdzAc0PRNlk5gO6N
         es3oNlaPF7dCeWy6Svagf7ORu/PsLnZKHNxGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aU4TmZzWiFqlSEYC1RbtAZyts4lShXtgbJujYZ7Iu+mYTZdlkyhCCxWFJsrW9JhCNt
         j+ffyTlUSIkdfgiEWOC/qHfb2tRPFxokTWFzO1S2Emp5F8cuzzCmKZHLrnOw3NXda5ph
         0IbPoyAEAWZjlQOHyMkTRhlkBM+rVARgmzS1A=
Received: by 10.82.167.9 with SMTP id p9mr315654bue.81.1215034105250;
        Wed, 02 Jul 2008 14:28:25 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 2 Jul 2008 14:28:25 -0700 (PDT)
In-Reply-To: <20080702211836.GF16235@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87194>

On 7/2/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Dmitry Potapov wrote:
>  >On Wed, Jul 2, 2008 at 10:10 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>  >> In that case, I will stick to extending git fsck to check grafts more
>  >> rigorously and fix git clone to *refrain* from looking at grafts.
>
>  >Linus suggested that "git-fsck and repacking should just consider
>  >it[grafts] to be an  _additional_ source of parenthood rather than
>  >a _replacement_ source."
>
>  >http://article.gmane.org/gmane.comp.version-control.git/84686
>
> Yes, I know that's what he suggested, the way it should be implemented
>  IMO though is by checking once without and once with regard to grafts.
>  And still it should be such that git clone disregards grafts completely.

I could see an argument that the only modes you really need are a) use
grafts as replacements, and b) use grafts as additions.  There is
perhaps no need for c) ignore grafts.

For example, say I wanted to give someone a copy of my repo that
includes grafts (ignoring the fact that this is probably bad to do in
general).  He could git-clone it and then install a copy of my grafts
file, as long as git-clone does (a) or (b) but not (c).  On the other
hand, if he just wants a copy of the "real" (graft-free) repo, then
git-clone needs to do (b) or (c) but not (a).  git-fsck needs (b), and
most normal git operations want (a) (since that was the original
purpose of grafts).

Based on that, (c) is redundant, unless you're really concerned about
not sending redundant objects to people who clone your repo that has
grafts installed.  But I think you probably shouldn't have people
cloning your grafted repository anyway unless you know what you're
doing, and if you know what you're doing, you probably want (b).  If
you see what I mean.

Have fun,

Avery
