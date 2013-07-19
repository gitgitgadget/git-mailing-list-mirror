From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] do_one_ref(): save and restore value of current_ref
Date: Fri, 19 Jul 2013 10:43:38 -0700
Message-ID: <51E97ACA.40300@alum.mit.edu>
References: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com> <1373901857-28431-1-git-send-email-mhagger@alum.mit.edu> <7voba04ir8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 19:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0EiY-0007yV-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 19:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760863Ab3GSRnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 13:43:42 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56793 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759971Ab3GSRnl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 13:43:41 -0400
X-AuditID: 1207440c-b7f016d000005997-95-51e97acce349
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 50.C0.22935.CCA79E15; Fri, 19 Jul 2013 13:43:40 -0400 (EDT)
Received: from [10.126.101.47] (204-16-157-26-static.ipnetworksinc.net [204.16.157.26])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6JHhc0i006656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Jul 2013 13:43:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7voba04ir8.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqHum6mWgwfKdChZdV7qZLBp6rzBb
	vGw/wOzA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M74dus+c0GzWMWbLeuYGxj3
	C3QxcnJICJhIvFyylgnCFpO4cG89WxcjF4eQwGVGiZNrNzBDONeZJG5M6WYGqeIV0JTontTI
	CGKzCKhKPJv4mw3EZhPQlVjU0ww0iYNDVCBM4spvVYhyQYmTM5+wgNgiAmoSE9sOgdnMAjES
	R86fAVssLOAh8fHrThaIXZsZJV5NXsAOkuAUMJNYu+8NM8hMZgF1ifXzhCB65SWat85mnsAo
	MAvJilkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERK4PDsY
	v62TOcQowMGoxMP74MvzQCHWxLLiytxDjJIcTEqivAcKXgYK8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuEtSAPK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeBmAESok
	WJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rT+GJgpIKkeID2KoC08xYXJOYCRSFa
	TzEac0w+u+U9I8eBH0BSiCUvPy9VSpxXFKRUAKQ0ozQPbhEsZb1iFAf6W5j3TyVQFQ8w3cHN
	ewW0igloleXU5yCrShIRUlINjIxnugIfmd77eH92qumvr1vMv0cFbNe4zxG1KvXm6vbEiByH
	Og6lD8vvyUTrTr9w85vd4dCrG6dM2dW+bIOOe0vnet1g/dYeTtsHxUwm3LxFj+7J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230833>

On 07/17/2013 09:03 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> If do_one_ref() is called recursively, then the inner call should no=
t
>> permanently overwrite the value stored in current_ref by the outer
>> call.  Aside from the tiny optimization loss, peel_ref() expects the
>> value of current_ref not to change across a call to peel_entry().  B=
ut
>> in the presence of replace references that assumption could be
>> violated by a recursive call to do_one_ref:
>>
>> do_for_each_entry()
>>   do_one_ref()
>>     builtin/describe.c:get_name()
>>       peel_ref()
>>         peel_entry()
>>           peel_object ()
>>             deref_tag_noverify()
>>               parse_object()
>>                 lookup_replace_object()
>>                   do_lookup_replace_object()
>>                     prepare_replace_object()
>>                       do_for_each_ref()
>>                         do_for_each_entry()
>>                           do_for_each_entry_in_dir()
>>                             do_one_ref()
>>
>> The inner call to do_one_ref() was unconditionally setting current_r=
ef
>> to NULL when it was done, causing peel_ref() to perform an invalid
>> memory access.
>>
>> So change do_one_ref() to save the old value of current_ref before
>> overwriting it, and restore the old value afterward rather than
>> setting it to NULL.
>>
>> Reported by: Mantas Mikul=C4=97nas <grawity@gmail.com>
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>=20
> Thanks.
>=20
> s/Reported by:/Reported-by:/ and lose the extra blank line after it?

ACK, sorry I got the notation wrong.

> I wonder if we can have an easy reproduction recipe in our tests.

I could reproduce the problem by following the recipe provided by Manta=
s
upthread (or at least something very close to it; I can't find the
script that I was using):

> git pack-refs --all --prune
> sed -i '/^[#^]/d' .git/packed-refs
> git replace -f HEAD $(git --no-replace-objects cat-file commit HEAD \
>     | sed 's/@/@test/' | git hash-object --stdin -t commit -w)
> ~/src/git/git describe

It would be good to document this in the commit message, but I don't
think it is necessary to have a test for it in the test suite because I
don't think it is the kind of bug that will reappear.

I sent the patch shortly before leaving for a trip so I didn't have tim=
e
to make it as complete as I would have liked.  But given that the
problem was already in master, and the fix is pretty simple, I wanted t=
o
send the fix right away.  When I have some time I can fix it up better,
or feel free to manhandle the patch and/or commit message yourself if
you prefer.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
