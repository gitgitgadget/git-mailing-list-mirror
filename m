From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Wed, 08 Jul 2015 00:48:06 -0700
Message-ID: <xmqqa8v7yts9.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:48:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCk5h-0004wN-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934397AbbGHHsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:48:13 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38831 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828AbbGHHsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:48:08 -0400
Received: by igrv9 with SMTP id v9so160497466igr.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1GXVv/3apG7JjP/kheDkoT2h6U9YQ/VJpWUOKpx7Ydo=;
        b=ZWe/t3ZUN0synQF0DI2xDDMu6j48vaAyNFtRbkiY+/6eei5nAWZVDY8b+7+WpHFheb
         4MER5fpKkR7kRSt0HkXD2kc7PeqrDph1G/Kxz0fna1jhcoexsiElMbQjtt6MdPkjRHqW
         vcgtLlPw/L/FmbDiKwRUCLvHV1TaUshlpHrOJY1+nkA70duRr+CPsQf3D07QqfchdHBm
         cf7uYoDXj3DqmV1VbVaKzRzRlycottpPR3efMnVMFW1CVSZawr8hEB+ztsKEbZKnInV8
         3OLa7j6TfQ357cq2mIcp/X4++c07C+AWdXvoiBp2E98C1mNDNeLFoAwaErF9vmEyG0Wy
         AjDQ==
X-Received: by 10.50.7.68 with SMTP id h4mr59605690iga.40.1436341687708;
        Wed, 08 Jul 2015 00:48:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id i7sm1366379igt.18.2015.07.08.00.48.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 00:48:07 -0700 (PDT)
In-Reply-To: <xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 08 Jul 2015 00:31:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273650>

Junio C Hamano <gitster@pobox.com> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
>> This patch series rewrites git-am.sh into optimized C builtin/am.c, and is
>> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].
>
> I merged this to 'jch' (that is somewhere in between 'next' and
> 'pu', which is what I use for everyday work) and tried it to apply
> the 8-patch series that starts at $gmane/273622 on top of 912bd49.
>
> It appears that your builtin version makes "am -3s" barf at the
> [PATCH 7/8] in that series, complaining about lack of author
> identity.

$ git am -s ./+dt
...
error: patch failed: builtin/update-ref.c:421
error: builtin/update-ref.c: patch does not apply
Patch failed at 0007 update-ref and tag: add --create-reflog arg
The copy of the patch that failed is found in:.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
$ git am -3
git: builtin/am.c:1332: parse_mail: Assertion `!state->author_name'
failed.
Aborted (core dumped)
