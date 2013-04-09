From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 16:13:32 -0700
Message-ID: <20130409231332.GZ30308@google.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 01:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPhjS-0006IJ-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 01:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab3DIXNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 19:13:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34853 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab3DIXNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 19:13:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so4025451pab.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vbNUvsQ3jNNx5N4b9msaZxot3Z23maWJ/CqMs3dftbA=;
        b=q/QxWbWRMuopRfPH23gG+RJwMYHPs8xzOkdwf36yiDqFvLq3SzKi3nRpvzWRCXEqaQ
         P/Y7d+zsp+QomcNsLHLbJ/e78B4y9oy8M1RrQ7YjHDVl3lDDcIaFEdB0GSwRw2oRzD3h
         /NZzI8CVZYx1jkVmimWdVqfcuQVnn2ud4bCbv9S2KHJ4BAjdJDStX9l3GiW6g88VqX2a
         AUPdur033+RqMr6fFbYLh6p8eN2/GC3fOPgrR7nJw08mm6mz10cbeFR3lEi/ya6RnhHm
         ztWDh0cjjLcZu/5LyJytd8kEjKKwGioNnp3AWEwt6xu/CUtOPv1FRo0nPLoDCGkUiPte
         d8ZQ==
X-Received: by 10.68.115.107 with SMTP id jn11mr4898620pbb.6.1365549217464;
        Tue, 09 Apr 2013 16:13:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id dr4sm3824381pbb.19.2013.04.09.16.13.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 16:13:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220651>

Junio C Hamano wrote:

> And I think now I agree that indeed is a sensible assumption.  I am
> not sure '-' is a good token for that, but I do not offhand think of
> a reason why '-' would be a _bad_ token for that, either.

Random idea: today you can do

	git push origin master; # push branch master to remote origin
	git push --multiple origin korg; # push default refspec to 2 remotes

How about:

	git push origin korg -- master; # push master to 2 remotes
	git push -- master next; # push two refs to default remote
	git push origin -- master; # push master to origin, more explicitly
	git push origin korg --; # push default refspec to 2 remotes, again

	git push host:some/path; # ambiguous argument. Please disambiguate.
	git push host:some/path --; # push default refspec over SSH
	git push -- host:some/path; # push specified refspec to default remote

	git push origin; # is a remote name and not a refname. Good.
	git push master; # is a ref name and not a remote name. Good.

What do you think?
Jonathan
