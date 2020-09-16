Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5318C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D7521D1B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZI56m0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgIPUXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgIPR2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E131C0698DF
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 04:50:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so3728193pgm.11
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppiV0KUOcMU2UfhFL0aXGVuxN+iJKkRiNcbcvIETxXQ=;
        b=mZI56m0zs8zi1xsIYPeLgJfrtusSksuQfNR0PgtB3ywA9wIEbhiZhC4sN2t+sjFPVC
         LyIe81h44m/P60EYn1Bf/+os1Xz7NmsQF30jyCh2677K4XIUpxhTRZEP5NIjoAHB76he
         AyoVGFbJ51Vy4ueoftuc2COzHYrwvNYWVk4iZqzecJwABg1D3tPbT3IEWZnX4yPQ60zJ
         z+NiiM1uYvgAUkhMrZjEBHw47190k12fsCZwU0ULFLSDSzFgO3IzdYBZ4uSNaxY4Wqs+
         wqDImxDk2drqwAnp9GMV8hcucnBUhjkCpkM9ip39Er+9vsjGvzLK2US1MsFbBNXHXYOz
         L6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppiV0KUOcMU2UfhFL0aXGVuxN+iJKkRiNcbcvIETxXQ=;
        b=Y58tNh27h92Hn3yXv2yCQdaLTh8Dvjahsoqv+/4SLf3eCvoIcmUzHmdWPlk/1vLKv1
         f2OI2Y1kjl0uM7rIHY1CvQNHXXaLHdcJEctMDjUgVNWNxgpzsMNaURll83JSkMHXttrV
         2+90FoOZw0zeKKoURfA3FtMNRZwnax8l1FCOnSUglJjyARpDZK87+CbiEHIpK1X+c0qt
         HOHG+um04hBEilLUyFr/jmfJf889oOivWhyC+S6AnoiuQOVV+jhLtxrMG1svjp24qSnI
         jj0Oe1WEInjr69PXbM/cpIvX67QKEL3yXDVtNxjQty0gQGSzPlZo0xY6Gw5tGr8VlLrH
         oUGQ==
X-Gm-Message-State: AOAM533zgguTsdVUAdbatg3r7yQtqBmz/rugl5KMXR6adxClnAlDYABB
        +zDLXyknIOdRnnxp2WdEYqU=
X-Google-Smtp-Source: ABdhPJwJKU+LiACEv2eKy7BwhkfBPWxp7zAsJZBZfZQGFrWb2dyvw7fMccelhhbCSz+RkUL2xacfkQ==
X-Received: by 2002:a62:78c9:0:b029:142:2501:34ea with SMTP id t192-20020a6278c90000b0290142250134eamr6047970pfc.67.1600257017463;
        Wed, 16 Sep 2020 04:50:17 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x3sm16568208pfq.49.2020.09.16.04.50.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 04:50:16 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
Date:   Wed, 16 Sep 2020 07:49:58 -0400
Message-Id: <20200916114958.1123-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqeen2xrok.fsf@gitster.c.googlers.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:=0D
=0D
> > The next block ("Finally, tell the other end!") is what we send=0D
> > commands to "receive-pack", right after some of the status are reset=0D
> > to REF_STATUS_OK or REF_STATUS_EXPECTING_REPORT by this chunk of code.=
=0D
> > So moving the generate_push_cert() part right before the "Finally,=0D
> > tell the other end!" part LGTM.=0D
> =0D
> Sorry, I do not follow.  The loop in question is the one before=0D
> "Finally tell the other end".  The loop ends like so:=0D
> =0D
> 	for (ref =3D remote_refs; ref; ref =3D ref->next) {=0D
> 		...=0D
> 		if (args->dry_run || !status_report)=0D
> 			ref->status =3D REF_STATUS_OK;=0D
> 		else=0D
> 			ref->status =3D REF_STATUS_EXPECTING_REPORT;=0D
> 	}=0D
> =0D
> and the patch moves a call to generate_push_cert() that looks at=0D
> remote_refs _after_ this loop, but generate_push_cert() function=0D
> uses a loop over remote_refs that uses check_to_send_update(), which=0D
> looks at ref->status's value to decide what to do.  Its correct=0D
> operation relies on ref->status NOT updated by the above loop.=0D
> =0D
=0D
To make it clear, I refactor the Han Xin's patch, quote and add comments=0D
as follows (changes on whitespace are ignored):=0D
=0D
=0D
>>         /*=0D
>>          * NEEDSWORK: why does delete-refs have to be so specific to=0D
>>          * send-pack machinery that set_ref_status_for_push() cannot=0D
>>          * set this bit for us???=0D
>>          */=0D
>>         for (ref =3D remote_refs; ref; ref =3D ref->next)=0D
>>             if (ref->deletion && !allow_deleting_refs)=0D
>>                 ref->status =3D REF_STATUS_REJECT_NODELETE;=0D
>>     =0D
>>    -    if (!args->dry_run)=0D
>>    -        advertise_shallow_grafts_buf(&req_buf);=0D
>>    -=0D
>>    -    if (!args->dry_run && push_cert_nonce)=0D
>>    -        cmds_sent =3D generate_push_cert(&req_buf, remote_refs, args=
,=0D
>>    -                                       cap_buf.buf, push_cert_nonce)=
;=0D
>>    -=0D
>>         /*=0D
>>          * Clear the status for each ref and see if we need to send=0D
>>          * the pack data.=0D
>>          */=0D
>>         for (ref =3D remote_refs; ref; ref =3D ref->next) {=0D
>>             switch (check_to_send_update(ref, args)) {=0D
>>             case 0: /* no error */=0D
>>                 break;=0D
>>             case CHECK_REF_STATUS_REJECTED:=0D
>>                 /*=0D
>>                  * When we know the server would reject a ref update if=
=0D
>>                  * we were to send it and we're trying to send the refs=
=0D
>>                  * atomically, abort the whole operation.=0D
>>                  */=0D
>>                 if (use_atomic) {=0D
>>                     strbuf_release(&req_buf);=0D
>>                     strbuf_release(&cap_buf);=0D
>>                     reject_atomic_push(remote_refs, args->send_mirror);=
=0D
>>                     error("atomic push failed for ref %s. status: %d\n",=
=0D
>>                           ref->name, ref->status);=0D
>>                     return args->porcelain ? 0 : -1;=0D
>>                 }=0D
>>                 /* else fallthrough */=0D
>>             default:=0D
>>                 continue;=0D
>>             }=0D
>>             if (!ref->deletion)=0D
>>                 need_pack_data =3D 1;=0D
>>     =0D
>>             if (args->dry_run || !status_report)=0D
>>                 ref->status =3D REF_STATUS_OK;=0D
>>             else=0D
>>                 ref->status =3D REF_STATUS_EXPECTING_REPORT;=0D
>>         }=0D
>>     =0D
>>    +    if (!args->dry_run)=0D
>>    +        advertise_shallow_grafts_buf(&req_buf);=0D
>>    +=0D
>>    +=0D
>>         /*=0D
>>          * Finally, tell the other end!=0D
>>          */=0D
>>    +    if (!args->dry_run && push_cert_nonce)=0D
>>    +        cmds_sent =3D generate_push_cert(&req_buf, remote_refs, args=
,=0D
>>    +                           cap_buf.buf, push_cert_nonce);=0D
=0D
Moving `generate_push_cert()` here, will: =0D
1. Increase the perforcemance a little bit for failed atomic push.=0D
2. Make it clear that the commands will be sent only once.=0D
   For GPG-signed push, commands will be sent via `generate_push_cert()`,=0D
   and for non-GPG-signed push, commands will be sent using the following c=
ode.=0D
3. For GPG-signed push, won't run the following loop.=0D
=0D
>>    +    else if (!args->dry_run)=0D
>>             for (ref =3D remote_refs; ref; ref =3D ref->next) {=0D
>>                 char *old_hex, *new_hex;=0D
>>     =0D
>>    -            if (args->dry_run || push_cert_nonce)=0D
>>    -                continue;=0D
>>    -=0D
>>                 if (check_to_send_update(ref, args) < 0)=0D
>>                     continue;=0D
=0D
In the original "Finally, tell the other end" block, the function=0D
`check_to_send_update()` is also called for non-PGP-signed push.=0D
The 'ref->status' changed by the "Clear the status" block won't =0D
make any difference for the return value of the function=0D
`check_to_send_update()`. Refs even with status REF_STATUS_OK and=0D
REF_STATUS_EXPECTING_REPORT will be sent to the server side.=0D
=0D
>>     =0D
>>                 old_hex =3D oid_to_hex(&ref->old_oid);=0D
>>                 new_hex =3D oid_to_hex(&ref->new_oid);=0D
>>                 if (!cmds_sent) {=0D
>>                     packet_buf_write(&req_buf,=0D
>>                              "%s %s %s%c%s",=0D
>>                              old_hex, new_hex, ref->name, 0,=0D
>>                              cap_buf.buf);=0D
>>                     cmds_sent =3D 1;=0D
>>                 } else {=0D
>>                     packet_buf_write(&req_buf, "%s %s %s",=0D
>>                              old_hex, new_hex, ref->name);=0D
>>                 }=0D
>>             }=0D
=0D
=0D
> The loop prepares the status field so that we can then read and=0D
> record the response against each ref updates from the other side.=0D
> =0D
> The ref->status field is set to EXPECTING_REPORT, later to be=0D
> updated to REF_STATUS_OK or REF_STATUS_REMOTE_REJECT.  We can=0D
> clobber the original value of ref->status at this point only because=0D
> the loop depends on the fact that no check_to_send_update() call=0D
> will happen after the loop (because the ref->status field the=0D
> helper's operation depends on is already reset for the next phase of=0D
> operation).  The patch that moves generate_push_cert() call below=0D
> the loop, whether it is before or after the "Finally tell the other=0D
> end" loop, is therefore fundamentally broken, isn't it?=0D
> =0D
> I do not think it would introduce such breakage if we teach=0D
> generate_push_cert() to pay attention to the atomicity, and that can=0D
> be done without reordering the calls in send_pack() to break the=0D
> control flow.=0D
=0D
