Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8EC20136
	for <e@80x24.org>; Fri, 17 Feb 2017 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934431AbdBQRFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 12:05:55 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33844 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbdBQRFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 12:05:54 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so4462802pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=odQAqyZNevN2zvd2koZiXuVzrFZq+oepnlB27wqpe2M=;
        b=K7Na6Ax7JD8B+g9/0MdGOYyq+y2SrdRcFYWB1lIttmUtGNC3PuN1Ql/EXcklNLO56D
         4ydVxcuzINhkkzTexUEfY0mHJl4wT5Y9XDot2Nx2kil7LNuPjKfvMio/ea4R2gHlLF3a
         ub1K7riB5dGV3WNQgM6X2U44TcDO82E4no4Z7Fr7vvXKDkf6+1WQTKAnUJQljSGhb3PY
         mLOFMCyzND6y7dlVwK3RtK8TbeJurRv4BCryyk9qkvliG3S71xrpHHTySbg65wkhrWa4
         lszS2OWHyC0b0eetqyjLLvbEk6TzvPCP710QGxc4G+i0ATcQrCIjt1wKosKvlAPVd566
         yHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=odQAqyZNevN2zvd2koZiXuVzrFZq+oepnlB27wqpe2M=;
        b=Cc/W2pks7oSQ1hEA0fC8uLeUGaD1is8/ZURv3oBU5B2Hd4nidkAsxltG9ojSS78DpR
         9W8tn/+Qbf9nEMVKC7AsFpjqqIn3PtlSbWL5V0bNLOX9Q0RyDKb2nwFxuZ7A9PF5ohbw
         hMFYUezCUzmO8HRpmKl66Mf8GWCwUhDTZ2weutMujINMx8AMme17iK+7/4KbX7iDPVHG
         9Qv4KamGtwPt8njkE/LHm9DR7ToUTAZrJ870J49MVXEUCJ+nyYE2xC0lrDd8G0KQlL9g
         WOt4K/Ab4WjvpYHfKL02WDt2taWlwDhjhBrZSUmLFrJYU7FM4C4qnce8TJJznyk0/iRN
         KcQg==
X-Gm-Message-State: AMke39mZpCtLSVYHEd3dRAyvbettfPCib2t/pLvI2iwY153FGZ9ud4U4X8h9aLX9i8DoNA==
X-Received: by 10.84.218.204 with SMTP id g12mr12469950plm.78.1487351153775;
        Fri, 17 Feb 2017 09:05:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id w25sm20840374pge.27.2017.02.17.09.05.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 09:05:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] delete_refs(): accept a reflog message argument
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
        <20170217035800.13214-1-kyle@kyleam.com>
        <20170217035800.13214-2-kyle@kyleam.com>
        <20170217081205.zn7j6d5cffgdvfbn@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 09:05:51 -0800
In-Reply-To: <20170217081205.zn7j6d5cffgdvfbn@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 03:12:06 -0500")
Message-ID: <xmqqshncu4r4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/refs.h b/refs.h
>> index 9fbff90e7..81627a63d 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -277,7 +277,7 @@ int reflog_exists(const char *refname);
>>   * be NULL_SHA1. flags is passed through to ref_transaction_delete().
>>   */
>>  int delete_ref(const char *refname, const unsigned char *old_sha1,
>> -	       unsigned int flags);
>> +	       unsigned int flags, const char *msg);
>
> Should the "msg" argument go at the beginning, to match update_ref()?

Probably.  rename/create have the message at the end but their
parameters are very different from update/delete.  The parameters
update and delete take are not identical, but we can view them as a
lot more similar than the other two.  So I think it makes sense for
delete to try matching update, even though trying to make all four
the same may proabably be pointless.
