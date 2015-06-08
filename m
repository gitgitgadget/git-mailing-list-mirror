From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fsck_handle_reflog_sha1(): new function
Date: Mon, 08 Jun 2015 08:07:45 -0700
Message-ID: <xmqqwpzeck72.fsf@gitster.dls.corp.google.com>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
	<1c6f5540fe974016c1547163c7b891707019154d.1433769878.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yeX-0004Lk-BB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbFHPHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:07:49 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36770 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbFHPHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:07:47 -0400
Received: by igbpi8 with SMTP id pi8so63788800igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qha+D6HUFw0CZ7fNruYLgrpjGFW5PUyt5m/OSAPDNC0=;
        b=mtWnHaluWug1JMH/GT8AS8oSkFN+VNPMBVkX84LB1RfmUuFBN0SvlN2omRA9DJPnRY
         2tp5qWqtUDAs2kCC6QE2k/OIEgxlCCMHZlZ4p38qqy+k22mtYJTOxQMP58dQGxryDjO+
         1SbBT6R9MKtLarmzIr6OLsPvhf9dmm5vXXTpvd+vls6eLWvc6orKF/9CD4ZveGRtx1G4
         L12uwRxZF8BWaPcA97xEgba4/aZWCHCJ0u9uDueH8WlfNGSv2A8uslCCCFgZonMzvX8l
         p1P6BwV/zZuEr+ic0EPJFRLYGHbW78r9M4VnGIk3IHpJoKkfQDnig+P7hgW5L+FFh95a
         f1pA==
X-Received: by 10.50.43.227 with SMTP id z3mr13966569igl.12.1433776067106;
        Mon, 08 Jun 2015 08:07:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id m193sm1888856iom.19.2015.06.08.08.07.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 08:07:46 -0700 (PDT)
In-Reply-To: <1c6f5540fe974016c1547163c7b891707019154d.1433769878.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 8 Jun 2015 15:40:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271042>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> New function, extracted from fsck_handle_reflog_ent(). The extra
> is_null_sha1() test for the new reference is currently unnecessary, as
> reflogs are deleted when the reference itself is deleted. But it
> doesn't hurt, either.

I think we would crash with today's code in such a situation, but
wouldn't we want to diagnose a 0{40} object name on the "new" side
of the reflog entry as an error in the endgame state?

I do share uneasiness with Dscho that this is tightening what used
to be an OK state into an error, but I haven't thought about how
serious it would be.

Thanks.
