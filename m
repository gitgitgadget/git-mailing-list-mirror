From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t0005: ksh93 portability workaround
Date: Tue, 31 May 2016 18:49:41 -0400
Message-ID: <CAPig+cRD8aTNJxvfkc-5Xjr6_pKRzAi3SpZ7JCZcRYMQFT_xMg@mail.gmail.com>
References: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:49:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sTq-0005Rs-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbcEaWtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:49:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35550 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbcEaWtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:49:42 -0400
Received: by mail-it0-f67.google.com with SMTP id z123so740124itg.2
        for <git@vger.kernel.org>; Tue, 31 May 2016 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=JlImz+hx/mGSm0RlGQHhn+CpVepdb4dbYzGqHyw3p3E=;
        b=cE7XqxloeWatCW6fFRvIejDWoBE0djKiKMDD9LnCxt7SMGPTaIrZ7K9uhOJLvlPQaw
         aQ9hw/mE6RPQxFCi967lkAyG0FfiVELuy72XFzN3nx5MYhZ9yq0JVxBEOyssHSwGj4Pl
         EHCKMyFv9Lnv6y/2Y3PFOWGm2EaoPLipIq1QXjEu6gzdEtJw6/pcbd7Q3xupqe3OKQop
         wiFz3MTVDUnbd3TW+1rEpPsLWnL64I2OKyO5jkqjADStXrPJmMVS+3Bo1SuqeTpDzvLI
         /re2LTiWv/zK97vVB4TFCMQ4HLbSsG1iHa4hWVRBSWWl491iRapv45uVEnN7LdNA3m3F
         OzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JlImz+hx/mGSm0RlGQHhn+CpVepdb4dbYzGqHyw3p3E=;
        b=bdRKN09wpjOoyMB2sq6/A4bZQJuH/2aLdMRIdSWYXXV4F9MRnQ+igg41zEMAoWiDnW
         ohUZoscIGXPNSW6yKkqOG6mMFEdYvP23KrUXVwiCddVazTYzWzPkBcQC9M2YFVT1WEez
         VIfa/2ulG/OvHsnei40RrOw72Uz3TQhQXEHJHhdbLU6SuzoDcH+H6QzSpGmUVULKQeZv
         134UgpUa086nQYoS/a2mKWaKLlH6BG2W9CCQogFq9vaVRM54oU0Ydxr5MjaHGVfbaj0T
         lkcJoVQ0Jddw8L4UgRpG9DrboyLk7L7E9WXhL8aazsUOHApeVzQ3Ppg5/8tMKQOXrc8z
         VNXw==
X-Gm-Message-State: ALyK8tLEwvj2I9LMX8sq4h0KF9by69uGbjeStiFWV8yCZqMp3hZZYsT2jnrjv/q/VO1yBwD8SEIIOP7v6M/eAQ==
X-Received: by 10.36.112.81 with SMTP id f78mr1366328itc.32.1464734981524;
 Tue, 31 May 2016 15:49:41 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 15:49:41 -0700 (PDT)
In-Reply-To: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: G_c-Q7L4RUzkGPN1anppx2PjxuU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296027>

On Tue, May 31, 2016 at 6:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The test has two things ksh93 does not happy about:

s/does/is/

>  * It thinks "(( command1; command2 ) | command3)" is a perfectly
>    sane way to write a pipeline.  ksh93, unlike other POSIX shells,
>    does not like the two open parentheses next to each other for
>    whatever reason it has.
>
>  * It adds 256, unlike 128 that are used by other POSIX shells, to
>    the signal number that caused the process to die when coming up
>    with the exit status.
>
> What is interesting is that we knew about the latter issue and had a
> workaround in the test-sigchain test when verifying that SIGTERM
> works OK, but we didn't have corresponding workaround for SIGPIPE.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
