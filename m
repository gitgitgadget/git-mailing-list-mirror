Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1D4279EE
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125228; cv=none; b=bNcFakjuTHbkc6mpdNC4J5Cb7Sj01u7lZZbn3g8QT1FXLkmYMUtB7h71RVo+irKa6ah7kNzhkptPzJ9zgsD/oBz5wiaO4MAFOLMXDLB6sNVEvjJ8snK8S1NdsgCewwWeyXJTNXL7Uwq8qeTfdcbFzpZGd03oo1DrCSXj7uD3JsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125228; c=relaxed/simple;
	bh=3RwILaGO1AuqyxidIMuNWcq3r9JgpuEtSLj5XdDWoRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKgy+44ETeDS9mB9U+AHTiVGsh4/JPSiETIKIQooByQWccuoedZLJWJLR8IhKsD/70kObSGE2vK3W3Ix1gnmhsAXlT22sQ8EsWMAgkcWbCnuVF2mC9UIFTEpuJUiuyi+TiGF5OrfBYwBpHZ4WI0xyT8yhvCNOPa4U/8cRkMrw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x4ToGEJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MfNInJlg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x4ToGEJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MfNInJlg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2228FEC0957;
	Thu, 26 Feb 2026 12:00:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 26 Feb 2026 12:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772125226; x=1772211626; bh=CQuzLHvvgn
	9Jak84YJB+fZCeeTB+Y7O5AEDuWQS5th0=; b=x4ToGEJhO3gOwZOYLypvqB9x7h
	D4O1RCrro57YHZIje9Lar/I6QenawhYXc3/SDSEE9T1a9z6EXQmCTassu9aRIW0h
	8jm/97pWt1jPOj4/lhMJW0IezV46QlOVsoiF1Op2k66hCBvUMg6gBj4jtwBE4xJ0
	FGXqniNLitpB/+cI9zxwgLzUfYqgOg9gULt1ZN999Ft1MLgrfrgPWJA+ms/EAzU9
	13oQTarphpgcf/fs2SQwvSd1UdtUng0XWoWN216hq/29/CmvfpZ/ibas6I9S0y4Y
	jsahfYZISoZQiYH2jiuVMwKl3mNc9cD31cl0/kkZdoL+h71A/+iY6m5KuT0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772125226; x=1772211626; bh=CQuzLHvvgn9Jak84YJB+fZCeeTB+Y7O5AED
	uWQS5th0=; b=MfNInJlgol0WOI+NP3GHR01xPrJnEljYIGtOvertf15LFrJPA0A
	oy+l44SA5Ru9GOy+Bn7WbKuZOwjACzyYCeCYI36g9GgXfsRNgJ/FHOd/ALJcfX+7
	TyyDuyRsaywNa4W/7Wq4MrgJeExC9nG5qR5bbrnTsJjpx5WTMNYBssLNzAwJF/lU
	yZvbzgBAf8p7KEg9/8kWsyT6yzg2YEdxWNqFQwJ6VSqbKdfm0AFCjbec3c4AwoDp
	n6teF8ZsVigxbwaP0lpq2Wm38VQuwlWmpW4DKW6BN3pAeNPpdcJwaHZ+Ji6mWqgz
	Obifr0pS8aeJQDaK6xdEBsdbXWNdxiIlc6g==
X-ME-Sender: <xms:KXygafMTCjRgz9pkX6W0DSPAWdvGuM5cYlE7dIEl1ZL8j7M6s12-ZQ>
    <xme:KXygadoRrEuIL8Y9kaFc0Vo2ecaPS0wABqdmCLrIc9gxXbqLnBEhLEvmWLKb4zC3l
    ErjhntN6nfPwOey5gfQLEEIooCYoXe5R_SyjNR0LRZlR3fJC1LHGg>
X-ME-Received: <xmr:KXygaYHQCJrISiwoAQGqK5bgIb4zAS6_A23celBmc9y_S3mzWibvUzPMiIwQONOsIEgEd0za5tYqPmG5s3dsCuVi8rF57o8uiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hnrghtrghnsehjohhnthgvshdrphgrghgvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepsggvnhhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KXygaaoc7nnQimq5vt0B6xrqdyXorZp2SPePG-YoA43bBD_6trKPpw>
    <xmx:KXygaZa_UBcqVIZvaVLdrhhDQMim7goqSZx9ESKvnG4C84Plg8Oazg>
    <xmx:KXygabV1-rruOJ180LEACAeHnXGETAcozvKRuiaM2f2C_EqIvJ1XYQ>
    <xmx:KXygaa8ySSnFEps4BhvduO4WTaRKYpeCKl1o_DquaOwL8f0Km_W8Yg>
    <xmx:KnygadWqa0GzsLiDnWiih45MDULScx_A9YPaIAlteXl4oDAA8W3bYbng>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 12:00:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] Fix small issues in alias subsection handling
In-Reply-To: <20260224171245.458377-1-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Tue, 24 Feb 2026 18:12:34 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260224171245.458377-1-jonatan@jontes.page>
Date: Thu, 26 Feb 2026 09:00:24 -0800
Message-ID: <xmqqa4wv4ezb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> Hello!
>
> I have two small patches related to the handling of alias subsections. 
> The first one is a documentation fix for the example showing the equivalence
> between alias.last and alias.last.command, which was missing list continuation marks. 
> The second patch addresses a compatibility issue where an empty subsection ([alias ""])
> was not treated as a plain [alias], 
> causing existing entries stored this way to be ignored.
>
> Thanks for considering these patches!
>
> Jonatan Holmgren (2):
>   doc: fix list continuation in alias subsection example
>   alias: treat empty subsection [alias ""] as plain [alias]
>
>  Documentation/config/alias.adoc |  7 ++++---
>  alias.c                         |  4 ++++
>  t/t0014-alias.sh                | 14 ++++++++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)

Memory leaks have been reported for these patches, e.g.,

  https://lore.kernel.org/git/6953f6f2-22e8-4efb-8169-395e1c52634f@intel.com/

I _think_ the following would be sufficient to plug it, but please
double check and then send in updated version of these two patches
incorporating them.

Thanks.



 git.c  | 2 +-
 help.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index c5fad56813..b5eb740e83 100644
--- a/git.c
+++ b/git.c
@@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
 	}
 	for (size_t i = 0; i < list.nr; i++)
 		puts(list.items[i].string);
-	string_list_clear(&list, 0);
+	string_list_clear(&list, 1);
 	return 0;
 }
 
diff --git a/help.c b/help.c
index 82fb2eaa3f..725e92a195 100644
--- a/help.c
+++ b/help.c
@@ -423,7 +423,7 @@ void list_cmds_by_config(struct string_list *list)
 		return;
 
 	string_list_sort(list);
-	string_list_remove_duplicates(list, 0);
+	string_list_remove_duplicates(list, 1);
 
 	while (*cmd_list) {
 		struct strbuf sb = STRBUF_INIT;
-- 
2.53.0-517-g7bf7f89b4a


