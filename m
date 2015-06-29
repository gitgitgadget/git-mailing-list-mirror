From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Sun, 28 Jun 2015 21:37:33 -0700
Message-ID: <xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apelisse@gmail.com, jrnieder@gmail.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 06:37:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9QpD-0007u6-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 06:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbbF2Ehh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 00:37:37 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33088 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbF2Ehf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 00:37:35 -0400
Received: by ieqy10 with SMTP id y10so107841189ieq.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Dpo6aNUJ8tP6mc9MO3oQzPgNTsyGsowAwYGnHSnURUk=;
        b=IuhXMaKnlCKm3DukzkJmwhdAhlaWeNw4t9eHW/a87u0h3cDUyLPgUHQpQoquDkkO42
         kaKejf9L00rpuqsS/yv+QvrUjjBWfHHwPgL+8pZVsU/BG8U5Eja32IV8e6CCLpHmYCok
         KfcwWmQqQ3OV2UkHbsFe4KOaHGN2Q7OJbydKkXLQX9Cbm0fSMHpUq4ku+u/usLSgA+i4
         KfYoTASLittlvbJNwydykT1WDYvqKahxh/2lV0DVDzHflaNz1nI1swspgxNg5BRUf/PY
         RoXxVKP+bpbidusYuLnrIvTvmUkgnYOTqvgf2Riu2EuLn8jRIK4lYDrmHLIUPHv0T2bu
         hPCA==
X-Received: by 10.107.135.21 with SMTP id j21mr16228187iod.33.1435552655156;
        Sun, 28 Jun 2015 21:37:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id w4sm4670512igl.22.2015.06.28.21.37.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 21:37:34 -0700 (PDT)
In-Reply-To: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	(Lawrence Siebert's message of "Sun, 28 Jun 2015 18:22:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272932>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> This is a new feature for short log, which lets you count commits on a per
> file or repository basis easily.
>
> Currently if you want a total count of commits with shortlog, you would
> need to add up each authors commits after using --summary. This adds a 
> -N / --count option to shortlog for this purpose.
  
The standard way to do that is

    git log --oneline ... whatever other args ... | wc -l

or more kosher from a script

    git rev-list ... whatever other args ... | wc -l

Adding an option to ignore per-author breakdown smells backwards.
The whole point of shortlog is to give you the commit stats broken
out for each author.  I guess it is not so far-fetched to add an
option to "git log" to only show the number of commits that would be
output, if you really wanted to avoid "| wc -l", but this option
does not belong to shortlog.

And it certainly does not deserve a short-and-sweet single letter
option "-N", I think.
