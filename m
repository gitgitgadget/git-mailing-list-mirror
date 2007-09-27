From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 13:51:06 -0700
Message-ID: <7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	<20070927185707.GC12427@artemis.corp>
	<94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	<7vhclfubh5.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	<7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	<7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kelvie Wong" <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib0KN-0007Cj-6x
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXI0UvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbXI0UvL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:51:11 -0400
Received: from rune.pobox.com ([208.210.124.79]:58811 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbXI0UvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:51:10 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 437B113D3A9;
	Thu, 27 Sep 2007 16:51:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A065C13D2AA;
	Thu, 27 Sep 2007 16:51:29 -0400 (EDT)
In-Reply-To: <7v8x6ru97z.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Sep 2007 13:47:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59334>

Junio C Hamano <gitster@pobox.com> writes:

> "Kelvie Wong" <kelvie@ieee.org> writes:
>
>> Egads, it's alive!
>>
>> I was in a subdirectory (most of my work is in that one subdirectory
>> anyways :p), but running it on the top level did indeed work as
>> expected.
>>
>> Thanks,
>
> Thanks for spotting a bug.  It claims to be subdirectory safe at
> the top of the script but apparently it isn't.
>
> And I do not see a reason why it cannot be made subdirectory
> safe.

It _could_ be just the matter of doing this, although I cannot
test it right now (at work and have no access to any of the
backends).  Care to try it from a subdirectory and report
failure or success?

---

 git-mergetool.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index a0e44f7..018db58 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -12,6 +12,7 @@ USAGE='[--tool=tool] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
+cd_to_toplevel
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
