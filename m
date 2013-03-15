From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Fri, 15 Mar 2013 06:12:10 +0100
Message-ID: <5142ADAA.6050503@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu> <7vwqtb2ood.fsf@alter.siamese.dyndns.org> <20130313215800.GA23838@sigill.intra.peff.net> <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net> <5141B475.1000707@alum.mit.edu> <20130314134032.GA9222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 15 06:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGMwk-0004g4-8a
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 06:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab3COFMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 01:12:18 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53413 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752309Ab3COFMP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 01:12:15 -0400
X-AuditID: 12074413-b7f226d000000902-39-5142adaeb493
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 14.EF.02306.EADA2415; Fri, 15 Mar 2013 01:12:14 -0400 (EDT)
Received: from [192.168.69.140] (p57A25F64.dip.t-dialin.net [87.162.95.100])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2F5CBj9007706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Mar 2013 01:12:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130314134032.GA9222@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqLturVOgQfMCfYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BldF1+zF8xTqmjr8GhgvC3d
	xcjBISFgInFppmkXIyeQKSZx4d56ti5GLg4hgcuMEtNuP2KEcM4wSdzfc5oJpIpXQFviWN9u
	FhCbRUBV4unNj8wgNpuArsSinmawGlGBMIm9F6axQdQLSpyc+QSsXkRAVuL74Y2MIDazQJTE
	+Zf/weLCAmoSq6c+h1q2gEni+tZvYEM5BawkVu16zwpyKbOAusT6eUIQvfIS29/OYZ7AKDAL
	yYpZCFWzkFQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iREStsI7GHed
	lDvEKMDBqMTD6/DQMVCINbGsuDL3EKMkB5OSKK/9GqdAIb6k/JTKjMTijPii0pzU4kOMEhzM
	SiK8u/4ClfOmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHj/gQwVLEpN
	T61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VpfDEwTkFSPEB7L4C08xYXJOYCRSFaTzEa
	cyy49ugFI8fud0BSiCUvPy9VSpy3B6RUAKQ0ozQPbhEsYb1iFAf6W5h3EUgVDzDZwc17BbSK
	CWhVeo49yKqSRISUVANj4/26yz9izv9mNvmUWNn5akoH05bO3xdEeWZr2qXa30lheMjEkRew
	o2Bm9ZrzP3tKbPkvThd7xeTseSvqzxKtvIDTzY+/P3D7yJa7V5HxoObn2x/Vmqcw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218185>

On 03/14/2013 02:40 PM, Jeff King wrote:
> On Thu, Mar 14, 2013 at 12:28:53PM +0100, Michael Haggerty wrote:
> 
>> Perhaps if peel_ref() *were* 100% reliable, we might be able to use it
>> to avoid object lookups in some other places.
> 
> In theory, some of the many uses of deref_tag could be adopted. However,
> we do not always have the refname handy at that point (and I believe
> peel_ref's optimization only kicks in during for_each_ref traversals
> anyway).
> 
> It may still be a win to check the packed-refs file before peeling a
> random sha1, as looking up there should be cheaper than actually loading
> the object. But right now, the way the optimization is used is always
> O(1) to just check the last ref loaded. With your recent ref
> refactoring, I think we should be able to do lookups in O(lg n).

There are more conceptual problems in the handling of peeled references
and current_ref.  I want to document them here for future reference and
to get other people thinking about whether other parts of the code might
be making wrong assumptions about this stuff.


What is stored in ref_value.peeled?  Is it the peeled version of
ref_value.sha1, or is it the peeled version of the associated refname?
Because they are not necessarily the same thing: an entry in the packed
ref_cache *might* be overridden by a loose reference with the same
refname but a different SHA1 which peels to a different value.

Obviously we cannot always guarantee that ref_value.peeled is the peeled
version of the refname, because it is read from a packed-refs file that
might be old.  So the only sane policy is that ref_value.peeled should
be the peeled version of ref_value.sha1 regardless of whether the
refname now points elsewhere.

It follows that the only time we can be sure that ref_value.peeled is
the correct peeled version of refname is if we know that there is no
loose reference overriding it.

This leads to some subtleties when reading and writing ref_value.peeled.


When reading ref_value.peeled:

When we iterate over references using do_for_each_ref(), then we only
present a packed ref if there is no loose ref with the same refname.  So
in that case it is OK to point current_ref at the packed ref entry, and
if somebody calls peel_ref() for the current reference then (modulo race
conditions?) current_ref->u.value.peeled is indeed the correct peeled
value for that refname.

But if we iterate over *only* the packed refs using
do_for_each_ref_in_dir() (as, for example, in repack_without_ref()),
then the iteration doesn't even look at the loose refs, so we don't know
whether the packed ref_entry being iterated over is authoritative.  But
we nevertheless set current_ref to that entry.  So if somebody would
call peel_ref() on the current refname during such an iteration, they
could get the peeled version of the packed ref rather than the correct
peeled version for the refname.

Currently, nobody calls peel_ref() during such an iteration, so I don't
think it causes any bugs.  But it is an unmarked landmine.


When setting ref_value.peeled:

When determining the value to write to ref_value.peeled (which I believe
only happens in pack-refs), we should record the peeled version of
ref_entry.sha1, and *not* the peeled version of refname.  This is indeed
what pack-refs does.  But if somebody were to get the clever and
reasonable-sounding idea of using peel_ref() in the implementation of
pack-refs.c:handle_one_ref(), then it would be easy to accidentally get
a peeled value for the current refname rather than for the SHA1 being
recorded in the file.


I am trying to change repack_without_refs() to write the peeled refs to
the packed-refs file (currently the peeled refs are lost if a packed ref
is deleted).  For this I would like to reuse the pre-peeled values from
the old version of the packed-refs file to avoid having to resolve them
all again.  So all of the issues mentioned above are coming together for me.

I think my solution will be to add a static function in refs.c that
passes pointers to the ref_entries to its callback, so that the function
has direct access to the peeled member rather than having to access it
via the information-losing peel_ref().

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
