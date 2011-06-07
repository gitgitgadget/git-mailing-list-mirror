From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [rfd] auto-following tags upon "git push"?
Date: Wed, 8 Jun 2011 01:23:01 +0200
Message-ID: <20110607232301.GB28023@sherwood.local>
References: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5cD-0003VQ-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905Ab1FGXXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:23:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62631 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897Ab1FGXXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:23:12 -0400
Received: by bwz15 with SMTP id 15so183289bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MRQW1D51OAyLpAmAvU5kMWRWgo65KulDpFisCV2sQxM=;
        b=J47uqzBIGGbBKDb3MxKjkL5vsOWwWPj6SLbu1pfS42WLLYvrrNX8R6Ih31McBNycYA
         xrmt3pmFumyYKXigd0j3xUrRgPPbVpO9N/mGKPu10t6RkAy7bcIHrbwh2gv35vcfhAAm
         XAMJ5I7nj6hcKNgciZPSu31AnrNObw1z2jsoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J2NnVFiMB+8RL+sO76KzPiLCe1rI6Lf2gqpalfocMn7xLuRZdSHnxsLYYIcnxdYXrO
         VREsBuYvWPVTRL3FroPOboDdOarrhN49W2OoM1m3qhOVWsuhVgr7BlzzstxIyK4mcdVk
         cI/sCSs75kHtS9/qtMJP+w501Op6lfoCwOE40=
Received: by 10.204.31.226 with SMTP id z34mr1664835bkc.160.1307488990855;
        Tue, 07 Jun 2011 16:23:10 -0700 (PDT)
Received: from sherwood.local ([89.204.137.168])
        by mx.google.com with ESMTPS id ag6sm131137bkc.18.2011.06.07.16.23.06
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 16:23:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175288>

If there would be a free bit somewhere in a tag object (or so):

    $ git tag --autopush -ma "This will be pushed along it's commit" T1

This i would understand at a glance!
And it is both, explicit on the one and automatic on the other
hand.  I.e.: work, work, work - commit & tag, hours pass until
internet access and then

    $ if-up-and-push-it-all-and-if-down.sh

.. and that would only do 'cd repo && git push'.
But having a short look into tag.c does not give much hope on that.
Maybe a new file .git/AUTOPUSH to which all SHA-1 to be
pushed automatically are simply appended.

@ Junio C Hamano <gitster@pobox.com> wrote:
>    Tell git that v*.* and v*.*.* are release tags (one-time set-up).
>    $ git config --unset-all push.autotag
>    $ git config --add push.autotag 'v*.*'
>    $ git config --add push.autotag 'v*.*.*'

I will blow that one, one of these days.

@ Jeff King <peff@peff.net> wrote:
> Hmm. Is it a clear enough hint when the user uses an actual tag
> object to make a signed or annotated tag? At least for me,
> private throw-away tags tend to just be refs/tags/foo pointing
> to a commit, and real, for-public-consumption tags at least get
> an annotation, if not a signature.
> [.] Anyway, the problem would be somebody who does something like:
>
>  $ git tag -m "here is a description of how this wip is going" foo-wip
>
> which violates the assumption above. I have no idea how common that is

I did understand that -m/-F required storage and thus force
creation of a tag object.  But hey - it's a bit odd, isn't it?
(Thinking about it some more it's very convenient that the
possibility exists.  But it will require more than one glance.
You know - that's ok for me, given all those features which will
make life easier once they're discovered and understood.)
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
