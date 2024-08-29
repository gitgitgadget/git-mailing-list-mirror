Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8D18DF75
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923109; cv=none; b=nPr3SdYsrt3v/7JxdPwXmXTJ6osdLKz2i+fyiC6PWf/uUDuZpXMVZYbWdKsZRZ7HzhTek4d3BlSnhTHvDLh5MSzcX8BEXoVmdLfKZB2IwfiMvCgaZEDQfLxHPbWH74225T2v/u/vBFYCLx3TVrl8hphmvYGmpgHigFRP5UpzJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923109; c=relaxed/simple;
	bh=mPdW2nRvjifK+TuCBV0/+HVdMXG03M0atn5CiZrBhkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYKA+dIVN4nbBBGzAO8cA8S8pFx+8VuGyUzAN6Qv3cXGTtDLCpXvCO1Y+egwOrFjRHSpy1etGBEbb0sLMO+Bh+YOXlHZvSndWpXt/jOd4boCWx0Zipte+Q7BNWmBgW8gZyBA59OohlISg/t3WMdP7wqFgd1HWVr+D9RKBRNVgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=i4NAVbGl; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="i4NAVbGl"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id jbGiswlxTYUSUjbGqsPmjc; Thu, 29 Aug 2024 09:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1724923008;
	bh=mPdW2nRvjifK+TuCBV0/+HVdMXG03M0atn5CiZrBhkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4NAVbGlMi7Wl0Z7RuuQ+2pO/LKhBQznF2EpLM5A5S7o6R/ZLsNLVayMOWDvRb1KF
	 ndrF+UaRr9J5Z0Ler+FHwl50keclJ8IGlfoyaA9CYo089FwMkTnsKGJ+RB4kQYJuRi
	 VtscOCaQ61EEaJxhDcdRPmIC2bXCNpdLuydN+moAkfcrZ5ECe2weEIAAu2rsa7Hv8k
	 5rpZtLfkecWMCQUFL4iXSQ4ocxRaruhwIq7SlbACCZeKSTYWIYFb3mApPx8tvMBRE4
	 eBURo0J9OAYSl2LkEFHypvPdhwJRleeCbr1Mfe1DloC6YU+G62k2SyalVWVK4f7YFk
	 fAVOvXmRC2ZqQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=A99qPbWG c=1 sm=1 tr=0 ts=66d03c80
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=7d-JQOuMnc6R7wqMHU8A:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] chainlint: reduce annotation noise-factor
Date: Thu, 29 Aug 2024 05:16:25 -0400
Message-ID: <20240829091625.41297-3-ericsunshine@charter.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829091625.41297-1-ericsunshine@charter.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBNFnaK9tSUHwZOmrThQ3IhI5taYzIZuaCk3WO3qPam704d3d+Lk++w36d7hhnLCvFM1u+JIluNsN0EUgGdvHlSENEm3YbDdrtZeaDmDJkuqj+IILrkF
 3Gijq+NsRBbetOy3371tLfFFslHdcM6vNkNyvQhD0BJS8aWUvEUBovbll7qosQS/0Hyxst+9eJK9yDPV4exibCVRKo11z3ntxccSlFah+i6MZb6Frza3sG/E
 P76rD+h2SYp1SxJQWSi/SFA5hq0UEDQ/JV/R9jJFBng=

From: Eric Sunshine <sunshine@sunshineco.com>

When chainlint detects a problem in a test definition, it highlights the
offending code with an "?!ERR ...?!" annotation. The rather curious "?!"
delimiter was chosen to draw the reader's attention to the problem area.

Later, chainlint learned to color its output when sent to a terminal.
Problem annotations are colored with a red background which stands out
well from surrounding text, thus easily draws the reader's attention. As
such, the additional "?!" decoration became superfluous (when output is
colored), however the decoration was retained since it serves as a good
needle when using the terminal's search feature to "jump" to the next
problem.

Nevertheless, the "?!" decoration is noisy and ugly and makes it
unnecessarily difficult for the reader to pluck the problem description
from the annotation. For instance, it is easier to see at a glance what
the problem is in:

    ERR missing '&&'

than in the noisier:

    ?!ERR missing '&&'?!

Therefore drop the "!?" decoration when output is colored (but retain it
otherwise).

Note that the preceding change gave all problem annotations a uniform
"ERR" prefix which serves as a reasonably suitable replacement needle
when searching in a terminal, so loss of "?!" in the output should not
be overly problematic.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 7 +++++--
 t/test-lib.sh  | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index d79f183dfd..971ab9212a 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -591,6 +591,7 @@ sub new {
 	my $class = shift @_;
 	my $self = $class->SUPER::new(@_);
 	$self->{ntests} = 0;
+	$self->{nerrs} = 0;
 	return $self;
 }
 
@@ -647,8 +648,10 @@ sub check_test {
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
 	my $problems = $parser->{problems};
+	$self->{nerrs} += @$problems;
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
+	my ($erropen, $errclose) = -t 1 ? ("$c->{rev}$c->{red}", $c->{reset}) : ('?!', '?!');
 	my $start = 0;
 	my $checked = '';
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
@@ -663,7 +666,7 @@ sub check_test {
 	$checked =~ s/^\d+ \n//;
 	$checked =~ s/(\s) \?!/$1?!/mg;
 	$checked =~ s/\?! (\s)/?!$1/mg;
-	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
+	$checked =~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;
 	$checked =~ s/^\d+/$c->{dim}$&$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
@@ -805,9 +808,9 @@ sub check_script {
 			my $c = fd_colors(1);
 			my $s = join('', @{$parser->{output}});
 			$emit->("$c->{bold}$c->{blue}# chainlint: $path$c->{reset}\n" . $s);
-			$nerrs += () = $s =~ /\?![^?]+\?!/g;
 		}
 		$ntests += $parser->{ntests};
+		$nerrs += $parser->{nerrs};
 	}
 	return [$id, $nscripts, $ntests, $nerrs];
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54247604cb..b652cb98cd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1606,7 +1606,7 @@ if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
    test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
 then
 	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
-		BUG "lint error (see '?!...!? annotations above)"
+		BUG "lint error (see 'ERR' annotations above)"
 fi
 
 # Last-minute variable setup
-- 
2.46.0

