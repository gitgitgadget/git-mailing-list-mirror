From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 03 Jun 2015 14:29:21 -0700
Message-ID: <xmqqiob4wkem.fsf@gitster.dls.corp.google.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<xmqqlhg0y9xj.fsf@gitster.dls.corp.google.com>
	<20150603190616.GA28488@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0GE4-0004I7-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 23:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbbFCV3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 17:29:25 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34864 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbFCV3X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 17:29:23 -0400
Received: by igbyr2 with SMTP id yr2so123944432igb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WeflJgQwe494kNtnLuyww3UL5Q8LL+0gb0WEE5mQoew=;
        b=Gaq4yYQlSrpjdyskCw7hA8+SCxq3oxUK0Va0iMdUHkhIMZHYDkC9lCtusAF62BirYC
         hYGASl6+mGlNjKmI8eOpmthDFrveVYS0B11C6sjDpxQONQ2B98qHAnG7oXCYcWBQ6Ayb
         DeXfrlBxrjJkPnBcD+gG9+aiNFKeJbaJE+wGDUFfzwQKLalcAY0bT/UTWGwNpbdr5jSk
         +xahSxMtSsFTarF92VoP5PUkiS5qz8R31y7FDBPI/jFmwmUHVqjRzMpPgi4qQ+J3lFLG
         pOl3SgwasW2up4Z3Zazfuj826WYDGbRmlSMxwZUiXEOq0CmvZfB2vSz5mKoaSm2QvssS
         0JJg==
X-Received: by 10.42.28.135 with SMTP id n7mr759261icc.41.1433366962776;
        Wed, 03 Jun 2015 14:29:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id f126sm9921ioe.21.2015.06.03.14.29.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 14:29:22 -0700 (PDT)
In-Reply-To: <20150603190616.GA28488@peff.net> (Jeff King's message of "Wed, 3
	Jun 2015 15:06:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270740>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 03, 2015 at 10:32:40AM -0700, Junio C Hamano wrote:
>
> Yeah, I'd say "cp -i" is the closest thing. I don't have a problem with
> adding that, but I'd really hate for it to be the default (just as I
> find distros which "alias rm='rm -i" annoying).

Oh, no question about it.

I think a typical user cease to be a newbie before having to type
"-i" every time starts to annoy her, and instead will learn to use
the tool more effectively and efficiently [*1*], so making "-i"
default is not good not just for you but for everybody.


[Footnote]

*1* In the context of this discussion, after screwing up the change
    in hello.c, instead of expressing the wish to recover and to
    start from scratch in two separate commands, i.e.

	rm hello.c && update-from-scm

    they will learn to use a single command that is designed for
    that purpose, i.e.

	checkout-from-scm hello.c

    without the "rm" step, which _is_ an artificial workaround for
    their other SCMs that do not update from the repository unless
    they remove the files.
