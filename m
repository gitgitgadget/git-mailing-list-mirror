From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 04/17] Makefile: a dry-run can error out if no perl. Document the issue
Date: Thu, 25 Jun 2015 20:33:04 +0100
Organization: OPDS
Message-ID: <DBFC4D88D6F34023BA43F5F10134331E@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org><1435190633-2208-5-git-send-email-philipoakley@iee.org> <xmqq8ub724ls.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"MsysGitList" <msysgit@googlegroups.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 21:30:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8CrR-0000ps-FV
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 21:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbFYTax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 15:30:53 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:22423 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753042AbbFYTav (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 15:30:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CPOQBmVYxVPHK/BlxVBoMRVF+HObEvhXEfCoVuBAEDAQGBP00BAQEBAQEHAQEBAUEkG0EDg1kFAQEBAQIBCAEBLhYIAQEhCwIDBQIBAxUMJRQBBBgCBgcDFAYICwgCAQIDAQoCBIgGDAm/H493LItKhENDgx6BFAWMFDeHOwGBA4NUiDRChluPYoEJgVqBPj0xAYJHAQEB
X-IPAS-Result: A2CPOQBmVYxVPHK/BlxVBoMRVF+HObEvhXEfCoVuBAEDAQGBP00BAQEBAQEHAQEBAUEkG0EDg1kFAQEBAQIBCAEBLhYIAQEhCwIDBQIBAxUMJRQBBBgCBgcDFAYICwgCAQIDAQoCBIgGDAm/H493LItKhENDgx6BFAWMFDeHOwGBA4NUiDRChluPYoEJgVqBPj0xAYJHAQEB
X-IronPort-AV: E=Sophos;i="5.13,679,1427756400"; 
   d="scan'208";a="554797163"
Received: from host-92-6-191-114.as43234.net (HELO PhilipOakley) ([92.6.191.114])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 25 Jun 2015 20:30:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272716>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> A 'make -n' dry-run is used as part of the /compat/vcbuild and
>> /contrib/buildsystems code. The commit ee9be06 (perl: detect new 
>> files
>> in MakeMaker builds, 2012-07-27) was not aware of that dry-run usage
>> and thus would not execute the target.
>>
>> Add a comment to the make file stating the issue and the available
>> solutions of either NO_PERL or a '+recipe'.
>
> I am not sure what this patch is trying to achieve.

It was probably a bit of 'don't mess with working code', given that I'd 
used the NO_PERL solution, rather 'document the issue'. The issue had me 
stuck for a while. The possible use of '+' came later when driving down 
through the Makefile manual.

>
> If you are not touching what this Makefile actually does, then I
> would imagine that you are running the "buildsystems code" that
> actually drives 'make -n' with some "available solution" (perhaps
> you are running 'make -n NO_PERL=NoThanks' or something like that)?
> Then instead of a command like this that nobody would read in this
> file, the same command can instead go there to explain what the
> "workaround" (e.g. unusual-looking 'make -n NO_PERL=NoThanks') is
> doing?
>
> I suspect you mean by +recipe that you modify this makefile to make
> such a workaround unnecessary?  If that is the case, why isn't such
> a change actually be done with this commit, instead of a comment?

Yes.  See above about the lack of 'fearless coding'; been working in 
real world engineering too long ;-)

>
> I am not sure what this patch is trying to achieve.
>
> Puzzled...
>
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Makefile | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 149f1c7..22108bb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1746,6 +1746,9 @@ $(SCRIPT_PERL_GEN): perl/perl.mak
>>
>>  perl/perl.mak: perl/PM.stamp
>>
>> +# 'make -n' (dry-run) will not execute this target which 
>> creates/updates the PM.stamp file.
>> +# To avoid the error of failing to find the target PM.stamp, either 
>> use NO_PERL=1 (YesPlease),
>> +# or add a leading '+' to the recipe '+$(QUIET_GEN)$(FIND) perl ...' 
>> so that it is executed.
>>  perl/PM.stamp: FORCE
>>  @$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
>>  { cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
>> -- 
>> 2.3.1
>>
>> -- 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
