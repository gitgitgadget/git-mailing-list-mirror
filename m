From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and
 BSD
Date: Mon, 28 Oct 2013 19:07:04 +0100
Message-ID: <526EA7C8.2020607@kdbg.org>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com> <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 28 19:07:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VarDg-0004ex-J4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 19:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab3J1SHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 14:07:09 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:4291 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756661Ab3J1SHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 14:07:09 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 772CFCDF83;
	Mon, 28 Oct 2013 19:07:05 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B860319F31A;
	Mon, 28 Oct 2013 19:07:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236845>

Am 28.10.2013 10:13, schrieb Ben Walton:
> Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) uses the System V
> semantics for tr whereby string1's length is truncated to the length
> of string2 if string2 is shorter. The BSD semantics, as used by GNU tr
> see string2 padded to the length of string1 using the final character
> in string2. POSIX explicitly doesn't specify the correct behavior
> here, making both equally valid.
> 
> This difference means that Solaris' native tr implementations produce
> different results for tr ":\t\n" "\0" than GNU tr. This breaks a few
> tests in t0008-ignores.sh.
> 
> Possible fixes for this are to make string2 be "\0\0\0" or "[\0*]".
> 
> Instead, use perl to perform these transliterations which means we
> don't need to worry about the difference at all. Since we're replacing
> tr with perl, we also use perl to replace the sed invocations used to
> transform the files.

In other tests, we check for prerequisite PERL, i.e., we are prepared
that perl is not available. Shouldn't we do that here, too?

But OTOH, I think that we should skip as few test cases as possible in
such a basic test as t0008.

Just some food for thought...
-- Hannes
