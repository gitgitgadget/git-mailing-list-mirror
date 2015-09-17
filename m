From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git status -u is mildly astonishing
Date: Thu, 17 Sep 2015 16:27:39 +0200
Message-ID: <vpqd1xhqfxg.fsf@anie.imag.fr>
References: <20150917104430.5dd73ae1@dev-05>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alastair McGowan-Douglas <altreus@altre.us>
X-From: git-owner@vger.kernel.org Thu Sep 17 16:27:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcaA7-0007aj-R6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 16:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbbIQO1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 10:27:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53151 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbbIQO1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 10:27:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8HERcoE006082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Sep 2015 16:27:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HERdKp026262;
	Thu, 17 Sep 2015 16:27:39 +0200
In-Reply-To: <20150917104430.5dd73ae1@dev-05> (Alastair McGowan-Douglas's
	message of "Thu, 17 Sep 2015 10:44:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Sep 2015 16:27:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8HERcoE006082
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443104858.98234@UNueH3Kzf7w2ApxtUBuYjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278117>

Alastair McGowan-Douglas <altreus@altre.us> writes:

> It seemed that the argument to -u was being ignored. It turns out that
> 'no' was not actually being considered an argument to -u in the first
> place.

-u takes an optional argument. We can't consider the command-line
argument following u as its argument, because that would mean

  git status -u --null

would be read as

  git status -u=--null

> The usage string implies that -- is used to disambiguate path specs
> from option arguments

Yes, but the problem here is not path specs Vs options, but anything Vs
argument of the previous option.

> Therefore I would argue that -u is behaving differently from other
> arguments (especially when considered across all git subcommands)

This is because you have options with non-optional argument in mind, or
options that have no short version.

If I grep the source correctly, the only options accepting a short
version and an optional string argument are "{merge,am,commit,revert}
-S", "grep -O" and "status -u", which behave consistantly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
