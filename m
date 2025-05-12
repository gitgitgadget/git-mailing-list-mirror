Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C42609CA
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041617; cv=none; b=l5oL/aOERKP6GO+efK+Nhug96g4yrc7E9wkIxzj2qBwoi0FQhdBBTu9010dsCKlEUzOu1ChEoK8Qe8lGmsiN5VzydRzXiQnVjPnB5s1XLP6netX8KE+yFIfclqpgC3iZRgRD5i0YSmcKSAi40CuWjFO5ByyMr1LIViubDpr6oHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041617; c=relaxed/simple;
	bh=lcn5zLl9cakUmNZk5GV3613Nf7kq0kQ+ReTdEWJemB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUbS+7eYWkpY3e+wwtgcC1XSK+waGGu4ya9tFSB7FW82NIfX/Oj9pdICJpUr88V5FEtBh+XNWj9iPno0o1lXs58a7rAGNYwAoiUSop9BEGz5m/JB6QYUt9XFckKKzkaqJrPEY/Ris+r9GJpvmggtpRoB4yWa2GqdoukOytNYF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Frbtg0fH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNJxUU9S; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Frbtg0fH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNJxUU9S"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5335E25400E8;
	Mon, 12 May 2025 05:20:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 05:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041613;
	 x=1747128013; bh=Zs80N5ZzpgOAMErZzkO3XJAhvfjHegnjBbswb8cosEI=; b=
	Frbtg0fH/pZfCBUF2RJveV2AHlplCso+/KHM4vsuAe0OgcjWjWqhpt0FDlyOS5wT
	U3wWh/zHgrMIBfTvWk2O96l00Yhw/mAmIecE1aYEmZNoBcqfC7OfpnAcoV5VlNo7
	wbvUhbQ9/vP6zwX4FwgdJyC9YsTLCGRbjLSJDSRgXBNg+d3JisG6nGXG0N1uuuoN
	6BTfEbGttREbpwV/vQI3ZGNa8ciP+PIz95JJmmCeS54y/0GdGNNdVJaOMjp4ZcwM
	nDr17cmBb+soZBraFZCPOmlC7cthDJUXviVe2/mErTcuUCcxACGIAkrzsJOlRBgE
	Zq0lD0PLJj8hRpYYSAfC6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041613; x=
	1747128013; bh=Zs80N5ZzpgOAMErZzkO3XJAhvfjHegnjBbswb8cosEI=; b=d
	NJxUU9S8tP+WYmPDbfVVO6eon6HH7O8XbdgB5e8fmRPd8gIRE3G2Q9Uotre/JTIw
	W30SDqqrs3p+9ixgxzTjS/De2RmcaHNN1M2VP7AGifRM9+IKFBTO3RMWHIhGOA9a
	nGqL5V8ANxFkCpW9YNnkX4taO/P287AWdB2Rc2dIm4youwQjgeu0F05MpaVraWv/
	TyFSvkEJ9cdCHR+YDveQ9rhm61Z4i3x+iwTMS21Zm6iX3TxepuVD7pdb6HnjJGRl
	WSamUGIMegDXzKaNkS503KVNlxBdfojVoQ6tc5i5feHy7EWS1uFGRuEDBGP4HqwS
	OdnmqHi4yP0i6nFm10+kg==
X-ME-Sender: <xms:Tb0haOnOoVC2Un6rH1E3EITCfFT8aHLHaVq_xa5V5hQxzm6SLRZ2Bg>
    <xme:Tb0haF2LjMm02a86oImLqArEgX1k2YX0fai5cEqSBkE554egQmASiPqu8cAHg0P74
    WGF87ZEGB6Q6NdHEw>
X-ME-Received: <xmr:Tb0haMo8KS33yYyCpoFFmYrTzhBWh1X_hevxg-ogjUWv87CXU0_SpSwA4KfA6m1n49PY-4ROg7QFKM1HlXDGuqkB0rED2zP27ZTm8TotnP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Tb0haCnKR8IqWo_KL4aDlnEQKY3BJ2PohLRzulbA7Tj-07s7Ie-81Q>
    <xmx:Tb0haM2tQWCvljmDlU-0ozCfln62cZfOmHxPZMiKw75P1cb5Sa7lCg>
    <xmx:Tb0haJvK_33VKytwdMFhwKSNqMoeCkzIxjXqLWEkSkr1s4gMVCrJEg>
    <xmx:Tb0haIUXchmkVqCPL9pwo2FXnp4w8_fTyY0AudCETcyt0sX88VX6wQ>
    <xmx:Tb0haP3MFYuWg6bgYXbp3zsVgtbLUCnEAanH9gxn4q90giVBh_ayKgcJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 519fc3c5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:20:01 +0200
Subject: [PATCH v3 11/11] contrib: remove some scripts in "stats" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-11-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
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

    This should be good-enough signal to indicate that nobody is using
    this script at all anymore.

  - "packinfo.pl" takes the output from git-verify-pack(1) and performs
    some pretty printing thereof. On the one hand it reformats the
    output to be easier to read and provide some summaries. On the other
    hand it may also print filenames of blobs.

    We don't have any replacement for this tool. Ideally, we should move
    its functionality into git-verify-pack(1) itself.

Remove the first two scripts, but retain "packinfo.pl".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/stats/git-common-hash | 26 ----------------
 contrib/stats/mailmap.pl      | 70 -------------------------------------------
 2 files changed, 96 deletions(-)

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

-- 
2.49.0.1101.gccaa498523.dirty

