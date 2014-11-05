From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Wed, 5 Nov 2014 13:35:21 -0000
Organization: OPDS
Message-ID: <D4F1F843014841509E8BFB9ACC7CDBCC@PhilipOakley>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net><xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com><20141030213523.GA21017@peff.net><FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley><xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com><20141101033327.GA8307@peff.net><F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley><xmqqmw88rvh3.fsf@gitster.dls.corp.google.com><20141103220408.GA12462@peff.net> <xmqq389zrguw.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 14:32:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm0hQ-0003fo-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 14:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbaKENcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 08:32:32 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:37508 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753888AbaKENcb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2014 08:32:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AskSAGAmWlRZ8YDkPGdsb2JhbABcgw6BLYc9gQTMJQQCgRcXAQEBAQEBBQEBAQE4IBuDfQUBAQEBAwgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcDFAYBEggCAQIDAYg0umaOJAEBAQEBBQEBAQEekRGDNIEeAQSLPYZkYpgHjA+BRD0vgksBAQE
X-IPAS-Result: AskSAGAmWlRZ8YDkPGdsb2JhbABcgw6BLYc9gQTMJQQCgRcXAQEBAQEBBQEBAQE4IBuDfQUBAQEBAwgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcDFAYBEggCAQIDAYg0umaOJAEBAQEBBQEBAQEekRGDNIEeAQSLPYZkYpgHjA+BRD0vgksBAQE
X-IronPort-AV: E=Sophos;i="5.07,319,1413241200"; 
   d="scan'208";a="759498604"
Received: from host-89-241-128-228.as13285.net (HELO PhilipOakley) ([89.241.128.228])
  by out1.ip01ir2.opaltelecom.net with SMTP; 05 Nov 2014 13:32:29 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, November 03, 2014 11:42 PM
> Jeff King <peff@peff.net> writes:
>
>> I peeked at libgit2 and I think it does not support bundles at all 
>> yet,
>> so that is safe. Grepping for "bundle" in dulwich turns up no hits,
>> either.
>>
>> Looks like JGit does support them. I did a very brief test, and it 
>> seems
>> to silently ignore a HEAD ref that has the NUL (I guess maybe it just
>> rejects it as a malformed refname).
>>
>> We could make JGit happier either by:
>>
>>   1. Only including the symref magic in ambiguous cases, so that 
>> regular
>>      ones Just Work as usual.
>>
>>   2. Including two lines, like:
>>
>>         $sha1 HEAD\0symref=refs/heads/master
>> $sha1 HEAD
>>
>>      which JGit does the right thing with (and git.git seems to, as
>>      well).
>
> Sounds sensible, even though it looks ugly X-<.
>
I believe that the 'two HEADs' mechanism would also fall foul of the 
'duplicate refs' warning (untested).

Philip 
