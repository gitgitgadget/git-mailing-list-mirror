From: Yuri <yuri@rawbw.com>
Subject: Re: git quietly fails on https:// URL, https errors are never reported
 to user
Date: Fri, 17 Jan 2014 12:39:39 -0800
Message-ID: <52D9950B.3030300@rawbw.com>
References: <52D7D017.107@rawbw.com> <20140116180310.GA27180@sigill.intra.peff.net> <52D8FAA6.1010601@rawbw.com> <xmqqmwiuwg0o.fsf@gitster.dls.corp.google.com> <20140117201325.GB775@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4GCn-0000dd-B4
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbaAQUjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:39:49 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:65107 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaAQUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:39:48 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0HKddRJ071536;
	Fri, 17 Jan 2014 12:39:39 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117201325.GB775@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240629>

On 01/17/2014 12:13, Jeff King wrote:
>    $ git clonehttps://google.com/foo.git
>    Cloning into 'foo'...
>    fatal: repository 'https://google.com/foo.git/' not found
>    fatal: Reading from helper 'git-remote-https' failed
>
> That second line is not adding anything, and IMHO is making things
> uglier and more confusing. We_expected_  the helper to hang up; that's
> how it signals an error to us. It is not an unexpected condition at all.
> The exit(128) we do is simply propagating the error report of the
> helper.
>
> That's the common error case: the message is redundant and annoying. The
> _uncommon_  case is the one Yuri hit: some library misconfiguration that
> causes the helper not to run at all.  Adding back any message is hurting
> the common case to help the uncommon one.

But you can use the error code value to convey the cause of the failure 
to git, and avoid an unnecessary message in git itself. Based on the 
error code value git could tell if the error has already been reported 
to user.

Yuri
