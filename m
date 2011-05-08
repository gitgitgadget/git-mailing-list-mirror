From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/11] revert: Introduce a struct to parse command-line options into
Date: Sun, 8 May 2011 17:48:40 +0530
Message-ID: <20110508121839.GD3114@ramkum.desktop.amazon.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <1302448317-32387-4-git-send-email-artagnon@gmail.com> <20110410192154.GB28163@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 14:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2x3-0002Lk-11
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab1EHMSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 08:18:50 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:30625 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1EHMSt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:18:49 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="430362762"
Received: from smtp-in-0105.sea3.amazon.com ([10.224.19.45])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 12:18:48 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0105.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p48CIkD9023391;
	Sun, 8 May 2011 12:18:47 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id E517F75480E; Sun,  8 May 2011 17:48:40 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110410192154.GB28163@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173103>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -35,17 +35,27 @@ static const char * const cherry_pick_usage[] = {
> >  	NULL
> >  };
> >  
> > -static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
> > -static enum { REVERT, CHERRY_PICK } action;
> > -static int commit_argc;
> > -static const char **commit_argv;
> > -static int allow_rerere_auto;
> >  
> > +static struct {
> > +	enum { REVERT, CHERRY_PICK } action;
> 
> That would require giving this struct a name, so it can be passed
> around.  Not a bad idea anyway imho since then a person reading
> top-to-bottom is not left in suspense:
> 
>  struct cherry_pick_opts {
> 	enum { REVERT, CHERRY_PICK } action;
> 
> 	unsigned edit:1;
> 	unsigned no_replay:1;
> 	...
>  };

Thanks.  A couple of nits:
1. You can't take the address of a bitfield, so 'edit' and 'replay'
   can't be passed to the command line argument parsing framework
   directly.
2. GCC throws a "warning: useless storage class specifier in empty
   declaration" for this kind of declaration.

-- Ram
