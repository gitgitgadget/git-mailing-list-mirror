From: John Keeping <john@keeping.me.uk>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 7 Aug 2013 19:31:17 +0100
Message-ID: <20130807183117.GC2337@serenity.lan>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <4EE8B37B-F6A1-4BC4-9151-8546868E60A5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 20:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V78WA-0006By-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 20:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149Ab3HGSb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 14:31:26 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:57821 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab3HGSbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 14:31:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E8BA2606534;
	Wed,  7 Aug 2013 19:31:24 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6g-7S8I+u2C; Wed,  7 Aug 2013 19:31:24 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 39520606501;
	Wed,  7 Aug 2013 19:31:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <4EE8B37B-F6A1-4BC4-9151-8546868E60A5@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231842>

On Wed, Aug 07, 2013 at 11:01:57AM -0700, Kyle J. McKay wrote:
> On Aug 7, 2013, at 09:00, Ramkumar Ramachandra wrote:
> > Hi,
> >
> > This is the difference between whatchanged and log:
> >
> > diff --git a/whatchanged b/log
> > index fa1b223..004d9aa 100644
> > --- a/tmp/whatchanged
> > +++ b/tmp/log
> > @@ -1,4 +1,4 @@
> > -int cmd_whatchanged(int argc, const char **argv, const char *prefix)
> > +int cmd_log(int argc, const char **argv, const char *prefix)
> > {
> >        struct rev_info rev;
> >        struct setup_revision_opt opt;
> > @@ -7,13 +7,10 @@ int cmd_whatchanged(int argc, const char **argv,
> > const char *prefix)
> >        git_config(git_log_config, NULL);
> >
> >        init_revisions(&rev, prefix);
> > -       rev.diff = 1;
> > -       rev.simplify_history = 0;
> > +       rev.always_show_header = 1;
> >        memset(&opt, 0, sizeof(opt));
> >        opt.def = "HEAD";
> >        opt.revarg_opt = REVARG_COMMITTISH;
> >        cmd_log_init(argc, argv, prefix, &rev, &opt);
> > -       if (!rev.diffopt.output_format)
> > -               rev.diffopt.output_format = DIFF_FORMAT_RAW;
> >        return cmd_log_walk(&rev);
> > }
> >
> > Should we remove it?
> 
> I use it all the time.  Is there some log option to get exactly the  
> same output?  It doesn't appear that there is.  The closest looks like  
> "log --name-status" but it omits the modes and hash values.

Is it not identical to "log --raw --no-merges"?

A quick test says "mostly", but whatchanged doesn't show empty commits
whereas log does seem to; e.g. in git.git:

    diff -u <(git whatchanged) <(git log --raw --no-merges)
