From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH V3 0/2] git-p4: improve client path detection when
 branches are used
Date: Thu, 23 Apr 2015 11:03:02 +0100
Message-ID: <CAE5ih79Ju6D0mZ75Z1UH2n2O6s9AWuxNgpojr=vTggEYY=7E3w@mail.gmail.com>
References: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
	<xmqqegncf5ps.fsf@gitster.dls.corp.google.com>
	<553808EE.8020404@diamand.org>
	<9A7A7CAA-66D5-48B4-83E7-267FDDA7C66A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 12:03:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlDyP-00009g-II
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 12:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbbDWKDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 06:03:05 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35942 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbbDWKDC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 06:03:02 -0400
Received: by oift201 with SMTP id t201so10165627oif.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AkqLKJdoAL7xl7TaH6IF/A9k8hK9kdRT4dT6rm0HVy4=;
        b=Ure/JQDArlzg4VNDM9vWJmIjXasW3EBZ3Sw/4GmWN0aR9c9OKEXIISHeKJ6h5gpSUd
         tuOOZ8Ydjs2PBSIruHi6xk9SyncJSkJi7dAnDZF7GX+mq5vPQyHrXHs1BonQ5JldMFL7
         RsXER7cbVmzLW6xoyE46Pf/j/Xvg+B0DadqQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AkqLKJdoAL7xl7TaH6IF/A9k8hK9kdRT4dT6rm0HVy4=;
        b=NE0NmLfdWdv4znHnii7NvNFEctya1334mFCOCm1GkfDDfbVipZLoOJRvKEyZ4BPV8/
         zbIbU8e0jgzsMwqu7NmxIpvz4HfX68lSuiAT1lOrV42ZV9gvUyLO/Qa/10kLAxRGr0/x
         2yJpaqG17ogjdq/zxgHsVmYFjv2iSCLMKOFjGcAGCiwvmpwAWgQl/PDviLwX9C37TJG4
         r7dBBCFH+64cNKQL2PC2oEO7LO+Zf9NwFm+6XIa2tleiAj0EW0OZuoh1MpxM6Z3EXM2A
         i26lE2Ea35/nUTHj5H/X8Ds0sBlH+CLpC4kEH5M8AybvVlOgQwhmklLORe58qIxkzZGm
         GGIg==
X-Gm-Message-State: ALoCoQmsYa6TtvxMjzvsrOo95bvEDGBMl+wOTQ4wiJf4+Pv2JWv8mcN2bMZ61+rYHfChf87DmeVb
X-Received: by 10.182.246.5 with SMTP id xs5mr1728189obc.13.1429783382165;
 Thu, 23 Apr 2015 03:03:02 -0700 (PDT)
Received: by 10.60.59.167 with HTTP; Thu, 23 Apr 2015 03:03:02 -0700 (PDT)
In-Reply-To: <9A7A7CAA-66D5-48B4-83E7-267FDDA7C66A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267681>

On 23 April 2015 at 09:37, Vitor Antunes <vitor.hda@gmail.com> wrote:

> That was a good combination to test. In fact, I am using such
> a client spec at my work place to exclude the import from
> Perforce of a folder that only contains binary files, but I never
> even considered to add files to that folder from git!
> Although I do agree that git-p4 should be able to exit sanely
> in this scenario, it is also my opinion that this is a different
> scenario from the one I'm tryig to fix in this set of patches and
> that it should not be enough to stop this merge.
>
> I will take this scenario into consideration, create a new test
> case and finally fix git-p4 to exit sanely in such a scenario.
> This new test will also be able to show that folder exclusion
> is working perfectly during import, which is important to
> guarantee that that functionality is not broken in future.
>
> BTW, no kudos is necessary because I've already walked this
> path before :) I've introduced branchList and improved how
> git-p4 looks for the original changelist used to create the new
> branch in Perforce side. If I remember correctly, many of the
> test cases in 9801 file were also created by me before Pete
> started splitting the git-p4 test file into topics.
>

Yes, I think you're right that this is a different, albeit related
problem. It was broken before, and it's still broken. So I'm happy
with this change - Ack.

Teaching git-p4 to handle this corner case would be a good thing to do
as a separate followup if you're OK to do that.

Thanks!
Luke
