Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56DE520323
	for <e@80x24.org>; Thu, 16 Mar 2017 17:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdCPRb1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 13:31:27 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35710 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbdCPRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 13:31:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id b129so28335059pgc.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1V3Ow7xjvKoqYmqD1NPHumrs/vkxc9BVmQc06rPOZ5E=;
        b=rcjaXyO7R4DGOli7Q2YGkoh1+E3JsaMtBXI3xJaedQPv4LcJvkUPYzv8opdfyxmU9R
         u62J1hi7iPUjkEJjwlJ1d09Gp5eM5YbkP2VpQg72A9CzCYdfi91NfTAlWL4K8QXNjd0j
         KAIsL6yo6/lPqWELz3iUyL+TeuXbdmYnJbfAhsBSR0uHfkJyyjcqauDOucbvj49LUqOb
         usBrUGUv7E+ceIiJG/FTMTiYQl4UCHB0Ro8nltbSqQ0xmeOIWjRC1mZMAwqW5rmsCO9h
         Wf3po8RqtQg0/qL/TPMwJFyNMGPQmeKDhv/QzttVYaO4zt8/yk7QWn1S9TJFV71ECZUK
         dpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1V3Ow7xjvKoqYmqD1NPHumrs/vkxc9BVmQc06rPOZ5E=;
        b=iQKlqr4akFnjvx8pt4QgzKVwpee9hLcDThhAxfj7VMOSJP9W47pCR0XYDj6tBtdhpt
         SsXXimk1J3U2DxcwiQCbo9+LUKCGken7Hnv2BOQy1WnQKQaHQBCfsD4RWT1mGpHr44RE
         JegL8Y14AYKBdX7wgniS4+h4G0OPP2GsHXKrdmox67PmgA03EcZG4AaPVPwNZZ646KQn
         Ev67R+X266FTE5DZonb1hIZPKf7HCTJkzA8y4U529FVhl1aDUOqvtgULNs0zNzg10geM
         g9Jv1kJ2ggDbTMgD9zfPN4ihDBUyWrkplvih9B7QQN7zYFI+H2ljPIXoN757JiX1Ej43
         XH2g==
X-Gm-Message-State: AFeK/H3SqyY57Ix6tB7NG6BwJeQ1nXNoJjQMj4TJTb+DpgUbxMno3BuAd0OSLNilcBR4b5Nm
X-Received: by 10.84.253.15 with SMTP id z15mr14046070pll.142.1489685470948;
        Thu, 16 Mar 2017 10:31:10 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:8d11:eba5:7754:a587])
        by smtp.gmail.com with ESMTPSA id d189sm11862677pga.17.2017.03.16.10.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 10:31:10 -0700 (PDT)
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
To:     Junio C Hamano <gitster@pobox.com>
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
 <xmqqinnafml4.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, markbt@efaref.net,
        git@jeffhostetler.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <90381e66-d91f-6412-6294-701f5f780645@google.com>
Date:   Thu, 16 Mar 2017 10:31:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqinnafml4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/15/2017 10:59 AM, Junio C Hamano wrote:
> By "SHA-1s for which it wants blobs", you mean that "want" only
> allows one exact blob object name?  I think it is necessary to
> support that mode of operation as a base case, and it is a good
> starting point.
>
> When you know
>
>  - you have a "partial" clone that initially asked to contain only
>    blobs that are smaller than 10MB, and
>
>  - you are now trying to do a "git checkout v1.0 -- this/directory"
>    so that the directory is fully populated
>
> instead of enumerating all the missing blobs from the output of
> "ls-tree -r v1.0 this/directory" on separate "want" requests, you
> may want to say "I want all the blobs that are not smaller than 10MB
> in this tree object $(git rev-parse v1.0:this/directory)".
>
> I am not saying that you should add something like this right away,
> but I am wondering how you would extend the proposed system to do
> so.  Would you add "fetch-size-limited-blob-in-tree-pack" that runs
> parallel to "fetch-blob-pack" request?  Would you add a new type of
> request packet "want-blob-with-expression" for fbp-request, which is
> protected by some "protocol capability" exchange?
>
> If the former, how does a client discover if a particular server
> already supports the new "fetch-size-limited-blob-in-tree-pack"
> request, so that it does not have to send a bunch of "want" request
> by enumerating the blobs itself?  If the latter, how does a client
> discover if a particular server's "fetch-blob-pack" already supports
> the new "want-blob-with-expression" request packet?

I'm not sure if that use case is something we need to worry about (if 
you're downloading x * 10MB, uploading x * 50B shouldn't be a problem, I 
think), but if we want to handle that use case in the future, I agree 
that extending this system would be difficult.

The best way I can think of right now is for the client to send a 
fetch-blob-pack request with no "want" lines and at least one 
"want-tree" line, and then if there is an error (which will happen if 
the server is old, and therefore sees that there is not at least "want" 
line), to retry with the "want" lines. This allows us to add alternative 
ways of specifying blobs later (if we want to), but also means that 
upgrading a client without upgrading the corresponding server incurs a 
round-trip penalty.

Alternatively we could add rudimentary support for trees now and add 
filter-by-size later (so that such requests made to old servers will 
download extra blobs, but at least it works), but it still doesn't solve 
the general problem of specifying blobs by some other rule than its own 
SHA-1 or its tree's SHA-1.

