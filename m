Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CA11F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeAYUe2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:34:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45943 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeAYUeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:34:23 -0500
Received: by mail-pg0-f66.google.com with SMTP id m136so5787529pga.12
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mhxgCuQNn5Y1WaYRPoaPgh45Rgsrm7+w6nL6QnOwCd4=;
        b=cXxDc+evycHW1+/HU6b/0Rns/AhsKNWrQULIuLrCDXWWvIGFvd19auLzS/Rv2k3XC/
         BgRSB3cydlZMA4AqE2Ehe3OUHAec79fdrvJLBHfFHJo2CU4bYx5c6yJ8fmbHB50XpNpm
         NLa6kENF47Oi7sNCuA8zNJmyKy2hptR3IgBWxMP5RAmpEnUpYji3Vz9KNKimeTEx0Bmj
         l9qtX+/zyz5M5UucrU4SZVBpHTV1zhvtX9Hn77hDDb/SCWam6WYIoc1MAyN/8c1cdzkr
         Bn2GRzdoVHAxo0Z7iIjUwHDUycBA57bQo468fUXLb00rYfjwRmHh1fmSePaeRIVLdauF
         NRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mhxgCuQNn5Y1WaYRPoaPgh45Rgsrm7+w6nL6QnOwCd4=;
        b=AmqK6kp968C1zHNmUTZbDQcs6DkoU5dzPBOaDaVaivK2YtDyJ1aHtvLKZ7dfxe+BDJ
         95jv8Uefp+ZgFjX/kzOmVZxgT+bC3sbaHWAmARR+aCnGd1lXfYaMBKkCYjg4gWWbfOiW
         LsYJEzbktp7WKI3NbzEp7JVTzzQWvfiqvagka/hAPRPFH0U6mGPkYQdeNedPnzmqSw3d
         n7PPvZu+1Ew85r6AutpBxVuA6dpuwjmOBydvjIGHczGGW8Ppt9tCoOHnhEm5pKMbWc83
         F6+6ktpW0U4WUjigzGwoSR/LfFdqSHwMH7z8e075X99NklFBfOVcb3MvvBO9U1LJ6kkk
         yWJQ==
X-Gm-Message-State: AKwxytd4h1KGi4zUzbxqijBzKmFLHppbb0VnthWdUeD8hjM7MDpTOBrg
        fr92w2m+JyAAztaZU7SA6jk=
X-Google-Smtp-Source: AH8x22733xSIsK47rC+wEUAWtnulAGygBn6+P+Wy1Rm2NMGL0u6StHKVUewqz/SPrSWyuI1RVqFZAQ==
X-Received: by 10.101.97.12 with SMTP id z12mr13365197pgu.92.1516912462585;
        Thu, 25 Jan 2018 12:34:22 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id o20sm5418719pgv.85.2018.01.25.12.34.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 12:34:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     KES <kes-kes@yandex.ru>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Feature request: Improve diff algorithm
References: <14657461479715884@web21h.yandex.ru>
        <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
        <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
        <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com>
        <12531516812201@web36o.yandex.ru> <446801516908691@web22j.yandex.ru>
Date:   Thu, 25 Jan 2018 12:34:20 -0800
In-Reply-To: <446801516908691@web22j.yandex.ru> (KES's message of "Thu, 25 Jan
        2018 21:31:31 +0200")
Message-ID: <xmqqfu6tad9v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

KES <kes-kes@yandex.ru> writes:

> One yet more:
>
> @@ -141,5 +86,9 @@
>  	// }
>  
>  
> -	OP* o;
> +	SV *tvs =  newSVpvs( "ScalarHistory" );
> +	SV *tva =  newSVpvs( "ArrayHistory"  );
> +	SV *tvh =  newSVpvs( "HashHistory"   );
> +
> +	OP *o;
>  	while( PL_op ) {

Huh?

If the asterisk between type OP and var o did not change, then
inserting the three new lines before o's definition may make sense,
but otherwise...

