From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Tue, 16 Apr 2013 22:22:57 +0100
Organization: OPDS
Message-ID: <2FE4D2171A03425AA9C8FF10140AC030@PhilipOakley>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org> <7v8v4k6hp2.fsf@alter.siamese.dyndns.org> <79879228B71A45A48A961F5B1880B61F@PhilipOakley> <7vli8k4lnj.fsf@alter.siamese.dyndns.org> <99AE5E981E2547B6A71A4D77B17167B9@PhilipOakley> <7v8v4imjji.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDL4-00059Y-VW
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965376Ab3DPVWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 17:22:50 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:35752 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965331Ab3DPVWu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 17:22:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar0NAMzAbVFOl3gj/2dsb2JhbAAuGAqDBokmuAUEAQMBgQoXdIIaBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcXBhMIAgECAwGIB6xDkDSNX1JqgmthA4hOhXSZWIMMOw
X-IronPort-AV: E=Sophos;i="4.87,487,1363132800"; 
   d="scan'208";a="572482320"
Received: from host-78-151-120-35.as13285.net (HELO PhilipOakley) ([78.151.120.35])
  by out1.ip06ir2.opaltelecom.net with SMTP; 16 Apr 2013 22:22:47 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221474>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, April 16, 2013 7:12 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> What kind of benefit are you envisioning out of this?
>>
>> The purpose of tests is to detect mistakes and spot regressions.
>>
>> A change to the 'git version X.Y.z' string would be a regression, as 
>> I
>> spotted earlier, as it conflicts with expectations of standard
>> programmes such as git-gui.
>
> Sorry, but I do not follow.
>
> A released version says "git version 1.8.2.1".  In a month or so,
> I'll have another one that says "git version 1.8.3".  Or I may
> decide to bump in preparation for 2.0 and it may identify itself as
> "git version 1.9".
>
> Neither of which no existing "program such as git-gui" has ever
> seen.
>
> In what way is that a regression?

But they both pass the test and test suite, yes? And even if you use 
git-gui with them, git-gui will not barf on start up, which it would if 
the version string fails my test.

Passing the test suite should be a reasonble guarantee that co-tools 
will work, including those that check for version. This is a check for 
that version string.

However if someone[1] creates "My Special Git Version 1-9-3 (Index 
V7b)", and here I'm suggesting they may have other special changes, then 
the version check will tell them that even when they have fixed their 
special changes to pass the other parts of the test suite, other 
co-tools could barf.

Its about pushing the piece of string from the users end ;-) It also 
stops others trying to change 'git' to 'Git' within this message, just 
as I did.

Philip
>
[1] my first draft had 'you', but that is not a reasonable starting 
position. It's more about *others* attempting to create release 
versions, which announce their name, that we expect to be compatible 
with say git-gui (via the rest of the test suite), and need to check 
that announcement. 
