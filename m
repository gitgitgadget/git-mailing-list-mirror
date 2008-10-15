From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 14:18:22 -0700
Message-ID: <d4bc1a2a0810151418r3bf21ddaj498017e8e178f579@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
	 <20081015062539.GB3775@blimp.localdomain>
	 <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>
	 <57518fd10810151402p4ea3283anf4b3d175c4e82425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:19:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDmM-0002l1-Lc
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbYJOVSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYJOVSZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:18:25 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:60600 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYJOVSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:18:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so214408and.103
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=l+lMuw1qQMGWm5HO7gU6si56G3AYrCxFgKqiedVrcZw=;
        b=pr4vmoraIswgLVLgbEfTqoeFMDUJO5bFHD5OrEHCnnMlOmQGvP0M2+//MRzZ8WT/zR
         50XVSVtNi4/jzy9wuRqlFRjHP6ofkWU94w2tkeh8BDIIHM9wrIh6gS6LfQacvsI5BEig
         CwjYCPfjgmtQrLqmaNv75Gygt3ttRRaApSU3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wdcbQnlZG3NuvKaDUcX9FzStknkKpNq8sSK5l5dBJ5PKXCWDxsZKKYTm+rQhAzxifF
         5SnOE+GOyCt09ptPos5ogpv62IiSCL3YZnJhzSUeDe6w5l2MYhZRFzlBCiaWaekgOFmJ
         YgXH6nqmQ/iPQFs92btnvqOnCpGjz/81zOrwc=
Received: by 10.100.141.5 with SMTP id o5mr1763375and.89.1224105502714;
        Wed, 15 Oct 2008 14:18:22 -0700 (PDT)
Received: by 10.100.197.16 with HTTP; Wed, 15 Oct 2008 14:18:22 -0700 (PDT)
In-Reply-To: <57518fd10810151402p4ea3283anf4b3d175c4e82425@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98330>

>> if you consistently use spaces, then tabs_to_spaces will
>> always give you back your original version; if you consistently use
>> tabs, then spaces_to_tabs will give you back your original version. If
>> you use some crazy mix of the two, you cannot reconstruct your
>> original without remembering where there were tabs versus spaces,
>
> Just IMO, a crazy mix of tabs and spaces is the only _sane_ thing to
> do.  Using tabs for the initial indentation, plus spaces for alignment
> of function arguments / comments / whatever, is the only way of
> getting a layout that will both look right regardless of the tab size,
> and allow a viewer to alter the indentation size.

That's not what I would call a "crazy" mix of tabs and spaces, but
rather a *sane* mix of tabs and spaces. That can consistently be
reproduced, and is in fact what the spaces_to_tabs function included
above produces. The sane consistent formats as I see it are:

  1) use spaces for everything
  2) use tabs for indentation, spaces for everything else
  3) use tabs for indentation and alignment

If you know the tab size, you can reproduce any of these from the
others, except that #3 is a little tricky since there's places where
the tab/space issue can be ambiguous. I actually think that keeping
the repo version with tab-based indentation is a very sane thing to
do. However, I'd still like to be able to edit the files using soft
tabs, largely because any program that doesn't know what my tab size
should be applies its own interpretation and makes the code look
terrible (think terminal output for diff, cat, less, etc.)

On the other hand, a *crazy* mix of tabs and spaces is where some
indentation is done with spaces while other indentation is done with
tabs. Even crazier is a single line where the indentation is a mixture
of tabs and spaces. I think that just about everyone can agree that
this is not only crazy, but evil and is the kind of thing one really
wants to avoid in a code base. Unfortunately, when developers disagree
on their standard settings, it's very, very hard to avoid precisely
this kind of mess. My idea is to enable git to prevent this sort of
insanity if configured to do so.
