From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 06:19:51 -0700 (PDT)
Message-ID: <m3sjh2ay6j.fsf@localhost.localdomain>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
	<20120321121126.GA27660@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 21 14:20:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SALSL-0004XH-7N
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 14:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854Ab2CUNT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 09:19:56 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35777 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782Ab2CUNTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 09:19:54 -0400
Received: by wgbdr13 with SMTP id dr13so655966wgb.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=iWuM4hqdM7wry1JsJFo2KN4NLhjQV933HsF/YmWUYvc=;
        b=dmYnTG1VhzFCI4/9MK9qJJZQz3q29ybimnehvLsYeP+q5JjWhP+WNSVtD6Q6o0ryhQ
         aJL8Q/tkRUbM0XcV6Ef8hDE3G89hkiQuN5EU+md/6TIAIX3+6acjbSd+CMTI4sFJFcof
         Dk11Xi9PAh1wLzjZXB0q8FnWjdwEDGm4UNNV6tQqyZVi3Y9qKc2y62FaWrmDlFdhzRJn
         KmyNz3/rr1z1w9dfoujpGZKHGW3v93yJqvu4RKnY8n8xAmQuNXOmhYQYssJbPXX7HNKh
         DXHAQE19vjxMdj8xoixrUfmFw1hsFVzYtS9MGJB303EYTaSljn0+4vwZIOrIbJqDcG0D
         jojg==
Received: by 10.180.80.70 with SMTP id p6mr37878699wix.21.1332335993447;
        Wed, 21 Mar 2012 06:19:53 -0700 (PDT)
Received: from localhost.localdomain (abwt72.neoplus.adsl.tpnet.pl. [83.8.243.72])
        by mx.google.com with ESMTPS id fl2sm7485061wib.4.2012.03.21.06.19.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 06:19:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2LDJnlh016157;
	Wed, 21 Mar 2012 14:19:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2LDJmhl016154;
	Wed, 21 Mar 2012 14:19:48 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120321121126.GA27660@odin.tremily.us>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193577>

By the way, it is custom on this mailing list to usually Cc (send a
copy) to all people participating in discussion, and not only to git
mailing list.

"W. Trevor King" <wking@drexel.edu> writes:

> Subject: [PATCH v3] Isolate If-Modified-Since handling in gitweb

Perhaps a better title would be:

  gitweb: Refactor If-Modified-Since handling, support in snapshot

to mention all that thispatch does.  Though trouble with coming up
with a short but fairly complete one-line summary might mean that this
patch would be better split in two: refactoring and adding support for
If-Modified-Since to snapshots.

> The current gitweb only generates Last-Modified and handles
> If-Modified-Since headers for the git_feed action.  This patch breaks
> the Last-Modified and If-Modified-Since handling code out from
> git_feed into a new function die_if_unmodified.  This makes the code
> easy to reuse for other actions

O.K.

>                                  where it is appropriate
                                   ^^^^^^^^^^^^^^^^^^^^^^^

This doesn't add any information.  I think it the commit message would
be better if you either remove this, or expand (in a separate
paragraph) where support for If-Modified-Since might make sense, and
where it could not.

>                                                         and adds the
> code to do that to git_snapshot.

This would read better as a separate paragraph.
 
> Signed-off-by: W Trevor King <wking@drexel.edu>                                 
> ---
> Changed since v2:
>   - Shorter title.
>   - Fixed modified_since -> die_if_unmodified in commit message.

Nice.

BTW. what happened to diffstat?

Tests (to be put, I think, in t/t9501-gitweb-standalone-http-status.sh)?
We could use test_tick() and $test_tick for that (or extract formatted
committer date from a commit).
 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad..b944351 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7003,6 +7003,28 @@ sub snapshot_name {
>  	return wantarray ? ($name, $name) : $name;
>  }
>  
> +sub die_if_unmodified {
> +	my ($latest_epoch) = @_;
> +	our $cgi;
> +
> +	my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> +	if (defined $if_modified) {
> +		my $since;
> +		if (eval { require HTTP::Date; 1; }) {
> +			$since = HTTP::Date::str2time($if_modified);
> +		} elsif (eval { require Time::ParseDate; 1; }) {
> +			$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> +		}
> +		if (defined $since && $latest_epoch <= $since) {
> +			my %latest_date = parse_date($latest_epoch);
> +			print $cgi->header(
> +				-last_modified => $latest_date{'rfc2822'},
> +				-status => '304 Not Modified');
> +			goto DONE_GITWEB;
> +		}
> +	}
> +}

O.K.

die_if_unmodified() is good enough name, though I wonder if we could
come up with a better name....

> +
>  sub git_snapshot {
>  	my $format = $input_params{'snapshot_format'};
>  	if (!@snapshot_fmts) {
> @@ -7029,6 +7051,10 @@ sub git_snapshot {
>  
>  	my ($name, $prefix) = snapshot_name($project, $hash);
>  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> +
> +	my %co = parse_commit($hash) or die_error(404, "Unknown commit object");
> +	die_if_unmodified($co{'committer_epoch'});
> +

That unexplainably changes behavior of 'snapshot' action.  Before we
would accept snapshot of a tree given by its SHA-1, now we do not.

This might be a good idea from a security point of view wrt. leaking
information (c.f. "git archive --remote" behavior), but it at least
needs to be explained in commit message, and perhaps even in a comment
above this line.

Alternative solution would be to skip If-Modified-Since handling if we
request snapshot by tree id:

  +
  +	my %co = parse_commit($hash);
  +	die_if_unmodified($co{'committer_epoch'}) if %co;
  +

> @@ -7038,9 +7064,11 @@ sub git_snapshot {
>  	}
>  
>  	$filename =~ s/(["\\])/\\$1/g;
> +	my %latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
>  	print $cgi->header(
>  		-type => $known_snapshot_formats{$format}{'type'},
>  		-content_disposition => 'inline; filename="' . $filename . '"',
> +		-last_modified => $latest_date{'rfc2822'},
>  		-status => '200 OK');

Of course this would need to be updated too.
  
>  	open my $fd, "-|", $cmd
> @@ -7820,24 +7848,8 @@ sub git_feed {
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
>  		my $latest_epoch = $latest_commit{'committer_epoch'};
> +		die_if_unmodified($latest_epoch);
>  		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
> -		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> -		if (defined $if_modified) {
> -			my $since;
> -			if (eval { require HTTP::Date; 1; }) {
> -				$since = HTTP::Date::str2time($if_modified);
> -			} elsif (eval { require Time::ParseDate; 1; }) {
> -				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> -			}
> -			if (defined $since && $latest_epoch <= $since) {
> -				print $cgi->header(
> -					-type => $content_type,
> -					-charset => 'utf-8',
> -					-last_modified => $latest_date{'rfc2822'},
> -					-status => '304 Not Modified');
> -				return;
> -			}
> -		}
>  		print $cgi->header(
>  			-type => $content_type,
>  			-charset => 'utf-8',

Nice.

-- 
Jakub Narebski
