From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 17:53:09 +0100
Message-ID: <4D5D5275.5070501@drmicha.warpmail.net>
References: <4D5CE3E7.5030101@atlas-elektronik.com> <4D5D1715.5020707@drmicha.warpmail.net> <4D5D1A04.4090107@atlas-elektronik.com> <4D5D1BCB.3010003@drmicha.warpmail.net> <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 17:56:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq79V-0002b9-BX
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 17:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab1BQQ4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 11:56:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60096 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856Ab1BQQ4T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 11:56:19 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A52AB20AE3;
	Thu, 17 Feb 2011 11:56:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Feb 2011 11:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QZL2W6iag5WH9QNAAzdRHldgb60=; b=kdO6RiLdeqRFkKeBIRYEI95v0D1u/+z7ZsfFLWKJXY6UNN5U7MndoZJ5aU3LPOlj1eOcr7pSET5BFoL6l49a6aQMujGtiZ4kdcm1/Jxt4XLQgZ23zGIIQqvg2Mnt/4R4PeuP0h2NILtPlYx54gYE+lgXa8LvenJr8I3nkCNGrho=
X-Sasl-enc: 62jBeT+SOdXSqfHrm8dTPP5g2MRUd7sHdE062Oqn0As1 1297961778
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0F079400F4A;
	Thu, 17 Feb 2011 11:56:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167093>

Sverre Rabbelier venit, vidit, dixit 17.02.2011 15:03:
> Heya,
> 
> [Thanks for summarizing.]
> 
> On Thu, Feb 17, 2011 at 12:59, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Sverre, with your 86ac751, the following two are equivalent (modulo a
>> warning) on a nonexisting dir:
>>
>> git clone dir
>> git init dir
>>
>> Is that intentional?
> 
> No, that was not intentional. The former should still be an error if
> 'dir' is an empy directory.
> 

Digging a little further: since a nonexisting directory is neither a dir
nor a file, clone thinks it is not local (is_local=is_bundle=0). None of
the transport_* commands error out since the relevant one is guarded by
86ac751...

Reverting that or forcing is_local=1 both help, but how to detect "local
nonexisting" reliably?

In fact, I don't have a problem with the current state if we document it :)

Michael
