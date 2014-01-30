From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of
 form local:remote
Date: Wed, 29 Jan 2014 16:40:37 -0800
Message-ID: <CA+55aFyWM+VDa4mdqseNy3tSnp23x=2sPtHf5KpxsfROeHbVGw@mail.gmail.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	<xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
	<xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 01:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8fgR-0004tt-KC
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 01:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbaA3Akj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 19:40:39 -0500
Received: from mail-vb0-f42.google.com ([209.85.212.42]:39985 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbaA3Aki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 19:40:38 -0500
Received: by mail-vb0-f42.google.com with SMTP id i3so1651013vbh.15
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 16:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NhhKrUx7lGgAr+pesZQ8NnLGvBAAj5rTAxbYCBU2ocU=;
        b=lKV7DfqV24kzMW0PQ1LTkPEOK+LYMSSyOUbhQF81F14OXjjEFw51qlJxIdFtXyiCjs
         5H2C9KsdpcMzEAhKxhUc5MCTB5Grqsw+MCVaqPub4CxEVvx3SGaAbxnAjwQZgRDQROwb
         SZhmeozMKyPPE3GN9JdZChqAmExRbc1Ra8GoIbHdWgmEhOwtMIBRFQXEWhapYe/4OIbI
         ZyS8Lo2hElctftl11NMoEPtMNtQsL1XiuqC3TrvZoRz+/LAyI+w1xlOTjbHB6Id2oaZp
         81v5PcyPRi2/XTop5yu215dY1/io1pyvVcKQhpHNHOq1X+bQJfDgoQC5nVBg3s21lhlo
         w06A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NhhKrUx7lGgAr+pesZQ8NnLGvBAAj5rTAxbYCBU2ocU=;
        b=bDDe4j3nrk2VAWq0K6n4r94rTpzR8vBRCsehMCzScDnc21zK+aOgL9Wu7rCsWHc3Ud
         SxOG/ow0MOrzB2VhY1qUA7GvHCnduMdkyKZxBjxKRO5fimKnvPdoxwD+5ifOFwLw9dK3
         wBdQ472j/QblvlRhsJ9XGcPyvamW75j5EPR5A=
X-Received: by 10.52.170.241 with SMTP id ap17mr7551592vdc.13.1391042437457;
 Wed, 29 Jan 2014 16:40:37 -0800 (PST)
Received: by 10.221.8.73 with HTTP; Wed, 29 Jan 2014 16:40:37 -0800 (PST)
In-Reply-To: <xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
X-Google-Sender-Auth: JREkQJUsIVbM7TV8jo5k6jVWtig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241235>

On Wed, Jan 29, 2014 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I am not yet doing the docs, but here is a minimal (and I think is
> the most sensible) fix to the "If I asked a tag to be pulled, I used
> to get the message from the tag in the output---the updated code no
> longer does so" problem.

That was a complete oversight/bug on my part, due to just removing the
tag_name special cases, not thinking about the tag message.

Thinking some more about the tag_name issue, I realize that the other
patch ("Make request-pull able to take a refspec of form
local:remote") broke another thing.

The first patch pretty-printed the local branch-name, removing "refs/"
and possibly "heads/" from the local refname. So for a branch, it
would ask people to just pull from the branch-name, and for a tag it
would ask people to pull from "tags/name", which is good policy. So if
you had a tag called "for-linus", it would say so (using
"tags/for-linus").

But the local:remote syntax thing ends up breaking that nice feature.
The old find_matching_refs would actually cause us to show the "tags"
part if it existed on the remote, but that had become pointless and
counter-productive with the first patch. But with the second patch,
maybe we should reinstate that logic..

                Linus
