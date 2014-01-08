From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 9 Jan 2014 00:07:56 +0100
Message-ID: <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
References: <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com> <20140108010504.GE26583@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 09 00:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W12EX-0005qR-OD
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 00:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348AbaAHXIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 18:08:18 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:32936 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109AbaAHXIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 18:08:17 -0500
Received: by mail-ob0-f169.google.com with SMTP id wm4so2497234obc.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=itGxtV/2TkTjARhq25zVw7YCsTelCV+ZqnJgkZI4Vq8=;
        b=zEMnvg5M791RlFyTDTTCA8hyOJLWbneLa4d55hV+3FCuyEU6djF7GSqLfDM3Vzlg9L
         4BX7ABsU4Mfur12ywrY5oYSMTOHdWb2QWGnlseSVNNGUANnJ/8UL2j3lFv0oEG9u1kgw
         E43/9+mgTrPumB32JRjX4UhFQZi28my8MAGNbK+jQhrpByruaYobwPtsH9LVtRV+ZKPq
         CKS8HeYA8bKskxuL5gPrpVQei3XBjBn1CK7O3U0dNZ0HI8AzE0xX0EpZE9dlIqqw6JQs
         2To+VYnYST5WbI/wtBidMDQfmEW1zZIk6mstCWswmE7iMRZZGlCUBJk29ATvR1XI1aSS
         JxiA==
X-Received: by 10.182.48.130 with SMTP id l2mr13490064obn.44.1389222496589;
 Wed, 08 Jan 2014 15:08:16 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Wed, 8 Jan 2014 15:07:56 -0800 (PST)
In-Reply-To: <20140108010504.GE26583@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240229>

2014/1/8 W. Trevor King <wking@tremily.us>:
> To elaborate the idea I sketched out here [2], say
> you want:
>
>   Superproject branch  Submodule branch  Upstream branch
>   ===================  ================  ===============
>   master               master            master
>   super-feature        master            master
>   my-feature           my-feature        master
>   other-feature        other-feature     other-feature
>
> That's only going to work with per-superproject-branch configs for
> both the local and remote branches.  Using the same name for both
> local and remote branches does not work.
>

After long thoughts, I think your idea about a local branch with a
differently named remote branch looks interesting but I would be
extremely cautious to add a ' submodule.<name>.local-branch' now. Do
we have a similar mechanism on regular repository clones? We can clone
and switch to a branch other than "master" by default, but can we also
have a different remote by default? If we don't have it, we shouldn't
add it first on submodules, as there's the chance the feature never
get coupled on  the regular clones.

Also, I think you fear too much that this can't be added also later.

I think you should pursue your initial proposal of "--branch means
attached" to get it upstream first. It's alone, IMO, a great
improvement on submodules.
