From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 17/33] repack_without_ref(): silence errors for dangling
 packed refs
Date: Wed, 17 Apr 2013 10:41:19 +0200
Message-ID: <516E602F.3090703@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-18-git-send-email-mhagger@alum.mit.edu> <7vhaj7vgk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USO2a-0003SK-1Z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab3DQIs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 04:48:27 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:50481 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751908Ab3DQIsY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 04:48:24 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2013 04:48:24 EDT
X-AuditID: 1207440d-b7fd06d000000905-02-516e6031cfa5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D4.E5.02309.1306E615; Wed, 17 Apr 2013 04:41:21 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3H8fJ0E013255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 17 Apr 2013 04:41:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vhaj7vgk6.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqGuYkBdo8Ga+vkXXlW4mi4beK8wW
	Kx/fZbb40dLD7MDi0f7+HbPHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdsfXMOpaC
	btWKZS9nsDQwNst1MXJySAiYSGx9+4gVwhaTuHBvPVsXIxeHkMBlRokr9+YwQjjHmSR2zV8O
	VsUroC3x5eArMJtFQFXifO8sNhCbTUBXYlFPMxOILSoQJrFq/TJmiHpBiZMzn7CA2CICahIT
	2w4B2RwczAIxEueuCoGEhQWiJJYf3QG1eAWjxJwpO8HmcAqYSdzsWAC2i1lAR+Jd3wNmCFte
	YvvbOcwTGAVmIVkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaU
	bmKEBDTvDsb/62QOMQpwMCrx8F4oyA0UYk0sK67MPcQoycGkJMpbEZcXKMSXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmEd34IUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCarwcEh
	sGbd6guMUix5+XmpShK830AWCBalpqdWpGXmlCCUMnFwgizikhIpTs1LSS1KLC3JiAfFcHwx
	MIpBUjxANzDHg9xQXJCYCxSFaD3FqMux8sqT14xCYDukxHlvgewQACnKKM2DWwFLa68YxYG+
	F+a9A1LFA0yJcJNeAS1hAlpyYFU2yJKSRISUVAPjlBYP/1Mur49t2H/nxPwrAucPdUUq/tkR
	5+WofL7kCltIsoKzgvBR7wUSdXe8rRiuKbGfFpmoHKCmqRNY9Y6Z1yTw0/mp5r0J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221522>

On 04/15/2013 07:39 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Stop emitting an error message for dangling packed references found
>> when deleting another packed reference.  See the previous commit for a
>> longer explanation of the issue.
>>
>> Change repack_without_ref_fn() to silently ignore dangling packed
>> references.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Somehow this feels as if it is sweeping the problem under the rug.
> 
> If you ignore a ref for which a loose ref exists when you update a
> packed refs file, whether the stale "packed" one points at an object
> that is still there or an object that has been garbage collected,
> you would not even have to check if the "ref" resolves to object or
> anything like that, no?
> 
> Am I missing something?
> 
> This one feels iffy in the otherwise pleasant-to-read series.

The usual situation when this code would be triggered would be that the
packed reference is overridden by a loose ref and points at an object
that has been garbage collected.  In that case it is definitely
incorrect to emit an error message.

But the fact that we don't explicitly verify that there is an overriding
loose reference means that it is possible that the failure to resolve
the packed ref comes from some kind of repository corruption, and you
are correct that such a problem would be swept under the rug by my change.

I've been trying to minimize the extra work that repack_without_ref()
needs to do to write peeled references, to avoid stretching out the
delay that can now occur when deleting a reference.  Thus I was trying
to save a check of loose references during this operation.  But I guess
I agree that a little bit more caution would be prudent.

I can think of a few ways to avoid sweeping possible indications of repo
corruption under the rug, in order of increasing run-time:

1. If a packed ref's SHA-1 cannot be resolved, write the packed ref to
the new packed-refs file anyway with SHA-1 but without a peeled value.
This would avoid having to check the loose references and avoid erasing
possible evidence of corruption, but would delay an actual check for
corruption until a later time.  It would be a quick fix, effectively
kicking the can down the road instead of sweeping it under the rug.

Minor pitfall: a reference that is listed without a peeled value in a
fully-peeled pack-refs file tells future readers that the corresponding
SHA-1 *cannot* be peeled.  IF the named object would somehow reappear in
the repository (e.g., via a fetch) and IF the object is peelable and IF
there is in fact no loose ref overriding the packed ref, then the final
result would be that one form of corruption (reference points to
non-existent object) would be converted to another form (reference
falsely believed to be non-peelable).  I think this is an acceptable
risk because (a) it would only happen in an unlikely series of events in
a repo that was already corrupt, and (b) because falsely believing a
reference to be non-peelable wouldn't have terrible consequences.

2. Whenever a packed reference cannot be resolved to an object, verify
that there is indeed a loose reference overriding it; if not, emit an
error and in either case omit the packed ref from the output.

3. Check for an overriding loose reference *before* trying to peel a
packed reference, and omit any overridden loose references from the
output packed-refs file.  This would be close to running "pack-refs
--no-prune" without the "is_tag_ref" test and with reuse of available
peeled values.  This approach would tidy up the packed-refs file a bit
more than (2) because it would cause the deletion of more overridden
packed refs, but only as part of first peeling them, which should only
happen once in a repo, and only if the first peeling occurs within
repack_without_ref() as opposed to an explicit pack_refs().  So it's a
negligible improvement over (2).

4. Further along the "correctness" spectrum, one could check for
overriding loose references *every* time the packed-refs file is
rewritten by repack_without_ref(), even for references whose peeled
values are already known.  But this would add overhead to every deletion
of a packed reference, which is probably not justified.

I'm worried that implementing 2-4 would introduce new race conditions of
the type that Peff discovered recently, unless we fix the locking policy
first (which is also on my TODO list).  So my suggestion is to implement
1 now and implement 2 sometime in the future.

Opinions?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
