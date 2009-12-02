From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/2] Document date formats accepted by parse_date()
Date: Thu, 03 Dec 2009 07:33:13 +0900
Message-ID: <20091203073313.6117@nanako3.lavabit.com>
References: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org> <831fc8f48429d5a21e29d04760b46b2ddfcb7d80.1259791789.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:36:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxny-0002qU-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbZLBWgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755885AbZLBWgC
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:36:02 -0500
Received: from karen.lavabit.com ([72.249.41.33]:33351 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755861AbZLBWgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:36:00 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 90A0B11B85C;
	Wed,  2 Dec 2009 16:36:05 -0600 (CST)
Received: from 4307.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 5LYPOF26ZKH1; Wed, 02 Dec 2009 16:36:05 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=aCdaRAzOPonM8UdBW9mUX2W65PVGdYZvoRhVSpWEnVlFNTZPYcpNAOiK1QZ3KDHyNShCYotzeiF53AAQR727fYsnFJbLPlAd2S1L6c5ZELGPepBsY3w1+5Lr8JLzml1AR2YE4LBVJLia1nkMBc3+DzcpmXavBx8pQ87RtFiuQuY=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
X-Draft-From: ("nnml:git-review" 6653)
In-Reply-To: <831fc8f48429d5a21e29d04760b46b2ddfcb7d80.1259791789.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134411>

Quoting Miklos Vajna <vmiklos@frugalware.org>

> ---

I don't think any message needs to be there, but a Signed-Off-By: 
line should be.

> +The GIT_AUTHOR_DATE, GIT_COMMITTER_DATE environment variables
> +ifdef::git-commit[]
> +and the `--date` option
> +endif::git-commit[]
> +support the following date formats:
> +
> +Git native format::
> +	It is `<unix timestamp> <timezone offset>`, where `<unix
> +	timestamp>` is the number of seconds since the UNIX epoch.
> +	`<timezone offset>` is a positive or negative offset from UTC.
> +	For example CET (which is 2 hours ahead UTC) is `+0200`.

It is better to call it 'internal' format, instead of 'native'. 
I think 'native' means the most natural way to Git, and users 
view what 'git show' outputs as 'native'.

  nana.git% git show -s v1.6.5^0 | grep Date
  Date:   Sat Oct 10 00:05:19 2009 -0700
  nana.git% ./test-date parse 'Sat Oct 10 00:05:19 2009 -0700'
  Sat Oct 10 00:05:19 2009 -0700 -> 2009-10-10 07:05:19 +0000

And 'Git native' format is also supported, I think.

> +RFC 2822::
> +	The standard email format as described by RFC 2822, for example
> +	`Thu, 07 Apr 2005 22:13:13 +0200`.
> +
> +ISO 8601::
> +	Time and date specified by the ISO 8601 standard, for example
> +	`2005-04-07T22:13:13`. The parser accepts a space instead of the
> +	`T` character as well.

I didn't know about "T", but it works (^_^).

  nana.git% ./test-date parse '2005-04-07T22:13:13'
  2005-04-07T22:13:13 -> 2005-04-07 13:13:13 +0000

Is there something wrong with 'show'?

  nana.git% ./test-date show '2005-04-07T22:13:13'
  2005-04-07T22:13:13 -> 40 years ago

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
