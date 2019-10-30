Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A0A1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 17:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfJ3RIb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 13:08:31 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33439 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfJ3RIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 13:08:31 -0400
Received: by mail-lj1-f170.google.com with SMTP id t5so3563950ljk.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avalanchestudios-se.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xP+SsoskEzlSuQBZ51FywNFTU7SI5JtOQ+4HzcWBXj8=;
        b=sCZoiTz91nPe5dxtlMUYwoJbx60nSzGthz3axpMTBvY6QxZKQyBG4OkTuLkrL7bp3t
         mMNUv5BirvV8NBeiCIPdBNDA6RoD0FgUEmWzMyyTeRfk3KFrtrr2DVV35ZdmiTfc3Ljh
         I7yBo8Pi87dwuZ/mE+0MhA5MwdpTHNGu9GOtLiGiNh5tVhLta1aClUpyobRUo3RSkLSl
         gLafv+X2ixVn+N35SscXIMCsGis59oKCUX6PRfA+/Qd30jsP+tSFruH7BwQ25h69rBBK
         QDsjM6E67yGPb2sU8PkXwfxLYR7zhtMU9xCk6xYtL43lZr8pxO0aoesAV+THV2DTgaL0
         XUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xP+SsoskEzlSuQBZ51FywNFTU7SI5JtOQ+4HzcWBXj8=;
        b=CKezqbXGl/qrBGb7JJ38khWqUeCvKhe8MzpTtLDIZQIoQwPlKjBXZRU9w17Dwjxoh5
         BiS1xzAVUqj1WoXXpmZ0bmRLorjY4MyD5dXb2CstlRFFnmDs+XkRfPz8coQTJz85N5L9
         yB6hoNCjnZauq2qoBOA30gcx67tqFRC+hru3ndeKXQxSmJx8NvoCb7VsHaXBU5f5IZz9
         id2xUij8V3JTYacFHuTt6ihds7dDeVmME3ybNnFJaRPbL+WtrRNDlMnK1OR+H2wwe5aj
         I3jhV6uuXO1Q6bKvfD5ZskXBf955As4tmQ6w2dUYx8xXROc54MjO+P0bFrRFlV+LJ261
         uuwA==
X-Gm-Message-State: APjAAAXSX9FSlCjzhNq0CwFDVzHJm+ply7vajqNCRNty1ko02S3Mo9HM
        epctadjFbv1LbQVIQb5rcnQkP4p7BMQDjY/pLyjkmEba
X-Google-Smtp-Source: APXvYqyUl3pOP7NcuzeFLxUimP87VceLF2TvEDDdLDIR5zPx1Hv4IQRm25Rx+5R3ZQP0PDRKMO4fehydZsl4YWkVfww=
X-Received: by 2002:a2e:93d7:: with SMTP id p23mr543980ljh.251.1572455309025;
 Wed, 30 Oct 2019 10:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+M_GG35V3yNCfQ247PSrpP-R_f8bWNcBcmrnTWbrn1Nap_A4A@mail.gmail.com>
In-Reply-To: <CA+M_GG35V3yNCfQ247PSrpP-R_f8bWNcBcmrnTWbrn1Nap_A4A@mail.gmail.com>
From:   Simon Holmberg <simon.holmberg@avalanchestudios.se>
Date:   Wed, 30 Oct 2019 18:08:18 +0100
Message-ID: <CA+M_GG1SfxGW=p_=418hdR1ypB3v-4GrooK6_75UUNJDb+kk2Q@mail.gmail.com>
Subject: Partial Clone garbage collection?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been experimenting with the new Partial Clone feature, attempting
to use it to filter out the otherwise full history of the large binary
resources in our repos. It works really well on the initial clone. But
once you start jumping around in history a lot, the repo will grow out
of proportion again as promised pack files are fetched.

Are there any plans to add a --filter parameter to git gc as well,
that would be able to prune past history of objects and convert them
back into pack promises? Or am I wrong in assuming that this could
ever act as a native replacement for LFS? Without this, a repo would
only continue to grow ad infinitum, resulting in the same issues as
before unless you actively chose to delete your entire clone and
re-clone it from upstream once in a while.
