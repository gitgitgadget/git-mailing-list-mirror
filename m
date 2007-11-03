From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 20:55:58 +0100
Organization: glandium.org
Message-ID: <20071103195558.GA22448@glandium.org>
References: <Pine.LNX.4.64.0711031219530.4362@racer.site> <1194095285-18651-1-git-send-email-mh@glandium.org> <7vlk9fxj1r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 20:57:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoP7K-0000yH-Te
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbXKCT5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757880AbXKCT5A
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:57:00 -0400
Received: from vawad.err.no ([85.19.200.177]:33138 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757030AbXKCT47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 15:56:59 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoP6u-0002yy-42; Sat, 03 Nov 2007 20:56:50 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoP66-0005uI-9T; Sat, 03 Nov 2007 20:55:58 +0100
Content-Disposition: inline
In-Reply-To: <7vlk9fxj1r.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63306>

On Sat, Nov 03, 2007 at 11:47:44AM -0700, Junio C Hamano wrote:
(...)
> But in this case, as the variable "sp" is never used before it
> is reassigned, I can easily say "drop the useless assignment to
> sp there". ;-)

You got me here ;)

(...)
> When prev is not NULL but points at a null_sha1 nobody writes
> anything out.  Is this intended?
> 
>         In fact, the calling site always passes prev which is
>         prev[] in cmd_tag() and cannot be non-NULL.
 
Damn, I overlooked this, and since the test suite doesn't do anything
on that, that got through. Indeed either the test can be removed, since
write_tag_body does the is_null_sha1() test, or the is_null_sha1() test
can be moved here.

> Why is there "else" in the first place?  Even if you start with
> the previous tag's message, you are launching the editor for the
> user to further edit it, and you would want to give some
> instructions, wouldn't you?

Well, it could be true if the text was more verbose than "Write a tag
message". Anyways, as the test is now, the text is not going to appear.
:(

I'll fix this and will try to enhance the test suite to catch these
problems.

Mike
