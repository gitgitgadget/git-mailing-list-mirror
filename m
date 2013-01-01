From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Tue, 01 Jan 2013 15:47:21 -0800
Message-ID: <7vmwws79fa.fsf@alter.siamese.dyndns.org>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net>
 <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
 <20121230213124.GA15946@sigill.intra.peff.net>
 <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
 <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com>
 <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com>
 <CAJo=hJsZedd0kfYJnXPhcud8bz3mgU0NMf6O6-_PY1yqv-EfDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 00:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqBYd-0003TQ-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 00:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab3AAXrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 18:47:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab3AAXrX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 18:47:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DEECAA29;
	Tue,  1 Jan 2013 18:47:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yelPuUBBnPEzSa/0i80/Z+pLcTE=; b=uCinj9
	MKsWdo4mL/ThBPg6+K5qS+20qkp/9g3q3X2W6uORN4TNbAwowHJrPKLeVK1D4pxG
	wvrOlXxK+zgOsD4olqRb0MBhzW3O1wzqGn+cf/985g7+x85gRmPK+xRdNwueguZJ
	HgowkRs3AosDurt6jMgkL+r4oZQzw7EKOEiZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVwWW4hKexo/EgSBOt6sZEnvkwpKBZId
	tsBni+7oZ/jxDiVWehP/rhuApgGiieEITXJ7sE0pVEIKGN3ZQUEWW8pLp1dTgM+K
	NvsOi198/8OIqBafB4w/kJk8Y7B48qQvWJhAEvDID9KkkmOEwMlMtE4KQJiECJFj
	vaMKZa80pvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDDAAA27;
	Tue,  1 Jan 2013 18:47:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A950CAA26; Tue,  1 Jan 2013
 18:47:22 -0500 (EST)
In-Reply-To: <CAJo=hJsZedd0kfYJnXPhcud8bz3mgU0NMf6O6-_PY1yqv-EfDg@mail.gmail.com> (Shawn
 Pearce's message of "Tue, 1 Jan 2013 09:17:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9675E450-546D-11E2-B6F8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212474>

Shawn Pearce <spearce@spearce.org> writes:

> How blobs are written is very different, Junio's
> implementation is strictly better than JGit's[1].

I do not think there can be a single ordering that is strictly
better than any other one.  The "clump all objects in a delta family
and write them width-first, starting from the base object" may give
you a reasonable trade-off for a result of normal repack, but if you
repack (like I do) with very shallow --depth with wide --window to
really get a tight pack, a delta may end up having too may uncles
between it and its father, requiring a large seek to skip over all
the uncles in order to grab the delta data, after you reconstitute
the delta base object.
