From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Thu, 11 Oct 2012 07:45:00 +0200
Message-ID: <50765CDC.8020509@viscovery.net>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com> <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 07:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMBaC-0001Fl-5b
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 07:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab2JKFpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 01:45:09 -0400
Received: from so.liwest.at ([212.33.55.24]:32681 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab2JKFpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 01:45:08 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TMBZt-0008Vx-Ah; Thu, 11 Oct 2012 07:45:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E523E1660F;
	Thu, 11 Oct 2012 07:45:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207463>

Am 10/10/2012 21:56, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> At any rate, I don't observe the warnings anymore with this series.
> 
> What kind of warnings have you been getting?  Earlier we had a bug
> in the jk/config-warn-on-inaccessible-paths series that made it warn
> when we tried to open a .gitattribute file and open() returned an
> error other than ENOENT.  The bug was that we saw unnecessary errors
> when a directory that used to exist no longer exists in the working
> tree; we would instead get ENOTDIR in such a case that needs to be
> ignored.

I saw EINVAL errors when 'git grep pattern rev' was run on Windows. The
reason is that the code attempted to access "rev:dir/.gitattributes" in
the worktree, which is an invalid path on Windows due to the colon. The
lack of this warning indicates that the attempts to access these files are
eliminated.

-- Hannes
