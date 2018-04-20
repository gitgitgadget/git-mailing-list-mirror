Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A8B11F424
	for <e@80x24.org>; Fri, 20 Apr 2018 07:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeDTH1E (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 03:27:04 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:48883 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbeDTH1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 03:27:02 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 20 Apr 2018 09:27:20 +0200
  id 000000000000003B.000000005AD99658.00001F5E
Date:   Fri, 20 Apr 2018 09:27:01 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: Silly "git gc" UI issue.
Message-ID: <20180420072701.GB13462@ruderich.org>
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
 <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
 <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
 <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
 <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
 <xmqqh8o7eq7j.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <xmqqh8o7eq7j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 02:10:40PM +0900, Junio C Hamano wrote:
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index c6679cb2cd..872627eafe 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -38,7 +38,11 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
>  int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
>  			     int unset)
>  {
> -	return parse_expiry_date(arg, (timestamp_t *)opt->value);
> +	if (unset)
> +		arg = "never";
> +	if (parse_expiry_date(arg, (timestamp_t *)opt->value))
> +		die("malformed expiration date '%s'", arg);
> +	return 0;
>  }

Should this error get translated?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
