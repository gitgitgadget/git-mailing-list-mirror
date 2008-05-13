From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Tue, 13 May 2008 15:34:05 -0700
Message-ID: <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
 <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
 <7vprrpswof.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 14 00:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw35O-0002pl-9D
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 00:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbYEMWeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 18:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYEMWeP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 18:34:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbYEMWeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 18:34:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3EEB39A5;
	Tue, 13 May 2008 18:34:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1915539A4; Tue, 13 May 2008 18:34:08 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 13 May 2008 15:24:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6BCBDBA-213C-11DD-BE85-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82050>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Look at CVS-generated patches, or SVN for that matter. The diffs look like 
> this:
>
> 	Index: file
> 	===================================================================
> 	--- file (revision 0)
> 	+++ file (working copy)
> 	@@ -0,0 +1 @@
> 	+test
>
> and there is no /dev/null there.
>
> The thing is, git-apply is careful, and it's very much careful with 
> respect to *knowing* that there are lots of different versions of "diff" 
> floating around, and lots of different SCM systems that generate odd diff 
> headers. We should absolutely NOT start expecting that diffs are only 
> generated with GNU diff.
>
> So non-/dev/null'ness means absolutely nothing. It means "don't know", and 
> we should leave is_new and is_delete as -1.

Ok, then what's the judgement for the original issue?  Is it a user error
to have a tracked absolutely empty file in the index?
