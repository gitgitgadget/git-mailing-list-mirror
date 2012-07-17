From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (8/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:17:09 -0700
Message-ID: <5005F275.3020702@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:17:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrH12-0008EI-LT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab2GQXRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:17:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755081Ab2GQXRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:17:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06168611;
	Tue, 17 Jul 2012 19:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=fKCCfSgYa4US
	FUbIpAcUUDdwBZQ=; b=r3PkQ+c7YNJvcUMq3EgaWeG7kXzs2ohhxpqGB9QeNzmk
	UecDz1Dc8f5VXcbt7MUJxLlYbkB+RFA9mu0Vi8emVXy7ZvdMl6mXHxJ/zGbwm5Y6
	T7qkLXj9pKKMdR+0zR8jstkKgHQWC21LIc4n6qip6YmN7iFNjnC7jkl0wFh7kRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YEjEuO
	KVtS6CrUYVx6zukRtQEhX/TdqXXLo6Q6qFOgBX7I1htbHOModXo8VU8BrrinTPwC
	r5Fgr4BmdNZHHBzK/ULHPHAwkTQ+6Hyq66Ti8JyefaAh6dvC4LJvUs5q4PKZtnfv
	T9jjm7ywaPfgVkeihNNSoIDHR/im2jC2MsAHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B687A8610;
	Tue, 17 Jul 2012 19:17:10 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C758F860F; Tue, 17 Jul
 2012 19:17:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 88DBB20C-D065-11E1-A45D-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201633>

>From 4fd7b8574b32753dcf22ec0a592f13586b938689 Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Thu, 12 Jul 2012 17:20:02 -0700
Subject: [PATCH 09/11] Fix Git::IndexInfo so it compiles.

Only used by Git::SVN::Fetcher.
---
 perl/Git/IndexInfo.pm   | 2 ++
 perl/Git/SVN/Fetcher.pm | 2 ++
 perl/Makefile           | 1 +
 t/Git-SVN/00compile.t   | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/perl/Git/IndexInfo.pm b/perl/Git/IndexInfo.pm
index a43108c..9e454be 100644
--- a/perl/Git/IndexInfo.pm
+++ b/perl/Git/IndexInfo.pm
@@ -1,6 +1,8 @@
 package Git::IndexInfo;
+
 use strict;
 use warnings;
+
 use Git qw/command_input_pipe command_close_pipe/;

 sub new {
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index ef8e9ed..69486ef 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -10,6 +10,8 @@ use IO::File qw//;
 use Git qw/command command_oneline command_noisy command_output_pipe
            command_input_pipe command_close_pipe
            command_bidi_pipe command_close_bidi_pipe/;
+use Git::IndexInfo;
+
 BEGIN {
 	@ISA = qw(SVN::Delta::Editor);
 }
diff --git a/perl/Makefile b/perl/Makefile
index d6a0e84..6c32918 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -26,6 +26,7 @@ instdir_SQ = $(subst ','\'',$(prefix)/lib)

 modules += Git
 modules += Git/I18N
+modules += Git/IndexInfo
 modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index 1307b65..5419438 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,10 +3,11 @@
 use strict;
 use warnings;

-use Test::More tests => 5;
+use Test::More tests => 6;

 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
 require_ok 'Git::SVN::Ra';
 require_ok 'Git::SVN::Log';
 require_ok 'Git::SVN::Migration';
+require_ok 'Git::IndexInfo';
-- 
1.7.11.1
