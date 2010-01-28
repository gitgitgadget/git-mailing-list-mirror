From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 00/23] git notes
Date: Wed, 27 Jan 2010 16:02:57 -0800
Message-ID: <7vk4v3nlji.fsf@alter.siamese.dyndns.org>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
 <7vzl3zpbbz.fsf@alter.siamese.dyndns.org>
 <201001280005.03190.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 01:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaHqs-0003Xv-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 01:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0A1ADG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 19:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716Ab0A1ADG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 19:03:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab0A1ADF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 19:03:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63B2B94401;
	Wed, 27 Jan 2010 19:03:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UasmvZNs96Y/OGDEsMxqFzToRx8=; b=wcQgnn
	HPWxWP/glob0sVzevXQ90cl4zFQxwX1ZpMDn6B2rq983+9z+/kDXolK4tmVqNhBF
	Galg2SWK9vkmDtxz1CmILZnM9bIZCzWz+bqNTsDr7U7m695RGhAoMgyZeqC9RTOJ
	/t0eCmE3buumxv9XvToKCU8cTPy3jpeA8cack=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Utz4iRizHM2eb7IRQ4UCoTLCrync+XJY
	UbOApKU/VJ2CIy/4GAutt4nWmV6oIW7dx2J2HReBKhnPZp2e7RoOiDsnZvbca2mw
	i5GIrtV82hqZnbKFXzL0One77tyJ9f4+rNy93a1DUeCEZv3m2w0Hhby6K+6rZ0u8
	3ej4PpirT8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40AFE943FD;
	Wed, 27 Jan 2010 19:03:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B476943FC; Wed, 27 Jan
 2010 19:02:59 -0500 (EST)
In-Reply-To: <201001280005.03190.johan@herland.net> (Johan Herland's message
 of "Thu\, 28 Jan 2010 00\:05\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8076C584-0BA0-11DF-A861-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138210>

Johan Herland <johan@herland.net> writes:

> On Wednesday 27 January 2010, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>> > - Patch #23 is a new patch adding the "git notes add" command for
>> > appending contents to notes (instead of editing/replacing).
>> 
>> I find this even more confusing.  Originally I was puzzled by the lack of
>> "git notes add"; it took me for quite until I managed to figure out that
>> "git notes edit" was the command to use, even if I wanted to add notes to
>> a commit that I know that does not have any.
>
> Not sure what you're getting at here.

The earlier frustration of mine was about adding a note, not adding _to_ a
note.  The semantic difference I described with add/edit was "adding anew"
vs "modify".

Once I realize that Dscho's original "edit" lacks an explicit "adding
anew" and it simply means "replace if exists otherwise add", then I can
agree the argument that "adding anew" mode is not necessary.

The semantic difference your add/edit try to capture works at a different
level.  They are "append to it" vs "replace it".  Current "edit -m 'foo'"
that replaces feels to me quite counterintuitive.

If two modes are useful, then I would suggest to deprecate the use of
"edit" subcommand with -m/-F (because its name doesn't tell the user which
one between "append" and "replace" it happens to implement) and instead
introduce two more explicit subcommands, "append" and "replace".  For the
same reason, "add" would cause confusion between "is this to add a new
note" vs "is this to add _to_ a new note", and I'd recommend against it.

"edit" could still open an editor to "modify" existing one (and if there
is no existing one, then the editor starts empty).

On the other hand, if "replace" is not very useful, then it might be
enough to just introduce a new "append" subcommand.  Or course, we could
redefine the useless "replace" semantics from "edit -m/-F" and change it
to always append.
