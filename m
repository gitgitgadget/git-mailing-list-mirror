Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261B21F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 15:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934904AbcHBPiO (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 11:38:14 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34919 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934886AbcHBPh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 11:37:59 -0400
Received: by mail-lf0-f68.google.com with SMTP id l89so10323989lfi.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 08:37:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kSpMGe6OjRn5zec4gyDcSJi0UrGyZlwMvvfdS1B4nL4=;
        b=hhn8EMVh90slmupAcXV9N/CmwSmnwAH1o3HcxhFBqf2qMlI3G2rCK1Xh3siceDscFS
         Jzt8aWaOyD96yGgowW7uvB2KgaT1Dq3Nn42nW/YBDe8xJri8M4tUPGrfc08Iu1IYySdU
         Wbm853lsBAChJmPO/lG5b9obZC6qBof+SMP2GJTiS4ewNer9iSp8tl8+70U8tFxFGUzk
         jjHOQMSCxERPvFuI40vBPwvhzj0FnbrukPUVCIib8+Ko+FXA47vsdXUe9gDvHTzHF9+S
         hcF71ScKLna+yRHGHEIEMV52Y0gjeQaPXbLwBiMS3SEw14DhRn0XmvAh34xSfZ00Unl4
         EzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kSpMGe6OjRn5zec4gyDcSJi0UrGyZlwMvvfdS1B4nL4=;
        b=O+egBlGXM378y7o/wd3dgSujDHMWWPnYkI6kdxx+hE1lWkgX3SVm4hTOEhi6XN+wvm
         DTvkomISZOVdK7ErVnwNKWG1jY53EGK3H4TFKjhNLRe6rt5PLpFqBDv4mjYI4xILnA/R
         BhKzz+laLVWqiUUuxT0fOtf+Wje4tuIMZCEPy2Upns0z2kqeLnfLBOi+EOn6W/kw0ZVU
         fug1c/iKxL5bFGjlFDE+IRWrNc1HPgl/1RJVA0ZzTn90YPSt1GDFWd0pEVfY5KOJnder
         HGQRM4XT0d4gRfI0NowMHwJYc3dcHTpjt2h4NSUDNIRZinX9TeLU4IxVddOUpVzIacuJ
         peeA==
X-Gm-Message-State: AEkoouvey8TEoc/aHc4kJkhTiNiT9FxLP+sN+DI2KmjyKNQwU5C2NDG624+bSuySIpEkow==
X-Received: by 10.46.32.68 with SMTP id g65mr19420543ljg.51.1470152238244;
        Tue, 02 Aug 2016 08:37:18 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 205sm588654ljj.47.2016.08.02.08.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 08:37:17 -0700 (PDT)
Date:	Tue, 2 Aug 2016 17:37:15 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Torstem =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"e@80x24.org" <e@80x24.org>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
Message-ID: <20160802153715.GA25286@duynguyen>
References: <20160718223038.GA66056@plume>
 <20160730182005.14426-1-pclouds@gmail.com>
 <6955746D-E47E-4BB8-AB0E-44D461E67AD6@web.de>
 <CACsJy8D=dZeE1tLFRaCefkkNX8dHQfTL134Nv--5=BXvnUm1ZQ@mail.gmail.com>
 <xmqq4m74i4k3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4m74i4k3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 02:04:44PM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Mon, Aug 1, 2016 at 3:37 AM, Torstem Bögershausen <tboegi@web.de> wrote:
> >> the term FREEBSD may be too generic to point out a single feature
> >> in an OS distributution.
> >> Following your investigations, it may even be possible that
> >> other systems adapt this "feature"?
> >>
> >> How about
> >> LAZY_DIR_MTIME_UPDATE
> >> (or similar)
> >
> > This feature was added in 1998, so yes there's a chance it has spread
> > to a few fbsd derivatives (not sure if openbsd or netbsd is close
> > enough and they ever exchange changes). But I'd rather wait for the
> > second OS to expose the same feature before renaming it.
> 
> I think a name based on the observed behaviour ("feature") would be
> more appropriate because I'd be more worried about us finding other
> glitches we see (initially) only on FBSD.  People who need to adjust
> tests that use the same FBSD prereq would have to wonder which
> prereq-skip is due to which glitch.

OK how about this squashed in? The name was taken from fbsd definition
IN_LAZYMOD.

Off topic. Since I found this macro defined twice, in ext2 and ufs,
but not in zfs (found its source!), I assume zfs does not have this
particular feature (but I didn't test it). Untracked cache may be more
effecient there.

-- 8< --
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 08fc586..8bb048a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -419,7 +419,7 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	rm base
 '
 
-test_expect_success FREEBSD 'Work around lazy mtime update' '
+test_expect_success LAZYMOD 'Work around lazy mtime update' '
 	ls -ld . >/dev/null
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3c730a2..1fc5266 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -962,7 +962,7 @@ case $(uname -s) in
 	test_set_prereq GREP_STRIPS_CR
 	;;
 *FreeBSD*)
-	test_set_prereq FREEBSD
+	test_set_prereq LAZYMOD
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
-- 8< --

--
Duy
