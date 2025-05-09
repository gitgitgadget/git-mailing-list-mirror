Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D925F7AA
	for <git@vger.kernel.org>; Fri,  9 May 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833518; cv=none; b=mMkVIaCac4zl5bw3bfkUes9J1vL+U/s7YUTXO9qqO7CSqBEq48C1zwFtvp5xaB/0WFvo8J6Bm1EkQii+Fd5GthzKgddo0KfnvVyts2DjEqjt9tLY3VwB4jM5NVQlbKqOd3iMw/VN2yEqRUCzoRPQ+7cDahtlA/fSnSJ/3y2ICfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833518; c=relaxed/simple;
	bh=exHgUFqRGP3+i/zZi1/rEPutn3KP2JrLh9H1Nl7e58U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFJ2iJNJU4FmGGMsw6GaskMmckD+8k2dyealKgXbUTOZK7lWvDv1fmThnQaxkigJpiGD3lYXUtPpVSedehnpUk25mYWyh5mVGbOFlzUjyjuKVSBr6AksfyC8y4cgEo9IIFkGssTVUagAXzRLY2dkeZPfqmrZHiq/5D4BrmeDojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgM5JpDE; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgM5JpDE"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8613f456960so68822539f.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746833514; x=1747438314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZmncES3BMdZEsGCqrm/rAPdWCiQmLugW19OcZ4MXDk=;
        b=HgM5JpDEow0wZHguJAePqUr1cdiUNxSffbYW17vDrYWFZBlaCti91jcPZX7dRZpJ2d
         38vBzYS66K1YsgusiVgssE/ClNW2HGwqp5YAlFRElEBN6OjjzjwotpkB/rtkkNogJV1X
         YwIu1H40BL7FalnZNiII6aiIw0Lk7hyUlfJTw0X2sgnWRVd9B+xRtm0IohjCyd+hAS4K
         of0/G2ZI8T2kpXDmFSuJK6yvGEEjrD0d2YHCWQ2CiqGqQrc/CBwokmNJCXpFOiPQCwvA
         ZU9YVZFXR4WaBkSf6UfONd6cP3x4gtlZsskozxPeBHFjCFuJUZnSbryOS3qpUZ2dw572
         wiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746833514; x=1747438314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZmncES3BMdZEsGCqrm/rAPdWCiQmLugW19OcZ4MXDk=;
        b=g4fxMdi5kMY0VCrrbO/8IJpYmM8l4prEFs+Nv5cNpmbya+d18YXuxN14jI4/vc0LNj
         klCm7FJGzHOT6VB9gHeD/wP15DXu+LRF7KLlMHNrCGXCTYIfopHkxp08nZVHDiHGhB/5
         biFGUSLTxp3beG4dfuwaLpQyESMHCRbWc1oYd6rMK83teZ3f/zI6h67iFA/Eq+OXnNuR
         raqTaRHk8/hZYC1Iyc6kJGY+9V2R+CWtVKe3z2P5WcwkqKf0gfiR4l2+Y6BzZUamExYH
         DGmriFh7JBcg1W6Ks0hN2lzE1oIljPfWLX3yrdJcwAJt/inFdCmjsiayYUGw2xBDhsAS
         M1uA==
X-Gm-Message-State: AOJu0YzbLlOumHkKCfb91KSSa/tdPK1WICBOWW6PMFbN0GshPCDGsw/M
	7Gn7BqbhIAZb4i4tapKOBt9Fa/2aqO+9I8lby6k/+GOZkiR5uFRVV5x8g0Y8z3SY7H1691bJdVf
	evM6mN7pu73EK0hBekqzLN0McQa0=
X-Gm-Gg: ASbGncubb8njIoBdbf1EVeH7/FYIRDAMWa7iBgTTRMcuPHTS3gWOG3J0ULJUgk+1CsO
	86CNzeJsfY8EHUpudeerQwTbq+awrT7rqdcaGK4hpjDoFXW2rI3bNLfgI+Y1XfU+X75wUwP9v70
	k78aEc2Vd8sRFh7Fego3H1SYqn+jMsa443ynTv8j51p/uyGzJyEV7lCK19KmUgVrXU
X-Google-Smtp-Source: AGHT+IEC5tO+6UNHfB70nFA7upntDzEoL45ucfpoteoiDP+Cvb1daTa8qWsL1hmY6gGhGGG4H0hAOaRu5KFQ0baNfJI=
X-Received: by 2002:a05:6602:13d2:b0:864:58a2:1f0a with SMTP id
 ca18e2360f4ac-8676362c4f8mr548886339f.10.1746833514182; Fri, 09 May 2025
 16:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im> <20250509-pks-contrib-spring-cleanup-v2-11-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-11-14e20d95ec68@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 May 2025 16:31:42 -0700
X-Gm-Features: ATxdqUH-0Uy1rq6GCIAbiCtRHcspyQfzL2a-u6qkwUmQcSbOSEbuGY-yY0H7o7c
Message-ID: <CABPp-BFUUwRe6q=gw2=XtUF3=cWk_=Rq083Q=FbBaTK5L+vXzg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] contrib: remove "stats" directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Matthieu Moy <git@matthieu-moy.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> The "stats" directory contains a couple of scripts to do some statistics
> on a repository:
>
>   - "git-common-hash" shows the longest common hash prefixes and can be
>     used to determine the minimum prefix length to use for object names
>     to be unique. The script has last been touched in 53474eb92ff
>     (contrib: update stats/mailmap script, 2012-12-12) and searching for
>     it on the internet doesn't really surface any potential use cases or
>     even mentions of it.
>
>     Modern Git also shouldn't really need this tool as it knows to
>     automatically scale printed prefixes via some heuristics.
>
>   - "mailmap.pl" performs some statistics on the number of mailmapped
>     commits in a repository. It has last been modified in 53474eb92ff
>     (contrib: update stats/mailmap script, 2012-12-12) and has since
>     been bitrotting. It doesn't even compile nowadays anymore:
>
>         $ perl contrib/stats/mailmap.pl
>         Experimental keys on scalar is now forbidden at contrib/stats/mai=
lmap.pl line 57.
>         Type of arg 1 to keys must be hash or array (not hash element) at=
 contrib/stats/mailmap.pl line 57, near "}) "
>         Experimental keys on scalar is now forbidden at contrib/stats/mai=
lmap.pl line 57.
>         Type of arg 1 to keys must be hash or array (not private variable=
) at contrib/stats/mailmap.pl line 57, near "$h)"
>         Experimental keys on scalar is now forbidden at contrib/stats/mai=
lmap.pl line 64.
>         Type of arg 1 to keys must be hash or array (not private variable=
) at contrib/stats/mailmap.pl line 64, near "$h)"
>         Execution of contrib/stats/mailmap.pl aborted due to compilation =
errors.
>
>     This should be good-enough signal to indicate that nodoby is using
>     this script at all anymore.

s/nodoby/nobody/

>   - "packinfo.pl" takes the output from git-verify-pack(1) and performs
>     some pretty printing thereof. On the one hand it reformats the
>     output to be easier to read and provide some summaries. On the other
>     hand it may also print filenames of blobs.
>
>     The script has last been touched in 3b1eb124932 (contrib: update
>     packinfo.pl to not use dashed commands, 2008-10-17), but it still
>     works nowadays. Even so, it is quite unlikely that anybody is still
>     using it. And if the provided information really was useful we
>     should rather think about moving it into git-verify-pack(1) itself.
>
> Remove the whole directory.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/stats/git-common-hash |  26 ------
>  contrib/stats/mailmap.pl      |  70 --------------
>  contrib/stats/packinfo.pl     | 212 ------------------------------------=
------
>  3 files changed, 308 deletions(-)
>
> diff --git a/contrib/stats/git-common-hash b/contrib/stats/git-common-has=
h
> deleted file mode 100755
> index e27fd088be1..00000000000
> --- a/contrib/stats/git-common-hash
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -#!/bin/sh
> -
> -# This script displays the distribution of longest common hash prefixes.
> -# This can be used to determine the minimum prefix length to use
> -# for object names to be unique.
> -
> -git rev-list --objects --all | sort | perl -lne '
> -  substr($_, 40) =3D "";
> -  # uncomment next line for a distribution of bits instead of hex chars
> -  # $_ =3D unpack("B*",pack("H*",$_));
> -  if (defined $p) {
> -    ($p ^ $_) =3D~ /^(\0*)/;
> -    $common =3D length $1;
> -    if (defined $pcommon) {
> -      $count[$pcommon > $common ? $pcommon : $common]++;
> -    } else {
> -      $count[$common]++; # first item
> -    }
> -  }
> -  $p =3D $_;
> -  $pcommon =3D $common;
> -  END {
> -    $count[$common]++; # last item
> -    print "$_: $count[$_]" for 0..$#count;
> -  }
> -'
> diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
> deleted file mode 100755
> index 9513f5e35b4..00000000000
> --- a/contrib/stats/mailmap.pl
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -#!/usr/bin/perl
> -
> -use warnings 'all';
> -use strict;
> -use Getopt::Long;
> -
> -my $match_emails;
> -my $match_names;
> -my $order_by =3D 'count';
> -Getopt::Long::Configure(qw(bundling));
> -GetOptions(
> -       'emails|e!' =3D> \$match_emails,
> -       'names|n!'  =3D> \$match_names,
> -       'count|c'   =3D> sub { $order_by =3D 'count' },
> -       'time|t'    =3D> sub { $order_by =3D 'stamp' },
> -) or exit 1;
> -$match_emails =3D 1 unless $match_names;
> -
> -my $email =3D {};
> -my $name =3D {};
> -
> -open(my $fh, '-|', "git log --format=3D'%at <%aE> %aN'");
> -while(<$fh>) {
> -       my ($t, $e, $n) =3D /(\S+) <(\S+)> (.*)/;
> -       mark($email, $e, $n, $t);
> -       mark($name, $n, $e, $t);
> -}
> -close($fh);
> -
> -if ($match_emails) {
> -       foreach my $e (dups($email)) {
> -               foreach my $n (vals($email->{$e})) {
> -                       show($n, $e, $email->{$e}->{$n});
> -               }
> -               print "\n";
> -       }
> -}
> -if ($match_names) {
> -       foreach my $n (dups($name)) {
> -               foreach my $e (vals($name->{$n})) {
> -                       show($n, $e, $name->{$n}->{$e});
> -               }
> -               print "\n";
> -       }
> -}
> -exit 0;
> -
> -sub mark {
> -       my ($h, $k, $v, $t) =3D @_;
> -       my $e =3D $h->{$k}->{$v} ||=3D { count =3D> 0, stamp =3D> 0 };
> -       $e->{count}++;
> -       $e->{stamp} =3D $t unless $t < $e->{stamp};
> -}
> -
> -sub dups {
> -       my $h =3D shift;
> -       return grep { keys($h->{$_}) > 1 } keys($h);
> -}
> -
> -sub vals {
> -       my $h =3D shift;
> -       return sort {
> -               $h->{$b}->{$order_by} <=3D> $h->{$a}->{$order_by}
> -       } keys($h);
> -}
> -
> -sub show {
> -       my ($n, $e, $h) =3D @_;
> -       print "$n <$e> ($h->{$order_by})\n";
> -}
> diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
> deleted file mode 100755
> index be188c0f11d..00000000000
> --- a/contrib/stats/packinfo.pl
> +++ /dev/null
> @@ -1,212 +0,0 @@
> -#!/usr/bin/perl
> -#
> -# This tool will print vaguely pretty information about a pack.  It
> -# expects the output of "git verify-pack -v" as input on stdin.
> -#
> -# $ git verify-pack -v | packinfo.pl
> -#
> -# This prints some full-pack statistics; currently "all sizes", "all
> -# path sizes", "tree sizes", "tree path sizes", and "depths".
> -#
> -# * "all sizes" stats are across every object size in the file;
> -#   full sizes for base objects, and delta size for deltas.
> -# * "all path sizes" stats are across all object's "path sizes".
> -#   A path size is the sum of the size of the delta chain, including the
> -#   base object.  In other words, it's how many bytes need be read to
> -#   reassemble the file from deltas.
> -# * "tree sizes" are object sizes grouped into delta trees.
> -# * "tree path sizes" are path sizes grouped into delta trees.
> -# * "depths" should be obvious.
> -#
> -# When run as:
> -#
> -# $ git verify-pack -v | packinfo.pl -tree
> -#
> -# the trees of objects are output along with the stats.  This looks
> -# like:
> -#
> -#   0 commit 031321c6...      803      803
> -#
> -#   0   blob 03156f21...     1767     1767
> -#   1    blob f52a9d7f...       10     1777
> -#   2     blob a8cc5739...       51     1828
> -#   3      blob 660e90b1...       15     1843
> -#   4       blob 0cb8e3bb...       33     1876
> -#   2     blob e48607f0...      311     2088
> -#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 st=
d_dev 635.85
> -# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1=
843 std_dev 107.26
> -#
> -# The first number after the sha1 is the object size, the second
> -# number is the path size.  The statistics are across all objects in
> -# the previous delta tree.  Obviously they are omitted for trees of
> -# one object.
> -#
> -# When run as:
> -#
> -# $ git verify-pack -v | packinfo.pl -tree -filenames
> -#
> -# it adds filenames to the tree.  Getting this information is slow:
> -#
> -#   0   blob 03156f21...     1767     1767 Documentation/git-lost-found.=
txt @ tags/v1.2.0~142
> -#   1    blob f52a9d7f...       10     1777 Documentation/git-lost-found=
.txt @ tags/v1.5.0-rc1~74
> -#   2     blob a8cc5739...       51     1828 Documentation/git-lost+foun=
d.txt @ tags/v0.99.9h^0
> -#   3      blob 660e90b1...       15     1843 Documentation/git-lost+fou=
nd.txt @ master~3222^2~2
> -#   4       blob 0cb8e3bb...       33     1876 Documentation/git-lost+fo=
und.txt @ master~3222^2~3
> -#   2     blob e48607f0...      311     2088 Documentation/git-lost-foun=
d.txt @ tags/v1.5.2-rc3~4
> -#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 st=
d_dev 635.85
> -# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1=
843 std_dev 107.26
> -#
> -# When run as:
> -#
> -# $ git verify-pack -v | packinfo.pl -dump
> -#
> -# it prints out "sha1 size pathsize depth" for each sha1 in lexical
> -# order.
> -#
> -# 000079a2eaef17b7eae70e1f0f635557ea67b644 30 472 7
> -# 00013cafe6980411aa6fdd940784917b5ff50f0a 44 1542 4
> -# 000182eacf99cde27d5916aa415921924b82972c 499 499 0
> -# ...
> -#
> -# This is handy for comparing two packs.  Adding "-filenames" will add
> -# filenames, as per "-tree -filenames" above.
> -
> -use strict;
> -use Getopt::Long;
> -
> -my $filenames =3D 0;
> -my $tree =3D 0;
> -my $dump =3D 0;
> -GetOptions("tree" =3D> \$tree,
> -           "filenames" =3D> \$filenames,
> -           "dump" =3D> \$dump);
> -
> -my %parents;
> -my %children;
> -my %sizes;
> -my @roots;
> -my %paths;
> -my %types;
> -my @commits;
> -my %names;
> -my %depths;
> -my @depths;
> -
> -while (<STDIN>) {
> -    my ($sha1, $type, $size, $space, $offset, $depth, $parent) =3D split=
(/\s+/, $_);
> -    next unless ($sha1 =3D~ /^[0-9a-f]{40}$/);
> -    $depths{$sha1} =3D $depth || 0;
> -    push(@depths, $depth || 0);
> -    push(@commits, $sha1) if ($type eq 'commit');
> -    push(@roots, $sha1) unless $parent;
> -    $parents{$sha1} =3D $parent;
> -    $types{$sha1} =3D $type;
> -    push(@{$children{$parent}}, $sha1);
> -    $sizes{$sha1} =3D $size;
> -}
> -
> -if ($filenames && ($tree || $dump)) {
> -    open(NAMES, "git name-rev --all|");
> -    while (<NAMES>) {
> -        if (/^(\S+)\s+(.*)$/) {
> -            my ($sha1, $name) =3D ($1, $2);
> -            $names{$sha1} =3D $name;
> -        }
> -    }
> -    close NAMES;
> -
> -    for my $commit (@commits) {
> -        my $name =3D $names{$commit};
> -        open(TREE, "git ls-tree -t -r $commit|");
> -        print STDERR "Plumbing tree $name\n";
> -        while (<TREE>) {
> -            if (/^(\S+)\s+(\S+)\s+(\S+)\s+(.*)$/) {
> -                my ($mode, $type, $sha1, $path) =3D ($1, $2, $3, $4);
> -                $paths{$sha1} =3D "$path @ $name";
> -            }
> -        }
> -        close TREE;
> -    }
> -}
> -
> -sub stats {
> -    my @data =3D sort {$a <=3D> $b} @_;
> -    my $min =3D $data[0];
> -    my $max =3D $data[$#data];
> -    my $total =3D 0;
> -    my $count =3D scalar @data;
> -    for my $datum (@data) {
> -        $total +=3D $datum;
> -    }
> -    my $mean =3D $total / $count;
> -    my $median =3D $data[int(@data / 2)];
> -    my $diff_sum =3D 0;
> -    for my $datum (@data) {
> -        $diff_sum +=3D ($datum - $mean)**2;
> -    }
> -    my $std_dev =3D sqrt($diff_sum / $count);
> -    return ($count, $total, $min, $max, $mean, $median, $std_dev);
> -}
> -
> -sub print_stats {
> -    my $name =3D shift;
> -    my ($count, $total, $min, $max, $mean, $median, $std_dev) =3D stats(=
@_);
> -    printf("%s: count %s total %s min %s max %s mean %.2f median %s std_=
dev %.2f\n",
> -           $name, $count, $total, $min, $max, $mean, $median, $std_dev);
> -}
> -
> -my @sizes;
> -my @path_sizes;
> -my @all_sizes;
> -my @all_path_sizes;
> -my %path_sizes;
> -
> -sub dig {
> -    my ($sha1, $depth, $path_size) =3D @_;
> -    $path_size +=3D $sizes{$sha1};
> -    push(@sizes, $sizes{$sha1});
> -    push(@all_sizes, $sizes{$sha1});
> -    push(@path_sizes, $path_size);
> -    push(@all_path_sizes, $path_size);
> -    $path_sizes{$sha1} =3D $path_size;
> -    if ($tree) {
> -        printf("%3d%s %6s %s %8d %8d %s\n",
> -               $depth, (" " x $depth), $types{$sha1},
> -               $sha1, $sizes{$sha1}, $path_size, $paths{$sha1});
> -    }
> -    for my $child (@{$children{$sha1}}) {
> -        dig($child, $depth + 1, $path_size);
> -    }
> -}
> -
> -my @tree_sizes;
> -my @tree_path_sizes;
> -
> -for my $root (@roots) {
> -    undef @sizes;
> -    undef @path_sizes;
> -    dig($root, 0, 0);
> -    my ($aa, $sz_total) =3D stats(@sizes);
> -    my ($bb, $psz_total) =3D stats(@path_sizes);
> -    push(@tree_sizes, $sz_total);
> -    push(@tree_path_sizes, $psz_total);
> -    if ($tree) {
> -        if (@sizes > 1) {
> -            print_stats("     size", @sizes);
> -            print_stats("path size", @path_sizes);
> -        }
> -        print "\n";
> -    }
> -}
> -
> -if ($dump) {
> -    for my $sha1 (sort keys %sizes) {
> -        print "$sha1 $sizes{$sha1} $path_sizes{$sha1} $depths{$sha1} $pa=
ths{$sha1}\n";
> -    }
> -} else {
> -    print_stats("      all sizes", @all_sizes);
> -    print_stats(" all path sizes", @all_path_sizes);
> -    print_stats("     tree sizes", @tree_sizes);
> -    print_stats("tree path sizes", @tree_path_sizes);
> -    print_stats("         depths", @depths);
> -}
>
> --
> 2.49.0.1077.gc0e912fd4c.dirty
>
>
