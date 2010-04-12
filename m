From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 16:28:37 +0800
Message-ID: <4BC2D9B5.6070400@drmicha.warpmail.net>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>	 <4BC2D61B.7050902@drmicha.warpmail.net> <n2ifbd9d3991004120123p7b08a8a2wee380454e9fe9a1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 10:28:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1F0d-00080d-VR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 10:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0DLI2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 04:28:39 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53492 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752372Ab0DLI2i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 04:28:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9B9C9EAEFD;
	Mon, 12 Apr 2010 04:28:37 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 12 Apr 2010 04:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9g7kNYt+SqqiQRQgllPj6JOB0qI=; b=HfhzkxVVM20jdzQPI28IbSATmWhnaoh/avd6B6FSu8vGCMoHrWAsNUSXsFQ8derJ0+CrfsNOdAkXew7CQzQ0iAayC0rRJqd80PUzcIM8vNP6fVEDD+0x/L4kBBQTlrQBaiEVc3ap98bR2UlQfwMV7n/gDSUQMYHJXqN5Ram7fD4=
X-Sasl-enc: csJxQUlewa0HTik3p8DjpKIegXQU5XIO8u/b2H2MTpur 1271060917
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19B664D56CE;
	Mon, 12 Apr 2010 04:28:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <n2ifbd9d3991004120123p7b08a8a2wee380454e9fe9a1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144712>

Stefan Hajnoczi venit, vidit, dixit 12.04.2010 16:23:
> On Mon, Apr 12, 2010 at 9:13 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> have you tried setting it to an empty value?
> 
> Yes I have tried it.  An empty string causes the SMTP auth Perl module
> to choke.  It expects a non-empty username and exits with an error.
> 
> On my system I have patched git-send-email to perform this check:
> 
> if (defined $smtp_authuser and length $smtp_authuser) {
> 
> This works but feels like a hack.  I think unset override could be
> useful for any git config option, not just sendemail.smtpuser.
> 
> I'm not familiar with git internals; do you have other suggestions for
> solving this issue?

I don't think it's possible to ignore/unset a specific global config
value right now, you can only change the path where that is looked for.
I see two ways to go forward:

- Change users of the config (such as git-send-email) to treat empty
values as unset values.

- Introduce a special value "unset" for config options.

Michael
