From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] lockfile: remove some redundant functions
Date: Wed, 10 Jun 2015 10:40:14 -0700
Message-ID: <xmqqtwuflawx.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
	<0d17c04842bef618ecd474c56f2dbcf6a613a379.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2jzC-0000Ru-St
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbbFJRkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:40:19 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35039 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbFJRkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:40:16 -0400
Received: by igbzc4 with SMTP id zc4so41331382igb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yYQKozkHPyY+NiG3ZExhvLJb0NxlueNqjl2Pz/GwNHM=;
        b=QKN0hfmHfajbkVQxQnyw9AWVwCI9bTGCxUEaRV/+9l+VyxgeAEWbC38xelcGZTvqDi
         hWh9YRVI/CzKIFkNf3h1D7h7kGVyqWhRFfgXMFztRVJkUz/NhzTkrNFugHoxoTI7V2TS
         I+hGPGlzsaeRnRigxtLc8L6xGv69lgfP9OH0uHTf0ZItXSvL884XrPqqrYb0bFvkXzcH
         8BruSrMPY7FR6MXeTTw2cWInwck2w2FuFgzhoNYNbJwR5u1CT1QMkJHoQcCFbnZ1v3OB
         GhLGiDs3iF8otRWFoaaO70iETT1DH7Mg137odyctu9JTuZ2LeACjToKZLsIgduYip4JB
         0qBg==
X-Received: by 10.42.118.3 with SMTP id v3mr6356650icq.66.1433958016061;
        Wed, 10 Jun 2015 10:40:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id rp7sm3658418igb.21.2015.06.10.10.40.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 10:40:15 -0700 (PDT)
In-Reply-To: <0d17c04842bef618ecd474c56f2dbcf6a613a379.1433751986.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 8 Jun 2015 11:07:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271332>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Remove the following functions and rewrite their callers to use the
> equivalent tempfile functions directly:
>
> * fdopen_lock_file() -> fdopen_tempfile()
> * reopen_lock_file() -> reopen_tempfile()
> * close_lock_file() -> close_tempfile()

Hmph, 

My knee-jerk reaction was "I thought lockfile abstraction was
fine---why do we expose the implementation detail of the lockfile,
which is now happen to be implemented on top of the tempfile API, to
the callers?"  I guess that was also where my comments on 02/14 "why
do callers have to include tempfile.h separately?" came from.

I'm undecided but would trust your judgement until I read thru to
the end of the series ;-).
