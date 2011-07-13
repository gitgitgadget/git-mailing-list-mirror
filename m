From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 21:33:57 -0400
Message-ID: <CAEBDL5WYn7v7kZiR8p5GD4r5sMPxMUibcmhMHBjvdZ4n6mSPag@mail.gmail.com>
References: <20110711161332.GA10057@sigill.intra.peff.net>
	<20110711161754.GB10418@sigill.intra.peff.net>
	<7vliw4d1hu.fsf@alter.siamese.dyndns.org>
	<20110711220107.GC30155@sigill.intra.peff.net>
	<7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
	<20110712000304.GA32276@sigill.intra.peff.net>
	<20110712193844.GA17322@toss.lan>
	<20110712194540.GA21180@sigill.intra.peff.net>
	<20110712210716.GB17322@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jul 13 03:34:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgoL0-0006qx-D7
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 03:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab1GMBd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 21:33:59 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:57246 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308Ab1GMBd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 21:33:58 -0400
Received: by fxd18 with SMTP id 18so5462252fxd.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=kcY4hy9bkK5cnf522efUzFjZMAuQSLQidr5LvOAVHFI=;
        b=UaoJws60LNSZ1nQsRKHKJPnAQ9YZ2MlX6nfRoJ7uX7Z7RYa4wc+yiRLOIyY3rIajBm
         QpdtMvF9e1nxc2H1mi+Ztzuk0Z4yfXqV7GlDzyYFyctd3odSQ4MaQ49P/NVDVAke8W8+
         LVwBi7pJydoOjwCll9zYDa8x4HYyvWUBD8svs=
Received: by 10.223.30.87 with SMTP id t23mr829912fac.51.1310520837427; Tue,
 12 Jul 2011 18:33:57 -0700 (PDT)
Received: by 10.223.30.68 with HTTP; Tue, 12 Jul 2011 18:33:57 -0700 (PDT)
In-Reply-To: <20110712210716.GB17322@toss.lan>
X-Google-Sender-Auth: 5_fwN6D27WC1WMD5x8uIPkHxw8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176991>

On Tue, Jul 12, 2011 at 5:07 PM, Clemens Buchacher <drizzd@aon.at> wrote:
[snip]
> Now, one might argue that this is a corner case. But it's actually
> very common. In the example, the patch-id changes because of an
> extra change in a different text area. That is indeed unlikely.
> However, the same problem will occur in a much more common case.
> Let's say we have a patch with 10 hunks. The patch is applied
> upstream, with only one difference in one of the hunks.
> Subsequently, text areas affected by any of the other hunks change
> upstream. When the original patch is rebased on top of that, it
> will conflict with the one hunk that was changed in the upstream
> version of that patch. And that's ok. Git should not decide which
> version is correct. But in addition to that conflict there will
> also be conflicts for all the other hunks, which the upstream patch
> did _not_ modify. And all of those conflicts will look like
> reverts.
>
> I believe that is the main reason why rebase is so painful all the
> time.

Clemens, that's a great description of the problem.  I've run into
this several times, and it is really confusing.  I've spent
considerable time tracking down the real conflict... only to find the
real issue was in something non-related and easily resolved.  IMHO, I
agree with you Clemens: this has been my major source of pain.

-John
