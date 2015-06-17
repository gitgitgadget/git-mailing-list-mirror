From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: add config option to disable auto-merge
Date: Wed, 17 Jun 2015 12:41:32 -0700
Message-ID: <xmqqd20u6s2b.fsf@gitster.dls.corp.google.com>
References: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
	<1434490514-36204-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: davvid@gmail.com, ssaasen@atlassian.com, john@keeping.me.uk,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JDP-0002gB-A0
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739AbbFQTle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:41:34 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34253 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537AbbFQTle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:41:34 -0400
Received: by iebmu5 with SMTP id mu5so40985684ieb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qX5EdxhTbeyC8PEm67Z51t+HptY6J5TlhbInH4naYsw=;
        b=RhLh2Dw1FNukTuz9vFWpoHd/yyTbytMiRH/kFhN3xyOx6k6AV1PhL6/V1+DILNOifX
         cswOAwEtfhwQ00sxmOMdd1cRgoz1dW1RwPMfqVqLn+TUp6gTVoVFsbMuGwQqOt3ioJx/
         4IDupMia7YOL79/auySsZO3p1fllKh10jxz3u3/5O4QZyHpvxu2CyK/6vjxIbbk/sY8f
         HEsJM62gdYHYad8CiUBoUO+AHPpNUxPNnPLaUqhuAEn9XhrOM0Lg9CjXH/4VSaPNSaWO
         WRTpnseZLSeJU8Wq5J2Fj5ql9J7HuO6FDHjl94i71ehBlDiozOXlsKd/78hKFEAL7qJE
         9+dw==
X-Received: by 10.50.90.179 with SMTP id bx19mr37677603igb.43.1434570093440;
        Wed, 17 Jun 2015 12:41:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id i4sm86294igm.2.2015.06.17.12.41.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 12:41:32 -0700 (PDT)
In-Reply-To: <1434490514-36204-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Tue, 16 Jun 2015 17:35:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271895>

Michael Rappazzo <rappazzo@gmail.com> writes:

> For some mergetools, the current invocation of git mergetool will
> include an auto-merge flag.  By default the flag is included, however if
> the git config option 'merge.automerge' is set to 'false', then that
> flag will now be omitted.

... and why is the "automerge" a bad thing that user would want to
avoid triggering under which condition?  That description may not
have to be in the proposed log message, but it would help users when
they decide if they want to use the configuration to describe it in
the mergetool.automerge configuration.

And depending on the answer to the above question, a configuration
variable may turn out be a bad mechanism to customize this (namely,
set-and-forget configuration variable is a bad match for a knob that
is more "per invocation" than "user taste").

Is this not about "automerge" but more about "always-show-UI because
I like GUI?"  Then that may be a "user taste" thing that is a good
match for a configuration variable.  I simply cannot tell from what
was in the message I am responding to.

> -TEMPORARY FILES
> ----------------
> -`git mergetool` creates `*.orig` backup files while resolving merges.
> -These are safe to remove once a file has been merged and its
> -`git mergetool` session has completed.
> -
> +CONFIGURATION OPTIONS
> +---------------------
> +mergetool.keepBackup::
> +	`git mergetool` creates `*.orig` backup files while resolving merges.
> +	These are safe to remove once a file has been merged and its
> +	`git mergetool` session has completed.
> ++

This is an unrelated change; I think it is a good change, though.

I however suspect that we would not want to repeat the configuration
description in this file and instead mention these in "see also"
section referring the readers to git-config(1).
