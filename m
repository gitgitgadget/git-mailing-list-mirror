From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Submodules implementation
Date: Tue, 23 Feb 2010 18:59:49 -0500
Message-ID: <32541b131002231559r49fc31e0i4ce46869d27190c8@mail.gmail.com>
References: <k76e57-g67.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4m2-0003rh-P4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab0BXAGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 19:06:38 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48810 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0BXAGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 19:06:37 -0500
Received: by gwj16 with SMTP id 16so829309gwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 16:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=C/42ohBz1a82TnoQgaULEG7bgW/QMOy4/RrpLW6uIf8=;
        b=ZhSKvAbyr9LzE2XXIGGT/w6TTEyD7Vih0+TzT34viYg+TQ/dVhThJVWsywzjhHdM34
         X7Ht/u4Pfk73m8nxn9axK2elexKLW67+9YjGiUPML3rbYxEP+GbZp2tfOAcf/ZTMvJEl
         t/ah1GvX8TX1995CY7pLasnh9KpKZ0J8nxzpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mRWuLkcQF/2Kn7KK2yOc/wlt7+C1ww+YCNnDZRF4XeKrkZblAWphmXpGN8m8ROmV2H
         HAikMeIjtE2qpiDnyVhdQggKDd0VTU80fNiUknTvDVP1gtPBAcWEEP4ixsJ+8kOSlksf
         ZKv4sBUAHL1in5g/SXog37gWAYIqIH0XF6yrk=
Received: by 10.151.59.13 with SMTP id m13mr5930699ybk.291.1266969609068; Tue, 
	23 Feb 2010 16:00:09 -0800 (PST)
In-Reply-To: <k76e57-g67.ln1@burns.bruehl.pontohonk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140878>

2010/2/23 Christoph Bartoschek <bartoschek@gmx.de>:
> what is the main reason that submodules are their own repositories linked
> into the enclosing one and not just additional pointers in the main
> repository?
>
> My impression is that submodules as pointers to existing tree objects would
> make a design more easier to understand and more user friendly.

The data format itself implements submodules as simply pointers to
commits (not trees) located at a particular point in the supermodule.
This is very elegant and simple.

> Especially I see no need for most of the submodule commands. Maybe "git
> submodule add" but the other commands are already covered by existing ones.
>
> Or is there a tool that uses such additional pointers for submodule
> management?

The implementation of submodule tools, particularly 'git submodule',
is the reason that these submodule pointers are implemented as
separate repositories.  I think the reasons are that a) it seemed
expedient at the time, and b) it's one valid way (although not the
only way) of thinking about what it means to have one repo point at a
commit.

By comparison, my git-subtree tool
(http://github.com/apenwarr/git-subtree) is the opposite: its data
storage format isn't very elegant (it just has a tree stored inside
another tree, as if there were no submodule at all) but its
implementation makes it easier for end users (since they don't have to
deal with separate repositories).

The ideal tool would be elegant *and* easy to use, but it doesn't exist.

Have fun,

Avery
