Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AD1BD4F7
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542319; cv=none; b=CajbYQXaRNzQ+xKZyenwQUyY6HMyZWgKdp9nRT6wcLEPjcXLBpxzLLVHBonLvAPt3KKDQyA62J/V7HPuFNQD8rTpt6E46yCKf+3rCgsvdpAd2GkGrlW/Ipv9hfZfsXoo7JrqYDhVQh0TnhebuAV/wa6LzmL30De1WMt3wgMoHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542319; c=relaxed/simple;
	bh=7aeQN+PQgpo63HFZUCs/6+PjPhsq0l1HnI1TCYflqoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9W0eamBV5+mVnsniMNj/mBPqYXWGjCtMBV2ByUkMlvbLOzBuOhxya0MRt8y51CcjNQnNFznRWP5s1stMWML0ngF9UmqdS2SHOldveqt9chuZAw0e6ZnSkQ+lTRt1v4bD6T/zppj9aZJCSzobh21FiA+pG/2Ygb+zx520zsDfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TouNGapZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9S8UaUU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TouNGapZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9S8UaUU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D8B861D0027B;
	Thu,  3 Jul 2025 07:31:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 03 Jul 2025 07:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751542315; x=1751628715; bh=8HpiTtvt8e
	Vz1HObj6RlowStpP1iFrJ0doHJMgKxq4c=; b=TouNGapZTKrcAQxOhWfdCU54CX
	C7j5tM0MfzrFUZSD7GZl+1gRWiohNpapYMXeF4OY486Yi6nZHhsGqEpweds6qeI7
	oOAo1xSMhySyptyZK82N/uiNv2crB1dRAPCbVDLLHzMHzdLmy28l+S1HlDAA5nBu
	vmExnIg5SPtBY+HM5/0PuZOYWO3OHF0jYkoeGx+f44z3WlURjO5EPYw0FDp7viWK
	Xtt2xbN6IaDifJMaHzPLEHKOTocOFtOOjqOXUAhZHwH72wQs3qQ40k73FR1M3oz7
	eukh4tYLX3K23AwJOWuLYOqAKbWlkc2v+zDnKcgiDZ69bZCJ/WyA3Bd1cvpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751542315; x=1751628715; bh=8HpiTtvt8eVz1HObj6RlowStpP1iFrJ0doH
	JMgKxq4c=; b=H9S8UaUUcB7T5hCLOby7Cf0GZ/cPz07oGTQ6Ey4HJdpUAWiE1Pm
	yPMPz4L5pRAl0AnqdiyZZmzcTfinXCtM/mqgyUEr+jwdVMemqFsW8i+EaD6/jxSQ
	qJSNcwvZe8Nw8qWVUEIA3c5AzhIS1ibmxAn2fwZNJ2OLOMpZStMKuT7cKLAfTj9g
	5aefFI/sMVlnzS0OYsmxuPJ8O6VSxvFD3W0sE/s6mz3NDZ0jpxQpx9Df/I5HJ2Qz
	LubwKqPP4yJoHeqw07Sp6NZAxSCPWBPlEmzBqUBCC0NahhOUqAGUsT5ZXYSMDqL6
	iytpMzCDF+COY9QjdYphNM1XC9dti93W1FQ==
X-ME-Sender: <xms:K2pmaDV6CLhcwX0FdUyMs1kCd7aQ7ChZh19StDz6O_0d9qAvWsaGkA>
    <xme:K2pmaLnCOeCOdHK3JVUMc2NVIQnGAOSTmZ4RMLGWsHnOcUfemUCxY2qkP2_Orr3Nn
    NdyemTWRl5SPdVgbg>
X-ME-Received: <xmr:K2pmaPZ2dkVSf5JTS1bNkWjHpDCO_pLNaq10GGj7Ofl2rbzMJqR1cmAJsdaMcVD_2VhOGkYjdt7_St6cErV45mnusfV8IKMxgeJCIk5LOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:K2pmaOUW_UURMQ3yUPiX0ivGw4NkV3cBJIYVI2fn-Dqu5mTfpZFjjQ>
    <xmx:K2pmaNlBtBydqtKIeCGjg4_mZ0eActj9RXa1zGDwOapRWQs8xQO6Xg>
    <xmx:K2pmaLeb244JYJitqs-5otfeIMVuFr2R8JaCAu8_87v9igmjhaaVAA>
    <xmx:K2pmaHFIudIYFOEshEFDQWNfypMVz3bbFMgl23RZJMBtvafZMR_7Rw>
    <xmx:K2pmaO0zul6V9IwQ_Xsisz1RNE7sbHv-cf8okbwDulrHqZ_w15Klc-VZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 07:31:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ea6cba8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 11:31:53 +0000 (UTC)
Date: Thu, 3 Jul 2025 13:31:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [GSoC RFC PATCH v2 2/7] repo-info: add the --format flag
Message-ID: <aGZqIJe2K3jGYeI3@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619225751.99699-3-lucasseikioshiro@gmail.com>

On Thu, Jun 19, 2025 at 07:57:46PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index a5c43e253f..cbe1475e30 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,21 +1,73 @@
>  #include "builtin.h"
> +#include "json-writer.h"
>  #include "parse-options.h"
>  
> +enum output_format {
> +	FORMAT_JSON
> +};
> +
> +struct repo_info {
> +	struct repository *repo;
> +	enum output_format format;
> +};
> +
> +static void repo_info_init(struct repo_info *repo_info,
> +			   struct repository *repo,
> +			   char *format)
> +{
> +	repo_info->repo = repo;
> +
> +	if (format == NULL || !strcmp(format, "json"))

Nit: we typically don't compare to NULL explicitly.

	if (!format || !strcmp(format, "json"))

> +		repo_info->format = FORMAT_JSON;
> +	else
> +		die("invalid format %s", format);
> +}
> +
> +static void repo_info_print_json(struct repo_info *repo_info UNUSED)
> +{
> +	struct json_writer jw;
> +
> +	jw_init(&jw);
> +
> +	jw_object_begin(&jw, 1);
> +	jw_end(&jw);
> +
> +	puts(jw.json.buf);
> +	jw_release(&jw);
> +}
> +
> +static void repo_info_print(struct repo_info *repo_info)
> +{
> +	enum output_format format = repo_info->format;

This variable indirection feels a bit pointless.

> +	switch (format) {
> +	case FORMAT_JSON:
> +		repo_info_print_json(repo_info);
> +		break;

We should probably `BUG()` in case there's any other unknown format
value stored in `repo_info`.

> +	}
> +}
> +
>  int cmd_repo_info(int argc,
>  		  const char **argv,
>  		  const char *prefix,
> -		  struct repository *repo UNUSED)
> +		  struct repository *repo)
>  {
>  	const char *const repo_info_usage[] = {
>  		"git repo-info",
>  		NULL
>  	};
> +	struct repo_info repo_info;
> +	char *format = NULL;

This should be const.

>  	struct option options[] = {
> +		OPT_STRING(0, "format", &format, N_("format"),
> +			   N_("output format")),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN_OPT);
> +	repo_info_init(&repo_info, repo, format);
> +	repo_info_print(&repo_info);
>  
>  	return 0;
>  }
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> new file mode 100755
> index 0000000000..f634e1a285
> --- /dev/null
> +++ b/t/t1900-repo-info.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

We should avoid setting the default initial branch name in new tests.
The variable really only exists for legacy tests where we assume that
the branch has a specific name.

> +. ./test-lib.sh
> +
> +parse_json () {
> +	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
> +}
> +
> +test_lazy_prereq PERLJSON '
> +	perl -MJSON -e "exit 0"
> +'
> +
> +test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
> +	git repo-info --format=json >output &&
> +	test_line_count = 2 output

This test doesn't really test much. In any case, two lines of output
certainly isn't empty output from my perspective. We should verify that
the generated output really is the empty JSON object.

Patrick
