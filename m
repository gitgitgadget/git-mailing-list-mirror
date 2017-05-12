Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E8F201A7
	for <e@80x24.org>; Fri, 12 May 2017 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757778AbdELSJp (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 14:09:45 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33922 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdELSJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 14:09:44 -0400
Received: by mail-wm0-f51.google.com with SMTP id u65so12705734wmu.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3aGpQgk8FrTwWx6+sh+QuMWhZ4CxHjU/cEkmQWVsJyo=;
        b=NSTGSrWjn944Tid1llEMgEyyP+xt++0sMtZAJvbSpZ6fsjpdiuAkgvIhhO6GTay70h
         NfWYgln6CBkYBOGj5j6RYoTJqz5mlmTAmpUu16rXT4/yZ/pDN311WcznF90dPjXy/9G/
         8lYC4oKayHyCiz41roFcdxSpl35zrpJNWTuaoW2uEcj57YAkRIz10WMbvkL2ASYu5dzl
         RBxLA1Va2tAVGwjfjdMq/xZL2osw1F+hxF+0P0JCAFIM915eMIox918nD3UjjG+P8lwm
         pmkq0mUylWILKp8Fq+ZbPHajdw+/0n6KGbMQk4wEeg/dzhnytwSg3qQbAO/s/b/ouYNR
         c0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3aGpQgk8FrTwWx6+sh+QuMWhZ4CxHjU/cEkmQWVsJyo=;
        b=tTNFGnxpZSqvXoe4pgJljZXkedfpyWz/QfSsB3dTR3Gjx6mO/RGk4HYzVDjdyD20o+
         wXPNBJ3WruMyyUh1xKHzxmD2DCiCfSEe1N+fLuFdt+PKjD2vFdCbOWnB+OX+E1r3+NF+
         /VJ3V9nvSlk6XBQ0Q8OCU9oVghNllUerz7SC+Yd2ElaCUjeCZ+2ujft/RDlYXOfC3YZb
         1HuwN2vfOD1S2vX240Pfmjg5LAEQN1puf/rmBGC64gMPc2pn1I10xrj21FGOmoZpkHSL
         HhiTR5WsYj39dkVXP4tLfWMq/b4UTigf6K3f/6mBk10ksKvIAXQrCxA5dozgECgPFzTK
         6oRQ==
X-Gm-Message-State: AODbwcAK9W+8dprW3iQWSyuE9+QTwmxvxQyN5z8/YIRmbYp+f6Aym4iC
        9MSyH298udb0w5BgP0aloHYpyrNld60R
X-Received: by 10.28.183.8 with SMTP id h8mr3545813wmf.54.1494612583154; Fri,
 12 May 2017 11:09:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.48.66 with HTTP; Fri, 12 May 2017 11:09:42 -0700 (PDT)
In-Reply-To: <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com> <20170511224639.GC21723@aiede.svl.corp.google.com>
 <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com> <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Fri, 12 May 2017 11:09:42 -0700
Message-ID: <CAGf8dgJxz+jA=pA5TRR6vmK=zP=CUenpsBDy2VEtjYB5CO9yuQ@mail.gmail.com>
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 12:59 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 12, 2017 at 03:01:35PM +0900, Junio C Hamano wrote:
>> Also, tip_oids_contain() uses unmatched and newlist only on the
>> first call, but the internal API this patch establishes gives an
>> illusion (confusion) that updating unmatched and newlist while
>> making repeated to calls to this function may affect the outcome of
>> tip_oids_contain() function.  In fact, doesn't the loop that calls
>> this function extend "newlist" by extending the list at its tail?
>
> It does, but only with elements whose oids were already in the set. So I
> don't think it's wrong, but I agree the interface makes it a bit muddy.

To make the interface less muddy, would you agree with this (untested):

@@ -648,7 +669,9 @@ static void filter_refs(struct fetch_pack_args *args,
  continue;

  if ((allow_unadvertised_object_request &
-    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
+      (check_tip_oids_initialized(&tip_oids, unmatched, newlist) &&
oidset_contains(&tip_oids,
+     &ref->old_oid))) {
  ref->match_status = REF_MATCHED;
  *newtail = copy_ref(ref);
  newtail = &(*newtail)->next;

(making the function-to-abstract be merely an initialization one,
instead of one that does 2 things). That decreases the scope of the
function that Jonathan Nieder and Peff wanted, but it might be a
warranted reduction in scope.
