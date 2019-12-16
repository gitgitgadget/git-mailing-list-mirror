Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FEBC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F22082E
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kNFkGNhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLPTNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:13:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59184 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPTNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 14:13:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82F9A3BD65;
        Mon, 16 Dec 2019 14:13:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z2JNIr5eXdnQar9NiJ5ipT5TcWc=; b=kNFkGN
        hL6wQ8UrgK8oqYxHxiAAVFuCOMqSMUHIPcxYmel+0C7KGyD+sCq/AOCElqwe0jWY
        69UlpLfqtkYAEALai4bK5nmdS41e7Fo0TL2yqKQqrPwtRDaWuepaOfbvUy7At41B
        in5lvQVqhCe6uOB/zt+zL10AB6I0CXBmuZ0DM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F3PZGstP5P+r57v1uYQmKSBTgXSqP/Eq
        BrvKv3W/puirwGDpqui20K69MvY0/qYm3rixI9NOcxzoOQLqgqnqL6IQrDPLS39Y
        tA/Oj407+rStJZe2QkY1ixvBEGbX6eEsuaeRZ54gOhMGJdfQtPOWwvmC72VmcpJh
        8yzxyyfZjoo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B2CB3BD63;
        Mon, 16 Dec 2019 14:13:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D62623BD61;
        Mon, 16 Dec 2019 14:13:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marce Romagnoli <marce.romagnoli@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: `git stash pop -q` is deleting files.
References: <CA+0NiBEFssPJsQ8UV6vRNBxzUEsJddF4Q-=-xVq-xgNUtFbHUA@mail.gmail.com>
        <CA+0NiBGcYwu1Gyyv3AQEbfQCMiE0rrurzgkQzwsjHgi9cEj4wQ@mail.gmail.com>
        <CA+0NiBFU46YRBFEbngK+Rc0e4uE_nSqQkYak9a-_UoTaCCb1Jg@mail.gmail.com>
        <CA+0NiBEifgam1xVJw7F=mO_DtLgfqK9g7eHJMK5dt3yc1JpaAQ@mail.gmail.com>
Date:   Mon, 16 Dec 2019 11:13:28 -0800
In-Reply-To: <CA+0NiBEifgam1xVJw7F=mO_DtLgfqK9g7eHJMK5dt3yc1JpaAQ@mail.gmail.com>
        (Marce Romagnoli's message of "Mon, 16 Dec 2019 14:19:38 +0100")
Message-ID: <xmqqd0cojd7r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2593D7F8-2038-11EA-92DA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this has already been fixed with

http://lore.kernel.org/git/20191113150136.GB3047@cat

at the tip of 'master' a few weeks ago.

