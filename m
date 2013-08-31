From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 00/24] Index-v5
Date: Sat, 31 Aug 2013 07:23:26 +0200
Message-ID: <87vc2mo2lt.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <CACsJy8AkvUiJhjYVCuMrNwZPR7AiO-CZFazvOG-mVO=+Qq9O3Q@mail.gmail.com> <xmqq61uuo4dl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 07:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFdf0-000236-0y
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 07:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035Ab3HaFXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 01:23:41 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59748 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130Ab3HaFXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 01:23:40 -0400
Received: by mail-ie0-f177.google.com with SMTP id e14so4594595iej.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=QrBLiKU+g7/NOW1EPJUM4sIUfdpwl9wgF3j8NYX1WzI=;
        b=xL7PAzP7kjjM0QyDcn0lDcwTRIRkOsylZxw+6kKS8G/c5scJ34Qa9LWMV2km6Y/hu/
         9Wi1NNiSibXtB0DXzVwIWRD75GjYIHWpKRKwjOQX8O4bbgDL7jnRdTOjOWLiHNwRg4S6
         qU81vNoVRWemh0l9gLTI9gOpuqVF7+58rI/qLa6ACufNy4dk6kHjcWDQORUur+o10247
         tQSPGnFUbVMUu/vGgqhN98HG/74KR0ooGIWKkpe4pObYGSvKJjCyTilgYhLEQYfmTl84
         /at75z7rlRoc6gVlJh4FwDurv72FbtLegaaHTBNrUEq25HlJ1OEofDBSKxzT5PkF01Aw
         9Ppw==
X-Received: by 10.50.25.101 with SMTP id b5mr4892660igg.31.1377926620244;
        Fri, 30 Aug 2013 22:23:40 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id pk8sm9106732igb.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 22:23:39 -0700 (PDT)
In-Reply-To: <xmqq61uuo4dl.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233504>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Aug 19, 2013 at 2:41 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>
>> I'm done reviewing this version (I neglected the extension writing
>> patches because after spending hours on the main write patch I don't
>> want to look at them anymore :p). Now that rc period is over, with a
>> partial write proof-of-concept, I think it's enough to call Junio's
>> attention on the series, see if we have any chance of merging it. The
>> partial write POC is needed to make sure we don't overlook anything,
>> just support update-index is enough.
>
> I've been following the review comment threads after looking at the
> patches myself when they were posted. I was hoping to see some API
> improvement over the current "we (have to) have everything available
> in-core in a flat array" model, which gives a lot of convenience and
> IO overhead at the same time, that would make me say "yes, this
> operation, that we need to do very often, will certainly be helped
> by this new API, and in order to support that style of API better,
> the current file format is inadequate and we do need to go to the
> proposed tree like on-disk format" for at least one, but
> unfortunately I haven't found any (yet).
>
> So...

I think the issue is a bit different.  The current API, with some small
additions (e.g. read_index_filtered()) works well as in-memory format,
even for partial reading/writing.  I will try to write a POC for partial
writing to show that the current in-memory format works for this too.
As Duy wrote in the other email, some API changes will be necessary to
allow that, but not a big API change moving from a flat array to a tree
based format.

I think it comes down to "this operation will be helped by partial
loading/writing and we need this small API changes
(read_index_filtered() for now, more to follow) and the index format
change to be able to do that".

Does that make sense, with at least Duy's comments in the review
addressed and a POC for partial writing?
