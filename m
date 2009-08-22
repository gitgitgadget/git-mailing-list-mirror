From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 09/14] Avoid including windows.h in winansi.c for MSVC 
	build
Date: Sat, 22 Aug 2009 13:40:15 +0200
Message-ID: <18cd41840908220440o37cf0909l15ff552abd52e075@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
	 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
	 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
	 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
	 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
	 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
	 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
	 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
	 <7vmy5sdgoc.fsf@alter.siamese.dyndns.org>
	 <3f4fd2640908211416i489b6e23s27cb9cae6a439ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 13:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeoxQ-0000jt-FT
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 13:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbZHVLkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 07:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbZHVLkR
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 07:40:17 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56036 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbZHVLkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 07:40:15 -0400
Received: by ewy3 with SMTP id 3so1251083ewy.18
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Gk10YOkyF4odEgDknMQiPJ2guYlzIvBcvn5qJvAKZ74=;
        b=eknzyA8fB3mg7VxViCYQu9ho0JcUbQadbNlJlqHDSvpqiXKW400RLtwH/EiWXsoqBR
         wkFS6Ijq28LhRc+giDbP1BP8fnxgOcg85Yd8T3k9SDJLFZu/bbPcjxdxReutN2e+C2D/
         FMlSB3X+Iaes40j5yAJOkq5fywRnpl2/8myT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kgNrITQeLRC5UT0stOoRtSi+/Idbj6eZziiHlv0uIENUONF3E3/ALO5W8/4UuEFcjW
         u03rhQCi1r++na5bOoFxHC1a1R4GneP4ZpvKaqOrT92agPCb5tyM/DpHRPUaNLMr0Lk/
         BBMKlTxkgIal0teZtB/2P28Fezm5FQcpbWPwE=
Received: by 10.216.86.139 with SMTP id w11mr439707wee.10.1250941216011; Sat, 
	22 Aug 2009 04:40:16 -0700 (PDT)
In-Reply-To: <3f4fd2640908211416i489b6e23s27cb9cae6a439ddc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126808>

On Fri, Aug 21, 2009 at 11:16 PM, Reece Dunn<msclrhd@googlemail.com> wrote:
> 2009/8/21 Junio C Hamano <gitster@pobox.com>:
>> Marius Storm-Olsen <mstormo@gmail.com> writes:
>>
>>> From: Frank Li <lznuaa@gmail.com>
>>>
>>> compat/msvc.h includes winsock2.h which conflicts with windows.h.
>>> msvc.h also defines the oldest Windows API version required.
>>
>> The first sentence sort-of makes sense; compat/msvc.h will be included by
>> git-compat-util.h and including <windows.h> here will bring conflicting
>> definitions, so we avoid doing so when on MSC.
>>
>> The second sentence does not make any sense to me.  It may be correctly
>> stating a fact (i.e. "defines required WAPI version"), but it is unclear
>> what relevance it has to this change to stop including <windows.h>.
>
> The way things are configured, windows.h is pulling in winsock.h. In
> git-compat-util.h, winsock2.h is included which has conflicting
> definitions of various functions and data structures.
>
>> Having said that, the first sentence hints me that perhaps you guys should
>> include (conditionally only on windows but not with MSC) <windows.h> not
>> from this file, but from git-compat-util.h?
>
> It would make sense for windows.h to be included in git-compat-util.h.
>
> According to http://social.msdn.microsoft.com/Forums/en-US/windowssdk/thread/4a90b143-1fb8-43e9-a54c-956127e0c579,
> the following will work:
>
> #define _WINSOCKAPI_    // stops windows.h including winsock.h
> #include <winsock2.h>
> #include <windows.h>
>
> Also, if you define WIN32_LEAN_AND_MEAN, windows.h will pull in a
> subset of the Windows header files (which also improves compilation
> times). Adding this may prevent it from pulling in winsock.h. This
> would be a better approach (and would make sense to go into
> git-compat-util.h).
>
> I don't have access to a Windows dev box at the moment, so can't
> verify that this does indeed work.
>
> - Reece
>

I'll check this on Monday, and send out a v3 of the series,
incorporating the pieces commented on, and clarifying some of the
still confusing commit msgs.

--
.marius
