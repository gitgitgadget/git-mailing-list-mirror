Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9627CB21
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782243; cv=none; b=AtUia8J3ABFWChDPXUbFwHQvLKKiq3mY4rKfDT3Jp6/LOTS7CVHWhGm1kRwwL8nTJKmzfFI7/OybBEpTxoId2zP++p9EQf6IRICdf7LR63/EX/3JU3aIqLbtArFBoJi0pvEJsa0FXCr/ahDo2i4HLll7VBVccblwmREkvZz77Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782243; c=relaxed/simple;
	bh=h1wTE9Rke3cFKHEWHafWE4J9cy3XzTAfv8EDTWRxJoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqS854csR4cTlRGdsnovnaaCtxuVApvPF73nO2U8hIsfp2BoWW5iuYsn0Cmy/oE0Uv7136jb0W71qa/BXtcs2JWWVlOBqEH6U2EL6M7y2VRnD8xHyNWujfu38IEObdwZtA4QR9igriIDpbtNPgdWO/bmwp1szz0mJ1+wXlpeW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TbURNSG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTdO7V+n; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TbURNSG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTdO7V+n"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 47B1B13801C7;
	Fri,  9 May 2025 05:17:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 May 2025 05:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782240;
	 x=1746868640; bh=yFhBRJXXuaf+JYB7T4cjh+Y/Sh0k/EJ8vQ4kdgIlQFo=; b=
	TbURNSG7kpqXCxCm2a7YAZ+G6h8DkOnSnpOB2ouNJt0kdGGimaUEUIhfRM9yUD2O
	mux3FPi+npFKiechp9pL6j0hsQEypblCrWpWQFAqFHMN0qJ6QqSMe1ZfVPFS1/w9
	ZX0snuI62SjZY84ZiQdndANcsBv5zpciynOmVMJc+WBAXbW8uXvSGyvBTEyQrPIz
	lx6ws69DXAyjIuNytaw6np/2H12xWChrN6bnOYippzu0SSPuDuCs7Ur93yJgUOYH
	NpqRpXPxGePQVvB83Jf8YKxioMpWUwno227RF0eNypOTG6kplI/ueQYgiLqmQCM7
	bK6p+f0RYXRPqNbkytQubA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782240; x=
	1746868640; bh=yFhBRJXXuaf+JYB7T4cjh+Y/Sh0k/EJ8vQ4kdgIlQFo=; b=q
	TdO7V+njLPcKqWPgcCyl/hfsJU2VkE6gnZSlIW6aSOrhOcJ3NR1gVxPlHRDdgfTO
	EMd2Q1XgXNOvnNid5YVoTapsrvdd8HOBzyjCU80l49dl9A27thU39W0+jqN90q7z
	MSbbQHVfBnlsV3UqxHuYuuxs3XegeRwZMeVcFWsYAWh1bQ9/Nz9pTmYO4soqMcSn
	Xf8Nxnz/vVRPETAakSKmGMc8qyRnEjf8w4fWXKX1JAndjpGtJIWPZvXDztQJJqsk
	igHKeKez/+9RJDeOynNDYVZB20brIL4TOTWbwNXaanOYu5UT8D40gVgXvE/mq2oi
	22+yW4nl5ghMV+ldoanDQ==
X-ME-Sender: <xms:IMgdaKSD13x7qy161YOGp4R6YFxMedNeZGJc80300Dx37LiiDE455A>
    <xme:IMgdaPyALqOP7yP-Kr-mWXX9SOVzXQjL9yjfER5IYQ5eIecU5siLKYl8wUHJp7qYU
    uTjTvlnD6OueqUYhg>
X-ME-Received: <xmr:IMgdaH2rX6rXioEs8nKgNPklr3fw1CR3TZEzV_oHhRD8GwzXMbheB2lHmF-StpckbxmyJjck5IO7rsF6-rd6ht4E7sYhZ8XH-pedZNR6pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphhtthhopehtmhiisehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:IMgdaGC-7UDI0EBc3wfHlqKzuWJTjO4Fs1_5IJs-bpDWtGDPujIQLA>
    <xmx:IMgdaDgTCDs5IOR7r8TK_CfpJ4rW7JEngwQKkqBnWWvQszp7fIDUqQ>
    <xmx:IMgdaCobOyxfeGs97hYngb4B5oR7A8L04-6VfC-_148ADxAP19aQfg>
    <xmx:IMgdaGje59iK6oRSlDRCWAlDq7t5vJu3r_Hkx1hmKcNB6ICwWv0hQQ>
    <xmx:IMgdaC68kBqg9p8WcS7Owu48ZU_0U0xMYiZC838--teKBhrQrMpirIPF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78e8b5df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:11 +0200
Subject: [PATCH v2 11/11] contrib: remove "stats" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-11-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

The "stats" directory contains a couple of scripts to do some statistics
on a repository:

  - "git-common-hash" shows the longest common hash prefixes and can be
    used to determine the minimum prefix length to use for object names
    to be unique. The script has last been touched in 53474eb92ff
    (contrib: update stats/mailmap script, 2012-12-12) and searching for
    it on the internet doesn't really surface any potential use cases or
    even mentions of it.

    Modern Git also shouldn't really need this tool as it knows to
    automatically scale printed prefixes via some heuristics.

  - "mailmap.pl" performs some statistics on the number of mailmapped
    commits in a repository. It has last been modified in 53474eb92ff
    (contrib: update stats/mailmap script, 2012-12-12) and has since
    been bitrotting. It doesn't even compile nowadays anymore:

        $ perl contrib/stats/mailmap.pl
        Experimental keys on scalar is now forbidden at contrib/stats/mailmap.pl line 57.
        Type of arg 1 to keys must be hash or array (not hash element) at contrib/stats/mailmap.pl line 57, near "}) "
        Experimental keys on scalar is now forbidden at contrib/stats/mailmap.pl line 57.
        Type of arg 1 to keys must be hash or array (not private variable) at contrib/stats/mailmap.pl line 57, near "$h)"
        Experimental keys on scalar is now forbidden at contrib/stats/mailmap.pl line 64.
        Type of arg 1 to keys must be hash or array (not private variable) at contrib/stats/mailmap.pl line 64, near "$h)"
        Execution of contrib/stats/mailmap.pl aborted due to compilation errors.

    This should be good-enough signal to indicate that nodoby is using
    this script at all anymore.

  - "packinfo.pl" takes the output from git-verify-pack(1) and performs
    some pretty printing thereof. On the one hand it reformats the
    output to be easier to read and provide some summaries. On the other
    hand it may also print filenames of blobs.

    The script has last been touched in 3b1eb124932 (contrib: update
    packinfo.pl to not use dashed commands, 2008-10-17), but it still
    works nowadays. Even so, it is quite unlikely that anybody is still
    using it. And if the provided information really was useful we
    should rather think about moving it into git-verify-pack(1) itself.

Remove the whole directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/stats/git-common-hash |  26 ------
 contrib/stats/mailmap.pl      |  70 --------------
 contrib/stats/packinfo.pl     | 212 ------------------------------------------
 3 files changed, 308 deletions(-)

diff --git a/contrib/stats/git-common-hash b/contrib/stats/git-common-hash
deleted file mode 100755
index e27fd088be1..00000000000
--- a/contrib/stats/git-common-hash
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/sh
-
-# This script displays the distribution of longest common hash prefixes.
-# This can be used to determine the minimum prefix length to use
-# for object names to be unique.
-
-git rev-list --objects --all | sort | perl -lne '
-  substr($_, 40) = "";
-  # uncomment next line for a distribution of bits instead of hex chars
-  # $_ = unpack("B*",pack("H*",$_));
-  if (defined $p) {
-    ($p ^ $_) =~ /^(\0*)/;
-    $common = length $1;
-    if (defined $pcommon) {
-      $count[$pcommon > $common ? $pcommon : $common]++;
-    } else {
-      $count[$common]++; # first item
-    }
-  }
-  $p = $_;
-  $pcommon = $common;
-  END {
-    $count[$common]++; # last item
-    print "$_: $count[$_]" for 0..$#count;
-  }
-'
diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
deleted file mode 100755
index 9513f5e35b4..00000000000
--- a/contrib/stats/mailmap.pl
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/usr/bin/perl
-
-use warnings 'all';
-use strict;
-use Getopt::Long;
-
-my $match_emails;
-my $match_names;
-my $order_by = 'count';
-Getopt::Long::Configure(qw(bundling));
-GetOptions(
-	'emails|e!' => \$match_emails,
-	'names|n!'  => \$match_names,
-	'count|c'   => sub { $order_by = 'count' },
-	'time|t'    => sub { $order_by = 'stamp' },
-) or exit 1;
-$match_emails = 1 unless $match_names;
-
-my $email = {};
-my $name = {};
-
-open(my $fh, '-|', "git log --format='%at <%aE> %aN'");
-while(<$fh>) {
-	my ($t, $e, $n) = /(\S+) <(\S+)> (.*)/;
-	mark($email, $e, $n, $t);
-	mark($name, $n, $e, $t);
-}
-close($fh);
-
-if ($match_emails) {
-	foreach my $e (dups($email)) {
-		foreach my $n (vals($email->{$e})) {
-			show($n, $e, $email->{$e}->{$n});
-		}
-		print "\n";
-	}
-}
-if ($match_names) {
-	foreach my $n (dups($name)) {
-		foreach my $e (vals($name->{$n})) {
-			show($n, $e, $name->{$n}->{$e});
-		}
-		print "\n";
-	}
-}
-exit 0;
-
-sub mark {
-	my ($h, $k, $v, $t) = @_;
-	my $e = $h->{$k}->{$v} ||= { count => 0, stamp => 0 };
-	$e->{count}++;
-	$e->{stamp} = $t unless $t < $e->{stamp};
-}
-
-sub dups {
-	my $h = shift;
-	return grep { keys($h->{$_}) > 1 } keys($h);
-}
-
-sub vals {
-	my $h = shift;
-	return sort {
-		$h->{$b}->{$order_by} <=> $h->{$a}->{$order_by}
-	} keys($h);
-}
-
-sub show {
-	my ($n, $e, $h) = @_;
-	print "$n <$e> ($h->{$order_by})\n";
-}
diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
deleted file mode 100755
index be188c0f11d..00000000000
--- a/contrib/stats/packinfo.pl
+++ /dev/null
@@ -1,212 +0,0 @@
-#!/usr/bin/perl
-#
-# This tool will print vaguely pretty information about a pack.  It
-# expects the output of "git verify-pack -v" as input on stdin.
-#
-# $ git verify-pack -v | packinfo.pl
-#
-# This prints some full-pack statistics; currently "all sizes", "all
-# path sizes", "tree sizes", "tree path sizes", and "depths".
-#
-# * "all sizes" stats are across every object size in the file;
-#   full sizes for base objects, and delta size for deltas.
-# * "all path sizes" stats are across all object's "path sizes".
-#   A path size is the sum of the size of the delta chain, including the
-#   base object.  In other words, it's how many bytes need be read to
-#   reassemble the file from deltas.
-# * "tree sizes" are object sizes grouped into delta trees.
-# * "tree path sizes" are path sizes grouped into delta trees.
-# * "depths" should be obvious.
-#
-# When run as:
-#
-# $ git verify-pack -v | packinfo.pl -tree
-#
-# the trees of objects are output along with the stats.  This looks
-# like:
-#
-#   0 commit 031321c6...      803      803
-#
-#   0   blob 03156f21...     1767     1767
-#   1    blob f52a9d7f...       10     1777
-#   2     blob a8cc5739...       51     1828
-#   3      blob 660e90b1...       15     1843
-#   4       blob 0cb8e3bb...       33     1876
-#   2     blob e48607f0...      311     2088
-#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
-# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
-#
-# The first number after the sha1 is the object size, the second
-# number is the path size.  The statistics are across all objects in
-# the previous delta tree.  Obviously they are omitted for trees of
-# one object.
-#
-# When run as:
-#
-# $ git verify-pack -v | packinfo.pl -tree -filenames
-#
-# it adds filenames to the tree.  Getting this information is slow:
-#
-#   0   blob 03156f21...     1767     1767 Documentation/git-lost-found.txt @ tags/v1.2.0~142
-#   1    blob f52a9d7f...       10     1777 Documentation/git-lost-found.txt @ tags/v1.5.0-rc1~74
-#   2     blob a8cc5739...       51     1828 Documentation/git-lost+found.txt @ tags/v0.99.9h^0
-#   3      blob 660e90b1...       15     1843 Documentation/git-lost+found.txt @ master~3222^2~2
-#   4       blob 0cb8e3bb...       33     1876 Documentation/git-lost+found.txt @ master~3222^2~3
-#   2     blob e48607f0...      311     2088 Documentation/git-lost-found.txt @ tags/v1.5.2-rc3~4
-#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
-# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
-#
-# When run as:
-#
-# $ git verify-pack -v | packinfo.pl -dump
-#
-# it prints out "sha1 size pathsize depth" for each sha1 in lexical
-# order.
-#
-# 000079a2eaef17b7eae70e1f0f635557ea67b644 30 472 7
-# 00013cafe6980411aa6fdd940784917b5ff50f0a 44 1542 4
-# 000182eacf99cde27d5916aa415921924b82972c 499 499 0
-# ...
-#
-# This is handy for comparing two packs.  Adding "-filenames" will add
-# filenames, as per "-tree -filenames" above.
-
-use strict;
-use Getopt::Long;
-
-my $filenames = 0;
-my $tree = 0;
-my $dump = 0;
-GetOptions("tree" => \$tree,
-           "filenames" => \$filenames,
-           "dump" => \$dump);
-
-my %parents;
-my %children;
-my %sizes;
-my @roots;
-my %paths;
-my %types;
-my @commits;
-my %names;
-my %depths;
-my @depths;
-
-while (<STDIN>) {
-    my ($sha1, $type, $size, $space, $offset, $depth, $parent) = split(/\s+/, $_);
-    next unless ($sha1 =~ /^[0-9a-f]{40}$/);
-    $depths{$sha1} = $depth || 0;
-    push(@depths, $depth || 0);
-    push(@commits, $sha1) if ($type eq 'commit');
-    push(@roots, $sha1) unless $parent;
-    $parents{$sha1} = $parent;
-    $types{$sha1} = $type;
-    push(@{$children{$parent}}, $sha1);
-    $sizes{$sha1} = $size;
-}
-
-if ($filenames && ($tree || $dump)) {
-    open(NAMES, "git name-rev --all|");
-    while (<NAMES>) {
-        if (/^(\S+)\s+(.*)$/) {
-            my ($sha1, $name) = ($1, $2);
-            $names{$sha1} = $name;
-        }
-    }
-    close NAMES;
-
-    for my $commit (@commits) {
-        my $name = $names{$commit};
-        open(TREE, "git ls-tree -t -r $commit|");
-        print STDERR "Plumbing tree $name\n";
-        while (<TREE>) {
-            if (/^(\S+)\s+(\S+)\s+(\S+)\s+(.*)$/) {
-                my ($mode, $type, $sha1, $path) = ($1, $2, $3, $4);
-                $paths{$sha1} = "$path @ $name";
-            }
-        }
-        close TREE;
-    }
-}
-
-sub stats {
-    my @data = sort {$a <=> $b} @_;
-    my $min = $data[0];
-    my $max = $data[$#data];
-    my $total = 0;
-    my $count = scalar @data;
-    for my $datum (@data) {
-        $total += $datum;
-    }
-    my $mean = $total / $count;
-    my $median = $data[int(@data / 2)];
-    my $diff_sum = 0;
-    for my $datum (@data) {
-        $diff_sum += ($datum - $mean)**2;
-    }
-    my $std_dev = sqrt($diff_sum / $count);
-    return ($count, $total, $min, $max, $mean, $median, $std_dev);
-}
-
-sub print_stats {
-    my $name = shift;
-    my ($count, $total, $min, $max, $mean, $median, $std_dev) = stats(@_);
-    printf("%s: count %s total %s min %s max %s mean %.2f median %s std_dev %.2f\n",
-           $name, $count, $total, $min, $max, $mean, $median, $std_dev);
-}
-
-my @sizes;
-my @path_sizes;
-my @all_sizes;
-my @all_path_sizes;
-my %path_sizes;
-
-sub dig {
-    my ($sha1, $depth, $path_size) = @_;
-    $path_size += $sizes{$sha1};
-    push(@sizes, $sizes{$sha1});
-    push(@all_sizes, $sizes{$sha1});
-    push(@path_sizes, $path_size);
-    push(@all_path_sizes, $path_size);
-    $path_sizes{$sha1} = $path_size;
-    if ($tree) {
-        printf("%3d%s %6s %s %8d %8d %s\n",
-               $depth, (" " x $depth), $types{$sha1},
-               $sha1, $sizes{$sha1}, $path_size, $paths{$sha1});
-    }
-    for my $child (@{$children{$sha1}}) {
-        dig($child, $depth + 1, $path_size);
-    }
-}
-
-my @tree_sizes;
-my @tree_path_sizes;
-
-for my $root (@roots) {
-    undef @sizes;
-    undef @path_sizes;
-    dig($root, 0, 0);
-    my ($aa, $sz_total) = stats(@sizes);
-    my ($bb, $psz_total) = stats(@path_sizes);
-    push(@tree_sizes, $sz_total);
-    push(@tree_path_sizes, $psz_total);
-    if ($tree) {
-        if (@sizes > 1) {
-            print_stats("     size", @sizes);
-            print_stats("path size", @path_sizes);
-        }
-        print "\n";
-    }
-}
-
-if ($dump) {
-    for my $sha1 (sort keys %sizes) {
-        print "$sha1 $sizes{$sha1} $path_sizes{$sha1} $depths{$sha1} $paths{$sha1}\n";
-    }
-} else {
-    print_stats("      all sizes", @all_sizes);
-    print_stats(" all path sizes", @all_path_sizes);
-    print_stats("     tree sizes", @tree_sizes);
-    print_stats("tree path sizes", @tree_path_sizes);
-    print_stats("         depths", @depths);
-}

-- 
2.49.0.1077.gc0e912fd4c.dirty

