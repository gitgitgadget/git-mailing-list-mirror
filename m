Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C4CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbjIKVcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjIKQNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 12:13:42 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FDF1B8
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 09:13:37 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40688)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfjXb-00A7T1-BR; Mon, 11 Sep 2023 10:13:35 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42410 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfjXZ-00E6NZ-Lr; Mon, 11 Sep 2023 10:13:35 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <xmqq8r9di5ba.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        10 Sep 2023 23:37:13 -0700")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <xmqq8r9di5ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 11 Sep 2023 11:13:27 -0500
Message-ID: <87cyyoeli0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qfjXZ-00E6NZ-Lr;;;mid=<87cyyoeli0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/O+wOqpsaOTIN15vAyUmacD/B7nnuqEew=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> I would like to see the SHA256 transition happen so I started playing
>> with the k2204-transition-interop branch of brian m. carlson's tree.
>
> I needed these tweaks to build the series standalone on 'master' (or
> 2.42).  There are semantic merge conflicts with some topics in flight
> when this is merged to 'seen', so it may take me a bit more time to
> push the integration result.

Junio, brian for the very warm reception of this, it is very
encouraging.

I am not worried about what it will take time to get the changes I
posted into the integration.  I had only envisioned them as good enough
to get the technical ideas across, and had never envisioned them as
being accepted as is.

What I am envisioning as my future directions are:

- Post non controversial cleanups, so they can be merged.
  (I can only see about 4 of them the most significant is:
   bulk-checkin: Only accept blobs)

- Sort out the configuration options

- Post the smallest patchset I can that will allow testing the code in
  object-file-convert.c.  Unfortunately for that I need configuration
  options to enable the mapping.

  In starting to write the tests I have already found a bug in
  the conversion of tags (an extra newline is added), and I haven't
  even gotten to testing the tricky bits with signatures.

- Once the object file conversion is tested and is solid work on
  the more substantial pieces.

Does that sound like a reasonable plan?

Eric
