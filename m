From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 23:45:17 -0000
Organization: OPDS
Message-ID: <B10A5C9F770D48C9958F240D59B1A400@PhilipOakley>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com> <50F3F852.8060800@viscovery.net> <7v622zbn3s.fsf@alter.siamese.dyndns.org> <vpqobgrpoh7.fsf@grenoble-inp.fr> <CAMoGvRKMwP_JBvNNWoN=m9AX3MP9xVgBUwxELHtry_-8Um8WKQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>, "git" <git@vger.kernel.org>
To: "George Karpenkov" <george@metaworld.ru>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tutif-00011s-K8
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 00:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074Ab3ANXpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 18:45:09 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:54203 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755800Ab3ANXpI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 18:45:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhAFAGuA9FBcHIm8/2dsb2JhbABEFothrk2DNhdzghkFAQEEAQgBAS4eAQEhCwIDBQIBAxUBAgklFAEEGgYHFwYBEggCAQIDAYgCCrVnjlKBe2EDiCyFUZNIhQ+CaA2BZiQ
X-IronPort-AV: E=Sophos;i="4.84,468,1355097600"; 
   d="scan'208";a="415710560"
Received: from host-92-28-137-188.as13285.net (HELO PhilipOakley) ([92.28.137.188])
  by out1.ip01ir2.opaltelecom.net with SMTP; 14 Jan 2013 23:45:06 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213544>

From: "George Karpenkov" <george@metaworld.ru>
Sent: Monday, January 14, 2013 10:57 PM
> Thanks everyone!
>
> Progress so far:
>
> After executing reverse sed command:
> find .git -name '*.*' -exec sed -i 's/    /\t/g' {} \;

Have you counted how many substitutions there are in the pack file(s). 
It may be sufficiently small that you can  simply try all the possible 
combinations of fwd and reverse substitutions. Even if it takes a few 
days the computer won't get bored ;-)

>
> And trying to switch the branch I get:
>
>> git checkout X
>
> error: failed to read object 51a980792f26875d00acb79a19f043420f542cfa
> at offset 41433013 from
> .git/objects/pack/pack-8d629235ee9fec9c6683d42e3edb21a1b0f6e027.pack
> fatal: packed object 51a980792f26875d00acb79a19f043420f542cfa (stored
> in .git/objects/pack/pack-
> 8d629235ee9fec9c6683d42e3edb21a1b0f6e027.pack) is corrupt
>
> So the actual .pack file is corrupt, unfortunately.
>
> On Tue, Jan 15, 2013 at 6:13 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Everybody seems to be getting an impression that .idx is the only
>>> thing that got corrupt.  Where does that come from?
>>
>> It's the only thing that appear in the error message. This does not
>> imply that it is the only corrupt thing, but gives a little hope that 
>> it
>> may still be the case.
>>
>> Actually, I thought the "read-only" protection should have protected
>> files in object/ directory, but a little testing shows that "sed -i"
>> gladly accepts to modify read-only files (technically, it does not
>> modify it, but creates a temporary file with the new content, and 
>> then
>> renames it to the new location). So, the hope that pack files are
>> uncorrupted is rather thin unfortunately.
>>
>> --
>> Matthieu Moy
>> http://www-verimag.imag.fr/~moy/
> --
