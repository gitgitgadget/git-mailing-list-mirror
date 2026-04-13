Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08630ACE6
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100171; cv=none; b=LjsKo62TEkXnmRzoM0eJZHocqxlRQv1WZdVcfPP92vBIqmJr68Cw2YrFESpM+U6E4lS8G8KHZb2mUc9r4l3ZfBlJ3BSP7n5+0OQzxXK56wVA0GtnkCdGlBVEpSbi1/nzzzywFW6ipCT/E5paVrNWO0enhxdxIpSJmoobA6bAgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100171; c=relaxed/simple;
	bh=pwxrmxe8QTB7WaTOfC7/ozQ+KJGTJW9+WMKgSxsT3Zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4Yu9d2yGZTfGRs36iShfVV8zIE7+F/BwwA4l73BO6kJaVDNkmWiZkhGsrEUlEU9WHWTvBZCA0DnmdvhsgbZD0tt8fBYK9/wSpEaOvUzg1L/fn1YGbA8upuHghmsLd7cezfjpqTX7dWFprkFRz6iOLOEQxxdGbdk5O2+dlZcugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E32TjPlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbs5jbw+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E32TjPlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbs5jbw+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CAA77A01E1;
	Mon, 13 Apr 2026 13:09:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 13:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776100169; x=1776186569; bh=fKjLr7hUl8
	4WJ7ibL6FF4B9geHAN4FYdLVP+AppeWXw=; b=E32TjPlPIOOSYzfD00J3pLd9/F
	zHBLWADZOMHLcH2S8mCt2cmt3wouhETc6VcdyZYrXHCV8VGeDlveHIrUXSl6G+kY
	QrIiuU3Kw7ymIEjF8ymo6nlzflxEyjGYVWSsp6vrkMrHWXKazbeUaCJVprGNSGIC
	YKNZ3QQ52GM34i/hcDY7DvKKly4bUirOvFlWChXAP7BBkutaidRonA+/IL7r826y
	1+BvCakFu9Z7MLIawc0pqhrR9ZIaScC4ny/FA6NBnkes5COPeeMrJXrRIQvBSksN
	i6b4qFZ5SULwQE3PuMAhXoOaLHkjq83C19aFJC8ixXRVI/LOrysEde0HMSIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776100169; x=1776186569; bh=fKjLr7hUl84WJ7ibL6FF4B9geHAN4FYdLVP
	+AppeWXw=; b=qbs5jbw+1YH/cr9nzFZoRb2cjxacsB1YntvTIO3MUK5aa2lcivI
	7KCfYyA43lBppwwimiMUIrBFcW1piO8uQMWs6XWv+gv3TvBDWmy2dJh2iGxvbRYY
	bm6YxDni3Lqh/acIaFbfuHwRadGR4XvxzGBt0lrl+l81oQ/qLiR+wR5ZbbDHrl2e
	BLYpHmaytPE/uUmEcKdjDA0O8hkhs0kE3kwIqBMazvFPAjdwOsVIYHfRT00oyxFD
	BleDGK8WIysa3TPxQvBl+FcZz/lS1wymxru4A0brkpR8qyclPuUjIiJCgC+Dcd5C
	C5P8ZgKdkGXEjTuPt2af5VF5eAmA8qdeWsw==
X-ME-Sender: <xms:SCPdacFAXoXqpiUiNkktxZa_yjsNxn4J0xXE46AZUZuy_N9Y0DmAZw>
    <xme:SCPdaczvDDl14p2mN2CKVRtqXMJy8nWA7skwi56Kb6W5YPR5G21mJG5fTzZXR83fl
    4gDRbKcLACSqF7tIDHa9XqDatI0oieeCf5mjMq9LAqupu8XUB_esg>
X-ME-Received: <xmr:SCPdaThqgRZmE4glMkbEMOAN_ewkk9-t_M3zQFH3-Y6NswrDWLd8XZAx9eXcfpllGGU7BP6gz_-JKuLU56BpYFqg7vXHi6C2pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeuieffhfejfedvhfffkeehueetfeekueffgeeitdekgeduvdeujeefuedvtdev
    hfenucffohhmrghinhephhhtthhpugdrshhhnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SCPdaXwN8z7ocf6T-ofBnb2Vv7nnbMnyRBEsI2tCOuyJZOe9yXqaKQ>
    <xmx:SCPdaWKhS4yAkI75rU_k-WcC2YL0YadHeZiGnTc3qtPP0X5E5uKK4w>
    <xmx:SCPdaeRDG3xOb0i6_14qF_MrxeDVeQ4gT9gn6ThZ3oc0Iv0iXJVmMQ>
    <xmx:SCPdaerJnRJcWiBOeMPOqVzW6eOELN0Jx6reAIHuTGLvgMYqLi1i0Q>
    <xmx:SSPdac4zWF5LHGzdhDKGw1wGdWj2tka3ovk1a5ai2qz7j6aRwyfYZr5_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:09:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:27 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 10:09:27 -0700
Message-ID: <xmqqtsteiy7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Several of our tests verify whether a certain binary can be executed,
> potentially skipping tests in case we cannot, for example because the
> binary doesn't exist. In those cases we often run the binary outside of
> any conditionally.
>
> This will start to fail once we enable `set -e`, as that will cause us
> to bail out the test immediately. Improve these tests by executing them
> inside of a conditional instead.

OK.  "svn help" and "cvs version" do exit with status 0 and the
rewrites that use them make sense.  I wonder if we can do something
similar to "git" instead of relying on "git<RETURN>" to exit with 1,
perhaps ...

    $ git version >/dev/null; echo $?
    0

... by using "git version" in the test-lib.sh change?

Other than that looking very good.


>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/lib-git-svn.sh                | 3 +--
>  t/lib-httpd.sh                  | 3 +--
>  t/t9200-git-cvsexportcommit.sh  | 3 +--
>  t/t9400-git-cvsserver-server.sh | 5 +++--
>  t/t9401-git-cvsserver-crlf.sh   | 4 ++--
>  t/t9402-git-cvsserver-refs.sh   | 4 ++--
>  t/test-lib.sh                   | 4 ++--
>  7 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 2fde2353fd..07d86ea244 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -15,8 +15,7 @@ GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
>  SVN_TREE=$GIT_SVN_DIR/svn-tree
>  test_set_port SVNSERVE_PORT
>  
> -svn >/dev/null 2>&1
> -if test $? -ne 1
> +if ! svn help >/dev/null 2>&1
>  then
>  	skip_all='skipping git svn tests, svn not found'
>  	test_done
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 4c76e813e3..fc646447d5 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -235,11 +235,10 @@ start_httpd() {
>  
>  	test_atexit stop_httpd
>  
> -	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
> +	if ! "$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
>  		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
>  		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
>  		>&3 2>&4
> -	if test $? -ne 0
>  	then
>  		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
>  		test_skip_or_die GIT_TEST_HTTPD "web server setup failed"
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index 14cbe96527..581cf3d28f 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -11,8 +11,7 @@ if ! test_have_prereq PERL; then
>  	test_done
>  fi
>  
> -cvs >/dev/null 2>&1
> -if test $? -ne 1
> +if ! cvs version >/dev/null 2>&1
>  then
>      skip_all='skipping git cvsexportcommit tests, cvs not found'
>      test_done
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index e499c7f955..4b45398bab 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -17,12 +17,13 @@ if ! test_have_prereq PERL; then
>  	skip_all='skipping git cvsserver tests, perl not available'
>  	test_done
>  fi
> -cvs >/dev/null 2>&1
> -if test $? -ne 1
> +
> +if ! cvs version >/dev/null 2>&1
>  then
>      skip_all='skipping git-cvsserver tests, cvs not found'
>      test_done
>  fi
> +
>  perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
>      skip_all='skipping git-cvsserver tests, Perl SQLite interface unavailable'
>      test_done
> diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
> index a34805acdc..6b4cbb1651 100755
> --- a/t/t9401-git-cvsserver-crlf.sh
> +++ b/t/t9401-git-cvsserver-crlf.sh
> @@ -60,12 +60,12 @@ check_status_options() {
>      return $stat
>  }
>  
> -cvs >/dev/null 2>&1
> -if test $? -ne 1
> +if ! cvs version >/dev/null 2>&1
>  then
>      skip_all='skipping git-cvsserver tests, cvs not found'
>      test_done
>  fi
> +
>  if ! test_have_prereq PERL
>  then
>      skip_all='skipping git-cvsserver tests, perl not available'
> diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
> index 2ee41f9443..65f2ceedec 100755
> --- a/t/t9402-git-cvsserver-refs.sh
> +++ b/t/t9402-git-cvsserver-refs.sh
> @@ -68,12 +68,12 @@ check_diff() {
>  
>  #########
>  
> -cvs >/dev/null 2>&1
> -if test $? -ne 1
> +if ! cvs version >/dev/null 2>&1
>  then
>  	skip_all='skipping git-cvsserver tests, cvs not found'
>  	test_done
>  fi
> +
>  if ! test_have_prereq PERL
>  then
>  	skip_all='skipping git-cvsserver tests, perl not available'
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 70fd3e9baf..81380fe978 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -143,8 +143,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  ################################################################
>  # It appears that people try to run tests without building...
>  GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
> -"$GIT_BINARY" >/dev/null
> -if test $? != 1
> +
> +if ! "$GIT_BINARY" version >/dev/null
>  then
>  	if test -n "$GIT_TEST_INSTALLED"
>  	then
