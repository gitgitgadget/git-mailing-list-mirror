From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for
 t9113 and 9126
Date: Thu, 19 May 2016 10:06:58 +0000
Message-ID: <20160519100658.GA20225@dcvr.yhbt.net>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
 <1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 12:07:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3KrD-0000kh-Ag
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 12:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbcESKHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 06:07:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56012 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbcESKHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 06:07:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B8E1FA7B;
	Thu, 19 May 2016 10:06:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295053>

larsxschneider@gmail.com wrote:
> Enable t9113 and 9126 by defining the SVNSERVER_PORT. Since both tests
> open the same port during execution, they cannot run in parallel. Add
> a ".seq.sh" suffix to the test files and teach "prove" to run them
> sequentially.

Interesting, I guess I forgot the problem because had some
rules in config.mak to serialize them for many years, now :x

Anyways, how about making the tests run on separate ports and
not worry about serializing them at all?  Maybe there was a
reason we didn't do this years ago, but I forget...

But probably the best (but I guess more difficult) option is to
get svnserve+apache to do socket activation off a random port
bound by a parent process at startup.
