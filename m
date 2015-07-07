From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Tue, 07 Jul 2015 14:19:11 -0700
Message-ID: <xmqqzj371x9s.fsf@gitster.dls.corp.google.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165501.GB23503@peff.net>
	<xmqqbnfn3dsb.fsf@gitster.dls.corp.google.com>
	<20150707204837.GA15483@peff.net>
	<xmqq4mlf3cgf.fsf@gitster.dls.corp.google.com>
	<20150707211304.GA16683@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:19:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCaHR-0007oE-ST
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 23:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbbGGVTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 17:19:49 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38770 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933702AbbGGVTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 17:19:14 -0400
Received: by igrv9 with SMTP id v9so151533362igr.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n5+BcgCX/Dhz3GSiHoQlyPeRA5i2Cle0aXY662uNRGg=;
        b=nFoNe9YmVcU1CC/2kXfRP3hMeYHQwiRQiRsk/XKNZYu6lJ16rakjLwHjOiUSGDdzaY
         qYrV8P7Txgvb189Idwg3VQ+1HUIP/gnaawUYqCD07C8SToBE1pqMcazwJeUhAnIxgyxX
         nAcrbswuvFTjAJNOlAvOq8tK9rNJe7NO9NGIayczBwmFbvIrU2JJeQwbRskEZhXRBsPa
         ER/20VfB8qLCJuDBvzl+By2QUKAE3w9zf//qe3COquQqAwqTTVbKxUhEtFES4Ozo0FK9
         tzrmwF0dYX8/vE0+eiWASxyy83/a5FVPmk1S12uqoLq48bzwRzYIfFeJdyJ+WW82/OG7
         1fuQ==
X-Received: by 10.107.7.21 with SMTP id 21mr10181823ioh.81.1436303953474;
        Tue, 07 Jul 2015 14:19:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id h138sm333683ioe.2.2015.07.07.14.19.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 14:19:12 -0700 (PDT)
In-Reply-To: <20150707211304.GA16683@peff.net> (Jeff King's message of "Tue, 7
	Jul 2015 17:13:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273603>

Jeff King <peff@peff.net> writes:

> OK. Do you want to leave it be, then, or would you prefer me to do the
> NULL fallback? Or we could bump the enum to start with 1, and then
> explicitly treat "0" as a synonym for DATE_NORMAL (in case it comes in
> through a memset or similar).

I didn't think about the memset() initialization, and keeping the
normal case to be 0 makes tons of sense.

I'd prefer to see the stale code dump core rather than leaving it
stale without anybody noticing.  Hopefully the date-mode change can
hit 'master' fairly soon after the upcoming release, so unless a fix
that involves show_date() need to be written and applied to 2.4
codebase and upwards at the same time, I do not think it is a huge
issue.

Thanks.
