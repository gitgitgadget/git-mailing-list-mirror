From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 11:57:12 -0800
Message-ID: <20130131195712.GH27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
 <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10GS-0001ue-7j
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab3AaT5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:57:19 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:59949 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab3AaT5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:57:17 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so1413608dac.40
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OXtfnzUAOsilKk4orsCYRP3r/3PXFm5mREpAdjdKU8c=;
        b=xu9qZWAUwmrhH+ZmVE3qBTVNQLquz+0F1HIF5fb+LDWcmDkhXFCs3wDEPWOrT0B3oJ
         mh3QvB5+G5jr4jAqjcccGBsrC1sjwUgfBv461KxK+Yq7AdTc3efifyf8lhRiLFuybNMW
         ISLo8+iS8+tU3B5wyBBb/nn1nOAZb6FVFQaHisHFKvy4aK6qSGH9CSQ7f1zvYTsQMEYy
         C1Mcv5P0C1yt6O1RPsUml9EW4pEeOl13aqR7wF2+m7HZqfhTqv/FMKBBLHjK9ApXeugG
         S+CUiaqTP+HfwnSVKW/IxoJ1AGuBaC+a0WAzbBu50qBib2ArZpqlNedSNA7Up2n9OWy/
         rVYA==
X-Received: by 10.66.82.170 with SMTP id j10mr23702934pay.9.1359662237245;
        Thu, 31 Jan 2013 11:57:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id l5sm6494412pax.10.2013.01.31.11.57.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 11:57:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215157>

Junio C Hamano wrote:

> That is why I tend to prefer how check-ref-format documentation
> describes --print:
>
>         --normalize::
>                 Normalize 'refname' by removing any leading slash (`/`)
>                 characters and collapsing runs of adjacent slashes between
>                 name components into a single slash.  Iff the normalized
>                 refname is valid then print it to standard output and exit
>                 with a status of 0.  (`--print` is a deprecated way to spell
>                 `--normalize`.)

That works because, as you mention, the usual way to look up an option
in manpages is to search for "--print", including the two minus signs.

Unfortunately an analagous approach in gitconfig(5) would be seriously
broken, because searching for "tracking" (no minus signs) is going to
hit many false positives.  I do not think such a change would be an
improvement.

Meanwhile I believe the prominent words "deprecated synonym" already
make it completely obvious that when I write a new config file, I should
use the modern option, unless I am trying to write a config file that
also works with older versions of git.  In the latter case (which
unfortunately is not too uncommon), hiding the option is not going to
make my life easier.  What would allow me to make an informed choice
is mentioning what version of git *introduced* the new name of the
option:

	- `tracking` - deprecated old name for `upstream`, used by git
	  versions before 1.7.4.2.  Don't use this.

Also I do not think anyone claimed we are removing "tracking" from the
documentation in order to stop people from using it.  The rationale
when the patch was proposed is that it makes the documentation easier
to read.  I agree with that rationale, with the caveat Avar mentioned.
There is a simple fix: just simplify the behavior being explained as
well, by biting the bullet and dropping the "tracking" synonym after a
suitable period in which it produces a warning.

In the meantime, the documentation is valuable, and pretending that
"tracking" does not exist for everyone who does not confusedly reread
the docs a few times is just a way to lie to ourselves and make users'
lives more difficult.  Is that really the intent?

Jonathan
