From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Fri, 9 Mar 2012 21:12:28 -0600
Message-ID: <20120310031228.GA3008@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 04:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Cja-00040H-Bc
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 04:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188Ab2CJDMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 22:12:37 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54590 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab2CJDMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 22:12:36 -0500
Received: by gghe5 with SMTP id e5so1388580ggh.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 19:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5ve+KeVaCzLNE5lfbg6wG4emnEx85+xZIcAnfJDV2Wc=;
        b=m3d9XyQhBN2Mq163aitat7gtjk8VlzpAkNsr/L4BlzJha065+tKG++V2AVdU61i8Sf
         EzOW+CAD5C7XKGtgLxzUwQfUNhD255UY81ZGE0jNYlKSNMRn8o7JOAJKR3J8dGnK25Ae
         1rC9ipo0tkfg8McpLio5FASvBGI4B1Wnz88yn5xg7cdQLbIwaw1/W7mQRIhosZppsJVx
         ooz8zt5yJMLwUjsQICR9Doi3n1u/pESeK3qLYrK7US6bLHhLQx1GrFTYE4unD4vYiP1N
         0U+1R36jgAvgmPFo1WbFH3HMModpVResa6AEBZYK1dXMoOROCqx6vCXz5o1z7fYSfkzn
         hQIg==
Received: by 10.60.14.101 with SMTP id o5mr2003158oec.20.1331349155958;
        Fri, 09 Mar 2012 19:12:35 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g10sm3897654oei.9.2012.03.09.19.12.33
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 19:12:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192763>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> [Subject: fast-import: fix ls command with empty path]
>>
>> I would s/fix/accept/ to be more precise about the nature of the
>> breakage.  (In other words: rather than mishandling ls with an empty
>> path, fast-import was not handling it at all.)
[...]
> So what do you guys want to do with topic?  My gut feeling is that
> this is not a new regression and can wait until the next cycle.

Thanks again for the advice so far.

After sleeping on it, here are two patches for 'maint'.  One plugs a
memory leak.  The other makes my above comment actually true, so
trying to use this missing feature results in an error message that
can help the frontend author instead of the silently broken conversion
Andrew found.

Then we can carefully add 'ls ""' support in 1.7.11.

svn-fe should probably also be tweaked to handle this case without
demanding support for the (nice) 'ls empty path' extension in
fast-import backends, and this could even happen before 1.7.10.
I can't promise to get to that quickly enough, though.

Sensible?

Jonathan
