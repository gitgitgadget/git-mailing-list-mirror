From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] builtin/clone: support submodule groups
Date: Tue, 1 Dec 2015 10:58:41 -0800
Message-ID: <CAGZ79kaLKGtfXZpOEY9yR9viwCDfi_cxhwCWNjh5_2qtcdBtzQ@mail.gmail.com>
References: <5656366D.4010508@web.de>
	<1448497884-2624-1-git-send-email-sbeller@google.com>
	<20151126045929.GA29107@tsaunders-iceball.corp.tor1.mozilla.com>
	<CAGZ79kbUktcGNw4C123dxGoUsi=W+h4vUPWmBm2rExipUOcXqA@mail.gmail.com>
	<565D43D1.9030207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3q8g-0006wK-8T
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 19:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbbLAS6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 13:58:54 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34433 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907AbbLAS6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 13:58:42 -0500
Received: by ykfs79 with SMTP id s79so19042278ykf.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YrtUYS7e6R0iTX8JWqTISOGrXgP2HK1WnSvhPvrKKwo=;
        b=Ot39LidBKBwJQn/WLWQB8+cije2QSUZoYe4jkLLNHC0Pa2IQfo2qqW2xf8O5upTYda
         /OucXeeUcxc6WYGra6MgP15BPu4rETY4O8rR/H6bBf4LNva/72/YAaT0aY5DEM4HJsj+
         BFIsHL3v3BylbRlc30oc23rhpUgXEQuo+x0rPGjk/EpDZEfKnQSusLAoUx91h9F7v/ce
         QYriuspC3GUJvxYafE3gGYSPOc/uIHiY/z6UB4Oz/0MM+w4s4ptFyuJLVjp7s7hqntBY
         l82Q6yE6Ez9XKLtJW4UnklnfZqJwZr7Wr7FsyT5wv9GbjH2/SFrj7Muk9cLHxVCMFNdk
         DXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YrtUYS7e6R0iTX8JWqTISOGrXgP2HK1WnSvhPvrKKwo=;
        b=Lzz2h/41SlzkSJdpWgcj2YA8B2PJpbin7PQO1yOv7MDD7O2gkDynn6JNodG6DvHzMc
         9qenRdBojD2RLnLFJH9G6Ih5OBpqmc5gJycn5CoUOWVgD05TrHw63dgcu+9ZpPo0niv6
         E56bTd92n/eU2D6twIfQBu1ptVZtpR7vDpqCcDh90TS+IrUiCoPnumunsoJ09d0++rSB
         +jrAcXavkIBQJqdIE2kpF/VqIC6+t2DO/7VJxTSe4gXj59NN7cRrYwmo+Cu3ZWXb5mo7
         2PVW/GzJBXi+kDc2lNlvJ6pRStMRPbKEP+9z8SSuY2VPjx9nkkusm2o3ItnzwvCLMhpj
         CrgA==
X-Gm-Message-State: ALoCoQk/4W+S2VQp5MyCOlAEPegnFtGn5rieiWVmsXzJObsNTIXw9gbBHM17kOwTFpBkWtjegz1v
X-Received: by 10.13.221.21 with SMTP id g21mr21088927ywe.320.1448996321820;
 Tue, 01 Dec 2015 10:58:41 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Tue, 1 Dec 2015 10:58:41 -0800 (PST)
In-Reply-To: <565D43D1.9030207@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281842>

On Mon, Nov 30, 2015 at 10:53 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I think we have to solve more basic issues for sparse checkouts first.
> I'm using them with extra worktrees now and everything seems to be
> working fine. But we need to get the UI right for the simple case (no
> submodules, maybe not even extra worktrees) first: setting up patterns
> before checkout etc. Having submodules in mind doesn't hurt, tough.

Well my thinking comes from the other side: "I want to improve submodule
handling, but do I need to pay any attention to sparse checkout?", as Trevor
pointed out, this may or may not be similar enough from a users perspective,
that we want to have a similar/same UI there.

>
> I still consider sparse checkouts a local "cludge" (not technically
> cludgy) in the sense that it helps you cater to some specific local
> needs; not something whose config you'd want to transport as part of the
> object store.

Right, the submodule groups would be in the same boat. Each user would decide
locally what groups they think is worth having. Unlike the sparse checkout
the repository contains the groups however. As fair as I understand the sparse
checkout you would specify to checkout /foo/* but not checkout /bar/*

Now it is likely that some people will have very similar preferences for their
sparse checkout, so it may make sense to add an abstraction layer in there,
which can be done by groups. These groups could be defined using similar
patterns as in .gitattributes or .gitignore in another .gitgroups file. Maybe
the .gitattributes file could be reused.

The definition of the groups would be in the repository, such that it is kept
maintained and the individual user only needs to specify a few groups they're
interested in.

Currently you can already checkout submodules in a sparse fashion by just
initializing and checking out those submodules you want. But I think this
is not feasible if you have a huge amount of submodules, because you cannot
apply file patterns like you could with a .git{attributes, ignore, groups}
file. Because of the missing pattern, I'd want to add the groups.

>
> Minor implementation detail: Do we have any precedence of comma
> separated values for config values? I'd say we rather use multiple
> entries, don't we?

Ok, I'll fix that.

>
> Michael
