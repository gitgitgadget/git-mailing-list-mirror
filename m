From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 5/5] [squash] fsck: revert --quick to the default and
 introduce --medium
Date: Fri, 30 Jan 2009 12:37:55 +0100
Organization: private
Message-ID: <861vulqb1o.fsf@broadpark.no>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
 <1233313517-24208-2-git-send-email-gitster@pobox.com>
 <1233313517-24208-3-git-send-email-gitster@pobox.com>
 <1233313517-24208-4-git-send-email-gitster@pobox.com>
 <1233313517-24208-5-git-send-email-gitster@pobox.com>
 <1233313517-24208-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 12:39:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSriX-0007gN-Fl
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZA3LiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbZA3Lh7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:37:59 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:42883 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbZA3Lh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:37:58 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEA00G9J8B8KH00@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 30 Jan 2009 12:37:56 +0100 (CET)
Received: from localhost ([80.202.92.196]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEA00FM88B72Z90@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 30 Jan 2009 12:37:56 +0100 (CET)
In-reply-to: <1233313517-24208-6-git-send-email-gitster@pobox.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107801>

Junio C Hamano <gitster@pobox.com> writes:
<snipp>
> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index 72bf33b..83faa98 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -20,7 +20,7 @@ static int show_tags;
>  static int show_unreachable;
>  static int include_reflogs = 1;
>  static int check_full;
> -static int check_quick;
> +static int check_medium;
>  static int check_strict;
>  static int keep_cache_objects;
>  static unsigned char head_sha1[20];
> @@ -578,7 +578,7 @@ static struct option fsck_opts[] = {
>  	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
>  	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (default)"),
>  	OPT_BOOLEAN(0, "full", &check_full, "fully check packs"),
> -	OPT_BOOLEAN(0, "quick", &check_quick, "only check loose objects"),
> +	OPT_BOOLEAN(0, "medium", &check_medium, "also check packs"),
>  	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
>  	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
>  				"write dangling objects in .git/lost-found"),
> @@ -594,8 +594,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  	errors_found = 0;
>  
>  	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
> -	if (check_full && check_quick)
> -		die("--full and --quick?  which one do you want?");
> +	if (check_full && check_medium)
> +		die("--full and --medium?  which one do you want?");
>  

  Would it not be better to have an "OPT_INT" argument named
  "check_level" or similar?

  Then you do not need those error checks, and people would maybe
  better understand the differences between the different check's?

  The documentation could then say that (for example) "level 2
  includes all check's that level 1 includes, in addition to ...".

  -- kjetil
