From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Sun, 12 Jul 2015 10:32:22 -0700
Message-ID: <xmqqvbdpi8nt.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
	<xmqqa8v7yts9.fsf@gitster.dls.corp.google.com>
	<20150708081902.GA8606@yoshi.chippynet.com>
	<xmqqio9tx42z.fsf@gitster.dls.corp.google.com>
	<CACRoPnQyPpK3g0G3N-Yf2Zatk5RCEUe_1mbW9LGq8-=zypYcNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 19:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEL78-0004TB-4z
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 19:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbbGLRcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 13:32:24 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:34372 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbGLRcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 13:32:24 -0400
Received: by ietj16 with SMTP id j16so5016577iet.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VjafNhw1mLNJxtwcqWMMHq0WpdwAwZya+M5szZBRqYc=;
        b=JegtpgKvhcCRQxKPxuz8/FzXLf3bOfYLtLfuoQhTCQmQi4ZNY8vBtWiI9PRY8SmB+p
         bKOX8+/yXjsynvzTT/d8WiGMFKdcgk/NMbsBVYXj7IheCud1OVoEpFWch725my0uDGbV
         hDyMZ+Q6sFYdT7TbwVkB4UtuH4nKPMDXoci8eYj1+YiXO2zx6OxoXiZPwmM3r0wwY8oV
         hcsrWcNdn4BKh1RNdpk2wCcA63GMvvJo3NR/b0zu5PzDkt65+4n/0uNGAt2GVZVRunXP
         Ah3IFvd0D7iHCf9hQoKHBbHlFkkPBVZ+6FIfPlGfoyxN4cCkA04EB+2pdGx87S+HUY31
         3ftQ==
X-Received: by 10.50.134.196 with SMTP id pm4mr8705898igb.6.1436722343861;
        Sun, 12 Jul 2015 10:32:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b9be:d9fd:18d2:4319])
        by smtp.gmail.com with ESMTPSA id z195sm10852121iod.33.2015.07.12.10.32.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 10:32:22 -0700 (PDT)
In-Reply-To: <CACRoPnQyPpK3g0G3N-Yf2Zatk5RCEUe_1mbW9LGq8-=zypYcNg@mail.gmail.com>
	(Paul Tan's message of "Sun, 12 Jul 2015 20:29:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273899>

Paul Tan <pyokagan@gmail.com> writes:

>> However, I am reluctant to blindly replace assert(!state->field)
>> with free(state->field).  Are there cases where we _must_ call a
>> function that sets these fields at most once?
>
> I wouldn't say we are "blindly" replacing them.

I said "I was", not "you and me".  If there was a case where we
should never call into a codepath once these fields are already
initialized, then we need to keep assert(!state->field) in such a
codepath.  I didn't know if that were the case, hence I would have
been blindly replacing, which I didn't want to do.  And that is why
I asked _you_ ;-)
