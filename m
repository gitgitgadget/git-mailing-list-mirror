Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C151A207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 12:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034469AbcIZM3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:29:46 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35904 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934871AbcIZM3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:29:46 -0400
Received: by mail-it0-f45.google.com with SMTP id u134so9085672itb.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=YPHD8upUIFQbiZM8GOhyXDqyQlYleqLV30iyuDql1o8=;
        b=vMTWN+8RXIHJ394x0tZCXoNtHnVklH+jpuseq+UbpX1D4+47cAY/DqmcH15C4ZARm7
         msxno3O4m6dOoYSeAHe4lNBUlUtbrE3gtHS5BiECx6fyW40j9n8YHNPqL4QOC7FcWDJi
         zXYLqVYVNUE4elnrSI52MtpLPa45c/Mpfa8TnNRxctDNRdpyRmtIDkwZ/qcp3EM+MWNH
         Bh9WvfCFBuvpcQTWf71ywZnAMg85h3bc+vwZuKULHHqIfuTFvhG/JS1/RDjbox3FBB2h
         iXdO3jlvyFrlU1FUWibEaPbkGMOEYLu++zilyV9j6FKNcax2B2hLYyKTBvsQl5jZnymq
         dEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YPHD8upUIFQbiZM8GOhyXDqyQlYleqLV30iyuDql1o8=;
        b=Cx6SOZdkzhaH/h0m8HXNBD7jI5VzS0I1OAwe5ZP7WWtbs8Sd2/B1602pfsaGituc41
         p+ocec9UzZYA1Vgj0rJB4CN4bg9Pkc5LZ5SFhYd1TdZenz/NukPF/3SBQeipG2M7EDEz
         kwvhjXmH7kk1CcZR1dAcM94ho1CY5ld9GV3YM5c6NX1IK5nO0962HpxPEDdvEU3ZFWx7
         qQqV8ulSFhB6CVbI8HYJOGtNZGn5pB+NRnr+VXEnqNSf4iZtB92AAEIm1qno7DDM2mVR
         7/VuisiUUo3CTFl23GUeYd6mj7tVnTmEqPZyySjwFpbpMnCKtW6a3HKV1QtilFz7wlP3
         1Avw==
X-Gm-Message-State: AA6/9RmfaWUXFTvBLLCsFi9BL4CWTjK1pIrSabO7+ObHt9Psr2DXxLFzbHOq3/pHnlNAOvZFFKuHGTu3wMi2/w==
X-Received: by 10.36.112.135 with SMTP id f129mr17320975itc.3.1474892985146;
 Mon, 26 Sep 2016 05:29:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.16.93 with HTTP; Mon, 26 Sep 2016 05:29:44 -0700 (PDT)
From:   Eric Amodio <eamodio@gmail.com>
Date:   Mon, 26 Sep 2016 08:29:44 -0400
Message-ID: <CAJxnqO6oMG2RvwP7y0Yt_xTrfeqqO6ZOUn5HWF7-h1hcjY+=bg@mail.gmail.com>
Subject: BUG: Git blame provides incorrect previous commit if the line is uncommitted
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first time I've reported a bug with Git so please forgive
me if this isn't the right place, format, etc.

If git blame --porcelain (or --line-porcelain or --incremental) is run
on a file that has uncommitted changes any uncommitted lines have the
wrong previous sha. Instead of the sha the last time that line was
changed or even the last time the file was changed it seem to return
the last commit in the repository. This seems to only affect
uncommitted lines, other line seem to be populated properly.

I am using git version 2.10.0 on macOS 10.12 (16A323).

Please let me know if I can provide any more information.

Thanks,
Eric Amodio
