From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue, 3 May 2016 15:43:32 -0700
Message-ID: <CAGZ79ka8RQmNzzKJ9r_GsLkSCK5Thewsz9scZvwpJb0Pf_+NRg@mail.gmail.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
	<xmqqy47qkc87.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Per Cederqvist <cederp@opera.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:43:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axj2Y-0004fF-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbcECWne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:43:34 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37477 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519AbcECWne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:43:34 -0400
Received: by mail-ig0-f179.google.com with SMTP id s8so33409856ign.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Dw+PnFkCs8VnImTQIn0rBBjgUvcqxaiifES4+bEd9oY=;
        b=Pa7EVK49a7Kn+yvk1Ft8R9RdkMaFnc2gdDTRdiyzI0LgDEu1Z10zkYoDeQJIJIB5pq
         vo8jJ5V2uqc0AU3Lhm0RP51R72cgB5LW9rFusKSU5aFt6rSO5tipgffVXrvUjpbCNaos
         wd4zmJIkDzKisEUb9cAMwFEYRtl/vwvLTwsH1hGEMDtNJbh6QpIQq3zco7HM0aHxC51T
         qroJNbvmGHouGWaePaSOXLkJGkYsuKKLGu+OJPeGHloLH3wBfb6RRk7e9xoOEVTk3EP/
         Fn9WDld3nz/qvEGZWYv0NdzCE15lU/Y/GwhxvUP391QDYEOq1nOBuLPjm0nJe8ta54Rr
         E3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Dw+PnFkCs8VnImTQIn0rBBjgUvcqxaiifES4+bEd9oY=;
        b=gVg44K0Sqe869OYk9u7GJlpq8SA6YOQPs93uypDY6FLyIJ0nsdOG0ByY+tA5El+6Th
         l3TpuSf2ij+cs5809YnfzIcxSJ2agYk9xsfnRnLliTWw8WoiO6I9ndsLQdtmwdOpmhq1
         wRAwPybALor5ATWjyJropdXiBFCMtENODlRrGia0KSnJzJ+l73xV8XAyMdZqTqOVRFuQ
         RhjAC594aI0htEPNuoIs2Imls/UUWhuR3rOoQcvm1pQanLwmeiUDGMq5OYdnLAGCRm3Q
         81K4KYovO8paW81XIhyU6cPTNUvNsa18PzN72r210qiwXechTHwESLswUl1mle2n6eew
         Uzow==
X-Gm-Message-State: AOPr4FVxk0kpkft4xsUxEicsel9mlIwfD0gNrGkgMrMjbEIp0bgse8wtleKcSzyhXolK77aE3jMN2Miq7JJM99uq
X-Received: by 10.50.170.68 with SMTP id ak4mr6650281igc.93.1462315412895;
 Tue, 03 May 2016 15:43:32 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 15:43:32 -0700 (PDT)
In-Reply-To: <xmqqy47qkc87.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293471>

On Tue, May 3, 2016 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I developed it on top of
>>     "submodule deinit test: fix broken && chain in subshell"
>>     on top of 2a4c8c36a7f6, 2016-03-24, Merge branch
>>     'sb/submodule-module-list-pathspec-fix'
>> but I think this would rather go in as a new feature, not on top
>> of a bugfix topic, so I think this could go on origin/master ?
>
> I do not particularly view it as a new feature.  The way the old
> message suggested did not work in a pathological corner case, but we
> wanted to keep the "force user to be explicit when doing mass
> destruction", and a fix we happened to chose requires addition of a
> new option--that would still look like a fix to me.
>
> It is not like we are forbidding the use of "submodule deinit ."
> that used to work in a tree with at least one tracked path.  With
> the change, a script that has such a command will continue to work,
> no?

Maybe.

With just this patch, yes.

I'd like to revert submodule-module-list-pathspec-fix partially
when redoing the groups support. That would break the '.' script
case. So eventually scripts want to use

    git submodule deinit -f --all

instead of

    git submodule deinit -f .

When implementing the groups support, I'd change module_list
in a way that you can give names, paths, or labels to it. In case of
a user gives 'COPYIN*' we'd want to know if that is a path (or a name,
label) or bogus, so I think we'd tighten the checks there just for the
functionality not just performance as originally anticipated for the
order of S_ISGITLINK and match_pathspec.

So eventually (i.e. after the submodule groups lands)
"submodule deinit ." will start acting weird again?
