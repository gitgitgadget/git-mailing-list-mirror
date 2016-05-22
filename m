From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] worktree.c: add is_worktree_locked()
Date: Sun, 22 May 2016 16:53:51 +0700
Message-ID: <CACsJy8ChM99n6skQCv-GmFiod19mnwwH4j-6R+cfZSiVFAxjgA@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160510141729.23063-1-pclouds@gmail.com>
 <20160510141729.23063-3-pclouds@gmail.com> <CAPig+cQR40u4nMEP1wz74ubA=wW5m+KiCZnpZwuWAyYvXsPHrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 22 11:54:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Q5a-0007Gv-QM
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcEVJyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 05:54:23 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34108 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbcEVJyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:54:22 -0400
Received: by mail-io0-f169.google.com with SMTP id 190so176275408iow.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JjWvP/DFKPqRye698huK6p2f669aQFM2ZAknkZat4tI=;
        b=n8t9GUUG/HvEYAaTWXIiEYMmTKP6RY/v8aA+LkK7ArkogXqCZGXD/BRMmp8rfFU4Wa
         SBF9qo7t2UOgK4qJFqCKc/0xjRCx3lgFJ7qMXPNPqLTh4xBBrfgRGBFrzSVKTFyD9LUj
         1y/0EnsFn7MheBF5Ki43oesiov3rqgr2NDo/zCc8X3sPbh5oeRS2loPesHQvaJYgIIoI
         XflXKBo/Z+znv0Y83EgwSRxovPlPd6qLOHEbLC/Bbs827K47d5WY9f11uEFA6EelbA7D
         9tnD30m8oOS3Yl0FsbcbzZ3VZwn85vTyQ3batreHIQ4imV7pGj7916YZ1gph7EMMMxai
         lGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JjWvP/DFKPqRye698huK6p2f669aQFM2ZAknkZat4tI=;
        b=P8CEU4XPKwffT1zb4Zu6SFPv4iP6hXTxI6eZiNsG+kUIDXoV9tFhlundt26sG9ywNU
         6HzrR5fhFondCPbq3Y1xL6mXokWFiv+nmWhpdEIh1DMoROF1VwCdjQPY5rF6f9FETgXF
         6UVR8M5PIbxw/mXQJmUs4xC/7lgoozCQsGYQM994W9Tp/Uix8uPVttTLtzXL1HhjzC/I
         7FIpHmz25e7UnNwTT1rUXjeIlvkkrtqQMiYdN7zSt0mzHspUY8TzPImn6P6N5lONv3Ew
         NjAp9+4SWr0z49W5A9mahDVuD+n5IqbE8aRskdMupsOiRRv5lLq/4GZF3A3M3W9tM3cE
         EiUA==
X-Gm-Message-State: AOPr4FVTgCWUdmqYc/FnjXsa2NUX6LoSV4a6sIubrf1B/0uDfj3EWAB52hGazWDdiLup5JcfkpoPxSYzPnXXDA==
X-Received: by 10.107.159.84 with SMTP id i81mr8124530ioe.29.1463910861365;
 Sun, 22 May 2016 02:54:21 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 22 May 2016 02:53:51 -0700 (PDT)
In-Reply-To: <CAPig+cQR40u4nMEP1wz74ubA=wW5m+KiCZnpZwuWAyYvXsPHrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295267>

On Fri, May 13, 2016 at 11:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Actually, I recall that when I suggested the idea of 'struct worktree'
> and get_worktrees() to Mike that it would be natural for the structure
> to have a 'locked' (or 'locked_reason') field, in which case the
> reason could be stored there instead of in this static strbuf. In
> fact, my idea at the time was that get_worktrees() would populate that
> field automatically, rather than having to do so via a separate
> on-demand function call as in this patch.

I'm keeping this as a separate function for now. I don't like
get_worktrees() doing extra work unless it has to. We soon will see
the complete picture of "git worktree" then we can merge it back to
get_worktrees() if it turns out checking "locked" is the common
operation. is_worktree_locked() then may become a thin wrapper to
access this "locked" field.

>> +extern const char *is_worktree_locked(const struct worktree *wt);
>
> I was wondering if builtin/worktree.c:prune_worktree() should be
> updated to invoke this new function instead of consulting
> "worktrees/<id>/locked" manually, but I see that the entire "prune
> worktrees" functionality in builting/worktree.c first needs to be
> updated to the get_worktrees() API for that to happen.

I thought about updating prune too. But it is in a bit special
situation where it may need to consider invalid (or partly invalid)
worktrees as well. So far worktree api is about valid worktrees only
if I'm not mistaken and we probably should keep it that way, otherwise
all callers may need to check "is this worktree valid" all over the
place.
-- 
Duy
