Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1D3AFD07
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806964; cv=none; b=LQQWP3s7L8IQmWZGZu+GthbC9015kJoY69AJD40VIkIuLkTcXgtsC5XZda4QB1haiMPqDX6TfD9DrAafVALhcd4j8wU/g2qWSY7yRJOUbxUPw7rvef6h1Zz2+FeTCl211W76V2XRddkA9SLn2EdhliuPoCtUtrtNeUmK0ocmEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806964; c=relaxed/simple;
	bh=7TYdV1pPBaw4QE5D4/vnQF89xXU5EdBT+cfwfx+UUXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5+m1s13guffw3mMi7/BHeuUJ1qEdfnzYkGOJu+6JPRcmABkJu43Pq3cdCcdjQQWYWtsfWKBCmf/qIxYHVKbmT1hokOARxpx8qWfS12f4h2BQCWdoOJN+f1w9RGPXNjUESZSxkMO9dJ+wHp9qlEGsSeVzh1lhKHQqpLh0V7rJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=UqDJ4PwU; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="UqDJ4PwU"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 687In0wc006729-687In0we006729
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 7 Sep 2026 21:49:01 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x3eOq-004gwD-U6
	for git@vger.kernel.org;
	Mon, 07 Sep 2026 21:49:00 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 21:49:00 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 08f289b2;
	Mon, 7 Sep 2026 18:49:00 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH] lint-gitlink: don't use empty lower bound in .{0,8}
Date: Mon, 7 Sep 2026 21:48:58 +0300
Message-ID: <20260907184858.13475-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=INEkyheV7xaqKWDOhn9Cnwm4eNI2QvJ3ywoeIpQU338=;
 b=UqDJ4PwUjB23nXbg4diopzg0/7ihdeOewanfNcYFDbm8IPgqF+PCrqrGMuP/zeQPk05HGHbJw7T1
	Ef2k+OX7n2+AsDodFbrkvCFwT/S1yXvCWXlg+MF/ktsrxSeI/FEMHYl0qeDsyFG3o6SMuxW61Ysp
	UhB9x+wqvoTfhh14pSKCoojmfUnxd3HfDvkbF9JbCvzJ536neCaA3GfphXkC4lhg4biN3QCgh46q
	XFXd4XwWEAAOiWu2S5nJoNqhloCvQAU2W40EGtk3jD7EirakzwiJ3JWHhSxwGeplkV1+6OzyQBrT
	dKqKZ3Vy/5Y4hSyO6c5FdvWT5n+TGUvvOrQ7Pw==

The regex quantifier {,n} was added in Perl 5.34.0 as a shorthand
for {0,n}.  That makes it too new an introduction for Git which
targets Perl 5.26.0.

Even though Documentation/lint-gitlink.perl is a development helper
script, let's stick to the general Perl version requirement for
consistency, and use an explicit zero in .{0,8}.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/lint-gitlink.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index a92e887b4c..6a87633dd4 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -42,7 +42,7 @@ sub report {
 while (<>) {
 	my $line = $_;
 	next if $line =~ /^\s*(ifn?def|endif)::/;
-	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
+	while ($line =~ m/(.{0,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
 	    my $pos = pos $line;
 	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
 		if ( $macro ne "linkgit:" ) {

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
ta/lint-gitlink-perl-regex-nit

