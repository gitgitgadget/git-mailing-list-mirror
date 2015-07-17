From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Fri, 17 Jul 2015 14:09:35 -0700
Message-ID: <xmqqfv4m1ofk.fsf@gitster.dls.corp.google.com>
References: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
	<xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
	<CAPig+cQvVA0Cb60AxA=9RAUj6bBN419FQHObM6PARiDwGLiHow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGCt6-0004CB-9T
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbbGQVJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:09:39 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34831 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbbGQVJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:09:37 -0400
Received: by pdrg1 with SMTP id g1so67197681pdr.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JjUakNPOmBUS98L/MEwbXqMm++gMx9jkiqyvZ1Wnoo4=;
        b=saspxIzaIOTsZEjVw1ImWjgAxBahWnW412qcHpAFMpH+cIwnDBlPTz5denp82PoGcI
         d5EAheGat1EAVSh5bjyuqOJVx1sTCqYjOui5YsYGp+d8IETg9Vt10fP8IrD3XvdmLAGQ
         /lRIAtDw2S9P2neQ8kP9ZVg/oYUw8bBQ4WUmq2UJfwyFBRSVXrJTGjhcuxpMOgtzaNM3
         Ngyg3Yj7t7iZXloQ1MDoMJRt7oDvurNUg744lWFOAIOPS6q1a+uthNKWrV/f+Q+Q5Uwf
         FUTo4IfESdjuQ50yYhBXYBps61veDxTWbtieONbngrABoGK5Ee9+Zz3tU24ZNxB4ESeE
         opSA==
X-Received: by 10.66.121.230 with SMTP id ln6mr33176708pab.17.1437167377407;
        Fri, 17 Jul 2015 14:09:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id m3sm12251158pdd.29.2015.07.17.14.09.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 14:09:36 -0700 (PDT)
In-Reply-To: <CAPig+cQvVA0Cb60AxA=9RAUj6bBN419FQHObM6PARiDwGLiHow@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 17 Jul 2015 16:52:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274103>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Thanks.  I have two comments.
>>
>> "if using Cogito etc.", which is totally outside the topic of this
>> patch, is way outdated. Perhaps we would want to remove or replace
>> it.
>
> Do you want me to re-roll the current patch to also include the
> "Cogito" change as a "while here..." add-on?

No.  That is totally outside the topic of this patch series.

> Also, I have v3 of "rid git-checkout of too-intimate knowledge of new
> worktree"[1] ready to roll. Do you want me to fold the current
> patch[2] and its brother [3] into v3?

I think I took them and merged them to 'master' today.

> ... since he plans
> on adding more tests[4] when fixing the can't-clone-a-linked-worktree
> problem.)

I saw that issue myself yesterday, too, I think, with a failed
attempt to fetch from one.  I do not think it is such a huge issue
in a sense that we can always say "don't do that", as cloning and
fetching only from the primary location is not something that would
make users feel unnatural.  After all, we sell this as "allowing
secondary checkout", meaning that it is perfectly OK for us to keep
secondaries second-class citizens compared to the primary one.  So
being able to fetch from and clone from is "nice to have".

> Other than that, the only consumer of GIT_COMMON_DIR seems to be
> setup.c, and, based upon a quick scan, it looks like it can be easily
> dropped, thus alleviating your concerns (but hopefully as a series
> separate from v3 of [1] which I'd like to see land).

One step at a time is perfectly fine.  We will be cautioning users
to avoid storing the only copy of their data in repositories that
employ this feature for a few releases until it matures by marking
it experimental exactly so that we can tweak external interfaces
like that incrementally.

Thanks.
