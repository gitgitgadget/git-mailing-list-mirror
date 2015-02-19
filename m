From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 16:43:32 -0800
Message-ID: <CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com> <CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
 <CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOFDk-0005aY-7s
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 01:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbbBSAnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 19:43:55 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:64381 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbbBSAny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 19:43:54 -0500
Received: by mail-yk0-f174.google.com with SMTP id 9so2747570ykp.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 16:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qJqtdBS780UHXhqv0Cu14m4bzCHox8ECXoXon66kV/Q=;
        b=UL/rZQ7yyqbLbSifncXlg4FNTidAzkeeisqEMorZL0wYY99huZx+6u7+2mdvEwc8Ck
         mBRtRDauS6P9YsEQcWoZJ2Mp2ujuUjfSFIGNWxHZ9gTbiDW529ws59VeFbMvR5ls45F0
         BQb7ulaunS7GsuhjiWppXW0YZen2aTmznlBGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qJqtdBS780UHXhqv0Cu14m4bzCHox8ECXoXon66kV/Q=;
        b=PNG+im92eUhnMiP1OUS+UPqj8n1RxpLSww9sjhEXYkYeMYyEORIUf281DDCOXKxK3m
         IKEQWRJpS8mQH4p8jPcrSZkr42w6ccmXYyY+VSAR6I1AT0OMs9Olj/LWfy/HGYjg/cQw
         PXgAHywa89sr0thRxpSbV83Iwkod4O5jSCpDYA5vnU79dwStQpHFaJzp0YmjPXfLm/2j
         rUUABGOYC9K7AcbWr7xt3uXzlUdWPIWlla/o+UPFCa1ljVVR1ps4Okkr+PcawEvEo3nr
         n5R+D6m43y1KiJtJLolUjJTw0RvF5xfHzIjG7JKfGWoRRSYU/4lGDfIRrmIEhjnaQSr/
         LsTQ==
X-Gm-Message-State: ALoCoQlxIOy8ERYRRNivoQKw9KauaLIHsxsobOBaiB+3uLEZt5rdh2yO71LnGT0pY7izlHs5ChQk
X-Received: by 10.236.29.244 with SMTP id i80mr1313469yha.113.1424306633037;
 Wed, 18 Feb 2015 16:43:53 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Wed, 18 Feb 2015 16:43:32 -0800 (PST)
In-Reply-To: <CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264077>

On Wed, Feb 18, 2015 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Checking out a random branch is absolutely the worst thing you can
> do. Personally, I would think that the best thing you can do is to
> educate your users not to clone from a void. Create some history
> that is worth sharing, and then push into an empty repository.

Users are dumb.

Consider a website like GitHub where you create a repository on a a
remote server. It is initialized as an empty repo. They now want to
clone that empty repo to work with it:

  git clone https://example.com/foo
  cd foo
  .... hack hack
  git commit -a -m "Foo is awesome!"
  git push

This works from git-core servers because the ref advertisement tells
the client its an empty repo and its OK to checkout HEAD from nothing
and its all fine.

This fails from a JGit server because the ref advertisement for an
empty repository differs and disagrees with the format used by
git-core. The result is a confused client spewing an odd checkout
message.
