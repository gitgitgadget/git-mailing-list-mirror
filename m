From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 09:55:43 -0700
Message-ID: <20140521165543.GA3743@hudson.localdomain>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
 <20140520182443.GA30533@sigill.intra.peff.net>
 <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
 <20140521164255.GA2040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 18:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9o1-0002a2-0U
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 18:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbaEUQzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 12:55:49 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59886 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbaEUQzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 12:55:48 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so1575993pad.30
        for <git@vger.kernel.org>; Wed, 21 May 2014 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=J7TxhHENDulE49CNsxaR2malggqvL85T23b3SpZDNok=;
        b=Vqk4QFqnlHe7dg95P82Ij96Y9pliBwUrKq9rAGISpAmSJC1wY2827ax/t2zEvsjVu3
         F9XosfV3hMG5J8NReD5ia1evyt4Yf+hX+fova1XmoPYJAmnUXPdFa0in0sXu5Fohmu1U
         LqluhBsntKHzEFh8qmP0LP9mc+WLEWfbomltI6evgHEHiL+X1oo3NOfqQhCU0484CpU5
         LvWiZd1OAr9YEZQjfLOpJv1f+QryKy8uPXcLqErRI3jmZG7LVGmvRMEXruC7ngpZQhnn
         BfdE1cHNkvEJknRGlV5y+9ZmOALTozZrGruyta51DD1Ak9WpEu5A3mVxK5swIVMVPQGH
         j8fQ==
X-Received: by 10.68.134.136 with SMTP id pk8mr59734421pbb.103.1400691347974;
        Wed, 21 May 2014 09:55:47 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id gu11sm8967047pbd.38.2014.05.21.09.55.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 09:55:46 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 09:55:43 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140521164255.GA2040@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249808>

On Wed, May 21, 2014 at 12:42:55PM -0400, Jeff King wrote:
> On Tue, May 20, 2014 at 11:46:51AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > If it were just "--signature", I'd agree. After all, nobody is even
> > > complaining. But this is also in preparation for --signature-file.
> > > Should the user create a file without a trailing newline?
> > 
> > Ahh, I missed that part.
> > 
> > I am fine with processing it with stripspace().
> 
> I wasn't planning on anything as drastic as stripspace. I really just
> wanted to suppress the one newline, which is almost certainly the right
> thing to include for "--signature", but the wrong thing for
> "--signature-file" (i.e., the patch I posted earlier).
> 
> Stripspace() would drop all extra whitespace, and I wondered if people
> would _want_ it in their sigs (e.g., a blank line after the "-- " but
> before their .sig content).
> 
> I dunno. Maybe it is not worth caring too much about. I don't want to
> hold up Jeremiah's patch for something that I suspect neither of us
> cares _that_ much about (I know I am not planning on using
> --signature-file myself). I just don't want to deal with a patch later
> that says "oh, this spacing is wrong" and have to respond "yes, but we
> have to retain it so as not to break existing users".
> 
> > By the way, at some point we may want to move that helper function
> > to strbuf.c, but that is a separate issue.
> 
> Agreed. I was touching some string functions earlier today and noticed
> that strbuf.c actually contains a lot of non-strbuf functions for
> dealing with C strings. That's fine, I guess, but I also wondered if we
> should have a separate file for C-string functions. I suppose it doesn't
> matter that much either way, as long as it's in a libgit.a file (and
> stripspace currently is _not_, which I assume is what you were
> indicating above).
> 
> -Peff

I am fine with including your previous patch.

Would like me to test it out and create another patch set?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
