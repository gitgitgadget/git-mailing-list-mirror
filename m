From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 18:02:13 +0000
Message-ID: <20140319180213.GB11018@serenity.lan>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
 <1395226935-53044-1-git-send-email-modocache@gmail.com>
 <xmqqob123wjm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:02:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKoy-0004fK-3c
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbaCSSC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:02:27 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60662 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaCSSC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:02:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BFEF6CDA659;
	Wed, 19 Mar 2014 18:02:25 +0000 (GMT)
X-Quarantine-ID: <gE2exo-xEcIF>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gE2exo-xEcIF; Wed, 19 Mar 2014 18:02:24 +0000 (GMT)
Received: from coyote.aluminati.org (coyote.aluminati.org [10.0.16.51])
	by jackal.aluminati.org (Postfix) with ESMTP id A4E3DCDA666;
	Wed, 19 Mar 2014 18:02:23 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9ADBC606575;
	Wed, 19 Mar 2014 18:02:23 +0000 (GMT)
X-Quarantine-ID: <0gqRyzNgUaqC>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0gqRyzNgUaqC; Wed, 19 Mar 2014 18:02:22 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id A7378198019;
	Wed, 19 Mar 2014 18:02:15 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqob123wjm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244471>

On Wed, Mar 19, 2014 at 10:53:01AM -0700, Junio C Hamano wrote:
>    "rebase -" with your change still says something like this:
> 
>         First, rewinding head to replay your work on top of it...
>         Fast-forwarded HEAD to @{-1}.
> 
>    instead of "Fast-forwarded HEAD to -".  Somebody may later want
>    to "fix" this, making these two eye-candy output to be different
>    from each other, and what your test expects will no longer hold
>    (not that I think it is better to say "-" instead of @{-1}
>    there).

I don't think either of these is correct.  When using "-" with the
commands that already support it, I have occasionally found that "-"
isn't what I thought it was.

Can we use `git name-rev` to put the actual name here, so that people
who have not done what they intended can hopefully notice sooner?
