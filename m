From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Wed, 03 Aug 2011 01:37:57 +0200
Message-ID: <4E388A55.6080606@kdbg.org>
References: <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org> <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net> <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 01:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoOYI-0003vA-3D
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 01:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab1HBXiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 19:38:04 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:8358 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751547Ab1HBXiC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 19:38:02 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 163D9130045;
	Wed,  3 Aug 2011 01:37:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 91D3719F38B;
	Wed,  3 Aug 2011 01:37:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110802181357.GA1861@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178533>

Am 02.08.2011 20:13, schrieb Jeff King:
> Hmm. So it's not _just_ the pipe vs file thing. What's different about
> calling it from the shell, versus the way we call it from git-archive?

When the parent process of an MSYS process is itself an MSYS process,
such as bash, then the child does not do its own
binary-mode-vs.-text-mode detection, but just uses whatever it is told
by the parent. This is achieved by MSYS's fork emulation.

But if the parent is a regular Windows program, such as git(-archive),
then the autodection happens and file descriptors pointing to files are
put into text mode.

-- Hannes
