From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 13:52:12 -0400
Message-ID: <20110414175212.GB23342@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQiR-0005CH-JI
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435Ab1DNRwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 13:52:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39895
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933429Ab1DNRwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 13:52:15 -0400
Received: (qmail 1655 invoked by uid 107); 14 Apr 2011 17:53:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 13:53:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 13:52:12 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171529>

On Thu, Apr 14, 2011 at 07:01:41PM +0200, Erik Faye-Lund wrote:

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 9c66367..a4b8b59 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -793,4 +793,19 @@ test_expect_success 'format-patch wraps extremely
> long headers (rfc2047)' '

Speaking of wrapping, your MUA seems to have mangled the patch.

> +M8="foo_bar_"
> +M64=$M8$M8$M8$M8$M8$M8$M8$M8
> +cat >expect <<'EOF'
> +From: foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar
> + <foobar@foo.bar>
> +EOF

Your expect data is missing the trailing "_". You could probably just
do:

  cat >expect <<EOF
  From: $M64
   <foobar@foo.bar>
  EOF

which is even simpler.

-Peff
