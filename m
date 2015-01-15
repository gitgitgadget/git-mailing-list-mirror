From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: reword --author error message
Date: Thu, 15 Jan 2015 15:40:38 +0100
Message-ID: <54B7D166.8090608@drmicha.warpmail.net>
References: <54B7CCCD.1070708@drmicha.warpmail.net> <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net> <20150115143120.GA16736@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBlbJ-0000vq-DX
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 15:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbbAOOkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 09:40:41 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41113 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012AbbAOOkk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 09:40:40 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 451BE213A9
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:40:40 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 15 Jan 2015 09:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=NSBfXo6ZJ9hZ6Y1OoW7zsk
	hV5YI=; b=e1dc7zKBdmf6LgaYF9WXgQfqmrCOdGtiwql/C6NRyYZyQ9FUIWQQTC
	PNMTJkdklKZEKHqQOQ0Owx7InEMf6QHC6wcIXZh0hpM9ZPomXQ5Lqe/zI2Faz4dF
	q56RUteW/I0JdF3/pijQwDlmx4rFRoy868Zark0gb39zRMBcnuFGc=
X-Sasl-enc: /YTJXOS9szCwdSzvlgNDvk8lR2S5B5GDeK+PNeui7USF 1421332839
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A104B6800AE;
	Thu, 15 Jan 2015 09:40:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150115143120.GA16736@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262483>

Jeff King schrieb am 15.01.2015 um 15:31:
> On Thu, Jan 15, 2015 at 03:23:08PM +0100, Michael J Gruber wrote:
> 
>> If an --author argument is specified but does not contain a '>' then git tries
>> to find the argument within the exiting authors; and gives the error
>> message "No existing author found with '%s'" if there is no match.
>>
>> This is confusing for users who try to specify a valid complete author
>> name.
>>
>> Rename the error message to make it clearer that the failure has two
>> reasons in this case:
>> "Bad --author parameter '%s': neither completely wellformed nor part of
>> an existing one"
> 
> I really like the intent of this patch, but I actually find the new
> message even more confusing.

The main observation is that the current error message is given only
when both interpretations (complete ident, match ident) fail, and the
error message conveys only one when it should do both. I don't care
about the wording either.

> Is this a time when we could use hint() to give a multi-line explanation
> (and probably a matching advice.* config)? Like:
> 
>   hint: If the --author parameter contains angle brackets ("<>"), it
>   hint: is treated as a literal name/email pair to use. If not, then
>   hint: the history is searched for an existing matching author.
> 
> or something?
> 
> -Peff
> 

Well, this basically copies the man page paragraph for that option. I
don't want to set a(nother) precedent for doing this and create yet
another config knob.

The alternative would be to just say "Bad --author parameter '%s'" (or
"Invalid..."), as we do in most cases, and force the user to check the
man page for the definition of "valid". I'm beginning to prefer this
minimalistic approach...

Michael
