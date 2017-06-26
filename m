Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84EF0207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 22:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdFZWNM (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 18:13:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33116 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFZWNK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 18:13:10 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so1805653pgb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pk9GxdfQVFB9/vRxJ4/SQ5QGeI+mRyBpqfZXQsFyjyw=;
        b=R7JOzjacBgEzE6nKH5ujSvXYJ4lP+p9aUiZnZWT1U/mhdQ6chDSP84JLtvyNn+9u/L
         lYvrUx5NpEGO6/9mxGHcaadWb8xaFQlYdZH8cGSjdreU/vVfst5ZrmpbI5Vke174l8Wx
         gDvvw9vA9+PvzY8gG54Fl65yAf8l7TKSjtHpLwkQRKyAHXdgNTPrBfi10QogyVx+pGVI
         OmamjosVeX75CZLyYoAPa4nOXlnsgSCLWNaVc4UOhSNH/2sSSnwseBsOCZAi5gXn9JLZ
         2lYsfxsn6qYbphiAqF+aQJhkpxxj8EbKFjRuQcS1SVn4rJGN8NsAt6/cTLVua7y1Yo4f
         exlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pk9GxdfQVFB9/vRxJ4/SQ5QGeI+mRyBpqfZXQsFyjyw=;
        b=cPUK1Edw/lbwXuS0qvAi9ASpY4Gt8iWSTLX/U/Sb5uCSn6ukkjCdXTKDjk0gnMEwDR
         tIAB8CjvCkp7BLXnvctk694ZGVrHDZbHs4bkwtB9SjprCcUJBHWgw0T0OIDJn2dHy/qr
         qSpz4UgHx7Tp5cQR8PlK7vEfOIdrxgveSMTmDDuC3bre22OIB3yrrObn8zdQLIREnsm7
         soAWHmslW/OJO7809ptAy6ErDqKZPEKe3xVuU4Ijz14mWoIxsMhlj3NjCzVYxw2ORes/
         2xuuJ34r1sTX5WQYakY7h9IQhUTZbvXsY27rwDoUp6subXcHm7labWzULSnFNfyZclP4
         g/vA==
X-Gm-Message-State: AKS2vOyY/wYIle6VETIDZt5mIbDHM9IYX6eJ8mSRHwXYvdlz7VgHt26n
        UBYQtsyBOAlBVQ==
X-Received: by 10.84.129.67 with SMTP id 61mr2356447plb.229.1498515189266;
        Mon, 26 Jun 2017 15:13:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id 75sm1809453pfc.52.2017.06.26.15.13.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 15:13:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 6/6] convert: add "status=delayed" to filter process protocol
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-7-larsxschneider@gmail.com>
        <xmqqzicu4lnq.fsf@gitster.mtv.corp.google.com>
        <F72755BA-6296-4C37-9EFA-4D7BCE9F1082@gmail.com>
Date:   Mon, 26 Jun 2017 15:13:07 -0700
In-Reply-To: <F72755BA-6296-4C37-9EFA-4D7BCE9F1082@gmail.com> (Lars
        Schneider's message of "Mon, 26 Jun 2017 23:28:21 +0200")
Message-ID: <xmqqa84u4cuk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Maybe this?
>     [...] If Git sends this command, then the
>     filter is expected to return a list of pathnames representing blobs 
>     that have been delayed earlier and are now available. [...]

OK.

>>> +by a "success" status that is also terminated with a flush packet. If
>>> +no blobs for the delayed paths are available, yet, then the filter is
>>> +expected to block the response until at least one blob becomes
>>> +available.
>> 
>> Ahh, this is better, at least you use "the delayed paths".
>> 
>> What if the result never gets available (e.g. resulted in an error)?
>
> As soon as the filter responds with an empty list, Git stops asking.
> All blobs that Git has not received at this point are considered an
> error.
>
> Should I mention that explicitly?

Otherwise I wouldn't have wondered "what if".

>> I am wondering whose responsibility it will be to deal with a path
>> "list-available" reports that are *not* asked by Git or Git got no
>> "delayed" response.  The list subtraction done by the caller is
>> probably the logical place to do so.
>
> Correct. Git (the caller) will notice that not all "delayed" paths
> are listed by the filter and throw an error at the end.

I am wondering about the other case.  Git didn't ask for a path to
be filtered at all, but the filter sneaked in a path that happens to
in the index in its response---Git should at least ignore it, and
better yet, diagnose it as an error in the filter process.

>>> +				filter->string = "";
>>> +				continue;
>>> +			}
>>> +
>>> +			/* In dco->paths we store a list of all delayed paths.
>>> +			   The filter just send us a list of available paths.
>>> +			   Remove them from the list.
>>> +			*/
>>> +			filter_string_list(&dco->paths, 0,
>>> +				&remove_available_paths, &available_paths);
>> 
>> We first remove from the outstanding request list (dco->paths) what
>> are now ready...
>> 
>>> +			for_each_string_list_item(path, &available_paths) {
>> 
>> ...and go over those paths that are now ready.
>> 
>>> +				struct cache_entry* ce = index_file_exists(
>>> +					state->istate, path->string,
>>> +					strlen(path->string), 0);
>>> +				assert(dco->state == CE_RETRY);
>>> +				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
>>> +			}
>> 
>> But we never checked if the contents of this available_paths list is
>> a subset of the set of paths we originally asked the external
>> process to filter.
>
> Correct.
>
>>  This will allow the process to overwrite any
>> random path that is not even involved in the checkout.
>
> No, not "any random path". Only paths that are part of the checkout.

Isn't it "any path that index_file_exists() returns a CE for".  Did
you filter out elements in available_paths that weren't part of
dco->paths?  I thought the filter-string-list you have are for the
other way around (which is necessary to keep track of work to be
done, but that filtering does not help rejecting rogue responses at
all).

> There are three cases:
>
> (1) available_path is a path that was delayed before (= happy case!)
> (2) available_path is a path that was not delayed before, 
>     but filtered (= no problem, as filtering is a idempotent operation)
> (3) available_path is a path that was neither delayed nor filtered
>     before (= if the filter returns the blob as-is then this would
>     be no problem. otherwise we would indeed have a screwed checkout)
>
> Case 3 might introduce a problem if the filter is buggy.  

> Would you be OK with this check to catch case 3?

I'd be very suspicious about anything you would do only with .nr
field, without filtering the other way around.  After all, we may
have asked it for 3 paths to be filtered, and it may have answered
with its own 3 different paths.

>     dco_path_count = dco->paths.nr;
>     filter_string_list(&dco->paths, 0,
>         &remove_available_paths, &available_paths);
>
>     if (dco_path_count - dco->paths.nr != available_paths.nr) {
>         /* The filter responded with entries that have not
>          * been delay earlier. Do not ask the filter
>          * for available blobs, again, as the filter is
>          * likely buggy. This will generate an error at 
>          * the end as some files are not filtered properly.
>          */
>         filter->string = "";
>         error(_("The external filter '%s' responded with "
>             "available blobs which have not been delayed "
>             "earlier."), filter->string);
>         continue;
>     }
>
>
>>> +		}
>>> +		string_list_remove_empty_items(&dco->filters, 0);
>>> +	}
>>> +	string_list_clear(&dco->filters, 0);
>>> +
>>> +	/* At this point we should not have any delayed paths anymore. */
>>> +	errs |= dco->paths.nr;
>>> +	for_each_string_list_item(path, &dco->paths) {
>>> +		warning(_("%s was not filtered properly."), path->string);
>>> +	}
>>> +	string_list_clear(&dco->paths, 0);
>> 
>> And "list-available" that says "path X is ready" when we never asked
>> for X gets away free without detected as a bug, either.
>
> With the addition above it would!
>
>
> Thanks for the review :-)
>
> - Lars
