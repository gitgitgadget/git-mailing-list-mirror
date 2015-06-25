From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Thu, 25 Jun 2015 06:07:44 -0700
Message-ID: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
	<1435062855-26274-1-git-send-email-pclouds@gmail.com>
	<xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
	<CACsJy8Ap4uNi3gXV8Y+S18xtLaZ1R6DscEf7wJKjt59ZLOAJ5Q@mail.gmail.com>
	<xmqqzj3p9gv7.fsf@gitster.dls.corp.google.com>
	<CACsJy8AVeGxOS4pWfkcbPnxRQ0-gJRC7B1NSs+Ci81x46ieDzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Patrick Higgins <phiggins@google.com>,
	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 15:08:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z86sr-0006Nz-Pg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 15:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbbFYNH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 09:07:57 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33437 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbFYNH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 09:07:56 -0400
Received: by igbqq3 with SMTP id qq3so14001402igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=THnmMaUFGVKg9g1wEmdZ9tKEby+KaYjfaKmn+flsPBA=;
        b=X8XnzHiV3DtgLR+H/kyfSl071BHLHLuydtn5syNrq5TEG3pNlF4mX7koOAMzrlEtc/
         W2YCfCumrN4VjN/kizx10Eyo73FYVJKwYvGYjBBQxVkU1CwpIo7Eoo7753YpKhTWEIXo
         SI7z/ZUOnljBAi2Orov6KYqClH/g3GnoD3fcPFYhQmy2h9ERaocfyklGsiqeJHI0E45E
         WzwP9pQFWn/6uDxC4AkdnMgLE37cQi3bBnn67reOtVGa+24TvJCWI7OSyD4xGYWT7Oz7
         l1D04tODnh/X6J8snL3fs5qArYAZqk0WiAglPZ3Un74OYDEh1c2RQ5eiOoc02yVOH1Wu
         MGkg==
X-Received: by 10.50.13.10 with SMTP id d10mr3980039igc.20.1435237676233;
        Thu, 25 Jun 2015 06:07:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id b15sm3287686igm.12.2015.06.25.06.07.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 06:07:50 -0700 (PDT)
In-Reply-To: <CACsJy8AVeGxOS4pWfkcbPnxRQ0-gJRC7B1NSs+Ci81x46ieDzQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 25 Jun 2015 19:26:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272673>

Duy Nguyen <pclouds@gmail.com> writes:

> I think it's clear that you need to revert that commit. I didn't see
> this at all when I made the commit.

I didn't either, and no other reviewers did. But now we know it was
not sufficient, so let's see...

>> Perhaps a good and safe way forward to resurrect what d95d728a
>> wanted to do is to first add an option to tell run_diff_index() and
>> run_diff_files() which behaviour the caller wants to see, add that
>> only to the caller in wt-status.c?  Then incrementally pass that
>> option from more callsites that we are absolutely certain that want
>> this different worldview with respect to i-t-a?
>
> Agreed.

OK.  Perhaps then first I should do that revert and we'll
incrementally rebuild on top.

Thanks.
