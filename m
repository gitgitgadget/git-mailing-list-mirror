Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEF02047F
	for <e@80x24.org>; Mon,  7 Aug 2017 23:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdHGXKf (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 19:10:35 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35120 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdHGXKe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 19:10:34 -0400
Received: by mail-pg0-f41.google.com with SMTP id v189so7160181pgd.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJkB6Fn/7+tU66PEkcZ4n/+yNnkrUtQ7L3TbFPAM6zY=;
        b=UmBew6Gk+zzw6tP73bXAICL60AiSOqyM7/vdQjJmB8U0HStS38ku51A6tNUvwHsHhH
         T6H4HnvrqZJqnSe8+6hGM08XXZlimS7US0Su38r8JFoAJTxFoDi2GJpR7bDxMV7ppcSv
         6LUDleaNLtpMLL2D5kbiJZjwJkGmukCECGK+SNbw9LIWSKsAqWQz+/JcNKB2L5tBJKeY
         RTten2VhJE2LsOqWtvubbdMqulKCiE9xnIUhizfqG/a6D9/WS7Rhzml1ScQjOdQEmMZV
         WS9oYl2IE1CW2MQOzFiqfLDitzzJr9Mp1HmxNLVey8TkgbCYC9xetdz+AymqcIXWiGbb
         HeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJkB6Fn/7+tU66PEkcZ4n/+yNnkrUtQ7L3TbFPAM6zY=;
        b=SKlt/5izpYpXA/XuWz+1Oe3i2OXNyTQrGA2O6ucxoVMwV3/icY01mCdeN5NicYDIRM
         /k8xmFG3tU2uukrKdLSaAm5wyVg2WIQKjVhhRCgkeBLaaVN6bAt1HZGQsJc62omoYJDK
         BABTascKI2Uv2XRfLXmNx0+1o14v/1TI6CKFFMupNgelijPmYEn0wvqXeHfcr6GmRnxg
         xLutkTvVBCCrp+ZxsgIkjXUbi4GZmrWFXiEct9YTVzQFLLX1ZfJG+RO5vEyqnqXNVBdT
         IBQtg4mLdB3KuuCHJ/+61q3eFE+IJXqNxm7AR3AQ7uLcIzRJLanqN4HhjVg0MhMMSY9C
         s6Rg==
X-Gm-Message-State: AHYfb5ifDld8XFt9qfRQQ+08g7k6Wv0rrviYGozogQ5sfGWfUuiKrcOX
        jImCLD6jh6kNtbpy
X-Received: by 10.99.167.70 with SMTP id w6mr2038183pgo.17.1502147433940;
        Mon, 07 Aug 2017 16:10:33 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a0fe:8dcf:c61c:f231])
        by smtp.gmail.com with ESMTPSA id i4sm5879428pfg.51.2017.08.07.16.10.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 16:10:33 -0700 (PDT)
Date:   Mon, 7 Aug 2017 16:10:31 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        christian.couder@gmail.com
Subject: Re: Partial clone design (with connectivity check for
 locally-created objects)
Message-ID: <20170807161031.7c4eae50@twelve2.svl.corp.google.com>
In-Reply-To: <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
        <20170804172137.42f27653@twelve2.svl.corp.google.com>
        <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 7 Aug 2017 15:12:11 -0400
Ben Peart <peartben@gmail.com> wrote:

> I missed the offline discussion and so am trying to piece together what 
> this latest design is trying to do.  Please let me know if I'm not 
> understanding something correctly.
> 
>  From what I can tell, objects are going to be segmented into two 
> "types" - those that were fetched from a remote source that allows 
> partial clones/fetches (lazyobject/imported) and those that come from 
> "regular" remote sources (homegrown) that requires all objects to exist 
> locally.
> 
> FWIW, the names here are not making things clearer for me. If I'm 
> correct perhaps "partial" and "normal" would be better to indicate the 
> type of the source? Anyway...

That's right. As for names, I'm leaning now towards "imported" and
"non-imported". "Partial" is a bit strange because such an object is
fully available; it's just that the objects that it references are
promised by the server.

> Once the objects are segmented into the 2 types, the fsck connectivity 
> check code is updated to ignore missing objects from "partial" remotes 
> but still expect/validate them from "normal" remotes.
> 
> This compromise seems reasonable - don't generate errors for missing 
> objects for remotes that returned a partial clone but do generate errors 
> for missing objects from normal clones as a missing object is always an 
> error in this case.

Yes. In addition, the references of "imported" objects are also
potentially used when connectivity-checking "non-imported" objects - if
a "non-imported" object refers to an object that an "imported" object
refers to, that is fine, even though we don't have that object.

> This segmentation is what is driving the need for the object loader to 
> build a new local pack file for every command that has to fetch a 
> missing object.  For example, we can't just write a tree object from a 
> "partial" clone into the loose object store as we have no way for fsck 
> to treat them differently and ignore any missing objects referenced by 
> that tree object.
> 
> My concern with this proposal is the combination of 1) writing a new 
> pack file for every git command that ends up bringing down a missing 
> object and 2) gc not compressing those pack files into a single pack file.
> 
> We all know that git doesn't scale well with a lot of pack files as it 
> has to do a linear search through all the pack files when attempting to 
> find an object.  I can see that very quickly, there would be a lot of 
> pack files generated and with gc ignoring "partial" pack files, this 
> would never get corrected.
> 
> In our usage scenarios, _all_ of the objects come from "partial" clones 
> so all of our objects would end up in a series of "partial" pack files 
> and would have pretty poor performance as a result.

One possible solution...would support for annotating loose objects with
".remote" be sufficient? (That is, for each loose object file created,
create another of the same name but with ".remote" appended.) This means
that a loose-object-creating lazy loader would need to create 2 files
per object instead of one.

The lazy loader protocol will thus be updated to something resembling a
prior version with the loader writing objects directly to the object
database, but now the loader is also responsible for creating the
".remote" files.  (In the Android use case, we probably won't need the
writing-to-partial-packfile mechanism anymore since only comparatively
few and large blobs will go in there.)
