Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A211F453
	for <e@80x24.org>; Thu, 20 Sep 2018 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbeIUCfp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 22:35:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40108 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbeIUCfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 22:35:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8-v6so7088321wrh.7
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bunorwQ38kbYpD9ywjvoKWcPpil5E4F/sMZtDTVGxhg=;
        b=nkOadLJ7u/6lHS8WYMcch2AituxHiTQIPqSBoLZkLrGkqz7ohem9YyoGzs6cyiCDt9
         P6jqWY9briIu4UgQ0yv3RvewMYX95VE1uxn4lDUU18MihIx5zml9Ts6/s76fz96LmgrG
         mdolK8A2THVbpPeZM2MmtulSpJr+exDM8r1cJbRFxF/bBZusLFGj548w86FdOjRSzS8x
         ZpRyIHQpOJOiwFNxpW/LaZeOGkbek2Ekd9qh08nACR5i4BKPMQFkyT3fQp7IhDda4uOv
         NeiHV/L7WncgVe+LTvyMhXmlBI97joLcKy0aIMKd8gOo6ukZjT8i0UEQI8dTVHS9S8aw
         FQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bunorwQ38kbYpD9ywjvoKWcPpil5E4F/sMZtDTVGxhg=;
        b=DnNyvPJfmdoRKrUCQISNsCqkbrZUlvhxWZYGvMtyBdXiTBwLZJ3gdOwcF6CGtdrPwt
         7kXq5g/DttFP9VkBftthttNn0eeDzpYrFiRvq+RzUAHVd2y3Nx3k/9hitcX3mHm1i3PC
         A7JoPQ2SwmfyMntjYLYyTuNnw9quQbHQaoua7xks0ohWBtLn0EQMqfP7BdVS43dDUlwo
         hbIvtZU5+S4gMTxOgtAE2LYe2Kl/fIAmQNlom6df4tohMN7iLmLyYnY+kNoVhbAUwIEi
         arHtzv0rd7dV+7P1IR/BoO4wdQ0VSAz9M4pTdnBOjO2BbjPj4hO06yjzlkkJMSycpFhf
         WrRA==
X-Gm-Message-State: APzg51D1hHY2v0B0miMOj6759A33iLOzDB6nuS4UcOy21OuFUHpefAQj
        LHXbitEJUv0zYu+F9kxdXK8klBwH
X-Google-Smtp-Source: ANB0VdZlMWtYC1wkBWvR+/McIXYWu6GSecgS9PWCaZp+IU4Q+BUzh5+impXP5r6YDUiKmYLO5yVWNA==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr35929581wrx.103.1537476623684;
        Thu, 20 Sep 2018 13:50:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z16-v6sm21191690wrq.78.2018.09.20.13.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 13:50:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matvore@google.com
Subject: Re: [PATCH] fetch: in partial clone, check presence of targets
References: <20180920184843.20898-1-jonathantanmy@google.com>
Date:   Thu, 20 Sep 2018 13:50:22 -0700
In-Reply-To: <20180920184843.20898-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 20 Sep 2018 11:48:43 -0700")
Message-ID: <xmqqh8ijzyep.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 61bec5d21..e9640fe5a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -938,6 +938,25 @@ static int quickfetch(struct ref *ref_map)
>  	 */
>  	if (deepen)
>  		return -1;
> +
> +	if (repository_format_partial_clone) {
> +		/*
> +		 * For the purposes of the connectivity check,
> +		 * check_connected() considers all objects promised by
> +		 * promisor objects as existing, which means that the
> +		 * connectivity check would pass even if a target object
> +		 * in rm is merely promised and not present. When
> +		 * fetching objects, we need all of them to be present
> +		 * (in addition to having correct connectivity), so
> +		 * check them directly.
> +		 */
> +		struct ref *r;
> +		for (r = rm; r; r = r->next) {
> +			if (!has_object_file(&r->old_oid))
> +				return -1;
> +		}

Because check_connected() lies in the presense of "promisor", we can
defeat it this way, which makes sense.  

I wonder if it makes sense to do this check unconditionally, even
when we are in a fully functioning clone.  The check is quite cheap
and can reject a ref_map that has an object we do not know about,
without check_connected() having to ask the rev-list.

> +	}
> +
>  	opt.quiet = 1;
>  	return check_connected(iterate_ref_map, &rm, &opt);
>  }
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index bbbe7537d..359d27d02 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -170,6 +170,23 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
>  	git -C dst fsck
>  '
>  
> +test_expect_success 'fetch what is specified on CLI even if already promised' '
> +	rm -rf src dst.git &&
> +	git init src &&
> +	test_commit -C src foo &&
> +	test_config -C src uploadpack.allowfilter 1 &&
> +	test_config -C src uploadpack.allowanysha1inwant 1 &&
> +
> +	git hash-object --stdin <src/foo.t >blob &&
> +
> +	git clone --bare --filter=blob:none "file://$(pwd)/src" dst.git &&
> +	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_before &&
> +	grep "?$(cat blob)" missing_before &&
> +	git -C dst.git fetch origin $(cat blob) &&
> +	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_after &&
> +	! grep "?$(cat blob)" missing_after
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
