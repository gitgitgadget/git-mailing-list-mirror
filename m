From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] fast-import: Remove redundant assignment of 'oe' to itself.
Date: Tue, 28 May 2013 10:22:05 +0200
Message-ID: <ko1pfi$7f6$1@ger.gmane.org>
References: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com> <51A26BB7.3060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 10:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhFAx-0000wf-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 10:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933432Ab3E1IWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 04:22:30 -0400
Received: from plane.gmane.org ([80.91.229.3]:50359 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933383Ab3E1IW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 04:22:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UhFAo-0000kk-GL
	for git@vger.kernel.org; Tue, 28 May 2013 10:22:26 +0200
Received: from dsdf-4db53f95.pool.mediaways.net ([77.181.63.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 May 2013 10:22:26 +0200
Received: from jojo by dsdf-4db53f95.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 May 2013 10:22:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53f95.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225621>

Stefano Lattarini wrote:
> On 05/26/2013 10:05 PM, Stefan Beller wrote:
>> Reported by cppcheck.
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>> ---
>>  fast-import.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fast-import.c b/fast-import.c
>> index 5f539d7..0142e3a 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -2914,7 +2914,7 @@ static void cat_blob(struct object_entry *oe,
>>  unsigned char sha1[20]) static void parse_cat_blob(void)
>>  {
>>  const char *p;
>> - struct object_entry *oe = oe;
>>
> This was done on purpose, to avoid spurious warnings with (at least)
> some versions of GCC.
>
>> + struct object_entry *oe;
>>  unsigned char sha1[20];
>>
>>  /* cat-blob SP <object> LF */
>

This strange construct has been removed in other places meanwhile. It is 
violating C-standards (C89, C99) and as such causes warnings with other 
compilers, so this is fighting fire with fire. As it is a pointer it may be 
more sensible to initialize with NULL, should appease all compilers and 
still be correct.

Bye, Jojo 
