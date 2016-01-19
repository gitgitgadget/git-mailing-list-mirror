From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/1] contrib/subtree: Add a test for subtree rebase
 that loses commits
Date: Mon, 18 Jan 2016 23:21:59 -0500
Message-ID: <CAPig+cQyn-TGocV8Z6UTCJtBZMT8-HCtV7HqqJ+yinaczGUPvg@mail.gmail.com>
References: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
	<3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	David Ware <davidw@realtimegenomics.com>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:22:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLNnx-0002xy-AM
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 05:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbcASEWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 23:22:01 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36208 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809AbcASEWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 23:22:00 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so10069363vkg.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 20:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Xym+MfJXg4+VL8Ar5/qKrY/BHptJcc3vn2LwMxran8U=;
        b=f8cEBFBVqZkFdMjtoi77RZhrrXCoN1/mPRESfsxxcE/u9XmspWVurMoro7VFXLnT2p
         FZbQIDZUlM4idZw/b9ZmxtvePKbP1fS1UJrpMP8BOLUZZvm1iuh+0JtToZmMKjaGuXJn
         F+5gK/2WnpVr6ZVep/LL89H7vkZAZLhjhqeiZBtSwIw75MP8ci0bab5syruv6II3Tkgr
         b0mj89cE7ehbdW/bE6x2n9tncqGIGXjKx+S7gmmiZsITg+Zjove7gg4qvfgQh9EvqfSM
         vpELhWZWB2dpwziJ2yErg2sjEY2CIBJojXrXCCrm5gfujy7PCJcsyzMMnAtPN4eZXGw7
         7Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Xym+MfJXg4+VL8Ar5/qKrY/BHptJcc3vn2LwMxran8U=;
        b=bt5ZX1yzvg2ZuXOFh1YWMvXO20yNnqlkBf2jt95VyKJlcO1s1FkcR7Ni/Sp9ggUWCB
         tSseiDjsFL6C8qZ5TAjpc0vTp5Wl27ZO3FgwXmmO+YskuWKIf4vxGJWvP9W2hVUhheS8
         yjHPKPupCUPzJbvlQhboHPKqkgggCy1lci72f/qJ1ldrqnTBfsc75cCoq6kCKZ4De0MQ
         9Cxlsk2Oy8S4XND8RhYtkixP/9To7CJL5PKvW8J5WNarepXLDRMkGkDqup/dOyaz0DTN
         Wjxd5KH6eO764cw7A17Db7gPeVflmY8kuQBFhEbxP/xD+yJoUnsBGrKt4EiwXazNpUxp
         OsAw==
X-Gm-Message-State: ALoCoQmQr035ws3rh1nd/ZEl8UEihhDyK2tFIKSh+JBpM0zzudTxLQO1BtJ1U45qsgiANhVbD99qbOVO+3SFQRvebGdjBgMB7g==
X-Received: by 10.31.58.74 with SMTP id h71mr19147841vka.151.1453177319484;
 Mon, 18 Jan 2016 20:21:59 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 18 Jan 2016 20:21:59 -0800 (PST)
In-Reply-To: <3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
X-Google-Sender-Auth: -Rg2O4iBUy94hn3Pe3DS7RtQaMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284346>

On Mon, Jan 18, 2016 at 9:59 PM, David Greene <greened@obbligato.org> wrote:
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost or the rebase aborts with an internal error.  The tests are
> marked to expect failure so that we don't forget to fix it.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
> Notes:
>     Change History:
>
>     v1 - Initial version
>     v2 - Additional tests and code cleanup
>     v3 - Remove check_equal, mark comments on failure and remove
>          test_debug statements
>     v4 - Send correct v3 test (botched v3)
>     v5 - Fix use of verbose

Thanks, I think this re-roll addresses all the (relatively
superficial) issues raised by my reviews of previous versions.
