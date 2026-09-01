Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF94854F2
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284854; cv=none; b=LS5u5abp4yIgCWLVlDi9lu9jY5nmt5F2DJ7ytut+5nRc1WrCK7CpO89wYNNoe4LVzBUpxpP1nAwJXuX4pRlZKQxYtCpZTDoRFBJDvwINNgO8BjQGnG9EqRk9F26DtAcpB3lvTXGuQkFimkT3N8cgcgykXHuEGqZQd2R1b3ZLzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284854; c=relaxed/simple;
	bh=c0xcMh/dvd8aZMLNTTCOEqcgrMZTr8s4nRG2aP19H1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjxuo6EuhR7rgdX9u98KP32VmL3qhGNH6FA3Gd8F0yqADzqZQe88V0GRsj2IcPilZKXvE8tV1zRGIGaDJmUpWPqG5AYQcaBxOFQMD86/PB1E0bQ603TVdcLuFI5U0omBTe2nD4b+PUBUFSgajW2TDzGSQF8r/KILpBga7Yz8R48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xDh17jEZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjfqW4gp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xDh17jEZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjfqW4gp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 309011D00125;
	Tue,  1 Sep 2026 13:47:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 13:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788284851; x=1788371251; bh=CWmfPChx+L
	znf4QCUP0kd/g6T9r1sTI4XWVD+7dep+I=; b=xDh17jEZpktr0+bq3n5urPjf08
	1B+smw3AEgb4XkUcs+10AQ7jRfeEgt/UD3+IBttjB49fOhlmPdNxKlP7tVulExW7
	aa9jbYVz4IwTkehG+W4z824R+aXJud8MxSBpSUpLkF6/NfCFMMJQJvOgbsB0ysjl
	K9MrRNtqbJzxd9lArNXWHJi7vnLDOfqtmjdaiyoz4Zcb09v3E2eGsqS24A7apMLe
	wJwme/H3w+zy2UX+jFXZBttsXvbXqsrJ4kfVgwbFQpLnTIL38vNDkWa0JMlMSp4o
	QjgiTSzwS/z/VH9UY+UAdooZ+CiJPZg7MbRzOQ204R11rtq1Y8f+gqFx0MZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788284851; x=1788371251; bh=CWmfPChx+Lznf4QCUP0kd/g6T9r1sTI4XWV
	D+7dep+I=; b=PjfqW4gphx4++sDrGO+WK8E03Xpf2MObu9AmBaYLhANIp+SBgne
	kS9ymnNpAIB90iPjcqGt8tno7iF6abtFiCCKXDFA7ZUkA0FGFs5xAEG6YT6xhxCo
	DBvLwMdKefM1QC+BfbVvcogWlpfQX0UYuXDITDo+lJLHJZGpe6ah5rCfyxsD0tWT
	Pcu/cn0PUA6yrn/NWLyTO9pzhWzKSFsGxzW9Qe8CEGhKn8HELgDG22Mw5yyZIQON
	5Z4gMdqACcp/E8+IXMCLOYs5vQirSEHnIXmgJBnRdTMtK2EpKCOq5BWQFh+cO7PO
	Gs78tlsfU27qdG5NPFcHBay+ONzcD8nHIxw==
X-ME-Sender: <xms:sg-Xams_DgC9x8gst0BdamoJXD162OPWQBLP8Uggzam4rrvay-ngdw>
    <xme:sg-Xai4agcWsKKm83aKFWsVjIXfq09VC3b-M1Z0U5ajtPQU8VkOVYAlTzhifdH6Fc
    8d_ixI9pUjUoTAtHJacXYBAd2LRg2h7DecHFS2FWYZw-ZFqkgdNMSM>
X-ME-Received: <xmr:sg-XavKBY1Buy121O1XC_h4uVPeThYhGpPz5-fpSGPfkPmE9FsI76POvwBgjKYc_s2OPgyFzxoMiLcgYg2WMD4FlIaoDYUmxQg>
X-ME-Proxy-Cause: dmFkZTFqTPg9TALpynG9QTik/V4bZ2WoRf8wEniR+PenhLdLC/wN4vw9Kvt61wdQnBV+DH
    vNhOGT54vug5tWkNNG9vRXOMHeGCizFOvhn4uqSdtOolUCPYazWW54vL5zAAWReUxAycaq
    P6b3fF1tHOkgUp88lmiaq+P9WkPgiI+kf2dcVgzC/l+NT3ObwnqVd4iJa861h1LC9awcGK
    xu79vJxlUeNXsRuqlE1naLf9TRlm3JATy5m3utJ2L//0SuFMNsZ1/7ZwwgCxq4ViLpgqLe
    EHBgyirJ7zD9jCHOL/R5EFUrWaa6nLccvKOF+R1mdIsmgJdRt0qBwqp2jUl9h5Jv/YgDpp
    FyDYfSFB7hkfekIrmCZJbp3BRRt6fM8sWGW9/F8n4fmDBVwjqqgsHaSEd5rtNhOoW9lxpx
    fIZL53pT8weeyVr5cCNg2ihyx11T4Fk3NxQgVyQahgp8uSUp6Y60EDTzrvYkhaLAKumR+H
    bbJUZS5pY/Y0JF97LGfmreEasS3iefXrdBdRfnQ4x7N+rE6L/EHmsEIbdoS103M5heePVg
    mHB/anAua5QcKG4znb6B7mo32t8LL8/cn6UGlyuvx2j/aQgrOc5ynyMpGIWXhWfgvXimLu
    c7CvpVTbbRcuSG/ZQcJMCcB28X5XLH9Gd+3Xop0Mz91nqIySddHuJJPNrwVw
X-ME-Proxy: <xmx:sg-Xaq5DADElG_X3Cys1hnUWOcLhWdJ_zFZ5DBVT5pgSnqIMmOLehA>
    <xmx:sg-XaqygtMw2RUkxxUKT4STRUMEWTwykiRAmshnOyFen_ss1q92slA>
    <xmx:sg-XamZyZMISQbBlYJ6qUJQWrN2Yc5wCtkW-1JH8isr8Kgnjn-SALg>
    <xmx:sg-XakRjZ1vzTmm0FURUf6ivoiNWw82ASRRrylMxDSmFFEp4avtEpw>
    <xmx:sw-Xau4JVgdeUeAgBDPMd3MgpSlCu1Wx9N4d26LZEPqt6ATgA2eNTURd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:47:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/8] checkout: validate stage and merge option
 compatibility in checkout_paths()
In-Reply-To: <CAOLa=ZTA=xmPnEkMsncwd=3iZA62nsXq0jk-KiUr=GU7OUhh1Q@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2026 04:53:23 -0700")
References: <20260828225206.310500-1-gitster@pobox.com>
	<20260830204835.1040408-1-gitster@pobox.com>
	<20260830204835.1040408-4-gitster@pobox.com>
	<CAOLa=ZTA=xmPnEkMsncwd=3iZA62nsXq0jk-KiUr=GU7OUhh1Q@mail.gmail.com>
Date: Tue, 01 Sep 2026 10:47:29 -0700
Message-ID: <xmqqld9ksw26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> @@ -591,6 +591,10 @@ static int checkout_paths(const struct checkout_opts *opts,
>>  		die(_("'%s', '%s', or '%s' cannot be used when checking out of a tree"),
>>  		    "--merge", "--ours", "--theirs");
>>
>> +	if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
>> +		die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
>> +		      "checking out of the index."));
>> +
>
> Doesn't checkout_paths() also get triggered when using '--patch',
> shouldn't this go below...
>
>>  	if (opts->patch_mode) {
>>  		enum add_p_mode patch_mode;
>>  		struct interactive_options interactive_opts = {
>>
>
> ...this block? As the original checked for `opts->patchspec.nr`

Sorry, I do not quite understand your question.  

The "if (opts->patch_mode)" block indeed appears in checkout_paths()
and when "--patch" is given the control comes here.  Are you worried
about

    git restore --patch --merge --theirs

triggering the option compatibility check, instead of ignoring it
and directly jumping into the patch mode?

>> @@ -2063,11 +2067,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>>
>>  	opts->pathspec.recursive = 1;
>>
>> -	if (opts->pathspec.nr) {
>> -		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
>> -			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
>> -			      "checking out of the index."));
>> -	} else {
>> +	if (!opts->pathspec.nr) {
>>  		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
>>  		    !opts->patch_mode)	/* patch mode is special */
>>  			die(_("you must specify path(s) to restore"));
>> --
>> 2.55.0-884-g76cf8659c2
