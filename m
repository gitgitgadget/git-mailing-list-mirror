From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Wed, 5 Nov 2014 23:50:14 -0000
Organization: OPDS
Message-ID: <05777A2415DD49F78B81EEA886A98F48@PhilipOakley>
References: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com> <20141030213523.GA21017@peff.net> <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley> <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com> <20141101033327.GA8307@peff.net> <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley> <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com> <20141103220408.GA12462@peff.net> <xmqq389zrguw.fsf@gitster.dls.corp.google.com> <D4F1F843014841509E8BFB9ACC7CDBCC@PhilipOakley> <20141105193557.GA12620@peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 00:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmAKu-00075M-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 00:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaKEXt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 18:49:56 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:19862 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbaKEXtz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2014 18:49:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ag0TADu3WlRcDxlMPGdsb2JhbABbgw6BLYMGhDeBBMwnBAKBHBcBAQEBAQEFAQEBATggG4N9BQEBAQECAQgBARkVHgEBIQUGAgMFAgEDDgcDAgIFIQICFAEEGgYHAxQGEwgCAQIDAYgnDbcZhwKOWYEtj2SCfjaBHgWSIWKYCYwPgUQ9L4JLAQEB
X-IPAS-Result: Ag0TADu3WlRcDxlMPGdsb2JhbABbgw6BLYMGhDeBBMwnBAKBHBcBAQEBAQEFAQEBATggG4N9BQEBAQECAQgBARkVHgEBIQUGAgMFAgEDDgcDAgIFIQICFAEEGgYHAxQGEwgCAQIDAYgnDbcZhwKOWYEtj2SCfjaBHgWSIWKYCYwPgUQ9L4JLAQEB
X-IronPort-AV: E=Sophos;i="5.07,322,1413241200"; 
   d="scan'208";a="15131849"
Received: from host-92-15-25-76.as43234.net (HELO PhilipOakley) ([92.15.25.76])
  by out1.ip02ir2.opaltelecom.net with SMTP; 05 Nov 2014 23:49:53 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Wed, Nov 05, 2014 at 01:35:21PM -0000, Philip Oakley wrote:
>
>> >>  2. Including two lines, like:
>> [...]
>> I believe that the 'two HEADs' mechanism would also fall foul of the
>> 'duplicate refs' warning (untested).
>
> It didn't in my very brief testing of what I posted above, but maybe
> there is some other case that triggers it that I didn't exercise.

I'd been testing the inclusion of a duplicate of the ref that matched 
the HEAD symref (rather than HEAD itself), and had hit that message a 
few times, hence my concern.
>
> I grepped through the code and the only "duplicate ref" warning I see
> comes from the refs.c code, which comes from commit_packed_refs().

I had it from is_dup_ref(), also in refs.c, though I may have followed 
the call stack incorrectly back to the bundle effects.

> If
> the duplicate line is HEAD, I think it shouldn't trigger that, as it 
> is
> not a regular ref. That would explain why I didn't see it in my 
> testing.

I've now also done a test and found the same (no warning/error) when 
there are two HEADs listed in the bundle preamble. Sorry for the 
confusion.

--
Philip
