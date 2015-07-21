From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Tue, 21 Jul 2015 23:48:48 +0100
Organization: OPDS
Message-ID: <11647308F0684851A72DDF51A486D11D@PhilipOakley>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org><1437416790-5792-5-git-send-email-philipoakley@iee.org><xmqqoaj6y50b.fsf@gitster.dls.corp.google.com><996C8C8A69844E44890D09811C57DAC8@PhilipOakley><xmqqa8uqxxpn.fsf@gitster.dls.corp.google.com> <xmqq615exwou.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 00:48:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHgKU-0001sd-4z
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 00:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbbGUWsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 18:48:00 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:14613 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755925AbbGUWsA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 18:48:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2D7CQDBy65VPAO4BlxcGYJ8VGmGUW22T4V/BAQCgUZNAQEBAQEBBwEBAQFBJBuEHgUBAQEBAgEIAQEuHgEBIQUGAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAQqICwy8VZAIi0yEIxEBUYMegRQFjDg4h2MBgQ2DZ4h4RpMkg2GBCWYBC4IoPTGBDYE+AQEB
X-IPAS-Result: A2D7CQDBy65VPAO4BlxcGYJ8VGmGUW22T4V/BAQCgUZNAQEBAQEBBwEBAQFBJBuEHgUBAQEBAgEIAQEuHgEBIQUGAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAQqICwy8VZAIi0yEIxEBUYMegRQFjDg4h2MBgQ2DZ4h4RpMkg2GBCWYBC4IoPTGBDYE+AQEB
X-IronPort-AV: E=Sophos;i="5.15,519,1432594800"; 
   d="scan'208";a="794517723"
Received: from host-92-6-184-3.as43234.net (HELO PhilipOakley) ([92.6.184.3])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 21 Jul 2015 23:47:56 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274433>

From: "Junio C Hamano" <gitster@pobox.com>
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I was trying to use, essentially, 'cat list.txt' as the command,...
>
> One thing that needs to be made clear is that I do not think we want
> to encourage `cat list.txt #` abuse in the first place.

OK [1]

>   It is an
> unacceptable hack for us to encourage in the longer term.  It may
> happen to work with the current implementation, but it does so
> merely by depending on the implementation too much.
>
> If it is so common to want to spray all your patches to exactly the
> same list of recipients that is unconditionally determined, having

It wasn't 'unconditional spraying' ;-), rather I'd carefully select who 
to send to for each series, previously with multiple cc=".." on the 
command line.

> multiple sendemail.cc configuration variables, which are cumulative,
> is already one way to do so, and you do not have to type such a long
> option "--cc-cmd='cat $filename'" every time.
>
> And if you do not want configuration for some reason, and having a
> list of addresses in a flat file is so common, we could have a new
> option "--cc-list=$filename" to support that use case.  I however
> doubt anything that starts with "First you make a list of addresses
> in a flat file, and then do this" is a good solution.

For a longer series, a list will still need collating by the OP somehow, 
but I don't think that alone would justify a new option.

>
> I would think that it would probably be the best way to address "I
> often want to cc these recipients, but not always" is to keep a list
> of aliases, each entry of which expands to the recipients, and say
> "--cc=group" from the command line to have it expanded to the set of
> recipients.
>
[1] You mentioned in the previous email the script command argv[] array, 
which I  hadn't heard of (for a script), having been used the $1, $2, 
method.

Given that new understanding, IIUC the proposal is that the garantee is 
the "--cc-cmd" should be a single command/script name, with the 
patchfilename passed as $1, and that a 'string string' for 
interpretation would now be deprecated.

I'll see about a shorter doc patch that restricts itself to just the 
base aspects, if that would be acceptable?
--
Philip
