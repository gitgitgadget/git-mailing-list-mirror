From: Adam Spiers <git@adamspiers.org>
Subject: $PATH pollution and t9902-completion.sh
Date: Mon, 17 Dec 2012 01:05:38 +0000
Message-ID: <20121217010538.GC3673@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 02:06:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkP9a-0007LB-HK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 02:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab2LQBFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 20:05:41 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41535 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab2LQBFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 20:05:41 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B30112E5D5
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 01:05:39 +0000 (GMT)
Content-Disposition: inline
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211620>

t/t9902-completion.sh is currently failing for me because I happen to
have a custom shell-script called git-check-email in ~/bin, which is
on my $PATH.  This is different to a similar-looking case reported
recently, which was due to an unclean working tree:

  http://thread.gmane.org/gmane.comp.version-control.git/208085

It's not unthinkable that in the future other tests could break for
similar reasons.  Therefore it would be good to sanitize $PATH in the
test framework so that it cannot destabilize tests, although I am
struggling to think of a good way of doing this.  Naively stripping
directories under $HOME would not protect against git "plugins" such
as the above being installed into places like /usr/bin.  Thoughts?
