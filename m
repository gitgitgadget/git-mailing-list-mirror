From: Jeff King <peff@peff.net>
Subject: Re: General support for ! in git-config values
Date: Wed, 1 Feb 2012 21:38:57 -0500
Message-ID: <20120202023857.GA11745@sigill.intra.peff.net>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
 <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org>
 <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org>
 <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 03:39:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsmZm-0006td-LY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 03:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab2BBCjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 21:39:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52649
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab2BBCjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 21:39:00 -0500
Received: (qmail 16159 invoked by uid 107); 2 Feb 2012 02:46:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 21:46:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 21:38:57 -0500
Content-Disposition: inline
In-Reply-To: <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189578>

On Thu, Feb 02, 2012 at 02:57:14AM +0100, demerphq wrote:

> > Not really.
> >
> > I do not think whatever "utility" value outweighs the hassle of having to
> > think through the ramifications (including but not limited to security) of
> > running arbitrary user command every time a value is looked up.
> 
> Why is that your problem? If I have to enable it then isn't that my choice?

>From a security perspective, you want to make sure that people who
aren't interested in your feature don't accidentally trigger it. E.g.,
imagine I currently run a locked-down git repo but execute some commands
on your behalf, and I allow you to set a few "known safe" config options
like user.email. Even though I am not interested in your feature,
respecting "!rm -rf /" in the user.email you give me would be a bad
thing.

It's not an insurmountable problem. There could be options to turn it
on, or turn it off, or whatever. Or we could shrug and say that config
is already dangerous to let other people set (which it is already, but
only for some options). But those are the sorts of ramifications that
need to be thought through.

(Another one is that with our current strategy, we actually read and
parse the config files multiple times. Should your program get run many
times?).

-Peff
