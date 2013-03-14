From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Thu, 14 Mar 2013 05:41:58 +0100
Message-ID: <51415516.2070702@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu> <7vwqtb2ood.fsf@alter.siamese.dyndns.org> <20130313215800.GA23838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 05:42:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG001-0003JZ-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 05:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab3CNEmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 00:42:14 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:60648 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750959Ab3CNEmO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 00:42:14 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-41-51415525e137
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 68.F8.02380.52551415; Thu, 14 Mar 2013 00:42:13 -0400 (EDT)
Received: from [192.168.69.140] (p57A25FE2.dip.t-dialin.net [87.162.95.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2E4g0Bl011010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Mar 2013 00:42:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130313215800.GA23838@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqKsa6hhoMPc4h0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7owj+74wFnQaVbxq0WtgPKjW
	xcjJISFgIrFj0m5GCFtM4sK99WwgtpDAZUaJW21FXYxcQPYZJokPNz4xgyR4BbQlZry+wApi
	swioSnzafJMJxGYT0JVY1NMMZosKhEm8XLKDDaJeUOLkzCcsILaIgKzE98MbwZYxC0RJnH/5
	HywuLKAmsXrqc0aIZS2MEuum9YE1cwpYSxw6cBAowQHUoC6xfp4QRK+8xPa3c5gnMArMQrJi
	FkLVLCRVCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEhC3fDsb29TKH
	GAU4GJV4eDOUHQOFWBPLiitzDzFKcjApifLGegOF+JLyUyozEosz4otKc1KLDzFKcDArifB6
	egHleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvLohQI2CRanpqRVp
	mTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCiNLwbGKUiKB2ivJEg7b3FBYi5QFKL1FKMux+53
	j14wCrHk5eelSonz/gkGKhIAKcoozYNbAUtSrxjFgT4W5n0HUsUDTHBwk14BLWECWpKeYw+y
	pCQRISXVwNgmzvY3tniCuL7Fp5VTltwJ/FMpx2D2wCXccW3S/7fbDdV27Py5IMn/itznI7Gv
	018UtR3vl1aR9pqa6tbAWbnA8/6PtW/XWidPP1Jop/tcP7xqovreZXPPnWZ/bnDC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218112>

On 03/13/2013 10:58 PM, Jeff King wrote:
> On Wed, Mar 13, 2013 at 10:29:54AM -0700, Junio C Hamano wrote:
> 
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> It is not
>>> clear to me whether the prohibition of tags outside of refs/tags should
>>> be made more airtight or whether the peeling of tags outside of
>>> refs/tags should be fixed.
>>
>> Retroactively forbidding presense/creation of tags outside the
>> designated refs/tags hierarchy will not fly.  I think we should peel
>> them when we are reading from "# pack-refs with: peeled" version.
>>
>> Theoretically, we could introduce "# pack-refs with: fully-peeled"
>> that records peeled versions for _all_ annotated tags even in
>> unusual places, but that would be introducing problems to existing
>> versions of the software to cater to use cases that is not blessed
>> officially, so I doubt it has much value.

I think that instead of changing "peeled" to "fully-peeled", it would be
better to add "fully-peeled" as an additional keyword, like

    # pack-refs with: peeled fully-peeled

Old readers would still see the "peeled" keyword and ignore the
fully-peeled keyword, and would be able to read the file correctly.  See
below for more discussion.

> I agree. The REF_KNOWS_PEELED thing is an optimization, so it's OK to
> simply omit the optimization in the corner case, since we don't expect
> it to happen often. So what happens now is a bug, but it is a bug in the
> reader that mis-applies the optimization, and we can just fix the
> reader.
> 
> I do not think there is any point in peeling while we are reading the
> pack-refs file; it is no more expensive to do so later, and in most
> cases we will not even bother peeling. We should simply omit the
> REF_KNOWS_PEELED bit so that later calls to peel_ref do not follow the
> optimization code path. Something like this:
> 
> diff --git a/refs.c b/refs.c
> index 175b9fc..ee498c8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -824,7 +824,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  
>  		refname = parse_ref_line(refline, sha1);
>  		if (refname) {
> -			last = create_ref_entry(refname, sha1, flag, 1);
> +			int this_flag = flag;
> +			if (prefixcmp(refname, "refs/tags/"))
> +				this_flag &= ~REF_KNOWS_PEELED;
> +			last = create_ref_entry(refname, sha1, this_flag, 1);
>  			add_ref(dir, last);
>  			continue;
>  		}

It would also be possible to set the REF_KNOWS_PEELED for any entries
for which a peeled reference happens to be present in the packed-refs
file, though the code would never be triggered if the current writer is
not changed.

> I think with this patch, though, that upload-pack would end up having to
> read the object type of everything under refs/heads to decide whether it
> needs to be peeled (and in most cases, it does not, making the initial
> ref advertisement potentially much more expensive). How do we want to
> handle that? Should we teach upload-pack not to bother advertising peels
> outside of refs/tags? That would break people who expect tag
> auto-following to work for refs outside of refs/tags, but I am not sure
> that is a sane thing to expect.

Here is analysis of our options as I see them:

1. Accept that tags outside of refs/tags are not reliably advertised in
   their peeled form.  Document this deficiency and either:

   a. Don't even bother trying to peel refs outside of refs/tags (the
      status quo).

   b. Change the pack-refs writer to write all peeled refs, but leave
      the reader unchanged.  This is a low-risk option that would cause
      old and new clients to do the right thing when reading a full
      packed-refs file, but an old or new client reading a non-full
      packed-refs file would not realize that it is non-full and would
      fail to advertise all peeled refs.  Minor disadvantage: pack-refs
      becomes slower.

2. Insist that tags outside of refs/tags are reliably advertised.  I
   see three ways to do it:

   a. Without changing the packed-refs contents.  This would require
      upload-pack to read *all* references outside of refs/tags.  (This
      is what Peff's patch does.)

   b. Write all peeled refs to packed-refs without changing the
      packed-refs header.  This would hardly help, as upload-pack
      would still have to read all non-tag references outside of
      refs/tags to be sure that none are tags.

   c. Add a new keyword to the top of the packed-refs file as
      described above.  Then

      * Old writer, new reader: the reader would know that some
        peeled refs might be missing.  upload-pack would have to
        resolve refs outside of refs/tags, but could optionally write
        a new-format packed-refs file to avoid repeating the work.

      * New writer, new reader: the reader would know that all refs
        are peeled properly and would not have to read any objects.

      * Old writer, old reader: status quo; peeled refs are advertised
        incompletely.

      * New writer, old reader: This is the interesting case.  The
        current code in Git would read the header and see "peeled" but
        ignore "fully-peeled".  But the line-reading code would
        nevertheless happily read and record peeled references no
        matter what namespace they live in.  It would also advertise
        them correctly.  One would have to check historical versions
        and other clients to see whether they would also behave well.

   d. Add some new notation, like a "^" on a line by itself, to mean
      "I tried to peel this reference but it was not an annotated tag".
      Old readers ignore such lines but new readers could take it
      as an indication to set the REF_KNOWS_PEELED bit for that entry.
      (It is not clear to me whether it would be permissible to make a
      change like this without changing the header line.)

I think the best option would be 1b.  Even though there would never be a
guarantee that all peeled references are recorded and advertised
correctly, the behavior would asymptotically approach correctness as old
Git versions are retired, and the situations where it fails are probably
rare and no worse than the status quo.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
