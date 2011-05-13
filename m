From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/8] revert: Separate cmdline argument handling from the functional code
Date: Fri, 13 May 2011 15:05:03 +0530
Message-ID: <20110513093501.GE14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-5-git-send-email-artagnon@gmail.com> <20110511114909.GE2676@elie> <20110513090923.GB14272@ramkum.desktop.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKomM-0001hl-2X
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399Ab1EMJfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 05:35:20 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:45872 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252Ab1EMJfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 05:35:19 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="435358904"
Received: from smtp-in-9001.sea19.amazon.com ([10.186.144.32])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 09:35:18 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-9001.sea19.amazon.com (8.13.8/8.13.8) with ESMTP id p4D9ZGaj003861;
	Fri, 13 May 2011 09:35:16 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 573F7754840; Fri, 13 May 2011 15:05:03 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110513090923.GB14272@ramkum.desktop.amazon.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173516>

Hi again,

Ramkumar Ramachandra writes:
> Jonathan Nieder writes:
> > Ramkumar Ramachandra wrote:
> > > --- a/builtin/revert.c
> > > +++ b/builtin/revert.c
> > > @@ -603,19 +603,12 @@ static int read_and_refresh_cache(struct replay_opts *opts)
> > >  	return 0;
> > >  }
> > >  
> > > -static int revert_or_cherry_pick(int argc, const char **argv,
> > > -				struct replay_opts *opts)
> > > +static int pick_commits(struct replay_opts *opts)
> > >  {
> > >  	struct rev_info revs;
> > >  	struct commit *commit;
> > > -	const char *me;
> > >  	int res;
> > >  
> > > -	git_config(git_default_config, NULL);
> > > -	me = (opts->action == REVERT ? "revert" : "cherry-pick");
> > > -	setenv(GIT_REFLOG_ACTION, me, 0);
> > > -	parse_args(argc, argv, opts);
> > > -
> > >  	if (opts->allow_ff) {
> > 
> > I don't see why the caller sets up GIT_REFLOG_ACTION, since the caller
> > is not making the commits.  Is there an example where it would use
> > something other than "cherry-pick" or "revert"?
> 
> Nice catch! Yes, GIT_REFLOG_ACTION should be in pick_commits.

Er, I mean in do_pick_commit.  Right?

-- Ram
