From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Tue, 08 Jan 2008 03:16:58 -0800
Message-ID: <47835BAA.3090100@freedesktop.org>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com>	<20071217195658.GB13515@fieldses.org>	<1197921847.27386.16.camel@localhost>	<20071217201219.GC13515@fieldses.org>	<1197922971.27386.32.camel@localhost>	<20071217205134.GB2105@coredump.intra.peff.net> <7vy7bt57wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Joe Perches <joe@perches.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 12:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCCZ2-00015R-HN
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 12:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbYAHLXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 06:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbYAHLXl
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 06:23:41 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:50498 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbYAHLXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 06:23:40 -0500
Received: (qmail 20498 invoked from network); 8 Jan 2008 11:16:58 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 8 Jan 2008 11:16:58 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080103)
In-Reply-To: <7vy7bt57wn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69866>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> Ah. The problem is that git-send-email unconditionally adds a
>> message-id. Usually git-format-patch doesn't add one, but for obvious
>> reasons, it must when doing --thread. Here is a fix.
> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 1d6f466..083466a 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -580,7 +580,7 @@ sub send_message
>>  		$ccline = "\nCc: $cc";
>>  	}
>>  	my $sanitized_sender = sanitize_address($sender);
>> -	make_message_id();
>> +	make_message_id() unless defined($message_id);
> 
> Isn't this called inside a loop?  If the outgoing message does not
> originally have "Message-Id:", does the loop correctly reinitialize
> $message_id to undef, or does this change make everybody reuse the same
> $message_id over and over again?
> 
> I have a feeling that --thread to format-patch is a misfeature.  Why is
> it needed if you are feeding the output to send-email?

I added that option; see (d1566f7883f727f38bf442af3fdb69d36e6fcea2,
cc35de8470541e389b7d2bdda4c901574720fa81, and
da56645dd7c1175fc2ed1628ac35fdd35e705641).  I use git-imap-send, not
git-send-email, and I wanted to thread my patches.

- Josh Triplett
