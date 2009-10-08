From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] perl/Makefile.PL: detect MakeMaker versions incompatible
 with DESTDIR
Date: Thu, 08 Oct 2009 08:34:34 -0500
Message-ID: <unyNhuV9VB06SYvOR8ONK47yVKPtJfgRVKs-sKMFc-8rKMQBz7DPnw@cipher.nrlssc.navy.mil>
References: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil> <FE_WTi0YAHrCrSdGFemlb7ALatFkdSu5V7Yfb5CUgyoxfv3ZFXdFABKbT1boP7aeGWli-gJPcBA@cipher.nrlssc.navy.mil> <4ACDE76C.4040307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, c@gryning.com,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 08 15:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvtG5-0002zr-1V
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 15:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310AbZJHNfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 09:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbZJHNfb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 09:35:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39887 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262AbZJHNfa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 09:35:30 -0400
Received: by mail.nrlssc.navy.mil id n98DYZ4A011309; Thu, 8 Oct 2009 08:34:36 -0500
In-Reply-To: <4ACDE76C.4040307@viscovery.net>
X-OriginalArrivalTime: 08 Oct 2009 13:34:35.0204 (UTC) FILETIME=[13358840:01CA481C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129692>

Johannes Sixt wrote:
> Brandon Casey schrieb:
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> It appears that ExtUtils::MakeMaker versions older than 6.11 do not
>> implement the DESTDIR mechanism.  So add a test to the generated perl.mak
>> to detect when DESTDIR is used along with a too old ExtUtils::MakeMaker and
>> abort with a message suggesting the use of NO_PERL_MAKEMAKER.
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>>
>>
>> This just reverses the logic in the test on $(MM_VERSION) so that the test
>> will also fail if MM_VERSION is unset.  Who knows if ancient versions set
>> it.  Sorry for the quick v2.
>>
>> -brandon
>>
>>
>>  perl/Makefile.PL |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
>> index 320253e..0b9deca 100644
>> --- a/perl/Makefile.PL
>> +++ b/perl/Makefile.PL
>> @@ -5,6 +5,14 @@ sub MY::postamble {
>>  instlibdir:
>>  	@echo '$(INSTALLSITELIB)'
>>  
>> +ifneq (,$(DESTDIR))
>> +ifeq (0,$(shell expr '$(MM_VERSION)' '>' 6.10))
> 
> I don't think the test works as intended, because 6.2 *is* greater than
> 6.10 (aka 6.1).

Hmm... I think you're right.

-brandon
