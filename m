From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Single brackets matching in .gitignore rules
Date: Mon, 28 Sep 2015 11:04:46 -0700
Message-ID: <xmqqy4fqctdt.fsf@gitster.mtv.corp.google.com>
References: <2606743.RipZrg6Xoz@pinguin>
	<CACsJy8DiTevhSnkkab-kfvpibitoUMHdjC2UdGT244JwLRxqWQ@mail.gmail.com>
	<xmqq7fnae92a.fsf@gitster.mtv.corp.google.com>
	<4259524.1vtm9ffbuH@pinguin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrey Loskutov <loskutov@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 28 20:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgcnc-0007nr-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 20:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbbI1SEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 14:04:48 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35009 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbbI1SEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 14:04:47 -0400
Received: by pacfv12 with SMTP id fv12so184556908pac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Jrq8svnCt9VchZo/MZyhZ5DpA/mj/unfTQtECxIAtUw=;
        b=x5Jpmr6MIKlVp5caCv/lMZV/gjK6RGR//uV6AgKRAcOCcnMKDlRMnHjwNAMlBcyxkb
         sZKMOf9Qz9L0mFSC0twb58Yd+16OihaMIEEsvUEz8BjRR0RwT02L+1gb9D9syGJVT2Mo
         qDF/GbCl+F/AZdZR/bMrEmqcVAeAOH5gYRnw+hJcOF5Ggrz12iO+FpHVTVX/Go6LNs/I
         ++iu0L5eDeroNGk/KUyLUIT622QL+qiQpH52oM3NKNxye8YqGjV6HhsTiS3bYFiAWWgN
         k+tdruArcywb8WdQRc2KYpsc6X1JuK183q1Fyw0Yzho3JpVc03vha81C+wvyvH1VVHNK
         INFw==
X-Received: by 10.68.192.70 with SMTP id he6mr27743675pbc.157.1443463487339;
        Mon, 28 Sep 2015 11:04:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id k10sm20619060pbq.78.2015.09.28.11.04.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 11:04:46 -0700 (PDT)
In-Reply-To: <4259524.1vtm9ffbuH@pinguin> (Andrey Loskutov's message of "Mon,
	28 Sep 2015 19:46:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278738>

Andrey Loskutov <loskutov@gmx.de> writes:

> On Monday 28 September 2015 10:40 Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>> 
>> > This is already answered. I just want to add that C Git has stopped
>> > using system fnmatch for some time (part of the reason is system
>> > fnmatch behaves differently in corner cases). If you don't mind C,
>> > have a look at dowild() in wildmatch.c, or t/t3070-wildmatch.sh for
>> > some corner cases (but your cases aren't there, may be worth adding
>> > too)
>> 
>> What exactly are you suggesting to "fix", though?  Barf when an
>> unmatched ] appears as a part of the pattern, instead of taking it
>> literally?
>
> I would rather treat the opened but unmatched [ bracket literally, so
> that it works similar like ].

Ah, OK.  As long as the (broken) pattern '[' has never been
accepted, it is safe to assume that no working .gitignore file
people have should contain such a string and relying that it
does not match anything, I guess.
