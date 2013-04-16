From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 14/33] refs: extract a function peel_entry()
Date: Wed, 17 Apr 2013 00:01:57 +0200
Message-ID: <516DCA55.8030601@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-15-git-send-email-mhagger@alum.mit.edu> <7v38urwv6o.fsf@alter.siamese.dyndns.org> <516D4D1F.5010207@alum.mit.edu> <7vhaj6mkcb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDx3-0006cp-MH
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331Ab3DPWCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 18:02:05 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:44515 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965255Ab3DPWCD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 18:02:03 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-5d-516dca5942b4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.1B.02295.95ACD615; Tue, 16 Apr 2013 18:02:01 -0400 (EDT)
Received: from [192.168.69.140] (p57A2542E.dip.t-dialin.net [87.162.84.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3GM1xcq019772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 18:02:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vhaj6mkcb.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqBt5KjfQYPsVa4uuK91MFg29V5gt
	Vj6+y2zxo6WH2YHFo/39O2aPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74/SWqywF
	u9Uqus7sYm5g/CDXxcjJISFgIvHgxzRmCFtM4sK99WxdjFwcQgKXGSX+HjjGBpIQEjjNJHFo
	BSuIzSugLbF1+iZGEJtFQFXi7+ZJTCA2m4CuxKKeZjBbVCBMYtX6ZcwQ9YISJ2c+YQGxRQTU
	JCa2HQKyOTiYBWIkzl0VAgkLCzhI3Dx3HmrvJ0aJHQv2soMkOAXMJP407wLbyyygI/Gu7wEz
	hC0vsf3tHOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0
	UlNKNzFCwplnB+O3dTKHGAU4GJV4eC8U5AYKsSaWFVfmHmKU5GBSEuW9vh8oxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYRXcRVQjjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUIJivD
	waEkwet/EqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtNQFp
	5y0uSMwFikK0nmI05pi19clrRo6VV4CkEEtefl6qlDjvwxNApQIgpRmleXCLYInsFaM40N/C
	vOYgA3mASRBu3iugVUxAqw6sygZZVZKIkJJqYJy1JeN4hvoXrpYTW2I/rYjpaVl6vvlB/mcz
	p+xtPYlHlHXznt1TPDCni/93QJ2x2pZn817Z/eH///1q42v2qyHac+v4i5tl4jKE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221481>

On 04/16/2013 07:55 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 04/15/2013 07:38 PM, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>>  	if (read_ref_full(refname, base, 1, &flag))
>>>>  		return -1;
>>>>  
>>>> -	if ((flag & REF_ISPACKED)) {
>>>> +	/*
>>>> +	 * If the reference is packed, read its ref_entry from the
>>>> +	 * cache in the hope that we already know its peeled value.
>>>> +	 * We only try this optimization on packed references because
>>>> +	 * (a) forcing the filling of the loose reference cache could
>>>> +	 * be expensive and (b) loose references anyway usually do not
>>>> +	 * have REF_KNOWS_PEELED.
>>>> +	 */
>>>> +	if (flag & REF_ISPACKED) {
>>>>  		struct ref_entry *r = get_packed_ref(refname);
>>>
>>> This code makes the reader wonder what happens when a new loose ref
>>> masks a stale packed ref, but the worry is unfounded because the
>>> read_ref_full() wouldn't have gave us REF_ISPACKED in the flag in
>>> such a case.
>>>
>>> But somehow the calling sequence looks like such a mistake waiting
>>> to happen.  It would be much more clear if a function that returns a
>>> "struct ref_entry *" is used instead of read_ref_full() above, and
>>> we checked (r->flag & REF_ISPACKED) in the conditional, without a
>>> separate get_packed_ref(refname).
>>
>> As I'm sure you realize, I didn't change the code that you are referring
>> to; I just added a comment.
> 
> Yes.
> 
>> But yes, I sympathize with your complaint.  Additionally, the code has
>> the drawback that get_packed_ref() is called twice: once in
>> read_ref_full() and again in the if block here.  Unfortunately, this
>> isn't so easy to fix because read_ref_full() doesn't use the loose
>> reference cache, so the reference that it returns might not even have a
>> ref_entry associated with it (specifically, unless the returned flag
>> value has REF_ISPACKED set).  So there are a couple options:
>>
>> * Always read loose references through the cache; that way there would
>> always be a ref_entry in which the return value could be presented.
>> This would not be a good idea at the moment because the loose reference
>> cache is populated one directory at a time, and reading a whole
>> directory of loose references could be expensive.  So before
>> implementing this, it would be advisable to change the code to populate
>> the loose reference cache more selectively when single loose references
>> are needed.  -> This approach would be well beyond the scope of this
>> patch series.
>>
>> * Implement a function like read_ref_full() with an additional (struct
>> ref_entry **entry) argument that is written to *in the case* that the
>> reference that was returned has a ref_entry associated with it, and NULL
>> otherwise.  This would have to be an internal function because we don't
>> want to expose the ref_entry structure outside of refs.c.
>> read_ref_full() would be implemented on top of the new function.
> 
> Isn't there another?
> 
> Instead of using read_ref_full() at this callsite, can it call a
> function, given a refname, returns a pointer to "struct ref_entry",
> using the proper "a loose ref covers the packed ref with the same
> name" semantics?
> 
> I guess that may need the same machinery for your first option to
> implement it efficiently; right now read_ref_full() goes directly to
> the single file that would hold the named ref without scanning and
> populating sibling refs in the in-core loose ref hierarchy, and
> without doing so you cannot return a struct ref_entry.  Hmm...

Yes, that's the crux.  Without the ref_cache, there is no persistent
ref_entry that can be returned to the caller.

Somewhere I have a prototype patch series (never submitted) that would
make it reasonable to access all references via the cache.  For single
reference accesses, it wouldn't read all of the loose references in the
whole directory but rather only create stub REF_INCOMPLETE ref_entries
for the refs that are not needed immediately.  These entries would be
filled when they are accessed.  There was also going to be a bulk read
command to be used when it is expected that the whole directory will be
needed.  With this change we really would have a ref_entry for every
reference and your suggestion would become plausible.  Someday...

But for the current issue it would be totally sufficient to return an
additional pointer to the ref_entry *if it is available*, because for
packed refs it will always be available.

Actually, for the current patch series I don't see the urgency of
changing *anything*.  The code works as is and is no worse than the old
code.  I'd rather do this change (if I get to it) in a separate series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
