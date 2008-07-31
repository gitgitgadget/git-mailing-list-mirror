From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 16:04:50 +0300
Message-ID: <4891B872.3040707@panasas.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 15:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXrg-0001r4-4p
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 15:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbYGaNFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 09:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYGaNFL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 09:05:11 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:30639 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751791AbYGaNFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 09:05:10 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m6VD5774015318;
	Thu, 31 Jul 2008 09:05:08 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.146]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 31 Jul 2008 09:04:13 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
X-OriginalArrivalTime: 31 Jul 2008 13:04:13.0981 (UTC) FILETIME=[EE6574D0:01C8F30D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90944>

cte wrote:
> I'm writing a git gui for OS X using cocoa/Objective-C++, and rather
> than being lame and parsing the output the various git commands, I'm
> using libgit.a to provide all of the needed functionality for my app.
> However, the git source uses a few reserved C++ keywords; namely
> 'typename', and 'new'. So, I was wondering if it is worth submitting a
> patch to fix these issues... I'm asking because I'm new to the whole
> open source thing, and I don't want to get yelled at by the git
> maintainers for submitting stupid patches that no one in their right
> mind would accept :)
> 
> Thanks!
> --

The practice of avoiding C++ keywords from public C headers is
very welcome. You should send a patch and try to push it.

That said the problem can be easily avoided.

Produce a C file and header that defines some stable API to your
GUI application, that does not expose any git internal headers.
Then compile that, say git_api.c, with C compiler in Makefile
and extern "C" link that file to your C++ application. This will
completely insulate you from any git code.

This could also solve the other problem of API changing, only
the git_api.c need change, your outer GUI code stays the same.

And if you do all that maybe you can submit it for inclusion
as a: somewhat stable high-level library, for developers.
Ala git-dev

Cheers
Boaz
