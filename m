Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3AC47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5394320774
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8TBLL3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgD3Twz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:52:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54868 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgD3Twz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:52:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A9F1BA4EB;
        Thu, 30 Apr 2020 15:52:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hVB/EyJ5vcchMT5PliQl/+oh5Wc=; b=Y8TBLL
        3igikdgu3RDPZAaNABVvT5frVFDQwWkV5LQCHQ9+gkoKBqrjWZwtTpHyNp9zRFR8
        IlnruMtiFuKoShOYOgN8Js+FFpTDH2pBNn5mzv0X3ea1bkqQD3s5uDnvs3WZDvpP
        YP1kd0rh3rSBh7m/Xw/yDTyqJZz5fOIr5qX14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=guMTxiVM48ATizlhwj4NoalqHdCHQG78
        Mmn4lFcNGFEaT2QGjGkdKACzaZd/pC2Uxv4b0xfL6D8wOZjQFDl8ABJIVveDZUVy
        4gAUpF2qk7hTbYzZstbxansrcJ0WbBQzpn/OKCPiHsqNpO/u6TkhE7pZIujvItMK
        GnwMVgJPJr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42D0DBA4E9;
        Thu, 30 Apr 2020 15:52:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8987CBA4E5;
        Thu, 30 Apr 2020 15:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Sergey Organov <sorganov@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
        <87imhihwbw.fsf@osv.gnss.ru> <20200430162753.pg6kpm6jlubotjlk@carbon>
Date:   Thu, 30 Apr 2020 12:52:48 -0700
In-Reply-To: <20200430162753.pg6kpm6jlubotjlk@carbon> (Konstantin Khomoutov's
        message of "Thu, 30 Apr 2020 19:27:53 +0300")
Message-ID: <xmqqbln8sqcv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C3DD460-8B1C-11EA-B912-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> I would speculate that `git checkout -` may have learned about "-"
> simply from the `cd -` ...

You do not have to speculate.  You only need to read what has been
already said in the thread ;-).

