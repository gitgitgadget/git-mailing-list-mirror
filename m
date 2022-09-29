Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238BC433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiI2TU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiI2TUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:20:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5466128
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:20:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r134so1680063iod.8
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=+KXzljHoL+BtJ+yJZaGibVee36EQ4yCudvDICuNjtAo=;
        b=V4OjeTJZQFT5xXFB+/Sa/lun1Q+TTNm+2RuMFnrsZi3etxUiN3MWpCJ+V77Ez4PFfr
         I5VPsU6wr8uR7IbRuYfB8Ukcrnp4fj5P/N+NSz2qpsCqfFIPEAxpa/DPhVNrGbx4XsJ4
         DGt8M0iMVncO+4xpeoAkX6+myrSzfgh879XPuJ2llVJHq4iHpnvdQ564sAVRbKJy6Ljy
         CJpwGpCc/OvRszi732O8Wtjn/3Ahz+FR2fAtLXHJGVPTxdDqI4zd04As7maejtB4ajT0
         gnzkTrKiMojRYf7Pc8DNT0oj0b1OxGhAC+kKnJIyZFkcB0FruOFexBAGq9LGYYQyfwkk
         noEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+KXzljHoL+BtJ+yJZaGibVee36EQ4yCudvDICuNjtAo=;
        b=v7TTBeLzOaNB69yjsB4R5ZHRQX8ZbRtnHx0C2/1+JNcA0QDdrBHF8nVLcrLOJFx0ut
         Htxp3NRXfaCpBw3fxcoLZTYCUurBXgzGHf6e3O+yna27KwijZ7+cA7S0H1EVHHt7/gJa
         NVTKx0iTZRDhf10PC3b6o/iqVIZtOkjGL0EdBQ+G8jg2MDjDnXrNsI3nypOENbtAXDPE
         TMkFWxYwTgnYPumLFqShTYDMYzSiD3Sqj9bweb0oHaAWLmdAJlLDttbyvahD40mufzzs
         ZIU0fiK3yFSWsuSs5LjXnDfm130mU1yF9YFjwCLEUexySPt7iO6mF6J2QB2P4vhTQvmx
         WAVg==
X-Gm-Message-State: ACrzQf3LAmczFjgShLxA4Wf86T4giGUoXR0VJHnLQAPZvtB9YlE7g8G1
        bb/c4lUxTNXQ5CPv+PA2mM3unlERk7dJZA==
X-Google-Smtp-Source: AMsMyM5KKIaAwLlkmzc7TF82aeFWONY5XYsM20toYh9uEAC/93H9U5AdDwUZ8a5lGGAE2+a2/nbrIw==
X-Received: by 2002:a6b:1c7:0:b0:6a3:2e71:2a91 with SMTP id 190-20020a6b01c7000000b006a32e712a91mr2324077iob.158.1664479220865;
        Thu, 29 Sep 2022 12:20:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b19-20020a056638151300b0035b3129ac03sm72250jat.171.2022.09.29.12.20.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:20:20 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:20:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 3/8] Merge ORT timeline
Message-ID: <YzXv80Lb+UUe37td@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Merge ORT (Elijah)

- Git has multiple merge backends - default was "recursive", now
	"merge-ort"
- When merge-ort was written, it was intended to be a replacement
- Would people be okay removing the old merge-recursive code? ORT was
	meant as a drop-in replacement, but it does have some differences in
	behavior
	 - If it is okay, what's the timeline?
- (Taylor): gradual guarded by config might be a good approach (e.g.,
	"merge.recursiveIsORT")
- (Johannes): describing the differences in behavior
	 - Merge-ort rename detection is always on, but merge-recursive is
		 opt-in
	 - ORT uses histogram diffs (arguably more correct, matching unique
		 lines in diffs). Leads to (sometimes) merge conflicts where
		 merge-recursive didn't find it, but ort did. Still probably more
		 correct, though. Much more rarely, it's the opposite - recursive
		 found a conflict, ORT did not
	 - Conclusion: wait 2 major versions to deprecate
- (Taylor): maybe we should add "turn off rename detection" option
- (Johannes): should we even give users that option in the first place?
	If they don't have it, they won't be as upset when we get rid of it ;)
- (Peff) how long has ort been the default? 2 versions. Now people have
	recursive as a escape hatch. But we don't know if/when people use if.
	Also recursive with find-renames is an escape hatch.
- (Emily): we know how often people are using escape hatches (at
	Google), could take the same approach with this option
- (jrn): do we have other signals for how often this escape hatch is
	used? Stack Overflow posts?
	 - No one's named it as a solution on the mailing list, though, so we
		 don't know from that medium
	 - Agree with Johannes, might be best to not give the option to users
		 because this way we have more chance of getting signal.
- (Peff): the mailing list isn't representative of the larger Git
	community, so people bringing it up to the mailing list might not be
	indicative of usage
	 - Leaving the hatch doesn't seem like it'd incur a huge maintenance
		 burden
- (Terry): some distros might have significant propagation delay, should
	probably bake in extra time because of slow adoption
- (Ævar): I'm happy to follow your decision
	 - Some behavior difference, but it's working -better-
	 - At some point, we should be willing to say "if you need an old
		 feature, use an old version"
- Some observed differences might be libgit2 recursive vs. ORT, unclear
	which ones though
- (Johannes): We can bake in a deprecation notice, like: if you see
	something wrong, now is the time to bring it up! We'd rather fix it
	now
- (Jeff): most users won't be bothered - they'll see a conflict and
	resolve it, without thinking about which algorithm generated the
	conflict
- (jrn): for most usage, this is a completely safe change. The
	discussion comes up because of the fear that some user might have some
	use of merge they regularly do that hangs, that kind of thing, rather
	than the subtle merge resolution changes that we've discussed. I think
	we're safe. :)
- (brian): observing something like Debian or other LTS versions of
	projects - if there isn't a lot of screaming after a couple months,
	it's probably safe.  Even if you wait a decade, though, there'll
	always be one or two who suddenly encounter issues with the new
	feature after the old is long deprecated.
- (Ævar): haven't seen any huge warning in the merge docs saying we've
	changed something, but with how many users are already using it, it's
	likely very few people will ever notice
