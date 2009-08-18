From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:36:44 +0200
Message-ID: <4A8AE6AC.4090005@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <7vtz05dq0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSbD-0002ga-BR
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbZHRRfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbZHRRfp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:35:45 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:45119 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbZHRRfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:35:45 -0400
Received: by ey-out-2122.google.com with SMTP id 22so807323eye.37
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:35:45 -0700 (PDT)
Received: by 10.210.59.14 with SMTP id h14mr3414068eba.49.1250616945629;
        Tue, 18 Aug 2009 10:35:45 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 5sm522941eyh.46.2009.08.18.10.35.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 10:35:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7vtz05dq0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126425>

Junio C Hamano said the following on 18.08.2009 18:51:
> Marius Storm-Olsen <mstormo@gmail.com> writes:
> 
> Marius Storm-Olsen <mstormo@gmail.com> writes:
> 
>> +ARFLAGS = rcs\ # whitespace intentional
>> +COMPFLAG = -c
>> +COBJFLAG = -o\ # whitespace intended
>> +LOBJFLAG = -o\ # whitespace intended
>> ...
>> +ifneq (,$(findstring Microsoft Visual Studio, $(INCLUDE)))
>> +	CC = cl 
>> +	COBJFLAG = -Fo
>> +	LOBJFLAG = -OUT:
>> +	CFLAGS =
>>  git.o: git.c common-cmds.h GIT-CFLAGS
>> ...
>> -		$(ALL_CFLAGS) -c $(filter %.c,$^)
>> +		$(ALL_CFLAGS) $(COMPFLAG) $(COBJFLAG)git.o $(filter %.c,$^)
> 
> Since use of make implies use of shell, this makes me wonder if it would
> make sense to go one step further by giving msvc users a thin shell
> wrapper mcvc-cc that turns bog-standard cc command line into whatever cl
> uses.

That, of course, is also a feasible option :)
However, there are still things you wouldn't want to pass on to this 
script, for example, we don't pass on all the CFLAGS to the linker on 
Windows.

The "whitespace intended" in the patch are quite nasty though..

--
.marius
