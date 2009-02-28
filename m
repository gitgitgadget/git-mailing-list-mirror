From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] "git repack -a -d" improvements
Date: Sat, 28 Feb 2009 09:41:14 -0800
Message-ID: <7vfxhyfohx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0902191318310.21686@localhost.localdomain>
 <cover.1235812035.git.gitster@pobox.com> <8663iuwxrb.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sat Feb 28 18:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdTD9-0000mb-FV
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 18:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZB1RlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 12:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbZB1RlX
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:41:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZB1RlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 12:41:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CFA19DE77;
	Sat, 28 Feb 2009 12:41:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 910259DE70; Sat,
 28 Feb 2009 12:41:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01D85E0A-05BF-11DE-AA35-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111781>

Kjetil Barvik <barvik@broadpark.no> writes:

>   OK, patch 2/6 failed for me when I was doing 'git am' to import the
>   patch-series, so sorry if do not see all bits of the patch correctly.

Ah, I should have mentioned that the series was meant to apply to v1.6.0.6
(and merged upwards).

I am off to dentist so I won't have time to think about below until I get
back.

>   Would it be an improvment to change the signature of the currently
>   find_sha1_pack() function to:
>
>     struct packed_git *
>     find_pack_entry(const unsigned char *sha1, off_t *sha1_pack_offset,
>                     struct packed_git *packs)
>
>     - The currently existing 'struct pack_entry *e' parameter is only
>       used to retrn the offset, so make it more clear.  The struct
>       pack_entry can probably be deleted from the sha1_file.c file.
>
>     - When the 'git repack -a -d' command is used, one has to compute
>       the list of allowed pack-files to look into, and give this list to
>       find_pack_entry().
>
>     - The currently named find_sha1_pack() function can then be deleted.
>
>     - For example, when this function is now used in sha1_object_info()
>       it can be called like this:
>
>           found_pack = find_pack_entry(sha1, &offset, packed_git);
>
>   -- kjetil
