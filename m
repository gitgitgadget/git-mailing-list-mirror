From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Sat, 29 Sep 2007 17:02:38 -0700
Message-ID: <7v4phdja01.fsf@gitster.siamese.dyndns.org>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
	<7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709300039430.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 02:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbmGu-0006eh-ML
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 02:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbXI3ACs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 20:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXI3ACs
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 20:02:48 -0400
Received: from rune.pobox.com ([208.210.124.79]:36191 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXI3ACr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 20:02:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DA77013E08D;
	Sat, 29 Sep 2007 20:03:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 285FF13DB09;
	Sat, 29 Sep 2007 20:03:03 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709300039430.28395@racer.site> (Johannes
	Schindelin's message of "Sun, 30 Sep 2007 00:40:41 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59514>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 29 Sep 2007, Junio C Hamano wrote:
>
>> We never supported URLs with embedded credentials (see
>> Documentation/urls.txt), partly because nobody asked for it, but
>> more importantly because giving -n to curl to have it read from
>> user's .netrc is generally much more preferred approach.
>
> To elaborate on that: if you fetch from somewhere, your url, username and 
> password can be read from the output of "ps ax | grep http" very easily.

Actually Documentation/howto/setup-git-server-over-http.txt
talks about http://user@server/path/ format.  How well does this
work in practice?  If it does, we should update Documentation/urls.txt
to allow optional user@ there like...

---

 Documentation/urls.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index e67f914..c9aab86 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -6,8 +6,8 @@ to name the remote repository:
 
 ===============================================================
 - rsync://host.xz/path/to/repo.git/
-- http://host.xz/path/to/repo.git/
-- https://host.xz/path/to/repo.git/
+- http://{startsb}user@{endsb}host.xz/path/to/repo.git/
+- https://{startsb}user@{endsb}host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
