Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CE71F597
	for <e@80x24.org>; Sat, 28 Jul 2018 09:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeG1LOF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 07:14:05 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:35993 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeG1LOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 07:14:05 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 28 Jul 2018 11:48:10 +0200
  id 0000000000000020.000000005B5C3BDA.00005D90
Date:   Sat, 28 Jul 2018 11:48:04 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clone and case sensitivity
Message-ID: <20180728094804.GA12770@ruderich.org>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net>
 <20180728051105.GA32243@duynguyen.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180728051105.GA32243@duynguyen.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 07:11:05AM +0200, Duy Nguyen wrote:
>  static int checkout(int submodule_progress)
>  {
>  	struct object_id oid;
> @@ -761,6 +785,11 @@ static int checkout(int submodule_progress)
>  	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));
>
> +	if (ignore_case && has_duplicate_icase_entries(&the_index))
> +		warning(_("This repository has paths that only differ in case\n"
> +			  "and you have a case-insenitive filesystem which will\n"
> +			  "cause problems."));
> +
>  	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
>  			   oid_to_hex(&oid), "1", NULL);

I think the advice message should list the problematic file
names. Even though this might be quite verbose it will help those
affected to quickly find the problematic files to either fix this
on their own or report to upstream (unless there's already an
easy way to find those files - if so it should be mentioned in
the message).

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
