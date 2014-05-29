From: Rodrigo Fernandes <rtfrodrigo@gmail.com>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 20:57:36 +0100
Message-ID: <CACJZPBs2_htD=zS1K3fOW+DZ323+2+iwupWuyNDArg2XF6Qx5g@mail.gmail.com>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
 <20140529161628.GB3763@sigill.intra.peff.net> <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
 <20140529194932.GA16665@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 29 21:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq6Sz-0008Dr-UT
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 21:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbaE2T6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 15:58:18 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:61884 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbaE2T6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 15:58:17 -0400
Received: by mail-yh0-f52.google.com with SMTP id z6so736465yhz.11
        for <git@vger.kernel.org>; Thu, 29 May 2014 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r6MtbMjwLu3PQon/eSGx2GuTU7jQltoMZjvENk9ectg=;
        b=owpPmYX+kMLBGTDkeGkFfWsbaH5ihSVkf3VIJyZRpHDJhcBI4xT1t8mN2iJSA0NOeg
         oQtRmCBQsWcEXOEFT6DkgbzwVN76Bd7lOUpwhNeD7CDlFlez0JAaXw9E/GSwkR4Dtxde
         Sy70HXuiaZLbNjjxKIBpGTPZx6oBdKbvs/OchpQZYUbOaegppXcRYypgPUOA178ACA8a
         J9GDjEqUJysYcd4odtkkzBRoOLqEI/NmO4Dgw+u2XkIaWERiyD45DiqkvTildex9aPH9
         LOOAEMTjM2QVNr8JdNuMsNgOBJN6h9+HzuHxzjpfhe1m0Zf5PfsdHXkpNqtTEguitrNp
         cQWA==
X-Received: by 10.236.185.167 with SMTP id u27mr13450697yhm.128.1401393496814;
 Thu, 29 May 2014 12:58:16 -0700 (PDT)
Received: by 10.170.51.136 with HTTP; Thu, 29 May 2014 12:57:36 -0700 (PDT)
In-Reply-To: <20140529194932.GA16665@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250406>

Jeff,
I have no idea what was the tool. The repo is not mine. I found the
problem when I was doing some tests and the commit parsing was failing
on that repo.

Cumprimentos,
Rodrigo Fernandes


On Thu, May 29, 2014 at 8:49 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 29, 2014 at 11:57:15AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > ...
>> > to at least make --format date output consistent with the rest of git
>> > (and to make "%at" consistent with "%ad" and --date=raw). That still
>> > doesn't address Rodrigo's concern, though (we would print "0 +0000").
>> [...]
>>
>> I actually am not very much interested in deciding what to show for
>> a broken timestamp.  An empty string is just as good as any random
>> cruft.
>
> I was thinking specifically of the first part I quoted above. We are not
> consistent between various methods of parsing/printing the date. That
> may fall into the "if were doing it from scratch..." category, though;
> it's possible that people currently using "--format=%ad" prefer and
> expect the empty string to denote a bogus value. I'm OK with leaving it.
>
>> I agree with you that it would be nice to have one escape
>> hatch to let the users see what garbage is recorded, if only for
>> diagnostic purposes, and DATE_RAW may be one good way to do so (but
>> I'd rather recommend "cat-file commit" for real diagnostics).
>
> Yeah, in case I wasn't clear, I don't actually like DATE_RAW as a way to
> do that. I'd prefer "--pretty=raw" or "cat-file commit", which already
> work.
>
>> I would be more interested to see whatever broken tool that created
>> such a commit gets fixed.  Do we know where it came from?
>
> I don't think it has been said yet in the thread. Rodrigo?
>
> -Peff
