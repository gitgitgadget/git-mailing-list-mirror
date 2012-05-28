From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] clone: make --local handle URLs
Date: Mon, 28 May 2012 20:31:09 +0200
Message-ID: <4FC3C46D.5070704@kdbg.org>
References: <20120526034226.GA14287@sigill.intra.peff.net> <20120526034532.GB14332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 28 20:31:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ4ir-0003YS-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 20:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab2E1SbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 14:31:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15400 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab2E1SbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 14:31:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E164ACDF8C;
	Mon, 28 May 2012 20:32:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4A09C19F5E3;
	Mon, 28 May 2012 20:31:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <20120526034532.GB14332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198712>

Am 26.05.2012 05:45, schrieb Jeff King:
> And did you know that file:// URLs
> can have a hostname in them? How useless.
...
> +test_expect_success 'cloning file:// turns off local optimizations' '
> +	git clone --bare file://"$PWD"/a non-local &&
> +	! repo_is_hardlinked non-local
> +'
> +
> +test_expect_success 'cloning file:// with --local uses hardlinks' '
> +	git clone --bare --local file://"$PWD"/a force-local &&
> +	repo_is_hardlinked force-local
> +'
> +
> +test_expect_success 'cloning file:// with --local parses URL properly' '
> +	git clone --bare --local file://host/"$PWD"/%61 force-local-odd &&
> +	repo_is_hardlinked force-local-odd
> +'

I'm pretty certain that we must use file://c:/path/to/repo on Windows to
make these work. This means we need $(pwd) rather than $PWD. But what
does this mean w.r.t. parsing the URL in the strict sense? Is "c:" the
host part?

-- Hannes
