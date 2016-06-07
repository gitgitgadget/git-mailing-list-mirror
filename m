From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 15:35:07 -0700
Message-ID: <CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com>
References: <20160607195608.16643-1-santiago@nyu.edu> <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net> <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net> <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net> <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
 <20160607221325.GA21166@sigill.intra.peff.net> <xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
 <20160607222908.GA25631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: santiago@nyu.edu, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:40:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPbI-0003jB-7w
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423393AbcFGWf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:35:29 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34566 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161129AbcFGWf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:35:27 -0400
Received: by mail-yw0-f178.google.com with SMTP id c72so3310456ywb.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Jc9DkDvuJhwKvXe4+5HDwcER7tYgw32kbAy7HjPiAJA=;
        b=GQwtoMsN2SmDYINLMkuepl9Q2U6pCXbxjSJV0X232SWeOMdoz4pA0XaynWz9Kjgjey
         njJycNxdjHCFKEZaYRhIvCGy5q7xjJPOH8A7xzrqzXeZGXllzz3Uzaiu2Qf6TciqaHNW
         FCn4SqJ2cO9bXA/tB01qHwudbDcimS4fXmLGWzExp+tCwLKbgRyQnVna8+RmyD7I38dP
         LbRQeju++J69wP5gmWg2/DVUBSPMakN+qQrpPuouIVx3DIsWmf8lMj1UT55KkXNGBeqF
         cWCWha0ObA9jYo/c/DCYSXclay4/KKBKHd5YJH6cj4a9WATMwh4mmS3/EGT8fvD87toI
         6zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Jc9DkDvuJhwKvXe4+5HDwcER7tYgw32kbAy7HjPiAJA=;
        b=JoHqcdr11QaJ9AB2kv/sgmrWXff4je30/CH4YZv5Qe0mGj6j2Fe8m4XxG1gKw9yGoU
         rNG6/kv8FNrn+wHdWRKR/q5q8kNMgnaOXdTwolcRZGUZxS9Fbx/Ov4vNjxCHO+8YQVbT
         7wXI20Gyb+zhD0pOhFEMXhdPNpifl3tOiS3iDZjvsSlGU43BGF3vapkdBI+GTZXkLwAf
         I1pc6pcIDQTV0pXjup61G7d+U2axWnoA/XaasidwtAXU6WTZSZ1P+YTmM5wiIf57jE14
         VqAu0dCpErk19IRRIpqDNKDPTH6ncLq2tdcAldSG1gMzF9h4OIo0cev10r+JVaeAOYqK
         OG2A==
X-Gm-Message-State: ALyK8tI7DO7dq/YqVvgw4tdl/bd7fNaj+aNQmY6Q5LGP2HtC6vG7ZbHWTjLbVXGldynP/iH9d7/KGODECa5C+A==
X-Received: by 10.129.146.206 with SMTP id j197mr1126664ywg.73.1465338926777;
 Tue, 07 Jun 2016 15:35:26 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 7 Jun 2016 15:35:07 -0700 (PDT)
In-Reply-To: <20160607222908.GA25631@sigill.intra.peff.net>
X-Google-Sender-Auth: QF81v4Wicz89UFp3mnu5YHcARE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296746>

On Tue, Jun 7, 2016 at 3:29 PM, Jeff King <peff@peff.net> wrote:
> or even:
>
>   git tag --show-tag-name foo/v1.0
>
> when refs/remotes/foo/v1.0 exists?
>
> The rule right now is generally that "git tag" takes actual tag names.

Ahh, I forgot about that. Yes, indeed the command does not work
like other Git commands, which would just let generic revision parser
to accept an object name from anywhere. Probably it was a mistake,
because "git tag --verify $T" may find refs/tags/$T but that may not
necessarily mean "git checkout $T^0" would give you that exact
tree state, but it is too late to change now.

So yes, I agree with you that any validation-related thing needs to
start from names relative to refs/tags/, not from object names, to be
consistent.

Which is a bit sad, but I do not offhand think of a way to avoid it.
