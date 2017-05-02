Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0CE207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbdEBBl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:41:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35144 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdEBBl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:41:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id o68so10906875pfj.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LVcwysNQ95HhcDeF30WQsfg59iB+JJJjoz2PkrF4FQo=;
        b=KOeGYruvRZcUhFgVgk2VXurkBx/HK0zZW34QkQFbQx3juUwYaAeGJuOlbMnwhmh2AP
         zRO7OYHHe1sxqFNn4Jy6V5N4EGFnhBO2tqtv2fChZ9oYnOlFuNHI79ekCpA/DDutiThE
         HP9SxWEZoxHQTN4bbLvlrJmV4wPlVObc1uOX7V/y2Kqg+4GVXDRTA3qa7VohZrEcGo5Y
         N61CJtv/U34Ie+TuDLqUrphAKx99PqhcaCgaUg1kj9mAtl1krNZ3ltzWIvuZnkkGQ/fz
         +pBeWB55UNygkU6+/4zkFP1tYHHMn/wEt6M5ElkslLA+Gr9h3iFWWan6sAxiRx3byiWq
         6shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LVcwysNQ95HhcDeF30WQsfg59iB+JJJjoz2PkrF4FQo=;
        b=nJTTgiJfQw1jSVyll4WOuyjlWxiAqG872/EUs+shwiu57J7bn8LTpa12rXUoA8E9fu
         fk5B2zXxGvjtn9V/eE3TzpjswtfeBxVsH0LIwBHtuXQF+uoXnLW9a2Jd7wrCDC/3+GLr
         da1Opp1TY5g5nayGUZWYZ9tUSDMtVLIBn36MlgfBNCEpSpAmWQlM1hpgHOhS6uJSOAYx
         81VjHCDQ3CGoFBlxIXxlbzRlS6d2qDmwlXv5YFlfc91vfJfnZ12frI05UPLc2/a/eNxi
         CL4TP5ic/nqk2PgF0JXVAqCD62K80PA/RSTDmDMGoBfqLec0W47CHYZ4nanPcbO3dM5c
         7PYw==
X-Gm-Message-State: AN3rC/7ehzizLAazNR7OQbcDm6jTeDkIS8SBBSBtjDCM028uEMnU3PO1
        bfNirlvVbYI6jA==
X-Received: by 10.84.238.206 with SMTP id l14mr18202158pln.189.1493689288255;
        Mon, 01 May 2017 18:41:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id q128sm24511448pfb.74.2017.05.01.18.41.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:41:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, markbt@efaref.net, git@jeffhostetler.com,
        kevin.david@microsoft.com
Subject: Re: Proposal for missing blob support in Git repos
References: <20170426221346.25337-1-jonathantanmy@google.com>
        <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
        <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
        <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
        <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
Date:   Mon, 01 May 2017 18:41:27 -0700
In-Reply-To: <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com> (Jonathan Tan's
        message of "Mon, 1 May 2017 17:33:01 -0700")
Message-ID: <xmqq37cof320.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 05/01/2017 04:29 PM, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> Thanks for your comments. If you're referring to the codepath
>>> involving write_sha1_file() (for example, builtin/hash-object ->
>>> index_fd or builtin/unpack-objects), that is fine because
>>> write_sha1_file() invokes freshen_packed_object() and
>>> freshen_loose_object() directly to check if the object already exists
>>> (and thus does not invoke the new mechanism in this patch).
>>
>> Is that a good thing, though?  It means that you an attacker can
>> feed one version to the remote object store your "grab blob" hook
>> gets the blobs from, and have you add a colliding object locally,
>> and the usual "are we recording the same object as existing one?"
>> check is bypassed.
>
> If I understand this correctly, what you mean is the situation where
> the hook adds an object to the local repo, overriding another object
> of the same name?

No.  

write_sha1_file() pays attention to objects already in the local
object store to avoid hash collisions that can be used to replace a
known-to-be-good object and that is done as a security measure.
What I am reading in your response was that this new mechanism
bypasses that, and I was wondering if that is a good thing.

