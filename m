From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/RFC] Remove the use of '--' in merge program invocation
Date: Mon, 16 Jun 2008 17:05:25 -0700
Message-ID: <7vlk157woq.fsf@gitster.siamese.dyndns.org>
References: <1213659221-27519-1-git-send-email-patrick.higgins@cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Patrick Higgins <patrick.higgins@cexp.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Oid-0001bW-2a
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 02:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYFQAFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 20:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYFQAFo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 20:05:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYFQAFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 20:05:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC5ACC025;
	Mon, 16 Jun 2008 20:05:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 56369C024; Mon, 16 Jun 2008 20:05:28 -0400 (EDT)
In-Reply-To: <1213659221-27519-1-git-send-email-patrick.higgins@cexp.com>
 (Patrick Higgins's message of "Mon, 16 Jun 2008 17:33:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D7B40F6-3C01-11DD-91D2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85249>

Patrick Higgins <patrick.higgins@cexp.com> writes:

> Put a "./" at the beginning of all paths given to the merge program so
> that filenames beginning with a '-' character don't get interpreted as
> options.
>
> This deals with a problem where kdiff3 can be compiled with or without
> support for the '--' separator between options and filenames.
>
> Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
> ---
>
> This is applying Junio's idea because my earlier attempts would fail on files
> that started with a dash. This should work for those files with kdiff3
> compiled with or without '--' support, does not require any additional
> overhead to determine if kdiff3 has that support, and the technique should
> work for all merge programs in case any others have the problem kdiff3 has.
>
> My only concern is if 'git ls-files -u' ever returns absolute paths,
> then this will not work.

What do you mean by "absolute paths"?  The path git proper deals with is
always relative to the root of the repository's work tree, so you won't be
seeing "/home/patrick/src/Makefile" from ls-files if that is what you are
worried about.

This change applies to all the backends not just kdiff3; people who use
different merge backends please give success (or breakage) reports.

Thanks.
