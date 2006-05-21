From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: don't accept bogus N in `HEAD~N'
Date: Sun, 21 May 2006 23:42:47 +0200
Organization: At home
Message-ID: <e4qmsn$3mv$1@sea.gmane.org>
References: <87mzdcjqey.fsf@rho.meyering.net> <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net> <87d5e7hxhl.fsf_-_@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 21 23:43:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhvi6-0006yo-8P
	for gcvg-git@gmane.org; Sun, 21 May 2006 23:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWEUVnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWEUVnF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 17:43:05 -0400
Received: from main.gmane.org ([80.91.229.2]:24514 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964943AbWEUVnE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 17:43:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhvhS-0006rH-Li
	for git@vger.kernel.org; Sun, 21 May 2006 23:42:58 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 23:42:58 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 23:42:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20464>

Jim Meyering wrote:

> In a very shallow audit, I spotted code where overflow was not detected.
> But it's hardly critical.
> 
> Currently,
> 
>   git-diff HEAD HEAD
> 
> is equivalent to this
> 
>   git-diff HEAD HEAD~18446744073709551616   # aka 2^64
> 
> Exercising git-rev-parse directly, currently I get this:
> 
>   $ git-rev-parse --no-flags --sq HEAD~18446744073709551616
>   '639ca5497279607665847f2e3a11064441a8f2a6'
> 
> It'd be better to produce a diagnostic and fail:
> 
>   $ ./git-rev-parse --no-flags --sq -- HEAD~18446744073709551616 /dev/null
>   fatal: ambiguous argument 'HEAD~18446744073709551616': unknown revision or filename

Wouldn't it remove ability to say "to the root commit"?
One can do it now I guess exactly by specyfying overly large N.
Although there should probably be some limit... or not.

-- 
Jakub Narebski
Warsaw, Poland
