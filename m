From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Thu, 5 May 2016 21:00:54 -0400
Message-ID: <20160506010053.GA15474@sigill.intra.peff.net>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
 <20160504062618.GA9849@sigill.intra.peff.net>
 <20160504074559.GA3077@sigill.intra.peff.net>
 <20160504080047.GA2436@sigill.intra.peff.net>
 <CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
 <20160505012219.GA15090@sigill.intra.peff.net>
 <xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
 <20160505201416.GD9162@sigill.intra.peff.net>
 <xmqqtwic6pxs.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ4wOQrZETB4UVVRO6oecF-qqjzb9hP6-JenNxFNfjiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 03:01:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayU8b-0005kB-DB
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 03:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbcEFBA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 21:00:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:34877 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754196AbcEFBA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 21:00:57 -0400
Received: (qmail 30878 invoked by uid 102); 6 May 2016 01:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 May 2016 21:00:56 -0400
Received: (qmail 23790 invoked by uid 107); 6 May 2016 01:01:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 May 2016 21:01:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2016 21:00:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ4wOQrZETB4UVVRO6oecF-qqjzb9hP6-JenNxFNfjiLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293733>

On Thu, May 05, 2016 at 05:23:51PM -0700, Stefan Beller wrote:

> >> -/*
> >> - * This function is intended as a callback for use with
> >> - * git_config_from_parameters(). It ignores any config options which
> >> - * are not suitable for passing along to a submodule, and accumulates the rest
> >> - * in "data", which must be a pointer to a strbuf. The end result can
> >> - * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
> >> - */
> >> -int sanitize_submodule_config(const char *var, const char *value, void *data);
> >> -
> >>  /*
> >>   * Prepare the "env_array" parameter of a "struct child_process" for executing
> >>   * a submodule by clearing any repo-specific envirionment variables, but
> >> - * retaining any config approved by sanitize_submodule_config().
> >> + * retaining any config in the environment.
> >>   */
> >>  void prepare_submodule_repo_env(struct argv_array *out);
> >>
> >>
> >> -Peff
> >
> > Hmph, Stefan, do you want to keep this (if you want to resurrect the
> > function in some future, for example)?
> 
> IMHO it is easier to revert or rewrite than to carry unused code?
> Unused code is not tested and untested code is broken code.
> And relying on broken code in the future will guarantee bugs.
> (Sure new code may also have bugs, but I just think that bugs
> in newly written code can be fixed easier)
> 
> I would prefer to get rid of it, i.e. taking that patch.

Keep in mind this squash is just dropping the _declaration_. The code
itself was dropped in the earlier patch. (And I agree there isn't a good
reason to keep it when we can easily "git revert" later).

-Peff
