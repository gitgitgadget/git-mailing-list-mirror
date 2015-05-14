From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] teach git pull to handle --log=<n>
Date: Thu, 14 May 2015 10:11:37 -0700
Message-ID: <xmqqd22384om.fsf@gitster.dls.corp.google.com>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:12:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswgA-0004zN-48
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbbENRLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:11:41 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33855 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030324AbbENRLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:11:39 -0400
Received: by iecmd7 with SMTP id md7so66157571iec.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=APJMef+xeZWS3KuBy+mvW+IK4QzdAsIOrKMzrbHbuSk=;
        b=NSW2uuvujTxVcViRIj8Y2v9iECMpSbXMKd05YJ9lnCS66eHpC1sHcRDrUlYoHbB7mf
         tWLJH+faWZ/Iqc1w42ZLAKKURO2IHfEJEvi0JSWPYhhSy5mnm8MbJX1Se1FJoKMoJZMN
         rLnPyn1Qd3PVFeOyxK6POYD7ggNXALSluRrSOeUVPzLCqX6rGQSoxtLXflckni4BpOI8
         MPHVCD199yGE9dP2049szeqgcINrqGywjKFL2PMRSmrBllmJQKNidfqYDDNXkfLnrbYU
         oj11JgafTO8nF395DlrAQFav0pSnTD/vowb54cBEVq7PTRuXYYKJoGuu+MD3uQLc8pjc
         b7cg==
X-Received: by 10.42.128.84 with SMTP id l20mr16255625ics.21.1431623498894;
        Thu, 14 May 2015 10:11:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id fs5sm1468459igb.0.2015.05.14.10.11.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 10:11:38 -0700 (PDT)
In-Reply-To: <1431508661-21729-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 13 May 2015 17:17:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269048>

Paul Tan <pyokagan@gmail.com> writes:

> Since efb779f (merge, pull: add '--(no-)log' command line option,
> 2008-04-06) git-pull supported the (--no-)log switch and would pass it
> to git-merge.
>
> 96e9420 (merge: Make '--log' an integer option for number of shortlog
> entries, 2010-09-08) implemented support for the --log=<n> switch, which
> would explicitly set the number of shortlog entries. However, git-pull
> does not recognize this option, and will instead pass it to git-fetch,
> leading to "unknown option" errors.
>
> This patch series implements a failing test that demonstrates the above,
> and teaches git-pull to handle the switch --log=<n>.

Looks good.

One advice; for a small patch like this one (and the "pull.ff vs
merge.ff" one, too), it is not necessary or even desirable to do a
two-step "first add a failure test and then another patch to fix and
flip the expectation" series.  Just do the fix and add a test to
expect success.

After all, the primary reason why we add test is *not* for you to
demonstrate that what you did works as expected.  It is to catch
other people breaking what you did in the future.

Thanks.
