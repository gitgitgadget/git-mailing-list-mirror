From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Revert "git am/mailinfo: Don't look at in-body headers when rebasing"
Date: Wed, 24 Jun 2015 09:04:24 -0700
Message-ID: <xmqq616day9j.fsf@gitster.dls.corp.google.com>
References: <1434445392-6265-1-git-send-email-pyokagan@gmail.com>
	<CACRoPnRFCZWih-uFMRnqWwOCmeM9=RgUUpQURk4vrZZsDOjGvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:04:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7nA8-0003eZ-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 18:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbbFXQE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 12:04:28 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36662 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbFXQE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 12:04:27 -0400
Received: by igbiq7 with SMTP id iq7so100456536igb.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7FkHxXqn/JLIv5pY+AxfybTMi+/MZbjxqcsPj115bP4=;
        b=V0ZvjyAPR1zgxsTdlE7QO0tnveUT+nDntio9mfDnyVV3F6XwrvXvlaO2aby1qd+z8k
         SMoEBscR9D3iPmxQRQ/eGTynWaznWMeBrC5zIbXwvq2ez1I48ujYm8jM60AidNNplFCd
         jirXkGFkQ3R9oMu5rGUq48H/lMSefVqfzsDPXfQoqX3B4vLM+66Oa6Gfyn435gZ+p54c
         4EUnuv0h7RysHoC3w/WGoXk4+/L8ypKueE9x1CcCsmbnaHGz1Im6xr3iewEUpNBve2RQ
         Klk7WtkODpGwAGuei8HHy2h5wvJ3mtP3K13dfF3FF/ZIiEyCHjmZvQy/g+BCq229Rcz7
         A3Pg==
X-Received: by 10.43.139.6 with SMTP id iu6mr39289685icc.32.1435161866675;
        Wed, 24 Jun 2015 09:04:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id eg3sm1511710igb.0.2015.06.24.09.04.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 09:04:26 -0700 (PDT)
In-Reply-To: <CACRoPnRFCZWih-uFMRnqWwOCmeM9=RgUUpQURk4vrZZsDOjGvg@mail.gmail.com>
	(Paul Tan's message of "Wed, 24 Jun 2015 18:36:07 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272562>

Paul Tan <pyokagan@gmail.com> writes:

> On Tue, Jun 16, 2015 at 5:03 PM, Paul Tan <pyokagan@gmail.com> wrote:
>> This reverts commit d25e51596be9271ad833805a3d6f9012dc24ee79, removing
>> git-mailsplit's --no-inbody-headers option.
>>
>> While --no-inbody-headers was introduced to prevent commit messages from
>> being munged by git-mailinfo while rebasing, the need for this option
>> disappeared since 5e835ca (rebase: do not munge commit log message,
>> 2008-04-16), as git-am bypasses git-mailinfo and gets the commit message
>> directly from the commit ID in the patch.
>>
>> git-am is the only user of --no-inbody-headers, and this option is not
>> documented. As such, it should be removed.
>>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>
> What do you think about applying this patch?

Indifferent, even though it would be the right thing to do in the
longer term.

Keeping what we think nobody uses does not hurt us at least in the
short term; removing such a thing hurts us if it turns out that
somebody whose use we didn't know about were actually using it.

And my time is better spent at this point in the cycle on other
things than having to worry about possible fallouts from the removal
that is not urgent.
