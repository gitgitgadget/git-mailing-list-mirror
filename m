From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Fri, 13 Nov 2015 16:10:41 -0800
Message-ID: <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<20151113233807.GD16173@sigill.intra.peff.net>
	<20151113234116.GA18234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 01:11:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOQq-0006Zp-RU
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbbKNALA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:11:00 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34093 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbbKNAKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:10:42 -0500
Received: by ykfs79 with SMTP id s79so174561485ykf.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uGoiv4nOWXB3c86pIpsJtqr8ueJDNUSfIB2bt894KZU=;
        b=D4XJf4kg7BHeamJpERVE6E2fCk3ldEo/Ro1x3E/NMs+1uYQyNWttIeyAAbs5xa8bsl
         yKv6B1scNmumqMxH2WYEQ3DO7sdHYYCQwDf627feCta95/9OTTg739OVXF+YF1HPAZSD
         feivdkBOEDHcxXiP2Z6p0frR1zUHezHEFA05/fMk8I53ZMHz+FgtKRvXNfpLm6muV/eZ
         Ipi705y6ADaWpJGHaPJaL2tm87SrAlTvDJZcdZWOYj4z1kNfloL1p8m+qfpI3u2/sGiR
         kQkTW3y1MbnPa4QUlvnCFrL1Ip7Q9A1LivUJW5UU1vo4tjcWim4VUzkwgTN7sGbnOzJ1
         XKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uGoiv4nOWXB3c86pIpsJtqr8ueJDNUSfIB2bt894KZU=;
        b=lAZEw6vyQMC/K6AJGv5LR9Bf8Y4oOjIRP0N9XEaUxn5SPixVcfk9Su1jzM0xpD1D6O
         VuCZeFGjD3PPKw6a7r71UB4rdTctZqqga1uTWdxpa8X+eemTUEUsJWsB4b6CxEY/tiHy
         sPI4OiFEnu2tQ1gwaA3ghb31H29SSpYRKTia/6Xywak06gyczq5xNScHzaRpd6KoAiNP
         +TtYNfbjn65yz0T46eYNvDaOKu13BIbEimLJIQKpuY7ZF8zohVjt/kRmojfWvEBwwG+2
         ymfi8L5DCpERgQZh2T93sJ/ox19ZK8mbKyoLqV+G8Uu31r/ucG1aPTCSpTiLTQVVtzUg
         2KVg==
X-Gm-Message-State: ALoCoQk7cZ0D9FUFZT5IszkclS4jnfVLAjQst9dyZOBrTytyOHs1kWduOpWY9D3dIP8o04eGZrjR
X-Received: by 10.13.214.19 with SMTP id y19mr25232524ywd.63.1447459842003;
 Fri, 13 Nov 2015 16:10:42 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 13 Nov 2015 16:10:41 -0800 (PST)
In-Reply-To: <20151113234116.GA18234@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281278>

On Fri, Nov 13, 2015 at 3:41 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 13, 2015 at 06:38:07PM -0500, Jeff King wrote:
>
>> On Fri, Nov 13, 2015 at 03:16:01PM -0800, Stefan Beller wrote:
>>
>> > Junio wrote on Oct 09, 2014:
>> > > This is so non-standard a thing to do that I doubt it is worth
>> > > supporting with "git clone".  "git clone --branch", which is about
>> > "> I want to follow that particular branch", would not mesh well with
>> > > "I want to see the history that leads to this exact commit", either.
>> > > You would not know which branch(es) is that exact commit is on in
>> > > the first place.
>> >
>> > I disagree with this. This is the *exact* thing you actually want to do when
>> > dealing with submodules. When fetching/cloning for a submodule, you want
>> > to obtain the exact sha1, instead of a branch (which happens to be supported
>> > too, but is not the original use case with submodules.)
>>
>> I think this is already implemented in 68ee628 (upload-pack: optionally
>> allow fetching reachable sha1, 2015-05-21), isn't it?
>
> Note that this just implements the server side. I think to use this with
> submodules right now, you'd have to manually "git init && git fetch" in
> the submodule. It might make sense to teach clone to handle this, to
> avoid the submodule code duplicating what the clone code does.

Yes I want to add it to clone, as that is a prerequisite for making
git clone --recursive --depth 1 to work as you'd expect. (such that
the submodule can be cloned&checkout instead of rewriting that to be
init&fetch.

Thanks for pointing out that we already have some kind of server support.

I wonder if we should add an additional way to make fetching only some
sha1s possible. ("I don't want users to fetch any sha1, but only those
where superprojects point{ed} to", even if you force push a superproject,
you want to want to only allow fetching all sha1s which exist in the current
superprojects branch.)

Maybe our emails crossed, but in the other mail I pointed out we could use
some sort of hidden ref (refs/superprojects/*) for that, which are
allowed to mark
any sort of sha1, which are allowed in the superproject/submodule context
to be fetched.

So whenever you push to a superproject (a project that has a gitlink),
we would need to check serverside if that submodule is at us and mark the
correct sha1s in the submodule. Then you can disallow fetching most of the sha1s
but still could have a correctly working submodule update mechanism.

Thanks,
Stefan


>
> -Peff
