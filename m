From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 11:53:20 -0800
Message-ID: <7vhalqsfkf.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 20:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2oaT-0003YU-7H
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 20:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab3BETxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 14:53:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309Ab3BETxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 14:53:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A201CA8F;
	Tue,  5 Feb 2013 14:53:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2zNix5PJ9YC4ljab1SxU/bdFEQU=; b=l5PMZV
	jQPLES00im67qEKq9tCWgzGOzGG5XWQNMhBS0Be8ck/gCCfTijz8YO4tjsd4vDs5
	QBgovmCl13V5CMUqE9EZP9t+5b2T1HzXbnDAeZqiVx71wgxsT7o9xNWxg0nPHx+w
	XV12MiMN+U6hkZNoixkpwu7vu7ObJm/pnc5/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EHayE8hCPzYMKO8DV3xAPhwTjQ73nS9C
	M+zkqBboDka3MIDM1R3fcREjIwQ46WtQK086fHNMtGdC32aE54bbfAgUQ9STrZLb
	nYKSEhhEB3DjNlb6CIRub5YdZbYSeaP5eSGyLfVUmWVco0QTRgUOjB+cZQkRy/MG
	KA+2i9uOBec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E9D5CA8E;
	Tue,  5 Feb 2013 14:53:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54A0FCA7A; Tue,  5 Feb 2013
 14:53:22 -0500 (EST)
In-Reply-To: <87fw1ar3og.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Tue, 05 Feb 2013 13:55:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B23862C8-6FCD-11E2-84D3-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215529>

Ted Zlatanov <tzz@lifelogs.com> writes:

> Changes since PATCHv3:
>
> - simple tests in Makefile
> - support multiple files, code refactored
> - documentation and comments updated
> - fix IO::File for GPG pipe
> - exit peacefully in almost every situation, die on bad invocation or query
> - use log_verbose() and -v for logging for the user
> - use log_debug() and -d for logging for the developer
> - use Net::Netrc parser and `man netrc' to improve parsing
> - ignore 'default' and 'macdef' netrc entries
> - require 'machine' token in netrc lines
> - ignore netrc files with bad permissions or owner (from Net::Netrc)

Please place the above _after_ the three-dashes.

The space here, above "---", is to justify why this change is a good
idea to people who see this patch for the first time who never saw
the earlier rounds of this patch, e.g. reading "git log" output 6
months down the road (see Documentation/SubmittingPatches "(2)
Describe your changes well").

>
> Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
> ---
>  contrib/credential/netrc/Makefile             |   10 +
>  contrib/credential/netrc/git-credential-netrc |  423 +++++++++++++++++++++++++
>  2 files changed, 433 insertions(+), 0 deletions(-)
>  create mode 100644 contrib/credential/netrc/Makefile
>  create mode 100755 contrib/credential/netrc/git-credential-netrc
>
> diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
> new file mode 100644
> index 0000000..ee8c5f0
> --- /dev/null
> +++ b/contrib/credential/netrc/Makefile
> @@ -0,0 +1,10 @@
> +test_netrc:
> +	@(echo "bad data" | ./git-credential-netrc -f A -d -v) || echo "Bad invocation test, ignoring failure"
> +	@echo "-> Silent invocation... nothing should show up here with a missing file"

Avoid starting an argument to "echo" with a dash; some
implementations choke with "unknown option".

> +	@echo "bad data" | ./git-credential-netrc -f A get
> +	@echo "-> Back to noisy: -v and -d used below, missing file"
> +	echo "bad data" | ./git-credential-netrc -f A -d -v get
> +	@echo "-> Look for any entry in the default file set"
> +	echo "" | ./git-credential-netrc -d -v get
> +	@echo "-> Look for github.com in the default file set"
> +	echo "host=google.com" | ./git-credential-netrc -d -v get
> diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
> new file mode 100755
> index 0000000..6946217
> --- /dev/null
> +++ b/contrib/credential/netrc/git-credential-netrc
> @@ -0,0 +1,423 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +use warnings;
> +
> +use Getopt::Long;
> +use File::Basename;
> +
> +my $VERSION = "0.1";
> +
> +my %options = (
> +               help => 0,
> +               debug => 0,
> +               verbose => 0,
> +	       file => [],

Looks like there is some funny indentation going on here.

> +
> +               # identical token maps, e.g. host -> host, will be inserted later
> +               tmap => {
> +                        port => 'protocol',
> +                        machine => 'host',
> +                        path => 'path',
> +                        login => 'username',
> +                        user => 'username',
> +                        password => 'password',
> +                       }
> +              );
> +
> +# Map each credential protocol token to itself on the netrc side.
> +foreach (values %{$options{tmap}}) {
> +	$options{tmap}->{$_} = $_;
> +}
> +
> +# Now, $options{tmap} has a mapping from the netrc format to the Git credential
> +# helper protocol.
> +
> +# Next, we build the reverse token map.
> +
> +# When $rmap{foo} contains 'bar', that means that what the Git credential helper
> +# protocol calls 'bar' is found as 'foo' in the netrc/authinfo file.  Keys in
> +# %rmap are what we expect to read from the netrc/authinfo file.
> +
> +my %rmap;
> +foreach my $k (keys %{$options{tmap}}) {
> +	push @{$rmap{$options{tmap}->{$k}}}, $k;
> +}
> +
> +Getopt::Long::Configure("bundling");
> +
> +# TODO: maybe allow the token map $options{tmap} to be configurable.
> +GetOptions(\%options,
> +           "help|h",
> +           "debug|d",
> +           "verbose|v",
> +           "file|f=s@",
> +          );
> +
> +if ($options{help}) {
> +	my $shortname = basename($0);
> +	$shortname =~ s/git-credential-//;
> +
> +	print <<EOHIPPUS;
> +
> +$0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] [-v] get
> +
> +Version $VERSION by tzz\@lifelogs.com.  License: BSD.
> +
> +Options:
> +
> +  -f|--file AUTHFILE : specify netrc-style files.  Files with the .gpg extension
> +                       will be decrypted by GPG before parsing.  Multiple -f
> +                       arguments are OK, and the order is respected.

Saying "order is respected" without mentioning the collision
resolution rules is not helpful to the users when deciding in what
order they should give these files.  First one wins, or last one
wins?  Later you say "looks for the first entry", but it will be
much easier to read the above to mention it here as well.

> +  -d|--debug         : turn on debugging (developer info)
> +
> +  -v|--verbose       : be more verbose (show files and information found)
> +
> +To enable this credential helper:
> +
> +  git config credential.helper '$shortname -f AUTHFILE1 -f AUTHFILE2'
> +
> +(Note that Git will prepend "git-credential-" to the helper name and look for it
> +in the path.)
> +
> +...and if you want lots of debugging info:
> +
> +  git config credential.helper '$shortname -f AUTHFILE -d'
> +
> +...or to see the files opened and data found:
> +
> +  git config credential.helper '$shortname -f AUTHFILE -v'
> +
> +Only "get" mode is supported by this credential helper.  It opens every AUTHFILE
> +and looks for the first entry that matches the requested search criteria:
> +
> + 'port|protocol':
> +   The protocol that will be used (e.g., https). (protocol=X)
> +
> + 'machine|host':
> +   The remote hostname for a network credential. (host=X)
> +
> + 'path':
> +   The path with which the credential will be used. (path=X)
> +
> + 'login|user|username':
> +   The credential’s username, if we already have one. (username=X)
> +
> +Thus, when we get this query on STDIN:
> +
> +protocol=https
> +username=tzz
> +
> +this credential helper will look for the first entry in every AUTHFILE that
> +matches
> +
> +port https login tzz
> +
> +OR
> +
> +protocol https login tzz
> +
> +OR... etc. acceptable tokens as listed above.  Any unknown tokens are
> +simply ignored.
> +
> +Then, the helper will print out whatever tokens it got from the entry, including
> +"password" tokens, mapping back to Git's helper protocol; e.g. "port" is mapped
> +back to "protocol".

Isn't "hostname" typically what users expect to see?  It is somewhat
unnerving to see an example that throws the same password back to
any host you happen to have an accoutn "tzz" on, even though that is
not technically an invalid way to use this helper.

> +Again, note that the first matching entry from all the AUTHFILEs is used.
> +
> +Tokens can be quoted as 'STRING' or "STRING".
> +
> +No caching is performed by this credential helper.
> +
> +EOHIPPUS

Otherwise, nice write-up.

> +my $mode = shift @ARGV;
> +
> +# Credentials must get a parameter, so die if it's missing.
> +die "Syntax: $0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] get" unless defined $mode;
> +
> +# Only support 'get' mode; with any other unsupported ones we just exit.
> +exit 0 unless $mode eq 'get';
> +
> +my $files = $options{file};
> +
> +# if no files were given, use a predefined list.
> +# note that .gpg files come first
> +unless (scalar @$files)
> +{
> +	my @candidates = qw[
> +				   ~/.authinfo.gpg
> +				   ~/.netrc.gpg
> +				   ~/.authinfo
> +				   ~/.netrc
> +			  ];
> +
> +	$files = $options{file} = [ map { glob $_ } @candidates ];
> +}
> +
> +my $query = read_credential_data_from_stdin();
> +
> +FILE:
> +foreach my $file (@$files)
> +{
> +	unless (-r $file)
> +	{
> +		log_verbose("Unable to read $file; skipping it");
> +		next FILE;
> +	}
> +
> +	# the following check is copied from Net::Netrc
> +	# OS/2 and Win32 do not handle stat in a way compatable with this check :-(
> +	unless ($^O eq 'os2'
> +		|| $^O eq 'MSWin32'
> +		|| $^O eq 'MacOS'
> +		|| $^O =~ /^cygwin/)
> +	{
> +		my @stat = stat($file);
> +
> +		if (@stat) {
> +			if ($stat[2] & 077) {
> +				log_verbose("Insecure $file (mode=%04o); skipping it",
> +					    $stat[2] & 07777);

Nice touch, although I am not sure rejecting world or group readable
encrypted file is absolutely necessary.

> +				next FILE;
> +			}
> +			if ($stat[4] != $<) {
> +				log_verbose("Not owner of $file; skipping it");
> +				next FILE;

OK.  A group of local users may share the same account at the
remote, but that would be unusual.

> +			}
> +		}
> +	}
> +
> +	my $mode = (stat($file))[2];
> +	if ($mode & 077)
> +	{
> +		log_verbose("Insecure $file (mode=%04o); skipping it",
> +			    $mode & 07777);

Again?  Didn't you just do this?

> +		next FILE;
> +	}
> +
> +	my @entries = load_netrc($file);
> +
> +	unless (scalar @entries)
> +	{
> +		if ($!)
> +		{
> +			log_verbose("Unable to open $file: $!");
> +		}
> +		else
> +		{
> +			log_verbose("No netrc entries found in $file");
> +		}

I think the prevalent style is to

	if (condition) {
        	do this;
	} elsif (another condition) {
		do that
	} else {
		do that other thing;
	}

(this comment applies to all if/elsif/else cascades in this patch).

> +
> +		next FILE;

Isn't this outermost loop, by the way?  What the motivation to have
an explicit label everywhere (not complaining---it could be your own
discipline thing---just wondering).

> +	}
> +
> +	my $entry = find_netrc_entry($query, @entries);
> +	if ($entry)
> +	{
> +		print_credential_data($entry, $query);
> +		# we're done!
> +		last FILE;
> +	}
> +}
> +
> +exit 0;
> +
> +sub load_netrc
> +{
> +	my $file = shift @_;
> +
> +	my $io;
> +	if ($file =~ m/\.gpg$/) {
> +		log_verbose("Using GPG to open $file");
> +		# GPG doesn't work well with 2- or 3-argument open

If that is the case, please quote $file properly against shell
munging it.

The only thing you do on $io is to read from it via "while (<$io>)",
so I would personally have written this part like this without
having to use IO::File(), though:

	$io = open("-|", qw(gpg --decrypt), $file);

Similarly for the plain file:

	$io = open("<", $file);

> +		$io = new IO::File("gpg --decrypt $file|");
> +	}
> +	else {
> +		log_verbose("Opening $file...");
> +		$io = new IO::File($file, '<');
> +	}
> +
> +	# nothing to do if the open failed (we log the error later)
> +	return unless $io;
> +
> +	# Net::Netrc does this, but the functionality is merged with the file
> +	# detection logic, so we have to extract just the part we need
> +	my @netrc_entries = net_netrc_loader($io);
> +
> +	# these entries will use the credential helper protocol token names
> +	my @entries;
> +
> +	foreach my $nentry (@netrc_entries) {
> +		my %entry;
> +		my $num_port;
> +
> +		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
> +			$num_port = $nentry->{port};
> +			delete $nentry->{port};
> +		}
> +
> +		# create the new entry for the credential helper protocol
> +		$entry{$options{tmap}->{$_}} = $nentry->{$_} foreach keys %$nentry;
> +
> +		# for "host X port Y" where Y is an integer (captured by
> +		# $num_port above), set the host to "X:Y"
> +		if (defined $entry{host} && defined $num_port) {
> +			$entry{host} = join(':', $entry{host}, $num_port);
> +		}
> +
> +		push @entries, \%entry;
> +	}
> +
> +	return @entries;
> +}
> +
> +sub net_netrc_loader
> +{
> +	my $fh = shift @_;
> +	my @entries;
> +	my ($mach, $macdef, $tok, @tok) = (0, 0);

I think you meant to use $mach as a reference to a hash and $macdef
as a reference to an array; do you want to initialize them to
numeric zeros?

(The remainder of the patch unsnipped for others' reference).

Thanks.

> +    LINE:
> +	while (<$fh>) {
> +		undef $macdef if /\A\n\Z/;
> +
> +		if ($macdef) {
> +			push(@$macdef, $_);
> +			next LINE;
> +		}
> +
> +		s/^\s*//;
> +		chomp;
> +
> +		while (length && s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//) {
> +			(my $tok = $+) =~ s/\\(.)/$1/g;
> +			push(@tok, $tok);
> +		}
> +
> +	    TOKEN:
> +		while (@tok) {
> +			$tok = shift(@tok);
> +
> +			if ($tok eq "machine") {
> +				my $host = shift @tok;
> +				$mach = { machine => $host };
> +				push @entries, $mach;
> +			}
> +			elsif (exists $options{tmap}->{$tok}) {
> +				unless ($mach) {
> +					log_debug("Skipping token $tok because no machine was given");
> +					next TOKEN;
> +				}
> +
> +				my $value = shift @tok;
> +				unless (defined $value) {
> +					log_debug("Token $tok had no value, skipping it.");
> +					next TOKEN;
> +				}
> +
> +				# Following line added by rmerrell to remove '/' escape char in .netrc
> +				$value =~ s/\/\\/\\/g;
> +				$mach->{$tok} = $value;
> +			}
> +			elsif ($tok eq "macdef") { # we ignore macros
> +				next TOKEN unless $mach;
> +				my $value = shift @tok;
> +				$mach->{macdef} = {} unless exists $mach->{macdef};
> +				$macdef = $mach->{machdef}{$value} = [];
> +			}
> +		}
> +	}
> +
> +	return @entries;
> +}
> +
> +sub read_credential_data_from_stdin
> +{
> +	# the query: start with every token with no value
> +	my %q = map { $_ => undef } values(%{$options{tmap}});
> +
> +	while (<STDIN>) {
> +		next unless m/^([^=]+)=(.+)/;
> +
> +		my ($token, $value) = ($1, $2);
> +		die "Unknown search token $token" unless exists $q{$token};
> +		$q{$token} = $value;
> +		log_debug("We were given search token $token and value $value");
> +	}
> +
> +	foreach (sort keys %q) {
> +		log_debug("Searching for %s = %s", $_, $q{$_} || '(any value)');
> +	}
> +
> +	return \%q;
> +}
> +
> +# takes the search tokens and then a list of entries
> +# each entry is a hash reference
> +sub find_netrc_entry
> +{
> +	my $query = shift @_;
> +
> +    ENTRY:
> +	foreach my $entry (@_)
> +	{
> +		my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
> +		foreach my $check (sort keys %$query) {
> +			if (defined $query->{$check}) {
> +				log_debug("compare %s [%s] to [%s] (entry: %s)",
> +					  $check,
> +					  $entry->{$check},
> +					  $query->{$check},
> +					  $entry_text);
> +				unless ($query->{$check} eq $entry->{$check}) {
> +					next ENTRY;
> +				}
> +			}
> +			else {
> +				log_debug("OK: any value satisfies check $check");
> +			}
> +		}
> +
> +		return $entry;
> +	}
> +
> +	# nothing was found
> +	return;
> +}
> +
> +sub print_credential_data
> +{
> +	my $entry = shift @_;
> +	my $query = shift @_;
> +
> +	log_debug("entry has passed all the search checks");
> + TOKEN:
> +	foreach my $git_token (sort keys %$entry) {
> +		log_debug("looking for useful token $git_token");
> +		# don't print unknown (to the credential helper protocol) tokens
> +		next TOKEN unless exists $query->{$git_token};
> +
> +		# don't print things asked in the query (the entry matches them)
> +		next TOKEN if defined $query->{$git_token};
> +
> +		log_debug("FOUND: $git_token=$entry->{$git_token}");
> +		printf "%s=%s\n", $git_token, $entry->{$git_token};
> +	}
> +}
> +sub log_verbose {
> +	return unless $options{verbose};
> +	printf STDERR @_;
> +	printf STDERR "\n";
> +}
> +
> +sub log_debug {
> +	return unless $options{debug};
> +	printf STDERR @_;
> +	printf STDERR "\n";
> +}
