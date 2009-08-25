From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Tue, 25 Aug 2009 15:00:39 -0400
Message-ID: <20090825190039.GD23731@coredump.intra.peff.net>
References: <7vfxbgvdx8.fsf@alter.siamese.dyndns.org>
 <1251220806-17607-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg1H5-0002KR-Sk
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 21:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbZHYTAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 15:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbZHYTAk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 15:00:40 -0400
Received: from peff.net ([208.65.91.99]:55936 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785AbZHYTAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 15:00:39 -0400
Received: (qmail 18384 invoked by uid 107); 25 Aug 2009 19:00:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 15:00:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 15:00:39 -0400
Content-Disposition: inline
In-Reply-To: <1251220806-17607-1-git-send-email-catap@catap.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127042>

Thanks for revising, it is looking a bit better. A few comments still,
though:

On Tue, Aug 25, 2009 at 09:20:06PM +0400, Kirill A. Korinskiy wrote:

> Sometimes (especially on production systems) we need to use only one
> remote branch for building software. It really annoying to clone
> origin and then swith branch by hand everytime. So this patch provide
> functionality to clone remote branch with one command without using
> checkout after clone.

Typos:
  s/It/It's/
  s/swith/switch/
  s/provide/provides/
  s/clone remote/clone a remote/

>  t/t5706-clone-brnach.sh     |   31 +++++++++++++++++++++++++++++++

Typo: s/brnach/branch/ :)

> +test_expect_success 'clone' '
> +
> +	git clone parent clone &&
> +	(cd clone && git rev-parse --verify refs/remotes/origin/master)
> +
> +'
> +
> +test_expect_success 'clone -b' '
> +
> +	git clone -b two parent clone-b &&
> +	(cd clone && git rev-parse --verify refs/remotes/origin/two)
> +
> +'

Is this really testing the right thing? Shouldn't you always have
refs/remotes/origin/*, no matter what "-b" says? The difference should
be that HEAD in the first test will point to 'master', and to 'two' in
the second test.

-Peff
