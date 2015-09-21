From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 21 Sep 2015 10:41:28 -0700
Message-ID: <xmqqzj0facvr.fsf@gitster.mtv.corp.google.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
	<1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
	<CAPig+cThcNa2Xg6GDkNKKeOMOzApTi_FQfQz_KRAbF8-PWY5Eg@mail.gmail.com>
	<4DB8A17D-A670-4E84-8FA8-9B05F2DCE1CB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze55r-0003Gv-FT
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025AbbIURlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:41:31 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34591 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbbIURla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:41:30 -0400
Received: by padhy16 with SMTP id hy16so122241662pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fpcIik/zDMgERi/ujU2Nd+ld6hgPbtALa+JAukEZKvA=;
        b=cyBmH3BATeqLCcy+9LAykdtCkFLh9yBnBZFruiwXT7eeYA+rUb+Oe3EqpE6A4kAT9u
         yvjskyqg/CbkOmbJkRirNuWqMX918cjPXfP6gOduebJyY4zt9bFS6utIZrSuDwN0Tlfp
         2cDEGvL8bmQHANCHlaX3pR2b9dxT1jm5eE1mGMA7G6bOFou1vs8NwvL5CdvA0dIXgA2r
         NulWkpkeynyyGCacabbyIv/G2R78t12A0edAzieUwOT1/DSXwJXnbzLudnfrZE9Sh3ZT
         c9Ko2NlD9kRhcLYdphajgfjBxSlJnHfRj9pQ7uJcU0VKwqiw/lLcsC6X8IwSBxIji06S
         qDhQ==
X-Received: by 10.66.164.230 with SMTP id yt6mr25698359pab.149.1442857290003;
        Mon, 21 Sep 2015 10:41:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id gw3sm25656666pbc.46.2015.09.21.10.41.29
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:41:29 -0700 (PDT)
In-Reply-To: <4DB8A17D-A670-4E84-8FA8-9B05F2DCE1CB@gmail.com> (Lars
	Schneider's message of "Sun, 20 Sep 2015 23:34:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278318>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 20 Sep 2015, at 23:16, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
>> On Sun, Sep 20, 2015 at 12:22 PM,  <larsxschneider@gmail.com> wrote:
>>> A P4 repository can get into a state where it contains a file with
>>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>>> attempts to retrieve the file then the process crashes with a
>>> "Translation of file content failed" error.
>> 
>> Hmm, are these tests going to succeed only after patch 2/2 is applied?
>> If so, the order of these patches is backward since you want each
>> patch to be able to stand on its own and not introduce any sort of
>> breakage.
> Yes, these tests succeed only after 2/2. I think I saw this approach
> somewhere in the Git history. I thought it would ease the reviewing
> process: show the problem in the first commit, fix it in a subsequent
> commit.
> However, I understand your point as 1/2 would break the build.
>
> What is the preferred way by the Git community? Combine patch and test
> in one commit or a patch commit followed by a test commit? I would
> prefer to have everything in one commit.

A single patch is fine and usually preferable when the patch does
not span all over the tree.
