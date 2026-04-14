Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B137DEA5
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151432; cv=none; b=d78ylVlu9IHc747X+R2lgGd0wQLGnbBooVIsC1osZtDvLD8uAb+VVSw3w79TyelpDCy9chi8i27I8U0CGbcKpos5adqTXJTeI4XYjcuMjh0oTT888IbgTmovFOPZL2lHH4C2QIf3Upld8XNX7Lfy1/xEi95c6OhLOBMizg4e+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151432; c=relaxed/simple;
	bh=VTLpSd0b3R1p+jztDfj4qEfdNana4Pp0Y3loCQ/nu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ6Bei2EpMUzecO4S4o9WrKExjiDV6V7fNwDAd3kFGEafCA4s1+Q9atSTv/feWZqOEHURF1MJan/GjPUPoA9s3U8QjsLg3tEYRvxK0FHCVLKy9u2GD0EaC3+vEVCmo/j52SCtUHFGlOxLzl0HiMqVGRI2QEe9pzzNraW+DFrZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s5aqRooY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5GtNdxS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s5aqRooY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5GtNdxS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69F307A00AB;
	Tue, 14 Apr 2026 03:23:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 03:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776151430; x=1776237830; bh=LDGfeFGVQC
	bWMjmAbF2rPYI58AhhTUPfYh1UolWB9a8=; b=s5aqRooYyHyikHVaiyAK8bPVWT
	VSAn9ruSa1cfYaunT3ulMqz9qgpYbx5NWnxEQEkML8oMeCd4r1lohySKrtQf1MJV
	MhilCYdsz4Oubjzd7orWLsmwhHz33T34eV0tzy5tiF5JDJXnJE8zpl8cFbPhBVAs
	DtoIGV8AH3gV0bAdXsYkDDn/UIDVB/H3lljimWIxX+aDqc2xofvdXH+7K9R/Vrch
	AjU+aU6jtkS+KXeyDs/Wf2cOXvYtf02H7eQPGLZDeoebE3Y5Xu6TuVnsJhfJBzvc
	cGiQ8Z+xiZawbGM+b0DFN4U5BSmIdzOk2cKmbbgLuh5+N7In0iDT8ocdgcaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776151430; x=1776237830; bh=LDGfeFGVQCbWMjmAbF2rPYI58AhhTUPfYh1
	UolWB9a8=; b=e5GtNdxS40CO9SjADJxNnqfjRF1gUI5wQqfcYA9nHYvNDjKsgs9
	eyWJqRUVJwUSgyucZaOZRpwFI+jVKH5qq3daySitJl13POvAWmO113t7ov8ePesM
	EUCjHx1kszHWMJclqzbr2xX28+TBX8VMhux6g0+0/hF1SmAxld48NRw/GcNsjIA5
	FlDh1kaJJEFfaZvwn4WRwGWRSy2IRS4oTBWZBdCG1Au62vtuYWucTTnJLRxkvwC/
	tlEzySEazcQYzibI0EI0pWfOXUCMAlq/DmNho1JS2ihhlPlAMWOOH7q2JrUWF9ck
	1qSB6OUs8LWpM/Lg4vBmwkJxP6kt1/CMAvQ==
X-ME-Sender: <xms:huvdafRAQ3N0_XnFlKYGKz0VDeXLtyLaUH8yelNnvIPtX8SL9uCd6g>
    <xme:huvdaWx_gdFTD9RltrhHadJZAUkWt_EkK-SR_1lRSzWiVJnWjDUZt4TRG_5L5ha-d
    8SqPq_5ek7ZxlmllG-gPxEPN8fA0_brh76J_cCHFiYMNUqkoY8uUg>
X-ME-Received: <xmr:huvdaSc_d-AMd-AADXcGDuHUnHOUUDKwj6JjmvEPYOAImxNOvWxdrMOh1229pYfTK9f-qrnPIQ7XCFLygxMePniqiSnxOPtYs57yMsEiQLasjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepfedvlefhgeelleeluefgtdekhfejfeetlefgge
    dtjedutefhudduhfetgfdtteeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdphhht
    thhpugdrshhhpdhhthhtphdqshhtrghtuhhsrdhshhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:huvdaaI2UedEArCUzwl1gEXkjC72yesN0oRJVz2Z4-JzNCAyi7OXiA>
    <xmx:huvdabFMyDcw25JIttJrMetzhj4e1O_23v-RaAmsGqdH-Cvs_Knizg>
    <xmx:huvdacqY84O7vuTJgXmB7V0fCuA2U9sG0IaBZbQb2TznfbhcYEJfYg>
    <xmx:huvdacQ8yutHqunbIqYzgPKVYu0CV0qLov-4SnZhYm4m8hgUmxIqDw>
    <xmx:huvdaSrZL6YKudF1mpmWfJNNXKAZuLyIJvxVKuLpG-pd_bX6sdM5Tivj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:23:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b88d172b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:23:49 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:23:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <ad3rgbgadjIZRgaz@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq340yfivf.fsf@gitster.g>

On Mon, Apr 13, 2026 at 06:09:08PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think I know what is lacking in this patch.  Following the above
> > section (which is a good conversion), there is this bit that needs a
> > similar handling.
> >
> >  t/lib-git-svn.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git c/t/lib-git-svn.sh w/t/lib-git-svn.sh
> > index 2fde2353fd..24c15d17eb 100644
> > --- c/t/lib-git-svn.sh
> > +++ w/t/lib-git-svn.sh
> > @@ -27,13 +27,13 @@ export svnrepo
> >  svnconf=$PWD/svnconf
> >  export svnconf
> >  
> > +x=0
> >  perl -w -e "
> >  use SVN::Core;
> >  use SVN::Repos;
> >  \$SVN::Core::VERSION gt '1.1.0' or exit(42);
> >  system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
> > -" >&3 2>&4
> > -x=$?
> > +" >&3 2>&4 || x=$?
> >  if test $x -ne 0
> >  then
> >  	if test $x -eq 42; then

Thanks, I've queued that change locally.

> The above is queued as a squash fix-up on top of the topic, but with
> the topic merged to 'seen', we seem to be getting a CI failure that
> appears specific to macOS.  Compare the failing
> 
>   https://github.com/git/git/actions/runs/24371204585 (aa13593)
> 
> with the same tree without the topic
> 
>   https://github.com/git/git/actions/runs/24369661492 (ad8b884)
> 
> The only differences between the commits are
> 
> $ git diff --compact-summary ad8b884 aa13593
>  t/lib-git-daemon.sh                | 13 ++++++++++---
>  t/lib-git-svn.sh                   |  7 +++----
>  t/lib-httpd.sh                     |  3 +--
>  t/t0005-signals.sh                 |  4 ++--
>  t/t0008-ignores.sh                 |  4 ++--
>  t/t1301-shared-repo.sh             |  2 +-
>  t/t3600-rm.sh                      |  2 +-
>  t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
>  t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
>  t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
>  t/t7508-status.sh                  |  4 ++--
>  t/t9138-git-svn-authors-prog.sh    |  4 ++--
>  t/t9200-git-cvsexportcommit.sh     |  3 +--
>  t/t9400-git-cvsserver-server.sh    |  5 +++--
>  t/t9401-git-cvsserver-crlf.sh      |  4 ++--
>  t/t9402-git-cvsserver-refs.sh      |  4 ++--
>  t/t9902-completion.sh              |  2 +-
>  t/test-lib-functions.sh            | 12 ++++++++----
>  t/test-lib.sh                      |  8 ++++++--
>  19 files changed, 78 insertions(+), 58 deletions(-)
> 
> which does match what is contained in this topic.

I knew it was a bad idea to not also run tests on GitHub Actions :) I'll
do that before the next reroll.

Anyway, looking at the failing test t9501, I assume that Perl isn't able
to enable the DATE_PARSER prerequisite. So something like the below
patch might hopefully fix it.

Thanks!

Patrick

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 32814e75df..3acb58125b 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -15,12 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-gitweb.sh
 
-#
 # Gitweb only provides the functionality tested by the 'modification times'
 # tests if it can access a date parser from one of these modules:
-#
-perl -MHTTP::Date -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
-perl -MTime::ParseDate -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
+test_lazy_prereq DATE_PARSER '
+	perl -MHTTP::Date -e 0 ||
+	perl -MTime::ParseDate -e 0
+'
 
 # ----------------------------------------------------------------------
 # snapshot settings
