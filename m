Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052719E7FA
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601797; cv=none; b=BD5E4SNRWoaxJ3skym4CjpPbwwIR9lSKK9XeAQofxsLuVboOzssxLATHjleut/+Phz2Wt87OevnEjPC/TV7TNNs5BVruXB1G1t/CvLM5JeK1i60iMBaof3zXQzuICcExPNhIQxitw6Dsa7kHq9sAJ8WTN7mqnnVWF6o7XzzblIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601797; c=relaxed/simple;
	bh=58sOyG7kroc6ljSZdXQDK2f/sj0Lay+dSG85Jex726o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XOe5fPcVzEF4DgueQ9uEfJtoZL8/qvP+xDi7bEkEuQHWTxRKGtVCRL1hN2AED58YtFMsq294AQsSKgAolyRtTvlnkZRwUr3CT9aS144wwybfrDzvJvnOsoddofgun+hfiwHcyNZfd/PD5wTHlzEprBAGBbf1K94NOuuSoo5jCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=htfY6jSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9QqwISx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="htfY6jSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9QqwISx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 754061140194;
	Fri, 25 Apr 2025 13:23:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 13:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745601793; x=1745688193; bh=l3gez0ma7P
	JPU8qnjQ+JkAPiC+qwIxYJXSNdfB8KvS8=; b=htfY6jSn7cASBEPHxHtwzGrQAU
	cS1UE81vpku5a4YoztPcU9XG4nndKjoj+sZZv3DDN8iODMjU7MRuz37BebGAKBMa
	1hXfgoYsWeeZHsYbMYoLOmzspwLvCVYKtcpzmgyiKCWU+599P8543156nyCVm+fQ
	DFYDnFToyKIvvtx5VXP9LAD30XalRzMwIVIR+rmmlnfysB32nOs5GKgyATVZz1mD
	LaRFLTIGVoOE/Fi+Nub1nzudiqDnllJAUwg/c7lg+pux5qX28FeXmkzws54HXaR+
	UFSziqWJXpPF88WexANDlPFgVdThB8AVTLtOLFVA8knZ97/6MnkLtwnqrA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745601793; x=1745688193; bh=l3gez0ma7PJPU8qnjQ+JkAPiC+qwIxYJXSN
	dfB8KvS8=; b=V9QqwISxZB9jf9sJODUTTRsDEMDL+at+1AIqCV43uWCmXr19IEJ
	cXWhUV79e07z4DpwbEAfV5iBHumIHVHPzRgURnh2Lts5j/KW4o+Pr1osDaw4pELA
	WsZY38O+5gWb6n9Sq+8r3P7FgINObhUMtuaizoq6Fdt0QpqsiPQw6p2SMN5//+sz
	NUA4k8MaqWP8TZbnOiyX/5imX1uHWkQqeLSRZrZEG7OnjG/D8ZFKdtLh9f5m5tnP
	mhhmFe5xRRkoZWasZR8AGafERq3VHneokp9q5KmQ2OtWsBUqMH7/rIgDif1nzNhi
	QtiI255icVeNDQie6uE0+5kmJ5//Zyzh9xA==
X-ME-Sender: <xms:AcULaLQJy65NDNMWJ-me5Bg2ttGrPWm43omRyDUjqRjM3-PEW2dYaw>
    <xme:AcULaMz1EClpYyZzH-HghGJgeMJUb4b06FPK10JzR85RxHQJE1v3cg0hu6adsyrQk
    6NxB5Icyzw0ZMcC1A>
X-ME-Received: <xmr:AcULaA1IfjAebP-TguYkEI4xNCqm21-Udecy6c0yzhLccbujw55UvQLZtsQcYPxFxkmp6Itl23hPiJdrIIOmPNCFf_owFx-zJ5i8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepteehtedvleehgeethfdtvdevkeejhefg
    ueevfefgffduveevteeuleegieetffejnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihht
    higrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrg
    hkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhr
    tghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepgh
    hrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvghh
    uhgvlhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:AcULaLDHXxEfMZ_CjEyVYnen-pYhMwSYOGvJ8sjvsefW-irNWtENPQ>
    <xmx:AcULaEjqs2WXE3wKwRhH48zRyCX4wQYCktTf8wwPjZ43RQ6oBBXzag>
    <xmx:AcULaPoMXt39OEEKRF37xdgKIfK3DLyUjIJTHFPuzYVbLeTQkGC5tg>
    <xmx:AcULaPizyfXdjteBk7BD09P_AQ3_vZJG3bbGc2cE4NxM_EdwIgiweg>
    <xmx:AcULaPz0BDKanF6BIQ3ulJdTgV4ovInzjZlAD7nr6RcVtXteReeQQKkC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 13:23:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,
    git@vger.kernel.org,
    M Hickford <mirth.hickford@gmail.com>,
    sandals@crustytoothpaste.net,
    Shengyu Qu <wiagn233@outlook.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook
 SMTP server
In-Reply-To: <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 25 Apr 2025 10:09:09 +0000")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 25 Apr 2025 10:23:11 -0700
Message-ID: <xmqqikmstatc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +sub is_outlook {
> +	my ($host) = @_;
> +	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
> +}

There were a few messages that raised concerns with respect to
on-prem installations of Outlook based servers, where the hostname
cannot be used to tell if we need this message-id tweaking.

The following is a completely untested patch, but it should be
sufficient to illustrate how simple it would be to support an
option to do so, if we cared about the issue enough.

Will queue your patch _without_ this tweak, at least for now.

Thanks.

 git-send-email.perl | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git c/git-send-email.perl w/git-send-email.perl
index 618474916e..dff3d861e4 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -60,6 +60,7 @@ sub usage {
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
+    --smtp-outlook-id-tweak <0|1>  * The server munges Message-ID.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
@@ -290,6 +291,7 @@ sub do_edit {
 my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
+my $outlook_id_tweak = -1; # we need to tell --no-opt and lack of it
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -305,6 +307,7 @@ sub do_edit {
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
     "mailmap" => \$mailmap,
+    "outlookidtweak" => \$outlook_id_tweak,
 );
 
 my %config_settings = (
@@ -518,6 +521,7 @@ sub config_regexp {
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
+		    "smtp-outlook-id-tweak!" => \$outlook_id_tweak,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
@@ -1576,7 +1580,13 @@ sub gen_header {
 
 sub is_outlook {
 	my ($host) = @_;
-	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+
+	if ($outlook_id_tweak < 0) {
+		$outlook_id_tweak = 
+		    ($host eq 'smtp.office365.com' ||
+		     $host eq 'smtp-mail.outlook.com') ? 1 : 0;
+	}
+	return $outlook_id_tweak;
 }
 
 # Prepares the email, then asks the user what to do.
