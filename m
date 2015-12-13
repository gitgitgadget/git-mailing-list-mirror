From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Sun, 13 Dec 2015 20:19:42 +0000
Message-ID: <CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>, Sam Hocevar <sam@hocevar.net>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 21:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8D7T-00009j-UX
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 21:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbbLMUTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 15:19:44 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33710 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbLMUTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 15:19:43 -0500
Received: by mail-ig0-f170.google.com with SMTP id mv3so69977107igc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qZ+98SDN5CmyVRB42RxnCi62XIsMVfXywFroLmjBz0s=;
        b=jYxPaLZsg5Ij+GnOeyTGrzGkSGjDkqRjHUTfxJxjI9B1zZpRdUBwVLYS+mEXJmDxb2
         yTiFgWn9ikPWaKhwO5gB/rNY4RNVM1qiaIj2tQSTjKHrET6MZvb2M9c1zKlAFSNLOnrP
         dJ2Rl1mPHAGaR3iqg/ne259eJt1LadCQ8tSgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qZ+98SDN5CmyVRB42RxnCi62XIsMVfXywFroLmjBz0s=;
        b=TSwgduJZW2+rvuP2M5RHuQrt1qN+rMPbWimWirH/MmqSV4Czwy038NYSOgT85Bvy92
         pckfQgm5F6qPd+GEiW+vdqJqvO6vmrRdZeJw+ZkHuC6gxFgeyqWPcH6EOAuejvWLEz/w
         NGkhf9su4zRbcPDpswFqiH28nSqWoFCZ2OcZafwyFJTpKMYZAJL5GAKKR6uDLF+mGhKl
         q2OcpUwqGYABRzwClJbNrIR43fbvoYWiCHhvoxJFry4vCz4Q8w+8hqpqAtsz0jxQAJMW
         QJbCM4wa93nlUW62UM950vM30vhnj0wXenbPmsHaTT4ntqP4+VzK2TP5yHAwrRCjdgIr
         RQmg==
X-Gm-Message-State: ALoCoQnG7orvP+Pg2EU0aCSGAvI4fHrBpYySlxV3Y8YghgqC5QyfkocGpc/dhSQ8W3hUSW0+6PjTvkJ1DW6MXFk69B5q1AQHOA==
X-Received: by 10.50.43.199 with SMTP id y7mr14923222igl.47.1450037982944;
 Sun, 13 Dec 2015 12:19:42 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Sun, 13 Dec 2015 12:19:42 -0800 (PST)
In-Reply-To: <1450037234-15344-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282351>

Having just fixed this, I've now just spotted that Sam Hocevar's fix
to reduce the number of P4 transactions also fixes it:

https://www.mail-archive.com/git%40vger.kernel.org/msg81880.html

That seems like a cleaner fix.

Luke


On 13 December 2015 at 20:07, Luke Diamand <luke@diamand.org> wrote:
> James Farwell reported a bug I introduced into git-p4 with
> handling of multiple depot paths:
>
> http://article.gmane.org/gmane.comp.version-control.git/282297
>
> This patch series adds a failing test case, and a fix for this
> problem.
>
> Luke
>
> Luke Diamand (2):
>   git-p4: failing test case for skipping changes with multiple depots
>   git-p4: fix handling of multiple depot paths
>
>  git-p4.py               |  8 +++++---
>  t/t9818-git-p4-block.sh | 28 +++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> --
> 2.6.2.474.g3eb3291
>
