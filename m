From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] merge-recursive: don't detect renames from empty
 files
Date: Thu, 22 Mar 2012 14:18:51 -0500
Message-ID: <20120322191851.GA23293@burratino>
References: <20120322185246.GA27037@sigill.intra.peff.net>
 <20120322185349.GC32727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnXR-0002Qd-NY
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944Ab2CVTTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:19:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64553 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759359Ab2CVTTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:19:02 -0400
Received: by iagz16 with SMTP id z16so3497640iag.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0dXGOKaDJsWmMYQn6Y+WTQ34UzK9Vj17oX5eFi5v7OY=;
        b=lzYnv4R3mQaKtwCvapS3+NeKe9KsShD3BzwCX3BFuPIH+McdsNrFBnfBNdxiboIdRc
         mxONCahBC07TkPxHBrAuUuIfDU/MYrIZBeojSGDh3vdyf7t+/L9coOBExjWo3QIGkiI3
         VyDcJe2jr8S7CUhRC0W9/0pVFydNu/xG1VJdnbpQt2ioy0VFu84hFQTSug2dJT9gHEzN
         Bt4R+EOX/d89YXjOwmvqjbVzsWfQPDOJ7BK2/HfQWtRnNOgwVTCWhCiHvzh0jClsMUIS
         W3YSR8panapEyT91EzsRNS88L/HyLn+CeGT9FDIgihBX2c3pZj+MSrihnozhnrJdX3df
         Qkqg==
Received: by 10.50.159.198 with SMTP id xe6mr3319496igb.74.1332443942017;
        Thu, 22 Mar 2012 12:19:02 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cg9sm2732778igb.17.2012.03.22.12.19.00
        (version=SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:19:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120322185349.GC32727@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193693>

Jeff King wrote:

> We could do the same thing for general diff rename
> detection. However, the stakes are much less high there, as
> we are explicitly reporting the rename to the user. It's
> only the automatic nature of merge-recursive that makes the
> result confusing. So there's not as much need for caution
> when just showing a diff.

The stakes may be different, but doesn't the same justification apply
anyway?  If "git diff -M" chooses a random pairing to describe a
renaming of multiple empty files, that seems just as confusing as
merge-recursive making the same mistake.

If adding this check in diffcore is more complicated, doing it in
merge-recursive for now seems fine and prudent, but if we are doing it
at the merge-recursive level just to be conservative then that seems
like the wrong layer.

Thanks for a clean and pleasant patch.
Jonathan
