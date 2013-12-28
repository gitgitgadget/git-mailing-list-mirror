From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short,
 medium or full formats
Date: Sat, 28 Dec 2013 11:27:01 +0100 (CET)
Message-ID: <20131228.112701.1954502091799602077.chriscool@tuxfamily.org>
References: <xmqqbo0cfz1x.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1hdNE__+bVtKegChBT4u3Rx7NEzBYYkdEmUwfFLLpkzg@mail.gmail.com>
	<xmqqppojctsh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, karsten.blees@gmail.com,
	git@vger.kernel.org, peff@peff.net, joey@kitenet.net,
	sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 28 11:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwr7A-0000Tr-Cp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 11:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab3L1K1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 05:27:08 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:58055 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab3L1K1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 05:27:06 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 512E946;
	Sat, 28 Dec 2013 11:27:02 +0100 (CET)
In-Reply-To: <xmqqppojctsh.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239771>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <christian.couder@gmail.com> writes: 
>>
>> Ok, so would you prefer the following:
>>
>> - NAME_ONLY_REPLACE_FMT and "--format=name_only" instead of
>> SHORT_REPLACE_FMT and "--format=short"
>>
>> - NAME_AND_VALUE_REPLACE_FMT and "--format=name_and_value" instead of
>> MEDIUM_REPLACE_FMT and "--format=medium"
>>
>> - DEBUG_REPLACE_FMT and "--format=debug" instead of FULL _REPLACE_FMT
>> and "--format=full"
> 
> The end-user facing names are probably fine with short, medium,
> full, as long as what they show are clearly explained in the
> end-user documentation (patch 10/10 covers this).

Ok, I will try to improve on that.

> I have a hunch that we may later regret "full" when somebody wants
> to add even fuller information, though. It might be better spelled
> "long" instead;

Ok, I will use "long" instead.

> I'd rather see REPLACE_FMT_ as a prefix, not suffix.  Do we use
> common suffix for enum values elsewhere?

I don't see common suffix, but we have the following enums about
formats:

* in builtin/commit.c:

static enum status_format {
        STATUS_FORMAT_NONE = 0,
        STATUS_FORMAT_LONG,
        STATUS_FORMAT_SHORT,
        STATUS_FORMAT_PORCELAIN,

        STATUS_FORMAT_UNSPECIFIED
} status_format = STATUS_FORMAT_UNSPECIFIED;

* in builtin/help.c:

enum help_format {
        HELP_FORMAT_NONE,
        HELP_FORMAT_MAN,
        HELP_FORMAT_INFO,
        HELP_FORMAT_WEB
};

* in commit.h

enum cmit_fmt {
        CMIT_FMT_RAW,
        CMIT_FMT_MEDIUM,
        CMIT_FMT_DEFAULT = CMIT_FMT_MEDIUM,
        CMIT_FMT_SHORT,
        CMIT_FMT_FULL,
        CMIT_FMT_FULLER,
        CMIT_FMT_ONELINE,
        CMIT_FMT_EMAIL,
        CMIT_FMT_USERFORMAT,

        CMIT_FMT_UNSPECIFIED
};

To conform to the above and what you suggest, I will send a new series
using the following:

enum replace_format {
      REPLACE_FORMAT_SHORT,
      REPLACE_FORMAT_MEDIUM,
      REPLACE_FORMAT_LONG
};

Thanks,
Christian.
