From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-cvsimport: allow author-specific timezones
Date: Tue, 16 Oct 2012 22:28:51 -0700
Message-ID: <7vr4oxpsz0.fsf@alter.siamese.dyndns.org>
References: <1350446009-25059-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOMBz-0003IU-O1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 07:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab2JQF3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 01:29:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196Ab2JQF3F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 01:29:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C0DA6F21;
	Wed, 17 Oct 2012 01:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vdL6jv4UQWInrYdyzh5EAFWqo6E=; b=TlAwX7
	ESLlPCfYTDs20HSCAUXsyOjs2pDEMEKBINsubb+o8nmUUBiiUZB9IfTstKhdRyb3
	WfyO5K6FMGkQhIZK0fiJqMrVrlac3vvf2CR/2M9RoPoEt+hO7Rih0Kt1gF9GEZ/z
	REbN0CW1L1nbyBY68psCqzYlsry5gGrHaqEyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bsu0SyQqnO5yM7vNkfX90hv23/BVJgdb
	/wlb09Z+s9Yn+2oqmg2mhJRPFREZOq0kMeKCyx5MvjWVp9FkONVLh4V6ttBwryS9
	0NWInWHb+scorwPkTc0eXTkxKwcShsfn/a4J751VBzwHBPJr4fHfVfAa3/YE7atr
	SFHl6ZpebWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183106F20;
	Wed, 17 Oct 2012 01:29:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 334CF6F14; Wed, 17 Oct 2012
 01:29:00 -0400 (EDT)
In-Reply-To: <1350446009-25059-1-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Tue, 16 Oct 2012 22:53:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E2000D0-181B-11E2-AFFA-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207893>

Chris Rorvick <chris@rorvick.com> writes:

> CVS patchsets are imported with timestamps having an offset of +0000
> (UTC).  The cvs-authors file is already used to translate the CVS
> username to full name and email in the corresponding commit.  Extend
> this file to support an optional timezone for calculating a user-
> specific timestamp offset.
>
> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---
>
> Use System V timezones in unit test per feedback from Junio and Peff.
> Also, use timestamps from before the 2007 changes to DST--seems
> reasonable that people may not have bothered patching their systems for
> this in some parts of the world.

OK ;-)

> Is continuing to update the patch helpful at this point, or is this
> just noise?

A convention around here is to keep replacing until the series is
merged to 'next', and after that fix it up with incremental updates.
To make this process work well, a new series that is still under
active discussion is queued on 'pu' and after seeing rough consensus
on the list, it is merged to 'next'.

Will replace what has been queued on 'pu' with this version, after
fixing up an obvious typo in the documentation patch ("and and").

Thanks.

>  Documentation/git-cvsimport.txt    |   8 +-
>  git-cvsimport.perl                 |  22 ++-
>  t/t9604-cvsimport-timestamps.sh    |  71 ++++++++++
>  t/t9604/cvsroot/.gitattributes     |   1 +
>  t/t9604/cvsroot/CVSROOT/.gitignore |   2 +
>  t/t9604/cvsroot/module/a,v         | 265 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 362 insertions(+), 7 deletions(-)
>  create mode 100755 t/t9604-cvsimport-timestamps.sh
>  create mode 100644 t/t9604/cvsroot/.gitattributes
>  create mode 100644 t/t9604/cvsroot/CVSROOT/.gitignore
>  create mode 100644 t/t9604/cvsroot/module/a,v
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 6695ab3..9ea8bb5 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -137,17 +137,19 @@ This option can be used several times to provide several detection regexes.
>  -A <author-conv-file>::
>  	CVS by default uses the Unix username when writing its
>  	commit logs. Using this option and an author-conv-file
> -	in this format
> +	maps the name recorded in CVS to author name, e-mail and
> +	and optional timezone:
>  +
>  ---------
>  	exon=Andreas Ericsson <ae@op5.se>
> -	spawn=Simon Pawn <spawn@frog-pond.org>
> +	spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
>  
>  ---------
>  +
>  'git cvsimport' will make it appear as those authors had
>  their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
> -all along.
> +all along.  If a timezone is specified, GIT_AUTHOR_DATE will
> +have the corresponding offset applied.
>  +
>  For convenience, this data is saved to `$GIT_DIR/cvs-authors`
>  each time the '-A' option is provided and read from that same
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 8032f23..ceb119d 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -31,7 +31,7 @@ $SIG{'PIPE'}="IGNORE";
>  $ENV{'TZ'}="UTC";
>  
>  our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
> -my (%conv_author_name, %conv_author_email);
> +my (%conv_author_name, %conv_author_email, %conv_author_tz);
>  
>  sub usage(;$) {
>  	my $msg = shift;
> @@ -59,6 +59,14 @@ sub read_author_info($) {
>  			$conv_author_name{$user} = $2;
>  			$conv_author_email{$user} = $3;
>  		}
> +		# or with an optional timezone:
> +		#   spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
> +		elsif (m/^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*(\S+?)\s*$/) {
> +			$user = $1;
> +			$conv_author_name{$user} = $2;
> +			$conv_author_email{$user} = $3;
> +			$conv_author_tz{$user} = $4;
> +		}
>  		# However, we also read from CVSROOT/users format
>  		# to ease migration.
>  		elsif (/^(\w+):(['"]?)(.+?)\2\s*$/) {
> @@ -84,7 +92,9 @@ sub write_author_info($) {
>  	  die("Failed to open $file for writing: $!");
>  
>  	foreach (keys %conv_author_name) {
> -		print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>\n";
> +		print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>";
> +		print $f " $conv_author_tz{$_}" if ($conv_author_tz{$_});
> +		print $f "\n";
>  	}
>  	close ($f);
>  }
> @@ -795,7 +805,7 @@ sub write_tree () {
>  	return $tree;
>  }
>  
> -my ($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
> +my ($patchset,$date,$author_name,$author_email,$author_tz,$branch,$ancestor,$tag,$logmsg);
>  my (@old,@new,@skipped,%ignorebranch,@commit_revisions);
>  
>  # commits that cvsps cannot place anywhere...
> @@ -844,7 +854,9 @@ sub commit {
>  		}
>  	}
>  
> -	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
> +	$ENV{'TZ'}=$author_tz;
> +	my $commit_date = strftime("%s %z", localtime($date));
> +	$ENV{'TZ'}="UTC";
>  	$ENV{GIT_AUTHOR_NAME} = $author_name;
>  	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
>  	$ENV{GIT_AUTHOR_DATE} = $commit_date;
> @@ -945,12 +957,14 @@ while (<CVS>) {
>  		}
>  		$state=3;
>  	} elsif ($state == 3 and s/^Author:\s+//) {
> +		$author_tz = "UTC";
>  		s/\s+$//;
>  		if (/^(.*?)\s+<(.*)>/) {
>  		    ($author_name, $author_email) = ($1, $2);
>  		} elsif ($conv_author_name{$_}) {
>  			$author_name = $conv_author_name{$_};
>  			$author_email = $conv_author_email{$_};
> +			$author_tz = $conv_author_tz{$_} if ($conv_author_tz{$_});
>  		} else {
>  		    $author_name = $author_email = $_;
>  		}
> diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
> new file mode 100755
> index 0000000..1fd5142
> --- /dev/null
> +++ b/t/t9604-cvsimport-timestamps.sh
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +
> +test_description='git cvsimport timestamps'
> +. ./lib-cvs.sh
> +
> +setup_cvs_test_repository t9604
> +
> +test_expect_success 'check timestamps are UTC (TZ=CST6CDT)' '
> +
> +	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
> +	git cvsimport -p"-x" -C module-1 module &&
> +	(
> +		cd module-1 &&
> +		git log --format="%s %ai"
> +	) >actual-1 &&
> +	cat >expect-1 <<-EOF &&
> +	Rev 16 2006-10-29 07:00:01 +0000
> +	Rev 15 2006-10-29 06:59:59 +0000
> +	Rev 14 2006-04-02 08:00:01 +0000
> +	Rev 13 2006-04-02 07:59:59 +0000
> +	Rev 12 2005-12-01 00:00:00 +0000
> +	Rev 11 2005-11-01 00:00:00 +0000
> +	Rev 10 2005-10-01 00:00:00 +0000
> +	Rev  9 2005-09-01 00:00:00 +0000
> +	Rev  8 2005-08-01 00:00:00 +0000
> +	Rev  7 2005-07-01 00:00:00 +0000
> +	Rev  6 2005-06-01 00:00:00 +0000
> +	Rev  5 2005-05-01 00:00:00 +0000
> +	Rev  4 2005-04-01 00:00:00 +0000
> +	Rev  3 2005-03-01 00:00:00 +0000
> +	Rev  2 2005-02-01 00:00:00 +0000
> +	Rev  1 2005-01-01 00:00:00 +0000
> +	EOF
> +	test_cmp actual-1 expect-1
> +'
> +
> +test_expect_success 'check timestamps with author-specific timezones' '
> +
> +	cat >cvs-authors <<-EOF &&
> +	user1=User One <user1@domain.org>
> +	user2=User Two <user2@domain.org> CST6CDT
> +	user3=User Three <user3@domain.org> EST5EDT
> +	user4=User Four <user4@domain.org> MST7MDT
> +	EOF
> +	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
> +	(
> +		cd module-2 &&
> +		git log --format="%s %ai %an"
> +	) >actual-2 &&
> +	cat >expect-2 <<-EOF &&
> +	Rev 16 2006-10-29 01:00:01 -0600 User Two
> +	Rev 15 2006-10-29 01:59:59 -0500 User Two
> +	Rev 14 2006-04-02 03:00:01 -0500 User Two
> +	Rev 13 2006-04-02 01:59:59 -0600 User Two
> +	Rev 12 2005-11-30 17:00:00 -0700 User Four
> +	Rev 11 2005-10-31 19:00:00 -0500 User Three
> +	Rev 10 2005-09-30 19:00:00 -0500 User Two
> +	Rev  9 2005-09-01 00:00:00 +0000 User One
> +	Rev  8 2005-07-31 18:00:00 -0600 User Four
> +	Rev  7 2005-06-30 20:00:00 -0400 User Three
> +	Rev  6 2005-05-31 19:00:00 -0500 User Two
> +	Rev  5 2005-05-01 00:00:00 +0000 User One
> +	Rev  4 2005-03-31 17:00:00 -0700 User Four
> +	Rev  3 2005-02-28 19:00:00 -0500 User Three
> +	Rev  2 2005-01-31 18:00:00 -0600 User Two
> +	Rev  1 2005-01-01 00:00:00 +0000 User One
> +	EOF
> +	test_cmp actual-2 expect-2
> +'
> +
> +test_done
> diff --git a/t/t9604/cvsroot/.gitattributes b/t/t9604/cvsroot/.gitattributes
> new file mode 100644
> index 0000000..562b12e
> --- /dev/null
> +++ b/t/t9604/cvsroot/.gitattributes
> @@ -0,0 +1 @@
> +* -whitespace
> diff --git a/t/t9604/cvsroot/CVSROOT/.gitignore b/t/t9604/cvsroot/CVSROOT/.gitignore
> new file mode 100644
> index 0000000..3bb9b34
> --- /dev/null
> +++ b/t/t9604/cvsroot/CVSROOT/.gitignore
> @@ -0,0 +1,2 @@
> +history
> +val-tags
> diff --git a/t/t9604/cvsroot/module/a,v b/t/t9604/cvsroot/module/a,v
> new file mode 100644
> index 0000000..3c338a0
> --- /dev/null
> +++ b/t/t9604/cvsroot/module/a,v
> @@ -0,0 +1,265 @@
> +head	1.16;
> +access;
> +symbols;
> +locks; strict;
> +comment	@# @;
> +
> +
> +1.16
> +date	2006.10.29.07.00.01;	author user2;	state Exp;
> +branches;
> +next	1.15;
> +
> +1.15
> +date	2006.10.29.06.59.59;	author user2;	state Exp;
> +branches;
> +next	1.14;
> +
> +1.14
> +date	2006.04.02.08.00.01;	author user2;	state Exp;
> +branches;
> +next	1.13;
> +
> +1.13
> +date	2006.04.02.07.59.59;	author user2;	state Exp;
> +branches;
> +next	1.12;
> +
> +1.12
> +date	2005.12.01.00.00.00;	author user4;	state Exp;
> +branches;
> +next	1.11;
> +
> +1.11
> +date	2005.11.01.00.00.00;	author user3;	state Exp;
> +branches;
> +next	1.10;
> +
> +1.10
> +date	2005.10.01.00.00.00;	author user2;	state Exp;
> +branches;
> +next	1.9;
> +
> +1.9
> +date	2005.09.01.00.00.00;	author user1;	state Exp;
> +branches;
> +next	1.8;
> +
> +1.8
> +date	2005.08.01.00.00.00;	author user4;	state Exp;
> +branches;
> +next	1.7;
> +
> +1.7
> +date	2005.07.01.00.00.00;	author user3;	state Exp;
> +branches;
> +next	1.6;
> +
> +1.6
> +date	2005.06.01.00.00.00;	author user2;	state Exp;
> +branches;
> +next	1.5;
> +
> +1.5
> +date	2005.05.01.00.00.00;	author user1;	state Exp;
> +branches;
> +next	1.4;
> +
> +1.4
> +date	2005.04.01.00.00.00;	author user4;	state Exp;
> +branches;
> +next	1.3;
> +
> +1.3
> +date	2005.03.01.00.00.00;	author user3;	state Exp;
> +branches;
> +next	1.2;
> +
> +1.2
> +date	2005.02.01.00.00.00;	author user2;	state Exp;
> +branches;
> +next	1.1;
> +
> +1.1
> +date	2005.01.01.00.00.00;	author user1;	state Exp;
> +branches;
> +next	;
> +
> +
> +desc
> +@@
> +
> +
> +1.16
> +log
> +@Rev 16
> +@
> +text
> +@Rev 16
> +@
> +
> +
> +1.15
> +log
> +@Rev 15
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 15
> +@
> +
> +
> +1.14
> +log
> +@Rev 14
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 14
> +@
> +
> +
> +1.13
> +log
> +@Rev 13
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 13
> +@
> +
> +
> +1.12
> +log
> +@Rev 12
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 12
> +@
> +
> +
> +1.11
> +log
> +@Rev 11
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 11
> +@
> +
> +
> +1.10
> +log
> +@Rev 10
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 10
> +@
> +
> +
> +1.9
> +log
> +@Rev  9
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 9
> +@
> +
> +
> +1.8
> +log
> +@Rev  8
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 8
> +@
> +
> +
> +1.7
> +log
> +@Rev  7
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 7
> +@
> +
> +
> +1.6
> +log
> +@Rev  6
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 6
> +@
> +
> +
> +1.5
> +log
> +@Rev  5
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 5
> +@
> +
> +
> +1.4
> +log
> +@Rev  4
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 4
> +@
> +
> +
> +1.3
> +log
> +@Rev  3
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 3
> +@
> +
> +
> +1.2
> +log
> +@Rev  2
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 2
> +@
> +
> +
> +1.1
> +log
> +@Rev  1
> +@
> +text
> +@d1 1
> +a1 1
> +Rev 1
> +@
> +
