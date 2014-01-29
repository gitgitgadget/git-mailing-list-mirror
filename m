From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: C standard compliance?
Date: Wed, 29 Jan 2014 23:00:20 -0000
Organization: OPDS
Message-ID: <3B29F809B09A46B38D4873721D0CCF06@PhilipOakley>
References: <87iot25y0r.fsf@fencepost.gnu.org><xmqqwqhiikpg.fsf@gitster.dls.corp.google.com> <87eh3q5x42.fsf@fencepost.gnu.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 30 00:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8e7P-0008Ve-DC
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 00:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaA2XAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 18:00:22 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:3893 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbaA2XAV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jan 2014 18:00:21 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhsZANeG6VJOl3Ob/2dsb2JhbABZFoJ2OIkStEwBAQIBAYECF3RpAQGBHwEBFAEEAQEBAQECCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGEwgCAQIDAYU4BwGCEyUJy0COf4MrgRQEiRGGGIoxiy+FPoMtPA
X-IPAS-Result: AhsZANeG6VJOl3Ob/2dsb2JhbABZFoJ2OIkStEwBAQIBAYECF3RpAQGBHwEBFAEEAQEBAQECCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGEwgCAQIDAYU4BwGCEyUJy0COf4MrgRQEiRGGGIoxiy+FPoMtPA
X-IronPort-AV: E=Sophos;i="4.95,744,1384300800"; 
   d="scan'208";a="434271803"
Received: from host-78-151-115-155.as13285.net (HELO PhilipOakley) ([78.151.115.155])
  by out1.ip04ir2.opaltelecom.net with SMTP; 29 Jan 2014 23:00:19 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241230>

From: "David Kastrup" <dak@gnu.org>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Hi, I am wondering if I may compare pointers with < that have been
>>> created using different calls of malloc.
>>>
>>> The C standard does not allow this (inequalities are only allowed
>>> for
>>> pointers into the same structure) to allow for some cheapskate sort
>>> of
>>> comparison in segmented architectures.
>>
>> Hmm... if you were to implement a set of pointers in such a way that
>> you can cheaply tell if an unknown pointer belongs to that set, you
>> would use a hashtable, keyed with something that is derived from the
>> value of the pointer casted to uintptr_t, I would think.
>
> The types intptr_t and uintptr_t are optional in ISO/IEC 9899:1999
> (C99).  So it would seem that I'd be covering fewer cases rather than
> more in that manner.
>
> I should think that architectures providing uintptr_t/intptr_t would
> have very little incentive _not_ to offer pointer inequalities
> equivalent to either the uintptr_t or intptr_t type conversion.
>
Undefined behaviours become hidden bugs of the future...
http://article.gmane.org/gmane.comp.version-control.git/230583

"blog on the problems of unexpected optimization bugs,
such as dereferencing a null pointer. "Finding Undefined Behavior Bugs
by Finding Dead Code" http://blog.regehr.org/archives/970 which links to
the draft of an interesting paper
http://pdos.csail.mit.edu/~xi/papers/stack-sosp13.pdf"

The code has now been released http://css.csail.mit.edu/stack/
https://github.com/xiw/stack/, and a few potential errors in Git were 
caught by that tool by Stefan Beller.

The key point of the paper was never to try to use an 'obvious', but
undefined, behaviour.

--
Philip
