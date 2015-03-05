From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFH] GSoC 2015 application
Date: Thu, 5 Mar 2015 00:17:28 -0000
Organization: OPDS
Message-ID: <75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
References: <20150218191417.GA7767@peff.net><54E6C78D.3070506@alum.mit.edu><20150220072924.GC8763@peff.net><vpqpp94exb5.fsf@anie.imag.fr><70A3994196D94205B75660D9DEFF0A12@PhilipOakley> <CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Jeff King" <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Stefan Beller" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:16:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJSz-0001tO-M3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbbCEAQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:16:37 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:23123 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753284AbbCEAQg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 19:16:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AgHQAqn/dUPF8vFlxagwKBLIMLgy5tv2MEAoElTgEBAQEBAQUBAQEBOCAbhAoFAQEBAQIBCAEBGRUeAQEcBQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBYMvUqGU5QDLIEhiXGEboJvL4EUBZADXoZ0gxURjn+DQIQRPjGCQwEBAQ
X-IPAS-Result: A2AgHQAqn/dUPF8vFlxagwKBLIMLgy5tv2MEAoElTgEBAQEBAQUBAQEBOCAbhAoFAQEBAQIBCAEBGRUeAQEcBQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBYMvUqGU5QDLIEhiXGEboJvL4EUBZADXoZ0gxURjn+DQIQRPjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.11,344,1422921600"; 
   d="scan'208";a="585898904"
Received: from host-92-22-47-95.as13285.net (HELO PhilipOakley) ([92.22.47.95])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 05 Mar 2015 00:16:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264796>

From: "Stefan Beller" <sbeller@google.com>
> On Wed, Mar 4, 2015 at 2:05 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>
>> A possible idea is to add a date based variant of shallow clone :
>>
>>  'git clone --date <when> ...'
>>
>> in the same vein as the existing depth (shallow) clone.
>
> As food for thought:
> Maybe broaden this further up to the git-ish way of describing refs, 
> so
>
>    git clone --since 2.weeks.ago <url>
>    git clone --since v2.10 <url>
>    git clone --since c0ffee^^ <url>
>
> would all equally work?

The use of --since instead of --date would be an equally valid way of 
spelling the option (coders choice;-)

At the clone stage, the local Git can't determine (for the 2nd & 3d 
option) where such a revison is located, so would have to send the 
revision string to the server for processing, which could complicate the 
protocol. Hence my choice of a simple unix time value at the protocol 
level.

An alternate/addition is to use a nominated sha1 (from ls-remote) as a 
stand in for a date, allowing your option 2 (--since <tag>) to be 
implemented as an alias or script.

It all depends on how complicated we want it to become, but starting 
simple (though extensible) is important.

>
> I am not sure if that is feasible though, but it would come in handy. 
> (E.g.
> you are an end user and want to bisect down a bug which you notice in 
> the
> new version X but not in old version Y, so you start on getting the 
> sources,
> compiling, bisecting)
> --
Philip 
