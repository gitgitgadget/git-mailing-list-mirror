From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: use "$GIT_DIR/BISECT_START" to check if we are
 bisecting
Date: Wed, 28 May 2008 21:28:24 -0700
Message-ID: <7vd4n5raxj.fsf@gitster.siamese.dyndns.org>
References: <20080528185702.4dcd2955.chriscool@tuxfamily.org>
 <7vmymauzqg.fsf@gitster.siamese.dyndns.org>
 <200805290601.19067.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 29 06:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ZlY-0001tu-3N
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 06:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYE2E2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 00:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbYE2E2g
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 00:28:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYE2E2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 00:28:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE4035EFD;
	Thu, 29 May 2008 00:28:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1309A5EFC; Thu, 29 May 2008 00:28:31 -0400 (EDT)
In-Reply-To: <200805290601.19067.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu, 29 May 2008 06:01:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B36C91EC-2D37-11DD-B36C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83172>

Christian Couder <chriscool@tuxfamily.org> writes:

>> The reason you ignore an existing but empty BISECT_START file is...?
>
> ... that it should not happen, because this file is only written 
> in "bisect_start" and there its content comes either from the current HEAD 
> or from a previous not empty BISECT_START file.
>
> We might add a check for an empty BISECT_START file and warn in this case 
> that the file may have been corrupted, but that may be for another patch.

My question was more about "why are you acting as if distinction between
empty and nonempty BISECT_START matters?"

Because you "echo $start_head >$GIT_DIR/BISECT_START", this file will
always at least have a terminating LF even when the head is detached.
IOW, if it exists, it will never be empty, I think.
