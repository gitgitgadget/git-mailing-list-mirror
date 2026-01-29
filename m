Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006101F09A8
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711847; cv=none; b=BmNC0CD+z4kGEb/UEh6QBXGRyQrNRXX0GK0PXnWZswa3Wwax+xednYoP1oMTkEUUA3CpPAP3Yp3Hasny5kFlrFCTCr7+wZTCX/JMorOopiaZiXcg7Kt6jNNCvylA16KQRZ6Cxs26uVPP7HYLZ2Kb7pE6k4pSWVg1CRUyjOIsd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711847; c=relaxed/simple;
	bh=Wmei5MJ6lOr0qFsoXTL58blSb5i74lP5PxUg/7S3yz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/sqQncOLt3m5QX6pL1tepcddnG3XqFqtvDHaUIpzTpmz3p4o93eoPiC3+OF2mrDYe2wIRKyxK0IF00BLykJV/2TVPFS8hkjrsvHcssDD/ZE+l05Ye4XqY41KxobP+gShfrLwD7qPCDKT6lKlERRCtBtCY7521deQooGBOOpzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ezK+lSKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VHn370Lu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ezK+lSKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VHn370Lu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AA8D140008A;
	Thu, 29 Jan 2026 13:37:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Jan 2026 13:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769711845; x=1769798245; bh=9o+4DMArnU
	tvHe39xB6GQueWFa5JQCNFxomGMY6THTw=; b=ezK+lSKsWNOpK7D5pagC+tYyXV
	XTFMokcIQ3gdYw5EmHJcEXG4sg/1aTTAERKncszTTxfHgLuOTWQcJu79Kpn4a9pZ
	pZkjOkMqVzrjhm2/9k2Q06pPJ6ejIK0wsBEpBtVIoIEq50sxa5mObwKFqZNDB36Y
	iZDcHr+pAiXHBuY3LJzRrgl3lNfyEQnOYA1ZfmmjId7c6OPQDqwZkv4VJ+BC9X53
	AwHfkG/zrhMUgmEeGmiH+EKFjBa1N60QSUVK4yND2jhb7rHhgrq1kMJmMP9GXgIZ
	p6fvSwHQlxLzig6acm359DRJDzD3c/tT6eNrE0T74bIIsbkDSqC42WarjXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769711845; x=1769798245; bh=9o+4DMArnUtvHe39xB6GQueWFa5JQCNFxom
	GMY6THTw=; b=VHn370Lu0znqG/YpruvPHOu+ki3Pb1mPVqXaaHsV706CsnW9n7y
	juCuqVEuFTEI0SS7aREs/RcAvr39A3GwNI+BdSPMKaAkqXPrXCMbrd2mwAfJIJxM
	0yjvDSYjNnjQLheHUM3P/POTXFXzAF3FLEGaYrj7h1gDQPkDgDd23b+tcA3RP7bJ
	27ij3tptGYc8rbCJqYrehzG24WbI9CxBGRx1mGs8G6IN96FpEAT6izkh6/vbWe3A
	hIEbf2ZjPp1rRhPm5mutPHH5UdJe8aMRmH14/aL3m3hH2xSZdGX1JsxoDC+C1T6p
	n3WEuQHPjl95GvOCB4VKevWyypGkzANvy0Q==
X-ME-Sender: <xms:5Kh7aWu0oFq1-TLHQPJeYoeQWoSVq_Ocb9NJLSqdJFw_XuGSVxxY9Q>
    <xme:5Kh7aYDa9Iwzi7S6S9zRgkv48uOyS3Tf27HaOZedpdR0jxVmx3rNHZiIexupHrJu6
    uElXjbaMCQgk88kNXA7hJ4a8u3wseBgU_7QAXh7mVN_XqjVxgqG4zc>
X-ME-Received: <xmr:5Kh7aWNBNuKRrO4ES_y6kSJ9TqZ4NIi8PWldG2ND7gQ40hUMEuTff-HPFth4kq6feiyLGy7G1_PVKq0RSzsmsSEtk8qtgAX6co20l74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetudduveekgfeuteevudfgkeeffe
    eghfeiudekiedugfektdelvdevudeggefggeenucffohhmrghinheprhgvphhoshhithho
    rhihrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtd
    dvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghm
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5Kh7aYDKkWGisOFYeKAf8mH8DK1YMfVD5HYt6VgxRlAtr-dcRyLjAw>
    <xmx:5Kh7aX4QIJHwUizHZoz7LxBkXAFsIusgBtn7llM_GMVVHsTtYPxfEg>
    <xmx:5Kh7aS6xouoFqwhDNvr2RHGYd998uUfL5MKrvMCMdoGSkQ-CWQ2jwg>
    <xmx:5Kh7aZQtneChu5CMnw8AafmLmBRNgyF-EbVKYt8jWs-4FIPpQi_P8g>
    <xmx:5ah7aXRflyHA8DZErf6UODdengBlILUzW6JSFqVezTi_ijJRfJdgiXut>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 13:37:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v5 3/3] environment: move
 "branch.autoSetupMerge" into `struct repo_config_values`
In-Reply-To: <e7f37bac87aac74ca13f85ae7e393a38d2079b9c.1769256839.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Sat, 24 Jan 2026 13:21:13 +0100")
References: <cover.1769256839.git.belkid98@gmail.com>
	<e7f37bac87aac74ca13f85ae7e393a38d2079b9c.1769256839.git.belkid98@gmail.com>
Date: Thu, 29 Jan 2026 10:37:23 -0800
Message-ID: <xmqqms1wb6zg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> -enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;

Unlike the other two, this global variable was not zero-initialized,
so we can do something like this to initialize it statically in the
new world order.  That way, we do not need to worry about the
repo_config_values_init() helper function, which (1) we can easily
forget to adjust, and (2) third-party may not be able to call.



diff --git i/repository.c w/repository.c
index d308cd78bf..b540e2ba01 100644
--- i/repository.c
+++ w/repository.c
@@ -25,7 +25,11 @@
 extern struct repository *the_repository;
 
 /* The main repository */
-static struct repository the_repo;
+static struct repository the_repo = {
+	.config_values = {
+		.branch_track = BRANCH_TRACK_REMOTE,
+	},
+};
 struct repository *the_repository = &the_repo;
 
 /*







>  enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
>  enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
>  #ifndef OBJECT_CREATION_MODE
> @@ -607,18 +606,20 @@ static int git_default_i18n_config(const char *var, const char *value)
>  
>  static int git_default_branch_config(const char *var, const char *value)
>  {
> +	struct repo_config_values *cfg = &the_repository->config_values;
> +
>  	if (!strcmp(var, "branch.autosetupmerge")) {
>  		if (value && !strcmp(value, "always")) {
> -			git_branch_track = BRANCH_TRACK_ALWAYS;
> +			cfg->branch_track = BRANCH_TRACK_ALWAYS;
>  			return 0;
>  		} else if (value && !strcmp(value, "inherit")) {
> -			git_branch_track = BRANCH_TRACK_INHERIT;
> +			cfg->branch_track = BRANCH_TRACK_INHERIT;
>  			return 0;
>  		} else if (value && !strcmp(value, "simple")) {
> -			git_branch_track = BRANCH_TRACK_SIMPLE;
> +			cfg->branch_track = BRANCH_TRACK_SIMPLE;
>  			return 0;
>  		}
> -		git_branch_track = git_config_bool(var, value);
> +		cfg->branch_track = git_config_bool(var, value);
>  		return 0;
>  	}
>  	if (!strcmp(var, "branch.autosetuprebase")) {
> @@ -761,4 +762,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  {
>  	cfg->attributes_file = NULL;
>  	cfg->apply_sparse_checkout = 0;
> +	cfg->branch_track = BRANCH_TRACK_REMOTE;
>  }
> diff --git a/environment.h b/environment.h
> index ddce69c6ba..27161d56ab 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -2,6 +2,7 @@
>  #define ENVIRONMENT_H
>  
>  #include "repo-settings.h"
> +#include "branch.h"
>  
>  /* Double-check local_repo_env below if you add to this list. */
>  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
> @@ -88,6 +89,9 @@ struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;
>  	int apply_sparse_checkout;
> +
> +	/* section "branch" config values */
> +	enum branch_track branch_track;
>  };
>  
>  /*
