From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Wed, 30 Apr 2014 14:22:52 -0500
Message-ID: <53614d8c23d6_2aa5fa32f06@nysa.notmuch>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
 <53614470489f9_f9b15012ecbc@nysa.notmuch>
 <xmqqy4ymeihb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaG6-0006sF-TG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946000AbaD3Tda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:33:30 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:48932 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945997AbaD3Tda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:33:30 -0400
Received: by mail-yh0-f45.google.com with SMTP id z6so2107236yhz.4
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=aH8unoEWOFgPf5pcqEB5ccVSU/RsmsCfY36ntLnNpNI=;
        b=EMVrsoB1hGeSc1KjGcJPDE2beD0jVY4TvLLi2tKvzQe6uKZXxp339UA1HsRIlT9SZ2
         wHtjh11kvixCY98iL08tOMhNgZ3YBfK2g5NnLzYdAqDQNIAsQjjCGWcgQvuaIoaJv93Y
         Lw4k34BXusZh/O7j3x0NeOvbLNDkcuWgQcfKxc/1tryzlrtXVWZk+/N0gcwxtiyHiL63
         s1xosAgIZ8JB05X62w2voKYBNm58znxmhmy3I/mpk0jG1S+BtjOCaPmH0za6SjyvCijq
         RN+UGzjWN5d/Zn+FpJCyST99CTojQJwFiYyna6KWI6KQy13pBgZi1LO2M4Msci/9NqIF
         Fs0A==
X-Received: by 10.236.1.3 with SMTP id 3mr8628828yhc.62.1398886409175;
        Wed, 30 Apr 2014 12:33:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z69sm44523549yha.26.2014.04.30.12.33.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 12:33:28 -0700 (PDT)
In-Reply-To: <xmqqy4ymeihb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247761>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >>     - With the endgame of "out of box Git without any configuration
> >>       refuses 'git pull' (without --merge/--rebase) that does not
> >>       fast forward" in mind, start warning "In the future you will
> >>       have to either set pull.mode (and/or its friends) or type
> >>       "pull --merge" (or "pull --rebase") when the endgame version
> >>       of 'git pull' would fail with the error message, but still do
> >>       as was asked to do as before.  At this step, existing users
> >>       can set pull.mode to "merge" or "rebase" or whatever to
> >>       squelch the warning.
> >> 
> >>     - Flip the default.  By the time this happens, thanks to the
> >>       previous step to warn beforehand, nobody needs to see the
> >>       warning. (your step 4)
> >
> > This is what my last version of the series did[1]. However, my plan was
> > to land this in 1.x so users could see the warning, and then flip the
> > switch on 2.0.
> >
> > This plan, however, fell off the cliff.
> 
> Yeah, I see that $gmane/234488 explains why the second step in the
> previous one stopped.  I guess it was in expecting a reroll state,
> waiting for that other topic (I do not remember offhand) to
> graduate.
> 
> I see nothing touching the affected codepaths now, so this time
> around we may have a better chance, perhaps?

A chance of what? Do you want me to reroll to include the future
backwards-incompatible change warning? Should I include the patch that
turns the switch?

-- 
Felipe Contreras
