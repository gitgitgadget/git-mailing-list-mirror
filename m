From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 20:33:29 -0400
Message-ID: <AANLkTikd5uZFk8-d7wmB8ZEqOy5=RWsDNnrsHqAQZhkz@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <7v62y661pl.fsf@alter.siamese.dyndns.org> <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
 <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com>
 <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com> <20100916001636.GA2371@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:34:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow2QS-0004Ec-FA
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690Ab0IPAeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:34:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56058 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0IPAeC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:34:02 -0400
Received: by iwn5 with SMTP id 5so542874iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jQWgd0b2YhPu2IHMpZ4Kl5S5HcKMNqzWvfhb8T4k5m4=;
        b=cBQsaScjaUEYLoatplhh/hCA8KKZ2ACJQBBcKq+7OWk2n4eOxTxD4hK4Zp98gL4+xV
         4gv9F0Dpd8lquZYP8QfnnKTTK39CtIZ3JMXGKaNK7AX6gH+7yrzLForTTz8pDXHuYhG1
         0DbqOjNPMFSyXDnTdkQiM3I2CsprBif7rwyLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MAS3+fclHhMrTw92VHFqoZt/LBbMsBYEMTCaL6+NGjz4AdJpXL9sjBRwEtMfE5PasN
         LObhBlDALP176xJN3cdggG6u7buhuZQLo7WPuIPm0fmcRelR9wK6PXGsYBhzGSkW6W6y
         j72qasr68JpJQhqmf54lDOPJcnyHUtFFNQlR4=
Received: by 10.231.12.139 with SMTP id x11mr2035509ibx.67.1284597239247; Wed,
 15 Sep 2010 17:33:59 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Wed, 15 Sep 2010 17:33:29 -0700 (PDT)
In-Reply-To: <20100916001636.GA2371@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156284>

On Wed, Sep 15, 2010 at 8:16 PM, Jeff King <peff@peff.net> wrote:
> It's not just the command line. It's also what's in .gitignore files. If
> you disable just half of that, then you get the awful behavior that some
> excludes apply to index files, and some don't.

Files matched by the standard excludes are not likely to be in the
index in the first place. So in that sense, arguably -x is special.

But nonetheless, I agree with you, and since the user must
specifically ask ls-files for the various exclusions, I think it makes
sense to apply those even to cached files.

> It would help if I understood exactly what you're trying to accomplish.

I'm building a project file for my editor and I want to exclude
certain files that make no sense for it to care about even though they
are part of the repo. So I tried:

$ git ls-files -x png -x jpg ...

and was confused by that not working. I've worked around this by just
filtering the ls-files output through grep, but, ick.

j.
