Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB072C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54103206F4
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvkvLt2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgJFSzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:55:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50079 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgJFSzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 14:55:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F450E3F6F;
        Tue,  6 Oct 2020 14:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PFwQ4u3RzboKFzoqk0M7YpiUhVk=; b=pvkvLt
        2iC6qVhqCt8V6ALVsNBi3Hn9jIwA+OpPbZvtGMmAvp+WxmLrfxtkU/+keltA2S3T
        h4K9vZ/vx91Gl1hH5LO3Oc+lBYByJgd0GOEG6MO7OXa2ndROol4R1/hsi/50vJV9
        7yZvyYq9pH9ZCoIejef/N82IbXpRSY9OapKkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HNFDqGp9Yp3RzMDoAHlcyqhs8C5AerEg
        0NdJzFNUtG8rxe8EtVlxmVsmVT7/L0hiSRbWAJTxHe3ugLJyYMNJOdLtxm7vPb2A
        iNAzeI3L+NmNoAeBgmPHyGVBuK3PotjhCP33oTVMzqnlfJM+9X9Fdy4VuJqxtmkc
        L4acTua4N7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67F5EE3F6E;
        Tue,  6 Oct 2020 14:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC4C9E3F6B;
        Tue,  6 Oct 2020 14:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Javier Spagnoletti via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Javier Spagnoletti <phansys@gmail.com>
Subject: Re: [PATCH] Improve diff pattern for PHP files
References: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
        <d262c797-29eb-1e08-8de0-6a2dd2a5d47f@kdbg.org>
Date:   Tue, 06 Oct 2020 11:55:14 -0700
In-Reply-To: <d262c797-29eb-1e08-8de0-6a2dd2a5d47f@kdbg.org> (Johannes Sixt's
        message of "Tue, 6 Oct 2020 20:27:06 +0200")
Message-ID: <xmqqpn5v5gml.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78AA5FB0-0805-11EB-913F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Please choose a commit summary line of the form "area: summary", for
> example:
>
>    userdiff: PHP: catch "abstract" and "final" functions
>
> Am 06.10.20 um 12:37 schrieb Javier Spagnoletti via GitGitGadget:
>> From: Javier Spagnoletti <phansys@gmail.com>
>> 
>> Improve the output diff readability for php files by taking into account some missing function modifiers.
>
> "Improve" is a noise word and need not be mentioned; a non-improvement
> would not be accepted. Also, wrap long lines to at most 72 characters.
> Perhaps:
>
>    PHP permits functions to be defined like
>
>        public final function foo() { }
>        protected abstract function bar() { }
>
>    but our hunk header pattern does not recognize these decorations.
>    Add "final" and "abstract" to the list of function modifiers.
>
> I am not a PHP expert, so I cannot tell whether what I have written
> above makes sense.

Me neither, but the new pattern does look like it was written tp
specifically allow these combinations.  Thanks for a good example
log message to guide new developers with.

>>  PATTERNS("php",
>> -	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
>> +	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
>>  	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",

It probably does not matter in practice, but I wondered what the
reason for the ordering between final and abstract here (and one
line above) ;-)

>>  	 /* -- */
>>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>
> It would be great if you could add test cases to t/4018/ that
> demonstrate how these new keywords are handled.

Yes.  It seems that we saw another userdiff patch with a test
update recently and that may serve as an example, too.

Thanks, both.
