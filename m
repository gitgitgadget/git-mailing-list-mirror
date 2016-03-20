From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] submodule: add test to demonstrate that shallow
 recursive clones fail
Date: Sun, 20 Mar 2016 15:40:50 -0400
Message-ID: <20160320194049.GA6288@sigill.intra.peff.net>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
 <1450653595-22676-2-git-send-email-larsxschneider@gmail.com>
 <CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
 <0767AEDB-36D6-45BE-A1CC-944ECAFC00FB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 20:40:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahjDe-0006YU-ES
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 20:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbcCTTky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 15:40:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:34970 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750874AbcCTTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 15:40:53 -0400
Received: (qmail 3052 invoked by uid 102); 20 Mar 2016 19:40:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 15:40:53 -0400
Received: (qmail 30296 invoked by uid 107); 20 Mar 2016 19:41:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 15:41:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 15:40:50 -0400
Content-Disposition: inline
In-Reply-To: <0767AEDB-36D6-45BE-A1CC-944ECAFC00FB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289380>

On Sun, Mar 20, 2016 at 06:05:34PM +0100, Lars Schneider wrote:

> >> +test_expect_failure shallow-clone-recursive '
> >> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
> > 
> > This would break if the test suite is in a path containing any other white space
> > than U+0020 such as a tab? (Not that I am encouraging using such paths...)
> True. I wonder if we really need to use the "file://" URL format here. Maybe
> a relative would be easier?!

I did not look closely at the patch or the tests, but generally we skip
shallow-cloning for local-path repositories, as we don't do a regular
object transfer at all (and we turn that optimization off for file://
URLs). So presumably it would defeat the purpose of the test.

-Peff
