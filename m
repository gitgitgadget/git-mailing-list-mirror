From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Tue, 08 Jul 2008 22:44:58 -0700
Message-ID: <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
 <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709300039430.28395@racer.site>
 <7v4phdja01.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGSVC-000578-Uj
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 07:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbYGIFpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 01:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYGIFpJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 01:45:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYGIFpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 01:45:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A58018A1D;
	Wed,  9 Jul 2008 01:45:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 66A1818A1B; Wed,  9 Jul 2008 01:45:00 -0400 (EDT)
In-Reply-To: <7v4phdja01.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 29 Sep 2007 17:02:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F155BAA-4D7A-11DD-B72C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87849>

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
