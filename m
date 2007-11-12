From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push mirror mode V4 (replacement stack)
Date: Mon, 12 Nov 2007 13:35:42 -0800
Message-ID: <7vd4uf2lld.fsf@gitster.siamese.dyndns.org>
References: <20071109233041.GC301@shadowen.org>
	<20071112110016.GG301@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irgwu-0006rr-Lu
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbXKLVfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXKLVfs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:35:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53095 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbXKLVfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:35:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2FDA42F9;
	Mon, 12 Nov 2007 16:36:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A85DE95086;
	Mon, 12 Nov 2007 16:36:05 -0500 (EST)
In-Reply-To: <20071112110016.GG301@shadowen.org> (Andy Whitcroft's message of
	"Mon, 12 Nov 2007 11:00:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64713>

Andy Whitcroft <apw@shadowen.org> writes:

> On Fri, Nov 09, 2007 at 11:30:41PM +0000, Andy Whitcroft wrote:
>> Following this mail is a complete replacement git push mirror mode
>> stack (V4).  It folds down all the various patches into a logical
>> sequence (thanks Dscho).  This stack passes the entire test suite,
>> and I have been using the same code for real work here.
>
> Ok, I have spotted one oddity with this feature.  The symbolic refs are
> getting converted to real refs in the mirror.  Generally speaking this
> is the <remote>/HEAD refs but I guess it may be possible to have others.

Currently there is no way to remotely create a symref.

It should be easy to make DAV based http push create a symref
file.

The native "send-pack" protocol does not support such feature,
so this needs a protocol extension, which hopefully would be
not too involved.

Also, to be symmetric, we would need a protocol extension on the
"fetch-pack" protocol side to allow fetchers to find out which
one is a symref pointing out what other ref.  The lack of the
information is why git-clone has to guess.
