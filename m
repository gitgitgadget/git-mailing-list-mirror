Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89ACD20D09
	for <e@80x24.org>; Sun, 28 May 2017 01:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdE1BOJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 21:14:09 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34609 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdE1BOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 21:14:08 -0400
Received: by mail-pg0-f41.google.com with SMTP id u28so8763191pgn.1
        for <git@vger.kernel.org>; Sat, 27 May 2017 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=muof6XTsDIfbQ/amwJ/iOecYsYiopzVMkJuWpuITSSk=;
        b=NS4xjSNFgz9JM3NdCPm+5k1ovrd3xPRf9KCN/O8TaxG46So+wKVdxMw9bcK9GluL6B
         wz27PnZDcSciNiDn9iB/OrvNapN53vNkvk2Tf7i9ZsZbmcXi37AVf/6FuXIVRi82OfKD
         InInsZd1N6z0ZhZC7oiIxQvJfPDlmFAog5xFVUxfMP42h2a8Y2VUrQFpPyFdf969nka6
         CcYVMdA/RsR5YklTFK5P0ZLe1cLtPNJ9TiMIjvO1JlZSMO3UQkAk89oDCpJMZ9Q3jkVT
         Mqy/0vnNtq1ktbz1c3ZsExZWdObshfz0YT6ZGVMzPW5rbuAR4+DNao4/J4V84+6Vk4qz
         KZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=muof6XTsDIfbQ/amwJ/iOecYsYiopzVMkJuWpuITSSk=;
        b=ZKIoJdUbOMykJwZSqJ/5rw5yRPoeuLlkgb3hAuTNHSxp7SIABTVdmW0raS5pgQqE8I
         zKXfjNoSITfZ2Pr3bHlJQjCSKHQLJRNwMkvP4+IjmOymbP75UONQrefs/a5NHM3R6RaA
         5oti0b7qzrhG6zsiPAgJo1N9MrzDsmTum83kgjgEd+I9juyIHjj4W62n4b2humIRFRa0
         LTamzztrxhSbM1MAqNT0h42CtZgiTtWgnNMxKcyFW7jBi3QZGPdURCWfg009V4fZv/GY
         75RTExk3yA1dEbgMH+vPA4uLMKJZ/EQzoTvy4DpJ7GXr/LJ3KIEOte8YlQu7irDVdYVy
         Qmzw==
X-Gm-Message-State: AODbwcCzM74ZMYxQK8UPTW1LuqJsJrLMol5K7c2A6kGYiWw5cYG4tJ2/
        DENqMgwbZZavj5EBpD8=
X-Received: by 10.98.68.2 with SMTP id r2mr10276498pfa.45.1495934048087;
        Sat, 27 May 2017 18:14:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bd10:cbc8:82cc:8993])
        by smtp.gmail.com with ESMTPSA id m12sm8636873pgn.30.2017.05.27.18.14.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 27 May 2017 18:14:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: mergetool: what to do about deleting precious files?
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>
Date:   Sun, 28 May 2017 10:14:06 +0900
In-Reply-To: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley> (Philip Oakley's
        message of "Sat, 27 May 2017 11:03:09 +0100")
Message-ID: <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> The git book [1] and a few blog posts [2] show how to preserve files which
> are in the current branch against changes that are on the branch being
> merged in.
>
> e.g. (from [2])
>
> echo '<filemane> merge=ours' >> .gitattributes && # commit
> git config --global merge.ours.driver true
>
> (test) $ git checkout demo
> (demo) $ git merge -
> # <filename> contents are not merged and the original retained.
>
>
>
> However what is not covered (at least in the documentation ) is the case
> where the file to be ignored is not present on the current branch, but is
> present on the branch to be merged in.

Hmph.  Per-path 'ours' and 'theirs' kick in only after we decide to
perform the content level three-way merge.  I wonder what would (not
"should", but "would with the current code") happen, with the same
attribute setting, if the file being merged were not changed by ours
but modified by the side branch?  I suspect that we'd take the change
made by the side branch.

> Normal expectations would be that in such a case the new file from the
> second parent branch would be added to the current branch.

So I do not think this is not limited to "new file".  Anything that
a tree-level three-way merge would resolve cleanly without having to
consult the content-level three-way merge will complete without
consulting the merge.ours.driver; per-file content-level three-way
merge driver (which is what merge=<drivername> mechanism lets you
specify via the attributes mechanism) is not something you would
want to use for this kind of thing.  It is purely for resolving the
actual content-level conflicts.

