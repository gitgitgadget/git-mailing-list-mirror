From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 16:11:03 -0400
Message-ID: <20130410201103.GD24177@sigill.intra.peff.net>
References: <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200512.GB27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1MQ-0007cx-QD
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936388Ab3DJULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:11:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39112 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935970Ab3DJULK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:11:10 -0400
Received: (qmail 6484 invoked by uid 107); 10 Apr 2013 20:13:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 16:13:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 16:11:03 -0400
Content-Disposition: inline
In-Reply-To: <20130410200512.GB27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220748>

On Wed, Apr 10, 2013 at 01:05:12PM -0700, Jonathan Nieder wrote:

> I don't see a big problem here, actually.  What's so wrong with
> branch.<name>.remote affecting what "git push" does?  If
> branch.crazy-feature.remote is my-personal-remote and I run
> 
> 	git push
> 
> and "[push] default = upstream", then it is obvious what the user
> wanted to happen.  But what about when "[push] default = matching"?
> Which of the following behaviors is correct?
> 
>  a) Error: you didn't tell me which remote to push to.
>  b) Just behave like "git push my-personal-remote :".
>  c) Ignore which branch is the current branch and behave like
>     "git push origin :".
> 
> How about when "[push] default = current"?
> 
> Except that people might have scripts or habits tied to the current
> behavior, any of (a), (b), and (c) sounds fine to me.  (b) is the
> obvious choice for historical reasons.

I think (b) could be quite surprising to a user. I suspect it hasn't
come up because people just don't work with a lot of different remotes
in practice.

> Now if I rely on the proposed DWIM and run
> 
> 	git push master
> 
> then the corresponding choices are:
> 
>  a) Error: you didn't tell me which remote to push to.
>  b) Just behave like "git push my-personal-remote master".
>  c) Behave like "git push origin master".
>  
> (b) is not a good choice there, but (a) and (c) look equally fine.

My complaint with anything but (b) is that you can't use a relatively
simple rule ("if you do not specify a remote, we fallback to defaults,
in this order"). Now the rule is different depending on what is in the
refspecs. If I say "git push HEAD", where should it go? Does it respect
branch.*.remote or not?

-Peff
