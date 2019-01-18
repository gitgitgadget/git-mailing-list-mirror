Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352F01F453
	for <e@80x24.org>; Fri, 18 Jan 2019 14:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfAROTK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 09:19:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:60377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfAROTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 09:19:09 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgeFd-1hXZWR0jzx-00nzCJ; Fri, 18
 Jan 2019 15:19:06 +0100
Date:   Fri, 18 Jan 2019 15:18:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/4] rebase: avoid double reflog entry when switching
 branches
In-Reply-To: <xmqqimz4cloh.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181518350.41@tvgsbejvaqbjf.bet>
References: <pull.24.git.gitgitgadget@gmail.com> <4c5f87b9dc245bf27785aa5559d4b35d87c4bcbf.1545398254.git.gitgitgadget@gmail.com> <xmqqimz4cloh.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KeZPWTkxxxIBZGth7ebk/mzk7No8cQ5WydOuChyRSiWNAE05KDg
 cGxcBoca0RdMAYyNea2/60/0bAwE+f/AzkL/4tPkGRfOGxG6425RsFZWfOsvdEesWHESwPG
 fZMJDsCNxkL+O8hV55GKSTwujNwCx/84mWx6R9P8R9GnbI7WVFQqReul05jHVVvispqG3p3
 n40C1wMtQ/ZofN+8/JfhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cZwUIAQSR0c=:ZJtooPq8WGEIAA9ws1L45f
 HFrmMdn9P1NmPcq+4fMYN/ior7XbE2naHSyoYS2Cko24L/zDC+ck/cJP6xjNjlHTIKYC9Jqq1
 FgmD2ZUR2cbkshVtg6efi/5Vq0jn9mfe4H4wHK/3XcdPvJ7tXgBjVFK+aZov4zAFmLEBRp4OW
 sXG33oIO6hDatzhRlSvKc+BZP63KQxoyhXl1GVEuwJ+Zm8ScAJ6oDgViH8Eqyj2+Jp5YMHDL3
 CLglJXfSiKaOEKlLpKSjxBqySMrNEgqX4tRxmGWIR0txwM7p7nHkyLj+Kt2MfPfOTy2Slcb8c
 mfl2uQuwp1BvYm5wbenhQf0DTl7HsJ2wuQXYoQZuwssXx3rTGU4Ak2mCdcPrG+UNwc5AkJ6BQ
 jmT/xtoq7DzlJjW9zpKw5rlLa86ApOHD+bfn+z4Yw1K0BZW2VSPV9mlWeYsQKS4Q88H7e39NI
 24HCnKtlzXCcm1im08SjbP7tqwqq5KxexEhDUZ8bj26a5abDJuii57Og7q1NHY9gLYxwofjfX
 wUvSRnM7OUa2NhtfRKQDVMQkjECgAbv5JPP42v1kXrLt7SsGZ1H2FcDEnxQS+2DdA/m8RYG8V
 jpkOVsnbny+8i3cchNhNvj4G+RkeQ2YWxfu+RTPRIx9JXBl5CYe3EYhoQ0Lf7CnG0lGhtw+GW
 cKj9sy2JTRhmed7BZiy4mfQ/wMrUBK6RNC/zWy3rQtuqdeDCQCVivncMAEBmqIo+Hc9Haqf3Q
 t/eAsmw7c03DvYzhjac8nqqGPS991gPOkeCylsI6oEyj0zYH2wshejyAJnIr+PY7WFz+RG3c8
 Tp5zoVngV2RyHcy9xMqDdvNggHsLEKyqkbE2YT6p45Hdn/3FL+JnkO61qiG0WND9avPuW8WfU
 xcmxgxlhuNq6XidmqdXd0Cj49YedAKUI0UFLdCJf/nX7gCdqzdEcVD4EXlbjRTUJnpy3U+FHk
 f5Ysqk0JuAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When switching a branch *and* updating said branch to a different
> > revision, let's avoid a double entry by first updating the branch and
> > then adjusting the symbolic ref HEAD.
> 
> Ah, in the original sequence, HEAD is updated twice, leaving two
> reflog entries for HEAD (and one for the underlying "switch_to"
> branch by virtue of REF_UPDATE_VIA_HEAD).  In the new sequence,
> update_ref() updates the underlying "switch_to" and then HEAD, so
> we'd get one reflog entry for each of them.
> 
> Makes sense.  s/let's avoid a double entry/& in HEAD's reflog/ would
> have avoided wasting reader's time who needlessly wondered where
> that redundancy came from, though.

Will fix the commit message.

Thanks!
Dscho

> 
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/rebase.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index e1dfa74ca8..768bea0da8 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -438,10 +438,11 @@ static int reset_head(struct object_id *oid, const char *action,
> >  				 detach_head ? REF_NO_DEREF : 0,
> >  				 UPDATE_REFS_MSG_ON_ERR);
> >  	else {
> > -		ret = create_symref("HEAD", switch_to_branch, msg.buf);
> > +		ret = update_ref(reflog_orig_head, switch_to_branch, oid,
> > +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> >  		if (!ret)
> > -			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
> > -					 UPDATE_REFS_MSG_ON_ERR);
> > +			ret = create_symref("HEAD", switch_to_branch,
> > +					    reflog_head);
> >  	}
> >  
> >  leave_reset_head:
> 
