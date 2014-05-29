From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v12 06/41] refs.c: add an err argument to
 repack_without_refs
Date: Thu, 29 May 2014 11:17:32 -0700
Message-ID: <20140529181732.GF12314@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
 <1401379676-9307-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 29 20:17:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq4tc-0002Vo-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 20:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbaE2SRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 14:17:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55635 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaE2SRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 14:17:35 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so755627pab.33
        for <git@vger.kernel.org>; Thu, 29 May 2014 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3uIc0zZFQy9nGRoMfsjJLoSTr7NSBKvPvZzW7HOBmfs=;
        b=eC7SgfwLz52SxZh503kLOk0ugveY47thaVCxIFQ4p+wivczala3NvJnid4fsBj7l3W
         drXFJba5/7QWU9CaV+Mit42CFdl9Klr5Uia+4fC4xZOp6BH5bC6cS4gt+iVSBcyyi4qS
         bySaD85WUkG5fUC5UHMUm2xn9al5Sep185FZ0Y9DhYs4pJkmXr7ANm1abzj1FjiY/TSe
         05bPP5nsRkif5pxXoVp2PFCAvImo3jwfROEwDkhYnuzF8dapv0+zFgnxytAZc2ylQDog
         1ab57MXPxGmRmcqmKtb1UGq8FiH/etPumtAeYUzJNsz7gwIE68jypvADd3+FNdAlF8kf
         C3Gw==
X-Received: by 10.66.161.33 with SMTP id xp1mr11247564pab.74.1401387455091;
        Thu, 29 May 2014 11:17:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wg7sm2325669pbc.73.2014.05.29.11.17.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 May 2014 11:17:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401379676-9307-2-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250396>

Hi,

Ronnie Sahlberg wrote:

> Update repack_without_refs to take an err argument and update it if there
> is a failure. Pass the err variable from ref_transaction_commit to this
> function so that callers can print a meaningful error message if _commit
> fails due to a problem in repack_without_refs.
>
> Add a new function unable_to_lock_message that takes a strbuf argument and
> fills in the reason for the failure.
>
> In commit_packed_refs, make sure that we propagate any errno that
> commit_lock_file might have set back to our caller.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  cache.h    |  2 ++
>  lockfile.c | 21 ++++++++++++---------
>  refs.c     | 25 +++++++++++++++++++------
>  3 files changed, 33 insertions(+), 15 deletions(-)

I don't want to sound like a broken record, but this still has the
same issues I described before at
http://thread.gmane.org/gmane.comp.version-control.git/250197/focus=250309.

The commit message or documentation or notes after the three dashes
above could explain what I missed when making my suggestions.
Otherwise I get no reality check as a reviewer, other reviewers get
less insight into what's happening in the patch, people in the future
looking into the patch don't understand its design as well, etc.

As a general rule, that is a good practice anyway --- even when a
reviewer was confused, what they got confused about can be an
indication of where to make the code or design documentation (commit
message) more clear, and when reposting a patch it can be a good
opportunity to explain how the patch evolved.

What would be wrong with the line of API documentation and the TODO
comment for a known bug I suggested?  If they are a bad idea, can you
explain that so I can learn from it?  Or if they were confusing, would
you like a patch that explains what I mean?

Jonathan
