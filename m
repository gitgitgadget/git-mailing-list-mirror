From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo =
 bar"
Date: Mon, 13 Oct 2014 14:38:08 -0700
Message-ID: <20141013213808.GB32245@google.com>
References: <20141010060636.GA15057@peff.net>
 <20141010061114.GB15277@peff.net>
 <20141013161022.GA20520@google.com>
 <20141013211524.GB15969@peff.net>
 <20141013213132.GA32245@google.com>
 <CAPc5daX7UBvxCw60VUW4rUkKYbD8Do+=Nczq=z=ykoykZA+ywQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnJo-0006KC-B6
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbaJMViN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:38:13 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62599 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaJMViM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:38:12 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so6549017pad.15
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=j03UljuWhC9/U9qU0XauZzJU2PDxdLRdtLMWtaAB9wk=;
        b=WLMYdDOEqgRtRicjWQa2/X+Ay3HRfvSjz5UzodFSLi671QEt2GBdDfgpqMvRlBqPwF
         Ml49ipiIN/CpJIkDSD/dylanKv4IIgwbg/oIggGZSmXJJOOqMUy5CNGHT0BfAJnmFqri
         NCxK9P6//gUEPpG4L0047wI85TbbN5ayjgnmvo6r4pOFcH7q8tEyoF0/YZs5apv3KsXG
         L8II2PZlFSQium1yoiO2azJ0e0QDO82dx2JrrnDuTd7W0uewQ9q4RbJGJKIcXfkuP783
         0Y8PbGbi+VsW+E+BZmWj0LY4XtRx7Ie1iaCBgD4S1ZdJOJKZkfTvqAL4gIDviX890vfi
         F3DQ==
X-Received: by 10.70.108.165 with SMTP id hl5mr1146134pdb.62.1413236291670;
        Mon, 13 Oct 2014 14:38:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8888:f50:ddbf:ae59])
        by mx.google.com with ESMTPSA id b2sm12080714pbu.42.2014.10.13.14.38.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Oct 2014 14:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daX7UBvxCw60VUW4rUkKYbD8Do+=Nczq=z=ykoykZA+ywQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> On Mon, Oct 13, 2014 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> It could segfault after producing the good output, but sure,
>> count-objects code doesn't change very often.
>
> "Doesn't change very often" is not the issue. Here we are not testing
> if it can count correctly without crashing, which *is* the real reason
> why it is perfectly fine to use $(git count-objects | sed ...) pattern here.
>
> There of course should be a test for count-objects to make sure it
> counts correctly without crashing.

That also makes sense, but it is a pretty big change from the general
strategy used in git tests today.

Currently they use &&-chaining to check the status from git commands
used along the way.  That way, unrelated bugs in git commands that are
only used incidentally get caught, as long as they cause the command
to crash.  This has helped me in the past to find weird bugs early
when they cause some particular command to crash on some platforms.
Sometimes they are races that show up on more popular platforms later.

Jonathan
