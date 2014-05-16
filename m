From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 04:23:15 -0500
Message-ID: <5375d903dd6c_1a1b8d33081f@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 11:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlEX3-000354-BH
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 11:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbaEPJeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 05:34:20 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:52259 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaEPJeR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 05:34:17 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so2657681obc.6
        for <git@vger.kernel.org>; Fri, 16 May 2014 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Cxedm6F7u13NF7ShLNyWgD42bHA/q+pBIPGhVehx2dY=;
        b=xX81xFTzpvBANhRK6u6M+kD80qxkgGYQ5duWnCwYHqCTpGBTGva32F/Wd3xZUnb2+e
         wXm+jkiR2HEopNjNh1YBcMkVJVe5nFynamnQricLTAmnlEFyDSYlpTuqc+d7clxiJh8G
         a4HZ53XS52lJyf61jU0k1O6sDeZRBvX1qDTlCvgsKNPKK4Pg2Ro7LDeGKzU0AhEx4t4D
         gu7SxAILwe9YQ5Qf1LbpzyO+o30yb5Rd3PBpjXGRc8Mqt2drFBIn0n2xvQ8EcUTQvO61
         GepCiJOVNFZei6xzcX83w+UCy9whUMgb1hQaPD4NKlUJ+9VBNkYEs9zOvdh7V6lukRI4
         +vBw==
X-Received: by 10.60.54.38 with SMTP id g6mr1332416oep.79.1400232857589;
        Fri, 16 May 2014 02:34:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p1sm13943463obh.28.2014.05.16.02.34.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 02:34:16 -0700 (PDT)
In-Reply-To: <20140516084126.GB21468@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249288>

Jeff King wrote:
> On Thu, May 15, 2014 at 03:56:29PM -0700, Junio C Hamano wrote:
> 
> > Two announcements for their version 0.2 on the list archive are not
> > quite enough to advertise them to their users.
> 
> I do not think this README nor a mention in the release notes will get
> their attention either, and many people (and packagers) will continue to
> use the stale versions forever until those versions go away.
> 
> I would much rather _replace_ them with a README in the long run, and
> people will notice that they are gone, and then use the README to update
> their install procedure.
> 
> For 2.0, I am hesitant to do that, though I do not have a problem with a
> README like this as a heads-up to prepare packagers for the future. I
> say hesitant because people may have been test-packaging 2.0.0-rc3 in
> preparation for release, and it will be annoying to them to suddenly
> switch.

I agree, that's why I sent patches that:

 1) Add a warning for v2.0 (which already has problems)

    So everything keeps working as well as in the release candidates,
    except a warning is introduced each time they do a fetch, push, or
    clone operation (use the remote-helpers)

 2) Replace the tools with stubs

    So when they try to fetch, push, or clone, they get an error, and
    nothing else happens.

There's an additional README for the people that want to read more, but
if you don't put stubs, users might try to do what worked before:

  % git clone hg::http://selenic.com/repo/hello
  fatal: Unable to find remote helper for 'hg'

It's much better to report:

  git-remote-hg is now maintained independently.
  For more information visit https://github.com/felipec/git-remote-hg

> But that being said, this is Felipe's code. While we have a legal right
> to distribute it in v2.0, if he would really prefer it out for v2.0, I
> would respect that.

That's right, you have the legal right to distributed it.

It is not my wish to disrupt v2.0, so I think adding a warning should be
sufficient.

Eventually I would prefer if they were not distributed, and replaced
with stubs, not just because it would help the out-of-tree projects
gather more visibility, but also because users would be better served by
not having poorly maintained or unsynchronized code. Hopefully for v2.1.

> I would prefer to instrument the code with warnings, as that is the sort
> of thing a packager moving from -rc3 to -final might not notice, and
> shipping the warnings to end users who did not package the software in
> the first place will not help them. It is the attention of the packagers
> (and source-builders) you want to get.
> 
> Of course that is all just my two cents, and is mostly predicated on
> there _being_ packagers of the contrib/ tools. It looks like there is a
> Debian package in RFP status, but I don't know if that is following the
> new release closely. And I don't know about other systems.

As far as I understand most distributions don't do anything special with
contrib, they just put everything under /usr/share.

It is unlikely packagers will notice any change in one of the dozens
tools in contrib, so they'll make no changes to the packages.

So if the user did:

 % ln -s /usr/share/git/remote-helpers/git-remote-hg ~/bin/git-remote-hg

The expectation would be that this keeps working even if the package
doesn't change (it just adds a warning). Eventually it will stop working
with an error, but the package still won't change.

The distributions that do something special about remote-helpers (AFAIK
it's only debian's git-bzr) would need to change, and sooner or later
they will if there's only stubs there.

Cheers.

-- 
Felipe Contreras
