From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6 (v2)] gitweb: Restructure projects list generation
Date: Sat, 7 May 2011 20:39:22 +0200
Message-ID: <201105072039.24548.jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com> <1304099521-27617-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cHZxN4XOF9hlBxz"
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 21:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QImp2-0007SV-0R
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 21:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab1EGTFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 15:05:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab1EGTFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 15:05:42 -0400
Received: by fxm17 with SMTP id 17so2941234fxm.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:message-id;
        bh=2fU3jGUiGHOgWz2oc9l23MUzU6uj+ADZjZgZvgLMCZE=;
        b=MeFZBGCeGFbU+7YRHjRCkPVlwnKKF0/Jl5Ojc8qTVMaWwL64xG0jE9F1CHR38t/fj4
         wj0OEWagA6nb5lFwbFXrq5g53pX2+dayd1QmFLMgxrLjnqHuwrBhjA21yAvfPu17HwKz
         8BxTOG02mYRIviZe8GSpty1tn0RPaT1cbEpeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        b=SVGIXYwnyZXhTbOgeGJQMNn82qZcI9f++UfeNxs5JkQgjzYvhS1w0bDi7oWcsrWhkB
         aavXLHdfeIi5FZ5zvP79ai9In/oZc/E0ed4ZwLIU17jiiOWmpYcaByKuPqywcazAysOx
         m1eyOivHtZxO5FOqVghJKL90+ygX6qvLh44uc=
Received: by 10.223.121.96 with SMTP id g32mr231834far.0.1304793575495;
        Sat, 07 May 2011 11:39:35 -0700 (PDT)
Received: from [192.168.1.13] (abwd142.neoplus.adsl.tpnet.pl [83.8.227.142])
        by mx.google.com with ESMTPS id j12sm1453909fax.33.2011.05.07.11.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 11:39:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1304099521-27617-2-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173062>

--Boundary-00=_cHZxN4XOF9hlBxz
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 29 Apr 2011, Jakub Narebski wrote:

> Extract filtering out forks (which is done if 'forks' feature is
> enabled) into filter_forks_from_projects_list subroutine, and
> searching projects (via projects search form, or via content tags)
> into search_projects_list subroutine.

If it was all this patch did, it would be probably easier to review.
Should I then split this patch into smaller, though not entirely
standalone patches: pure refactoring, improving finding forks, and
adding tests?

> Sorting projects got also refactored in a very straight way (just
> moving code) into sort_projects_list subroutine.

This also could be refactored in a separate patch... though I rather
have all refactorings together, so one can see the result: clean code.
=20
> The interaction between forks, content tags and searching is now made
> more explicit: searching whether by tag, or via search form turns off
> fork filtering (gitweb searches also forks, and will show all
> results).  If 'ctags' feature is disabled, then searching by tag is
> too.

This is functional change that makes code more clear, and I think it
makes better behavior... but it changes how gitweb behaves, so it is
not pure refactoring.  Should I put it into a bit artificial separate
patch?
=20
> While at it we now detect that there are no projects and respond with
> "404 No projects found" also for 'project_index' and 'opml' actions.

This "while at it" is here because we can now say "No projects found"
for 'projects_list' action, because filtering / searching is done
upfront, so we know if we found anything.

But again, this perhaps would be better put in a separate patch.
=20
[...]
> filter_forks_from_projects_list() uses trie[1] (prefix tree) to find
> which repositories are forks of other projects; directories are used
> as "letters" in trie.  Algorithm to create trie and find prefix match
> was created with some help of code of Tree::Tree[2] Perl module from
> CPAN.
>=20
> [1]: http://en.wikipedia.org/wiki/Trie
> [2]: http://p3rl.org/Tree::Trie

This change in algorithm should perhaps be put in a separate patch...

> Note that before this commit filtering out forks worked only for
> $projects_list being a file, it assumed that forks are always after
> forked project (not very unreasonable), and used algorithm which is
> O(<projects>^2).
>=20
> Current code filters out projects only where it should, regardless
> whether $projects_list is directory or a file, and trie-based
> algorithm is O(<projects>) + O(<projects forked>*<max depth>).
> Current code also consistently finds shortest prefix (important in
> counting forks in case of forks of forks).

Jakub Narebski wrote in
"Re: What's cooking in git.git (May 2011, #02; Wed, 4)"
http://thread.gmane.org/gmane.comp.version-control.git/172789/focus=3D172820

> Junio C Hamano <gitster@pobox.com> writes:
[...]
>> * jn/ctags (2011-04-29) 6 commits
>>  - gitweb: Optional grouping of projects by category
>>  - gitweb: Modularized git_get_project_description to be more generic
>>  - gitweb: Split git_project_list_body in two functions
>>  - gitweb: Mark matched 'ctag' / contents tag (?by_tag=3Dfoo)
>>  - gitweb: Change the way "content tags" ('ctags') are handled
>>  - gitweb: Restructure projects list generation
>>=20
>> Waiting for comments.
>=20
> Should I do and post benchmarks for
>=20
>    - gitweb: Restructure projects list generation
>=20
> change (when 'forks' feature is used)?

It is not easy to compare old and new code, because those algorithm
have different behavior.

Best I can come up with is comparing pure fork detection (not the time
it takes to generate page) - I can easy mock that - for sizes comparable
with http://repo.or.cz which uses 'forks' feature.  repo.or.cz has
around 4,000 projects, around 300 of those have forks (note: forks are
not included in number of projects).  From non-representative sample
most forked project have but single fork; note however that there are
repositories such as git.git, which has 55 forks, and some of those have
forks on its own (forks of forks).

 plan: nprojects=3D4000; nprojects_forked=3D300; nforks_per_forked_project=
=3D1
 number of projects: 4000

 Benchmark: running old, new for at least 600 CPU seconds...
        old: 1231.38 wallclock secs (620.23 usr +  1.30 sys =3D 621.53 CPU)=
 @  0.03/s (n=3D21)
        new:  847.6  wallclock secs (632.34 usr +  0.80 sys =3D 633.14 CPU)=
 @  5.18/s (n=3D3277)
     s/iter    old    new
 old   29.6     --   -99%
 new  0.193 15219%     --

 Dumbbench: running old, new for at least 50 iterations...
 old: Ran 106 iterations (25 outliers).
 old: Rounded run time per iteration: 3.316e+01  +/- 1.5e-01 (0.5%)
 new: Ran 66 iterations (15 outliers).
 new: Rounded run time per iteration: 2.0213e-01 +/- 2.1e-04 (0.1%)

Below there is table of time versus number of projects, used to generate
attached and linked images.  Data was generated using Dumbbench module
from CPAN.

 ########################################################
 # nforks  =3D 5 (forks per project forked)
 # nforked =3D 5.00%
 # 1:projects 2:nforked  3:old 4:old_err  5:new 5:new_err
 #  0   0  8.959e-06  2.2e-08  1.0137e-05 2.0e-08
   50   3  3.211e-03  1.6e-05  2.0524e-03 5.0e-06
  103   5  1.4003e-02 6.7e-05  4.477e-03  2.2e-05
  204  10  5.647e-02  2.3e-04  9.464e-03  4.6e-05
  402  20  2.1939e-01 3.2e-04  1.9943e-02 9.6e-05
  500  25  3.666e-01  3.6e-03  2.706e-02  2.5e-04
  800  40  9.124e-01  1.7e-03  4.175e-02  2.1e-04
 1000  50  1.575e+00  1.3e-02  5.896e-02  5.3e-04
 1600  80  3.738e+00  1.2e-02  9.347e-02  4.3e-04
 2004 100  6.820e+00  6.7e-02  1.1216e-01 3.6e-04
 3203 160  1.8189e+01 8.5e-02  1.8144e-01 4.5e-04
 4003 200  2.927e+01  2.9e-01  2.2939e-01 5.7e-04

Script used to generate this data is attached.

=46rom those data we can generate a plot to show how time depends on size
of problem (on total number of projects).  Assuming that both "old" ane
"new" are P i.e. are O(n^k), where 'n' is number of projects, this
dependency is best examined on loglog scale.

      y =3D x^k
  log y =3D log (x^k) =3D k * log x
      v =3D k * u,  where u =3D log x, v =3D log y

This plot, together with fit of cubic polynomial and linear function
to the data, is shown in

  https://git.wiki.kernel.org/index.php/File:Benchmark_find_forks-old_vs_ne=
w.png

(I'm sorry for abusing git wiki for sharing images...).
=2D-=20
Jakub Narebski
Poland

--Boundary-00=_cHZxN4XOF9hlBxz
Content-Type: text/plain;
  charset="iso-8859-2";
  name="benchmark_find_forks.perl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="benchmark_find_forks.perl"

#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(first);
use POSIX qw(ceil);

use Acme::MetaSyntactic qw(any);
use Benchmark qw(:all :hireswallclock);
use Dumbbench;

use Data::Dumper::Concise; # for debugging


# ----------------------------------------------------------------------

# old: version used to be in git_get_projects_list for $projects_list file
sub filter__git_get_projects_list {
	my ($projects, $need_sorting) = @_;

	@$projects = sort { $a->{'path'} cmp $b->{'path'} } @$projects
		if ($need_sorting);

	my (@filtered, %paths);
 PROJECT:
	foreach my $pr (@$projects) {
		my $path = $pr->{'path'};

		# below is v1.7.5.1:gitweb/gitweb.perl lines 2725 and later
	PATH:
		foreach my $filter (keys %paths) {
			# looking for forks
			my $pfx = substr($path, 0, length($filter));
			if ($pfx ne $filter) {
				next PATH;
			}
			my $sfx = substr($path, length($filter));
			if ($sfx !~ /^\/.*\.git$/) {
				next PATH;
			}
			# is a fork, don't include it in
			# the list
			next PROJECT;
		}

		# [...]
		# below is v1.7.5.1:gitweb/gitweb.perl line 2746 and later
		push @filtered, $pr;
		(my $forks_path = $path) =~ s/\.git$//;
		$paths{$forks_path}++;
	}

	return @filtered;
}


# new: using 'path' only, using trie; code borrowed from Tree::Trie (Perl Artistic License)
sub filter_forks_from_projects_list {
	my ($projects, $need_sorting) = @_;

	@$projects = sort { $a->{'path'} cmp $b->{'path'} } @$projects
		if ($need_sorting);

	my %trie; # prefix tree of directories (path components)
	# generate trie out of those directories that might contain forks
	foreach my $pr (@$projects) {
		my $path = $pr->{'path'};
		$path =~ s/\.git$//;      # forks of 'repo.git' are in 'repo/' directory
		next if ($path =~ m!/$!); # skip non-bare repositories, e.g. 'repo/.git'
		next unless ($path);      # skip '.git' repository: tests, git-instaweb
		#next unless (-d $path);  # containing directory exists (NOT IN TESTS!!!)
		$pr->{'forks'} = [];      # there can be 0 or more forks of project

		# add to trie
		my @dirs = split('/', $path);
		# walk the trie, until either runs out of components or out of trie
		my $ref = \%trie;
		while (scalar @dirs &&
		       exists($ref->{$dirs[0]})) {
			$ref = $ref->{shift @dirs};
		}
		# create rest of trie structure from rest of components
		foreach my $dir (@dirs) {
			$ref = $ref->{$dir} = {};
		}
		# create end marker, store $pr as a data
		$ref->{''} = $pr if (!exists $ref->{''});
	}

	# filter out forks, by finding shortest prefix match for paths
	my @filtered;
 PROJECT:
	foreach my $pr (@$projects) {
		# trie lookup
		my $ref = \%trie;
	DIR:
		foreach my $dir (split('/', $pr->{'path'})) {
			if (exists $ref->{''}) {
				# found [shortest] prefix, is a fork - skip it
				push @{$ref->{''}{'forks'}}, $pr;
				next PROJECT;
			}
			if (!exists $ref->{$dir}) {
				# not in trie, cannot have prefix, not a fork
				push @filtered, $pr;
				next PROJECT;
			}
			# If the dir is there, we just walk one step down the trie.
			$ref = $ref->{$dir};
		}
		# we ran out of trie
		# (shouldn't happen: it's either no match, or end marker)
		push @filtered, $pr;
	}

	return @filtered;
}

# ----------------------------------------------------------------------

sub prepare_projects {
	my ($nprojects, $nforked, $nforks_per_project, $exclude_forks) = @_;
	my @projects;

	while ($nprojects > 0) {
		push @projects, metaname().".git";
		$nprojects--;
		last unless $nprojects;

		if (rand() < (1.0*$nforked/$nprojects)) {
			(my $base = $projects[-1]) =~ s/\.git$//;
			push @projects, map { "$base/$_.git" } metaname($nforks_per_project);
			$nprojects -= $nforks_per_project unless $exclude_forks;
			$nforked--;
		}
	}

	#print Dumper(\@projects);
	@projects = map { { 'path' => $_ } } @projects;

	return @projects;
}

# ######################################################################

my (@projects, @filtered);

# repo.or.cz
# * 4038 projects (without forks?), based on http://repo.or.cz/w?a=project_index
# * 4024 projects, based on "grep -c -e '<tr class="'" on http://repo.or.cz/w?a=project_list
# * 3428 active projects, based on "grep -c -e '"age'" on http://repo.or.cz/w?a=project_list
# *  308 projects have forks (7.6-10%), based on grep -c -e '/forks">+</a>' project_list.html
# * nonrepresentative sample of nforks: 6, 2, 1, 1, 0, 0, 1, 0, 1, 2, 3, 3, 3, 55+, 1, 1, 1

my $nprojects = 100;
my $nforked_frac = 0.05;
my $nforked   = ceil($nforked_frac*$nprojects); # 5%
my $nforks    = 5;

$nprojects = 4000;
$nforked   = 300;
$nforks    = 1;

print "plan: nprojects=$nprojects; nforked=$nforked; nforks=$nforks\n";
@projects = prepare_projects($nprojects, $nforked, $nforks);
print "number of projects: ".(scalar @projects)."\n";

print "\n";
my $results = timethese(-600, {
	'old' => sub { filter__git_get_projects_list(\@projects) },
	'new' => sub { filter_forks_from_projects_list(\@projects) },
});
#print Dumper($results);
cmpthese($results);
print "\n";

print "Dumbbench: old, new\n";
my $bench = Dumbbench->new(
	target_rel_precision => 0.005, # seek ~0.5%
	initial_runs         => 50,    # the higher the more reliable
);
$bench->add_instances(
	Dumbbench::Instance::PerlSub->new(
		name => 'old',
		code => sub { filter__git_get_projects_list(\@projects) },
	),
	Dumbbench::Instance::PerlSub->new(
		name => 'new',
		code => sub { filter_forks_from_projects_list(\@projects) },
	),
);
$bench->run();
$bench->report();

print "\n";
#print Dumper($bench->instances());
__END__

print "#####################################################################\n".
      "# nforks  = $nforks (forks per project forked)\n".
      "# nforked = ".(sprintf "%.2f%%", $nforked_frac*100.0)."\n".
      "# 1:projects 2:nforked  3:old 4:old_err  5:new 5:new_err\n";
for (my $i = 50; $i <= 4000; $i *= 2) {
	$nforked  = ceil($nforked_frac*$i);
	@projects = prepare_projects($i, $nforked, $nforks);

	$bench = Dumbbench->new(
		target_rel_precision => 0.005, # seek ~0.5%
		initial_runs         => 50,    # the higher the more reliable
	);
	$bench->add_instances(
		Dumbbench::Instance::PerlSub->new(
			name => 'old',
			code => sub { filter__git_get_projects_list(\@projects) },
		),
		Dumbbench::Instance::PerlSub->new(
			name => 'new',
			code => sub { filter_forks_from_projects_list(\@projects) },
		),
	);
	$bench->run();

	my %instances = map { $_->name() => $_ } $bench->instances();

	printf "%4d %3d ", (scalar @projects), $nforked;
	foreach my $name (qw(old new)) {
		my $result = $instances{$name}->result();
		print " ".$result->number();
		print " ".$result->error()->[0];
	}
	print "\n";
}
#print Dumper($bench->instances());
#print Dumper($_->result()) foreach ($bench->instances());


print "\n";


1;
__END__

--Boundary-00=_cHZxN4XOF9hlBxz--
