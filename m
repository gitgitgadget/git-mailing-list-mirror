From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v4] pull --rebase: add --[no-]autostash flag
Date: Mon, 7 Mar 2016 13:53:46 +0530
Message-ID: <CA+DCAeSD60jChusPviF-VNENVEfO0SoFkTZE-B-q+X_YcnuvFw@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457171545-14496-1-git-send-email-mehul.jain2029@gmail.com>
	<xmqqfuw4x3e8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 09:23:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acqSH-0005mi-H6
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 09:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcCGIXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 03:23:49 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35739 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcCGIXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 03:23:48 -0500
Received: by mail-qk0-f194.google.com with SMTP id s5so3988974qkd.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2GfXfxOEu1YY7STw83BeWCtzEd2VFNRWwYjORnKk9VU=;
        b=JZDUhH2/rGHJAIYFHfteRSUra6HeYDSU7e48BRS5WndzecLef39kbNvEm6UiYPftMK
         KjAKqvrkbg2BR1N+Gswy2aQ5HXlim0hoKgHsTwUVbJRl8FzUFIVPEv1sHFJC6dBZMefR
         vwCVjS9mkgFdcvo68mzAvblCWBMBpsczVKtnVOMkJzeDZtwY6Gmjv1vMwj3lmmmhoF+8
         OflvWBc4US6aroowmTvzVuHq3UaBknnmd8nCO8gjtQ/Ja5IWgAa4wC6uSlT5fzfh4UC8
         fcQ4+9Y7bMhhSEuxhPd8LftlpoNKnqlLqoSD99p0e93k6kKsNo7KlPDUw8RCy7ZUCl0m
         YDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2GfXfxOEu1YY7STw83BeWCtzEd2VFNRWwYjORnKk9VU=;
        b=IcTjfKvaBNRCxX/NikvGHNEwwMzgrJpNANrUdQ6LDEMxH5ehj/iM+kUqyrtGx9JnDf
         S6RwgOKIl538ldFmXyccSr4eH+KThdoTobB/lCOMO1ztjQgo1Et0qFMfXaQdhNEvQCWH
         h+zEU4SRF1RzpO7sHriIXUcFgNLbNzIAc4+8FokMBiI2qaZSbq/9HJJ4qeNoacK6i8cd
         ICHPE1K/RpCAIt0QoevIu0xvofi786ew5/31NR+SYNW4gM/V4ZLvXKRBZXgg5C70MbaG
         U5WXS035MBk8YpBOwgEWY2wFuW/JG9GDNthXapwF3CwZdbyLaN+HiGI1YQzz+0SKFUhQ
         16sQ==
X-Gm-Message-State: AD7BkJLbdsnxcf6iMMqDKNFtOaorVDBcW1wTNxBJh7TyRWTrGJR2B3VDxj/EMJetdyMA+FHJUlqlYzbtPgs63A==
X-Received: by 10.55.217.151 with SMTP id q23mr26384075qkl.88.1457339027007;
 Mon, 07 Mar 2016 00:23:47 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Mon, 7 Mar 2016 00:23:46 -0800 (PST)
In-Reply-To: <xmqqfuw4x3e8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288383>

Hi Junio,

Thanks for the thorough review.

On Sat, Mar 5, 2016 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Is it worth checking the case where autostash kicks in, rebase
> itself is completed successfully, but the final "stash pop" fails in
> conflict?  I am thinking aloud and just wondering, not suggesting
> to add such a test, or even suggesting that having such a test is
> worthwhile. I didn't even check if there is already an existing test
> to cover that case.

I think this case has already been checked in t3420-rebase.autostash.sh:
"rebase$type: non-conflicting rebase, conflicting stash". Though in that
test rebase.autoStash has been used to trigger git-stash.

Thanks,
Mehul
