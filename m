From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: "git add --interactive" does not work with UTF-8 filenames
Date: Wed, 02 Apr 2008 08:50:07 -0700
Message-ID: <7v3aq49ryo.fsf@gitster.siamese.dyndns.org>
References: <200804012232.03559.tlikonen@iki.fi>
 <m3y77xtk32.fsf@localhost.localdomain>
 <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
 <200804021317.16007.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 17:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh5F3-0004Qx-8W
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 17:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbYDBPuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbYDBPuU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 11:50:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYDBPuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 11:50:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0ED4E5314;
	Wed,  2 Apr 2008 11:50:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B69AF530E; Wed,  2 Apr 2008 11:50:09 -0400 (EDT)
In-Reply-To: <200804021317.16007.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 2 Apr 2008 12:17:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78697>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, the code to unwrap the path quoting can be found in gitweb
> as unescape() subroutine... or git-add--interactive can use '-z' switch.

Yes, but if you use '-z' to read from plumbing, you would need your own
wrapping on the UI side to protect your output from control characters
(most notably LF) embedded in pathnames.

Also I had an impression that the compatibility implementation of
run_cmd_pipe() had some issues with NUL terminated list.
