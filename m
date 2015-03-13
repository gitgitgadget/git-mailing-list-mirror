From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 23:03:05 -0700
Message-ID: <xmqqwq2lzb6u.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	<1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
	<CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
	<20150311220825.GB46326@vauxhall.crustytoothpaste.net>
	<xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
	<55016A3A.6010100@alum.mit.edu>
	<20150312104651.GF46326@vauxhall.crustytoothpaste.net>
	<CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
	<xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com>
	<CACsJy8CMZbwyBayX-bbWmGwV=AWC000Yx6LfzOcB2irq2X6qHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:03:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWIgl-0002uy-J1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 07:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbbCMGDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 02:03:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751141AbbCMGDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 02:03:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8F6538F8C;
	Fri, 13 Mar 2015 02:03:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BqTEwt0cupnE59J2AYHlZLKJ/Qs=; b=RNHNjM
	4KAr9d0OtCGdHlzsEFGCVuYEJXCHuQJK0d8Nni56yhqPJT3grQ56DD8k/txSZA9h
	PJTsAEUSpS7SSaDTSaZW04V3NifiVIwOZEA4QhajuYjT1LxZaPycx372rCxHrC+y
	qjOsXIsCWK/QbhMO5BTerqa3q6lanzgJeUHAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYq4G3WBYRGDyZk568Un2LrewC92X00G
	V/zo94TadRDPGvMtDrZvdyU9x1LQ1lAksA+huZx5zqG54M+YriSExaykSO193hpw
	8uw/Ng4lIXvvCJpsYKiIDe/WLlcO7kd1cw/mF7i8lQYuQLOAPXH+KxUXNFxeZhsJ
	bfKphYz3I9s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFA9838F8B;
	Fri, 13 Mar 2015 02:03:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1AAC38F8A;
	Fri, 13 Mar 2015 02:03:06 -0400 (EDT)
In-Reply-To: <CACsJy8CMZbwyBayX-bbWmGwV=AWC000Yx6LfzOcB2irq2X6qHQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 13 Mar 2015 07:58:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E4DFD52-C946-11E4-B270-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265401>

Duy Nguyen <pclouds@gmail.com> writes:

>> You mean "if it came in <pack, offset> format, convert it down to
>> <sha1> until the last second that it is needed (e.g. need to put
>> that in a tree object in order to compute the object name of the
>> containing tree object)"?
>
> I picked my words poorly. It should be <pack, the index in pack>
> instead of the _byte_ offset.

Thanks for a clarification, but I do not think it affects the main
point of the discussion very much.  If we use "union in struct",
where we can store either an SHA-1 hash or some other identifying
information for the object, but not both, then at some point you
would need to convert <pack, nth> to <sha-1> in a codepath that
needs the sha-1 hash value (e.g. if the object A, that is known to
you as <pack, nth>, is placed in a tree object B, you need the
object name of A in <sha-1> representation in order to compute the
object name of the tree object B.  You can choose to keep it in
<pack, nth> form in "struct object_id { union }" and look up the
<sha-1> from the pack index every time, or you can choose to give
up the <pack, nth> form and upgrade the "struct object_id" to store
<sha-1> at that point.

If you keep both <pack, nth> *and* <sha-1> in "struct object_id" at
the same time, you can choose whichever is convenient, but it would
bloat everything in core.  Not just it bloats "struct object" and
its subclasses, the in-core index entries, which is what I meant
by ...

>> Unless you fix that "union in struct" assumption, that is.

... this.

>> To me, <pack, offset> information smells to belong more to a "struct
>> object" (or its subclass) as an optional annotation---when a caller
>> is asked to parse_object(), you would bypass the sha1_read_file()
>> that goes and looks the object name up from the list of pack .idx
>> and instead go there straight using that annotation.
>
> For pack v4, commits and trees can be encoded this way.

Even if your in-pack representation of a commit object allowed to
store the tree pointer in <pack, nth> format, its object name must
be computed as if you have the commit object in the traditional
format and computed the hash of that (together with the standard
"<type> <size>\0" header), and at that point, you need the contained
object's name in <sha-1> format (imagine how you would implement the
commit-tree command).  Hence, I do not think the v4 encoding changes
the discussion very much.  I see the primary value of v4 encoding is
to shorten the length of various fields take on-disk and in-pack.
If it were <pack, offset>, it could be argued that it would also be
faster to get to the packed data in the packfile, and going from
<pack, nth> to the .idx file and then going to the location in the
data in the packfile would be faster than going from <sha-1> to a
particular pack and its in-pack offset, with the difference of cost
around log(n)*m where n is the number of objects in a pack and m is
the total number of packs in the repository.

It is true that <nth> format (force that the referred-to object
lives in the same pack as the referrer) can help speed up
interpretation of extended SHA-1 expression, e.g. "v1.0^0:t", which
can read v1.0 tag in v4 format, find the <nth> info for the commit
pointed by the tag and get to that data in the pack, find the <nth>
info for the top-tree recorded in that commit and directly get to
the data of that tree, and then find the entry for "t", which will
give the object name for that subtree again in <nth> format, and at
that point you can find the <sha-1> of that final object, without
having to know any object names of the intermediate objects
(i.e. you must start from <sha-1> of the tag you obtain from the
refs API, but you didn't use the object name of the commit and its
top-level tree).  So for such a codepath, I would say it would be
sufficient to use a "union in struct" people have been envisioning
and convert <pack, nth> to <sha-1> when the latter form becomes
necessary for the first time for the object.

Anyway, wouldn't this be all academic?  I do not see how you would
keep the object name in the <pack, nth> format in-core, as the
obj_hash[] is a hashtable keyed by <sha-1>, and even when we switch
to a different hash, I cannot see how such a table to ensure the
singleton-ness of in-core objects can be keyed sometimes by <hash>
and by <pack, nth> in some other time.
