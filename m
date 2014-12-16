From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 11:57:04 -0800
Message-ID: <CAGZ79kZnGKNTpRZndgG_CjAC9gqafGXoq8rFOWuHZkaqY_LK7w@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
	<xmqqoar39y3l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0yF6-0004aE-71
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaLPT5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:57:07 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42769 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaLPT5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:57:06 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so13101451ieb.7
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/Y0T/hy6JqcMUG8CoKh48ukxMG/styyFl5VfvZgeIlg=;
        b=Ocetwb6t3E5F7jEMVhFWM6WJXZF7xC0cq8UARMDoIVfSh3x9bTcAkDoECvFVClZioN
         DDfuP8lbVb+E5e8XV7Uq9WQfxaQqsdEcvqmmBcC7ENdBNzFpp2nkTW8Rs/vm1DdLIwwN
         BznbJCV/hP5kXmgO5VsvR4BtPNXiGOiBry6j8HdVVGbno6gxS4qZ6uaYVRZ7cEMhIIKk
         5mic1SLyOwATJUusjsPGilptyUSpFsWqcjv+4dT5NpKXT404Q4L9frRuCVQGpOEYEkRn
         FGgWROmu1JVdIbBX18MJmjCUZhS+TDGkWr4u1vcP4ujMyvqlUNLYvBiKrnj4Ov2i5Pp4
         608w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/Y0T/hy6JqcMUG8CoKh48ukxMG/styyFl5VfvZgeIlg=;
        b=gu8Ut5p+TaVSRTxd9ePNNM3Ajn0HgKit/WKvXMFYK9JZNJDk8+LaXL8exhPeWyPI4v
         sBaH0otbaQSmNtizughu0t43uU8CBA1Fmm4rJnV57ZT3QHgUp/R8sN5DH8/lUm1tCA93
         W7z2ZA8gEbdJ5FUJ/1Z8qGjE7zjQFUTLKbxR+YJArg6oEHIB6WAJ4toJ7dhP7Onj/igA
         5UwEJIJ9vXxSvMzWUTg29uMgovvhuxW4OyIkrQOZo6KAnVFyu7QwR1p4+ZDJcZbupICd
         75OmEWQ74e2G7gEPQLJOEXjoGoEe3V+ElBsR8aRhP53aSLZXj0wqbCqq28M3xmK8mojp
         b0zA==
X-Gm-Message-State: ALoCoQlvZjOg8dyTm/V1ArpmqMaFcAoJpSyInD5VOZy9wH/XxH38kpNjjoFE1RgoUAlvxySWukN2
X-Received: by 10.43.154.196 with SMTP id lf4mr3390186icc.95.1418759824761;
 Tue, 16 Dec 2014 11:57:04 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 16 Dec 2014 11:57:04 -0800 (PST)
In-Reply-To: <xmqqoar39y3l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261464>

On Tue, Dec 16, 2014 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> Seeing that all callers of test_ref_upstream computes $2 as
>
>         git -C workbench rev-parse --verify <something>
>

Only in the first tests, where this should be the case after push.
In the failure tests, we go with HEAD@{N} which needs to be computed
inside the workbench repo.

Alternatively we could check if the reflog of upstream has a certain
number of entries
which would indicate the push was not recorded (i.e. not performed?)

I think we should keep it similar to this one.
