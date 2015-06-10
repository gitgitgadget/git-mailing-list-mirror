From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Introduce a tempfile module
Date: Wed, 10 Jun 2015 11:34:16 -0700
Message-ID: <xmqqa8w7l8ev.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 20:34:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kpU-0005CS-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbbFJSeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 14:34:20 -0400
Received: from mail-ie0-f193.google.com ([209.85.223.193]:35382 "EHLO
	mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbFJSeS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 14:34:18 -0400
Received: by iery20 with SMTP id y20so246315ier.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Mx3O8S63jaNDUaPpiYpX6C0c9ouddsgIyNJlcYwXycA=;
        b=DoYQXP0GMXOU/zW20bF4qw6Thl8r7WKFvyngO3ekvemT+J/PWL7ZdZCMbzYhwvRft0
         6KXy/kl0ZkXUwvDnhQWZ5DAGnopLpQ+z8r+OjB94c54aczMpt/gW2XKJVxG4FOCnE8X/
         TM1DMeY9fyQYjPXZxgh6tpjcCpcVpwV9oAVoD9dz/zyqDTE8S2Lac2iYT1rEctjnJj2R
         avDtqJWfsFQmXtlQFA0js3Cv0g5lchsr5ehzn0Ld7AmPmkHob7RykwezHBZfel6EWo6n
         ySd8A0mSxcFQZjRZGJMIF1Smv8DSil3HZAGilt+EesxrdnZgtMj58DbqazkulQLNqCqu
         lVow==
X-Received: by 10.42.81.201 with SMTP id a9mr6600900icl.9.1433961257602;
        Wed, 10 Jun 2015 11:34:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id d81sm6516499ioe.12.2015.06.10.11.34.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 11:34:17 -0700 (PDT)
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu> (Michael Haggerty's
	message of "Mon, 8 Jun 2015 11:07:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271340>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> These patches are also available from my GitHub repo [2], branch
> "tempfile".

Overall the series made a lot of sense.

On a few points I raised:

 - I still think that exposing the implementation detail of the
   lockfile API that it builds on tempfile API is going backwards.
   I wonder if a few helper functions added to the lockfile
   API to hide it, e.g. instead of letting the caller say
   "lk->tempfile.fd", have them call "lockfile_fd(lk)", would make
   things even more clean.

 - The tempfile API could be built on yet another layer of
   clean_on_exit_file API to unconfuse me on "register_tempfile()",
   but I do not think it is worth it only for two existing callers
   (gc and credential).

Thanks.
