Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F4B20958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbdDATDq (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:03:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33911 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdDATDp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:03:45 -0400
Received: by mail-io0-f196.google.com with SMTP id n76so8760485ioe.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Dgz4TcEfgt6Z10aPvOdR7d6jPxZFwgqZsgubCr5Hirg=;
        b=UlYa+OZ42QheoTZZuW4qLeMXoDG+DjiolLdrbVcGKUnjZUhbwawUXfVFxc+HKtEb8Y
         StjSDczLg9bDd9jV2RavOD/9qMnWd6aD/1VY59lArjw+GApd0u5EjIRED3dHMByhzXdd
         /GMo83+uBAKMCUor1ziL+xH2guXLCVX2pdTYm7jIFVV3+0z+d7UOaqXTHaIANyRZjF7A
         xhOsZYmiW+V3NlGwMflwLx9AEp5ARjyZvL4AZj0GrqbMALN9l0j/jTUbIzQDMnYYeNnY
         IJQPMP21kGG9RzdTMWZ8AjZseNG1h+zsQ2NDPQ6yQEg3qrWQl7Ki9Oe0ud0oFcqeS20e
         V32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Dgz4TcEfgt6Z10aPvOdR7d6jPxZFwgqZsgubCr5Hirg=;
        b=WAeOG+mGhDMc26da60JoU/LY2TWs/KMAQT05N1EeBl/fIg/2dJga56UCSbBrBtsX0d
         La0wG3SupY9JlJ8XCuM9wyoaW128iB9fjLB+h2whUyetdPl7ImUiSfPMEp+3uHL3Tbz/
         Vet92MYEx947NecnCmI9/vfVl0BoxapS9a4ZkPd/OtfY3aYhUL8lG4mPOpydf4VxGquC
         zts0tLFe7mOA0VuSIwEJyQAkatLPaObYkKCoChQ8pNAElwELOTeOPUZv841dDaP2VENl
         AlIM4SxqQpiR7Y1tLl+H/jmPbFaqWnSIB1tlQrjVIu79b4iTmq1mxByp6sedDC+IV4Y8
         U2LQ==
X-Gm-Message-State: AFeK/H2xUfN5pxtWeFfnlMF8/MUQsvctGCF1bkcfHmdIguB7JhmoFjEXANxJ/mAHIehcFNaow1tsUCc15FibBw==
X-Received: by 10.107.178.137 with SMTP id b131mr9185838iof.50.1491073424786;
 Sat, 01 Apr 2017 12:03:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Sat, 1 Apr 2017 12:03:44 -0700 (PDT)
In-Reply-To: <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
 <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Apr 2017 12:03:44 -0700
X-Google-Sender-Auth: vSLXN0Y7L-ABBFpM4_1ipp-0Zsw
Message-ID: <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
Subject: Re: Bug in "git am" when the body starts with spaces
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a114c98b4d1af73054c1f9559
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114c98b4d1af73054c1f9559
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 31, 2017 at 5:52 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The continuation logic is oddly complex, and I can't follow the logic.
> But it is completely broken in how it thinks empty lines are somehow
> "continuations".

The attached patch seems to work for me. Comments?

The logic is fairly simple: if we encounter an empty line, and we have
pending in-body headers, we flush the pending headers, and mark us as
no longer in header mode.

The code used to just ignore empty lines when in header mode, which is
garbage, exactly because it would happily continue accumulating more
headers.

There may be other cases this misses, but this at least seems to fix
the case I encountered.

                    Linus

--001a114c98b4d1af73054c1f9559
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0zmj2z20

IG1haWxpbmZvLmMgfCA3ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9tYWlsaW5mby5jIGIvbWFpbGluZm8uYwppbmRl
eCBhNDg5ZDlkMGYuLjY4MDM3NzU4ZiAxMDA2NDQKLS0tIGEvbWFpbGluZm8uYworKysgYi9tYWls
aW5mby5jCkBAIC03NTcsOCArNzU3LDEzIEBAIHN0YXRpYyBpbnQgaGFuZGxlX2NvbW1pdF9tc2co
c3RydWN0IG1haWxpbmZvICptaSwgc3RydWN0IHN0cmJ1ZiAqbGluZSkKIAlhc3NlcnQoIW1pLT5m
aWx0ZXJfc3RhZ2UpOwogCiAJaWYgKG1pLT5oZWFkZXJfc3RhZ2UpIHsKLQkJaWYgKCFsaW5lLT5s
ZW4gfHwgKGxpbmUtPmxlbiA9PSAxICYmIGxpbmUtPmJ1ZlswXSA9PSAnXG4nKSkKKwkJaWYgKCFs
aW5lLT5sZW4gfHwgKGxpbmUtPmxlbiA9PSAxICYmIGxpbmUtPmJ1ZlswXSA9PSAnXG4nKSkgewor
CQkJaWYgKG1pLT5pbmJvZHlfaGVhZGVyX2FjY3VtLmxlbikgeworCQkJCWZsdXNoX2luYm9keV9o
ZWFkZXJfYWNjdW0obWkpOworCQkJCW1pLT5oZWFkZXJfc3RhZ2UgPSAwOworCQkJfQogCQkJcmV0
dXJuIDA7CisJCX0KIAl9CiAKIAlpZiAobWktPnVzZV9pbmJvZHlfaGVhZGVycyAmJiBtaS0+aGVh
ZGVyX3N0YWdlKSB7Cg==
--001a114c98b4d1af73054c1f9559--
