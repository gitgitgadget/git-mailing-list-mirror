From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 22:57:47 +0200
Message-ID: <20140819205747.GB64203@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
 <20140819102421.GA5012@book.hvoigt.net>
 <CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
 <xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
 <CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
 <20140819193010.GA64203@book.hvoigt.net>
 <CAHd499BvBBymACfHVZyuSXuNSFbT+M8my4uATOsn30w90Zb0QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 23:02:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJqYR-0006RX-HN
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 23:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaHSVCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 17:02:51 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:51410 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaHSVCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 17:02:51 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XJqTU-00083P-Rn; Tue, 19 Aug 2014 22:57:48 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499BvBBymACfHVZyuSXuNSFbT+M8my4uATOsn30w90Zb0QQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255518>

On Tue, Aug 19, 2014 at 03:23:36PM -0500, Robert Dailey wrote:
> On Tue, Aug 19, 2014 at 2:30 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > Well the remote for the submodule is currently only calculated once,
> > when you do the initial
> >
> >         git submodule update --init
> >
> > that clones the submodule. Afterwards the fixed url is configured under
> > the name 'origin' in the submodule like in a normal git repository that
> > you have freshly cloned. Which remote is used for cloning depends on the
> > configured remote for the current branch or 'origin'.
> >
> > When you do a fetch or push with --recurse-submodules it only executes a
> > 'git fetch' or 'git push' without any specific remote. For fetch the
> > same commandline options (but only the options) are passed on.
> >
> > Here it might make sense to guess the remote in the submodule somehow
> > and not do what fetch without remotes would do.
> >
> > For the triangular workflow not much work has been done in regards to
> > submodule support.
> >
> > But since a submodule behaves like a normal git repository maybe there
> > is not much work needed and we can just point to the workflow without
> > submodules most times. We still have to figure that out properly.
> 
> Maybe then the only thing we need is a --with-remote option for git
> submodule? ::
> 
> git submodule update --init --with-remote myremote
> 
> The --with-remote option would be a NOOP if it's already initialized,
> as you say. But I could create an alias for this as needed to make
> sure it is always specified.

I would actually error out when specified in already cloned state.
Because otherwise the user might expect the remote to be updated.

Since we are currently busy implementing recursive fetch and checkout I have
added that to our ideas list[1] so we do not forget about it.

In the meantime you can either use the branch.<name>.remote
configuration to define a remote to use or just use 'origin'.

Cheers Heiko

[1] https://github.com/jlehmann/git-submod-enhancements/wiki#add-with-remote--switch-to-submodule-update
