From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH v2] perl/Makefile.PL: detect MakeMaker versions incompatible
 with DESTDIR
Date: Thu, 08 Oct 2009 11:58:57 -0500
Message-ID: <F3v6_n7wtTFWz8nzE5EpqB8ZsobXLax0nn_ghA5foHOvOJEMjHl0Qw@cipher.nrlssc.navy.mil>
References: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil> <FE_WTi0YAHrCrSdGFemlb7ALatFkdSu5V7Yfb5CUgyoxfv3ZFXdFABKbT1boP7aeGWli-gJPcBA@cipher.nrlssc.navy.mil> <4ACDE76C.4040307@viscovery.net> <unyNhuV9VB06SYvOR8ONK47yVKPtJfgRVKs-sKMFc-8rKMQBz7DPnw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, c@gryning.com,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:05:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwQN-0002bc-SM
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbZJHRAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbZJHRAW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:00:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40422 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbZJHRAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 13:00:21 -0400
Received: by mail.nrlssc.navy.mil id n98GwwWC029613; Thu, 8 Oct 2009 11:59:00 -0500
In-Reply-To: <unyNhuV9VB06SYvOR8ONK47yVKPtJfgRVKs-sKMFc-8rKMQBz7DPnw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 08 Oct 2009 16:58:57.0908 (UTC) FILETIME=[A059AB40:01CA4838]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129701>

Brandon Casey wrote:
> Johannes Sixt wrote:
>> Brandon Casey schrieb:

>>> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
>>> index 320253e..0b9deca 100644
>>> --- a/perl/Makefile.PL
>>> +++ b/perl/Makefile.PL
>>> @@ -5,6 +5,14 @@ sub MY::postamble {
>>>  instlibdir:
>>>  	@echo '$(INSTALLSITELIB)'
>>>  
>>> +ifneq (,$(DESTDIR))
>>> +ifeq (0,$(shell expr '$(MM_VERSION)' '>' 6.10))
>> I don't think the test works as intended, because 6.2 *is* greater than
>> 6.10 (aka 6.1).
> 
> Hmm... I think you're right.

I think we're safe.  Looks like the MakeMaker folks have always used two
digits for the minor number.  So version 6.2 was written like 6.02.

Here's their repo:

   git://github.com/schwern/extutils-makemaker.git

git log -p -- lib/ExtUtils/MakeMaker.pm | grep -- '$VERSION = ' | less

I didn't search exhaustively, but I think all of 6.X has two digit minor
numbers, which means all versions should compare correctly since 5.X will
always compare less than 6.X and 7.X will be greater, etc.

-brandon
