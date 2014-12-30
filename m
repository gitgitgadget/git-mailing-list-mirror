From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 1/9] receive-pack.c: add documentation for atomic push support
Date: Tue, 30 Dec 2014 04:09:54 -0500
Message-ID: <CAPig+cSuf0yXE1BE=tCTDrcxRMEZ_pU9VU_Q9F+Jxk-xNrPdgg@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-2-git-send-email-sbeller@google.com>
	<CAPig+cQ7GhrZqXH3zRYTWjwuWKwDNNwLRKG516dXS6et2TURgw@mail.gmail.com>
	<CAGZ79kZ_yiA7tMv49qp3OOMfOmwdaDtWs_Gt9V359xCKUE_SJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 10:10:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5soU-0007rG-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 10:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbaL3JJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 04:09:57 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:58703 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaL3JJz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 04:09:55 -0500
Received: by mail-yk0-f181.google.com with SMTP id 142so6974868ykq.40
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ej2VH3EE/QyEc6k/AM53QG72MHE90RIIvdzvSfhg7TE=;
        b=HQfZwK+baUokdSAbUYlk/QpJPD8K+eegs6oE2GYqrdrqzWDbSQ1Bdvum2bemGFb+57
         RBTfGWMIIAteKCQaw/iMthn+eQA5NWOgnRPsIWsrfuO0RGhoyWw/BHI2pYj6yPhfzoUa
         +pCaKWrjgXV+RvU2Dcl9VC1SXXU3zSs1V3xFW8UhOXr8N6cqShMx4q4BDLaH0CQkqyi3
         lj4udE2v+M36KFAYsvqx0JQJC/7glKhz0JB7r46rXSGPPnrBdPjHUsJau+RI4qlg8BMn
         crtGoZTO5DtJ4TrcNdTFAAR8TPehblu+z7+joBGQduLPAVewnHJj8q1hzZieYUOuVema
         K91g==
X-Received: by 10.170.127.5 with SMTP id t5mr27553213ykb.2.1419930594229; Tue,
 30 Dec 2014 01:09:54 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 01:09:54 -0800 (PST)
In-Reply-To: <CAGZ79kZ_yiA7tMv49qp3OOMfOmwdaDtWs_Gt9V359xCKUE_SJg@mail.gmail.com>
X-Google-Sender-Auth: rpV1lZNpThcjDIn3jRz7a4n4NcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261920>

On Tue, Dec 30, 2014 at 3:33 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Dec 29, 2014 at 11:08 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>>> Subject: receive-pack.c: add documentation for atomic push support
>> When Michael raised the issue of the server being "broken" due to
>> advertising a capability which it does not yet implement, his
>> recommendation[1] was to reorder the patches, not to split out the one
>> tiny bit (capability advertisement) from the larger change. Was there
>> an insurmountable conflict which prevented you from reordering the
>> patches? This is a genuine question since splitting off advertisement
>> -- and only advertisement -- to a patch later in the series smells
>> like a least-resistance approach, rather than a proper solution to the
>> issue Michael raised.
>
> Well there was no syntactical problem (i.e. the interactive rebase
> went flawless),
> but rather a semantic dependency. The reordered patches would not compile
> as we'd heavily depend on the use_atomic variable.
>
> Of course that could have been introduced where required, but at the
> time it did
> not look appealing to me.
>
> I'll reword the commit message header to mention the negotiation part as well.

This still smells like a least-resistance (lazy) approach. You
shouldn't need the stand-alone patch enabling "atomic" advertisement
just to address Michael's concern. His suggestion[1] to reorder the
patches sounds sensible and correct. Toward that end, moving the
declaration of 'use_atomic' to the patch where it is first needed
makes sense, even if the machinery for manipulating that variable
arrives with a later patch.

[1]: http://article.gmane.org/gmane.comp.version-control.git/261793
