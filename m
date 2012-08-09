From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 04/13] Add documentation of the index-v5 file
 format
Date: Thu, 09 Aug 2012 15:41:36 -0700
Message-ID: <7vobmjn0wv.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:41:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzbQH-0004aU-VA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759868Ab2HIWlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 18:41:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759779Ab2HIWlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 18:41:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD719573;
	Thu,  9 Aug 2012 18:41:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/W3Y49TaFbVYlO1ZX6v71G2hdCM=; b=God3bS
	/yjGN64xRUAwxPeMs1rslVSLHplkm/OcFYiiubq40LRQKD3sfjVSm7GD5/3qGGqZ
	SNndnjUXUxpcP3/rHl29205pZbYV1n2rjySFO5LlQPG/GNS+Nx20v/RiQ1SYwU9a
	KLwuLsZQkR2kEecd1Q1aqhVcYBVC34Rm/DCuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mP5vL9JVjBy65/uZI6lklP5e6PQFT73z
	RERuQa8utRBhwhlKbhHIanurJkPTVIAk/h0hKIGq5oX4jRUKTmOXIWsI2/aHcUx5
	Xlbo8EBW0OSPnnRIJGCDBBoDL1B5+6rwOVIuxGxjLIdWI5lXRMDBCAl3vklztSDp
	X/5rE59YJck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2905D9572;
	Thu,  9 Aug 2012 18:41:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 621669570; Thu,  9 Aug 2012
 18:41:37 -0400 (EDT)
In-Reply-To: <1344424681-31469-5-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Wed, 8 Aug 2012 13:17:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60FC9C54-E273-11E1-804F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203184>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +GIT index format
> +================
> +
> +== The git index file format
> +
> +   The git index file (.git/index) documents the status of the files
> +     in the git staging area.
> +
> +   The staging area is used for preparing commits, merging, etc.

The above two are not about "index file format".  It is an
explanation of what the index is.

> +   All binary numbers are in network byte order. Version 5 is described
> +     here.

I had to read between these two lines something like 

    ""The index file consists of various sections; the sections
    appear in the following order in the file."""

to make sense of the document.

> +   - A 20-byte header consisting of
> +
> +     sig (32-bits): Signature:
> +       The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
> +
> +     vnr (32-bits): Version number:
> +       The current supported versions are 2, 3, 4 and 5.
> +
> +     ndir (32-bits): number of directories in the index.
> +
> +     nfile (32-bits): number of file entries in the index.
> +
> +     fblockoffset (32-bits): offset to the file block, relative to the
> +       beginning of the file.

Ok.

> +   - Offset to the extensions.
>
> +     nextensions (32-bits): number of extensions.
> +
> +     extoffset (32-bits): offset to the extension. (Possibly none, as
> +       many as indicated in the 4-byte number of extensions)

OK.

> +     headercrc (32-bits): crc checksum for the header and extension
> +       offsets

This may have to have the same "  - <section title>" at the same
level as "A 20-byte header" and "Offset to the ext"; as it stands,
it looks as if it is part of "Offset to the ext" which consists of
12 bytes.

> +   - diroffsets (ndir * directory offsets): A directory offset for each
> +       of the ndir directories in the index, sorted by pathname (of the
> +       directory it's pointing to) (see below). The diroffsets are relative
> +       to the beginning of the direntries block. [1]

"ndir * diroffsets" confused me.  I think you meant to say that this
"diroffsets" section consists of ndir entries of something and that
each of that something is a directory offset.  It is unclear how "a
directory offset" is represented, except that it is "relative to the
beginning of direntry block" (and it is unclear what and where the
direntry block is from the information given up to this point) and
the reader can guess it is in "network byte order" (assuming it is a
binary number).  Perhaps

	diroffsets (ndir entries of "directory offset"): A 4-byte
	offset relative to the beginning of the "direntries block"
	(see below) for each of the ...

and drop the last sentence?

Other tables may want to be adjusted in a similar fashion.

> +== Directory offsets (diroffsets)
> +
> +  diroffset (32-bits): offset to the directory relative to the beginning
> +    of the index file. There are ndir + 1 offsets in the diroffset table,
> +    the last is pointing to the end of the last direntry. With this last
> +    entry, we can replace the strlen when reading each filename, by
> +    calculating its length with the offsets.

The mention of "strlen" looks very out of place.  The reader may be
able to guess that you want to say that the nth "string" is between
diroffset[n] and diroffset[n+1], and these "string"s are densely
packed so strlen(diroffset[n]) and diroffset[n+1]-diroffset[n] are
either the same thing (or with a fixed difference, if each "string"
is accompanied by some fixed-length data), but it is unclear what
these "strings" represent, especially because the name of the table
implies that you are talking about directories but strlen talks
about filename.

> +== Design explanations
> + ...
> +[3] The data of the cache-tree extension and the resolve undo
> +    extension is now part of the index itself, but if other extensions
> +    come up in the future, there is no need to change the index, they
> +    can simply be added at the end.

Interesting.  When we added extensions, we said that there is no
need to change the index to add new features, they can simply be
added at the end.  Perhaps the file offset table can be added as an
extension to v2 to give us the same bisectability, allowing us a
single entry in-place replacementability, without defining an
entirely different format?
