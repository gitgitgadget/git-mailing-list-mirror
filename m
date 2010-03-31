From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Wed, 31 Mar 2010 10:45:54 +0200
Message-ID: <d2d39d861003310145i3ee2422bn83946d465d375185@mail.gmail.com>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
	 <7vfx3hqsaf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 10:46:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwtYt-0003bz-HL
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 10:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab0CaIp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 04:45:58 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36609 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab0CaIp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 04:45:56 -0400
Received: by fxm5 with SMTP id 5so5340974fxm.29
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=gWk3Cu3yqzptkmnTJVO2qcuLklANLEq/jCOf1KveoQo=;
        b=iTMezc+knvUrkMmt6ddBJZSiqC+uOfkU//9OIq9lpeErOBCFl2Vyq3vjjsaPl4IJBR
         kngBEzc53Q5VV2UcOfLIMAF6MYSzTqdOF9PQ64v631P4XJg1PQEXrX4OT3oojCYxcilk
         DnISNxfbToSB9nN3UJeRYLkolBOH3i1UVVfHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=XAz6FCtTxQXhpfqlD6kD61bHIrrdP/d7jfO3iHpe9x68NpEbd/HNjpALEr5rmx4kpC
         sQKPSWX3j3gRhJp4muPkr//vq0UHzqrW77EG5rrS2haloKlALkFDd6fDge/DtYfuv2S6
         BpJlEi4np1UKeAP3oPlStNyQTNELbPbVMUpso=
Received: by 10.239.138.80 with HTTP; Wed, 31 Mar 2010 01:45:54 -0700 (PDT)
In-Reply-To: <7vfx3hqsaf.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 86aa450d4e2ccac0
Received: by 10.239.186.13 with SMTP id e13mr705158hbh.27.1270025154291; Wed, 
	31 Mar 2010 01:45:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143652>

On 31/03/2010, Junio C Hamano <gitster@pobox.com> wrote:
> Tor Arntsen <tor@spacetec.no> writes:
>
>> Patch included below, as well as attached (in case of
>> mailler-mangling). Please let me know if you feel there are any issues
>> with it.
>
> Thanks.
>
>> From d4a5ba0727d7e3a4455320bad641cb34402d16fd Mon Sep 17 00:00:00 2001
>> From: Tor Arntsen <tor@spacetec.no>
>> Date: Tue, 30 Mar 2010 19:36:40 +0200
>> Subject: [PATCH] Add Tru64/OSF1 support in Makefile
>>
>> Tested with V5.1
>
> V5.1 "of Tru64/OSF1" I presume...

Indeed. uname -r = V5.1. The system I have, and have thus tested this
with, is actually Tru64 V5.1a, although the 'a' isn't easily visible.
There's also a V5.1b revision, in addition to V5.2 and possibly even
newer systems.

>> +ifeq ($(uname_S),OSF1)
>> +	# Tested with V5.1 w/libcurl and zlib-1.1.4-5 in /usr/local/
>> +	CC = cc
>> +	CFLAGS = -O2 -g3
>
> Is this because the compiler there does not like -Wall?
>
> Not a complaint; just a request for clarification.

Two issues: -Wall, and that the native Tru64 compiler refuses to
optimize if -O2 is combined with -g. Thus the -O2 -g3, which does
work, and (and this is incidentally also the case for the IRIX MIPSPro
compiler).

$ cc -g -O2 -o hello hello.c
cc: Info: File not optimized; use -g3 if both optimization and debug
wanted. (suppressoptlvl)

-Tor
