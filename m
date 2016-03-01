From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 31/33] refs: add LMDB refs storage backend
Date: Tue, 1 Mar 2016 08:45:50 +0700
Message-ID: <CACsJy8A8rwcKFb_fH2BZN=nuqMdhA2u8xCP4fN0KZmDAczQPog@mail.gmail.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-32-git-send-email-dturner@twopensource.com>
 <CACsJy8AUqB_1XZweTmAV4atDeUWZJhzEJoY2t9nJqp3CNcViXA@mail.gmail.com> <1456796138.18017.77.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:46:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZOM-0000tv-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 02:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbcCABqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 20:46:22 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34693 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcCABqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 20:46:21 -0500
Received: by mail-lb0-f179.google.com with SMTP id of3so90625152lbc.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 17:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vxHkd63/edXMyGlSh+lXUo5mwVEzdokkQN3f5cqX5Ic=;
        b=B7Y9j34VB1Zn+raGlZkZrdH7XILREQwy5XfWhdmLcIKPxhm15sg4Vl7Y3UiPsqemqk
         t3IDWBfJ8DeL8Fiydv+FrfhDdzQ6SuQ9lpistQgaKLxfpETugCUkZkeesQR1ycGzZeSZ
         opSzmMLm4SDml1TM2pcTtmHn7QET6jQhwus0+Wd6paaj1QH+iNvzEW3sgaYVThHJHrWz
         qGbJ16hlSYDQRQjfyaZU9GkndIaC8GVkSbnDNV92XlxDQfoSbvvyMbPBAXWlB8tO1Wso
         IChdlWDHRqDEPX3JRZwAVFqHST6Jl6Gm/zmwZPO0HJt0B2HidZtcDEXuQh4Y1sziqELb
         qpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vxHkd63/edXMyGlSh+lXUo5mwVEzdokkQN3f5cqX5Ic=;
        b=ZNBSZ9PzWIKLtPI/tfmKD03u+XaZipcah0mC6XCG8WTWSl5ORmegreKAtZTo6Dmjfu
         +uywAf4vtiH7PrW4qZ9epgQq752qKOAtZdZIZHCgwp5JEj7WkpffDPYnnhFFZj/OokTV
         c7BHY3fb2IGpAoN8y1Lgpu3cJRXiiC5SKqBHKjcDtY+ka54Wx5phqQDun129UIto8yIt
         Dh8stV70IxZMzIB6KHj17+1FlPFk8weAy7neBopG9Mmlr5okRCoxVH6HhSDraZ5RzuC6
         jgIsm6M8itDwB8KhTCOzWbjfMlLyaqFjsg2S5BDBOkuH1fWnBhkCdjcykVMu2JKpmZ00
         3jdA==
X-Gm-Message-State: AD7BkJJxD03poxkbhFeWHSQJV9v2QNBCouqnSRhHt61u6gDjXDC5SqFRamwFXHB/z/TkPVyrj1M5TxmBFD11PQ==
X-Received: by 10.112.209.99 with SMTP id ml3mr6667297lbc.26.1456796779626;
 Mon, 29 Feb 2016 17:46:19 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Mon, 29 Feb 2016 17:45:50 -0800 (PST)
In-Reply-To: <1456796138.18017.77.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287982>

On Tue, Mar 1, 2016 at 8:35 AM, David Turner <dturner@twopensource.com> wrote:
> On Tue, 2016-03-01 at 08:31 +0700, Duy Nguyen wrote:
>> On Tue, Mar 1, 2016 at 7:53 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > +Weaknesses:
>> > +-----------
>> > +
>> > +The reflog format is somewhat inefficient: a binary format could
>> > store
>> > +reflog date/time information in somewhat less space.
>>
>> This raises an interesting question. What if we want to change lmdb
>> format in future (e.g. to address this weakness)? Do we need some
>> sort
>> of versioning in lmdb database? I suppose you can always add "lmdb2"
>> backend that shares most of the code with current lmdb backend. Not
>> sure if that's what you had in mind though.
>
> The weakness of versioning inside the LMDB database is that in order to
> check the version, you need to already have LMDB.  That's the argument
> for "lmdb2".
>
> I had sort of hoped that this version would be "good enough" that we
> could avoid modifying it.  So maybe that means we ought to address the
> reflog format.  But I'm not sure that it's that big a deal.  What do
> you think?

I'm not using lmdb yet (can't because if I convert my git.git to use
it, all topics I'm working on must be rebased on lmdb :-( ) so I don't
have any strong opinion about this. As long as we have an escape hatch
(that won't lead to a too messy future) I think we're good.

Note that storing in binary also has disadvantage. If we move from
SHA-1 to SHA-XXX in future, we can easily detect incorrect reflog line
in text form, it's a bit harder to do in binary form when you pack
everything (including some variable stuff like email) in one value.
But I think we don't have to care about that right now, there will be
lots of problems migrating to SHA-XXX anyway.
-- 
Duy
