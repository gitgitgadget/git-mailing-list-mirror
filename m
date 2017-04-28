Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601991FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 09:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425648AbdD1Jwe (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 05:52:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:56431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425627AbdD1Jvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 05:51:54 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ls7MZ-1e6MqY367z-013zOd; Fri, 28
 Apr 2017 11:51:41 +0200
Date:   Fri, 28 Apr 2017 11:51:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/26] difftool: close file descriptors after reading
In-Reply-To: <xmqqzif2mlm1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281146030.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <c634ea5dad0ce1c1f424f54a12a5614e6fa4a847.1493237937.git.johannes.schindelin@gmx.de> <xmqqzif2mlm1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pPRkzWgmW9mjNu6WNzfEKqoCbGOasqiG8tnTZJndvEw9sbk+HfJ
 wPblhumL6vSS9yN8ukp5jJAMHnKkmbdxnsfRnVMfUYUz3CrerUWIOUiFSFxtEPcU4Q8zr5g
 IlfCPjPDEHtatAcleOUTSQd4QGGevgregKuljK85Lh9auYnBj+fp1exX0UsprSqK+zyAdqe
 SJ9HPHZoeZfNkELnLfV/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KWLZGPR+oaA=:1noVXNq1sLx+f16kybTbx4
 1Om+PMyyRugZH6xi18hX1wBTmchyJBhurI6iETs8jFWDU6of53Iekmbx5RIJVb5Zq8bJ8GrTk
 opfhQoDX0sARKM2r/EYdNTpKb/obeVh4E2d2Y+wrJ2fr+OxxrqxZ3MnMOeBxRTzPuk4EJkbH+
 Pe9aoqoip5SLKdoSiYRBZ3DlhywOXiCmXi7xVruxDezhUBI5ObQ1CqdR9VNNG0wAye24pwZuC
 iVl3Gn+Xvd5l44B71T6//+Dm+psZRM63siwbDfJtAU4+ale237ONuqXcValgOupsx3qAMqb6Y
 6XfZxaf5y5uskhy0NMGrX2aFF/S0AfVHiR86ZvVGOtF8ZRI6h11WlcidLcuwlPlqaGgqCl/5O
 gQJyJtDct/+QNODhEp7/8l5aEEPgo9OmnrsiFEr7nHuFWL53T08Yk4+XjtiDoWXjsbccvyhLH
 /mzmBvM8Dv4irtQNs6B0JwadtIdE6sIptbQEIHSROrL2TV5FhuxshAebDoCG2RthmcwNC67WK
 EsNZV/dwf58wwnQtfO3Jcx+7v6XknH/X7BaXr4WYBdDeK0Sh7qnVeXaqNWhpj6DXazF5d1W/V
 6lcFAkMA4/U/XNoF6uP3aCw4FlTHq3OINCMxhHvkVnMgmgotQUgPNXHtfhiykyke4L1/uKqK4
 6DelXvHVK40Nqz1PSFbn35I+mOpztywnJichShlSe9nk+gKZC5XNjxVG9yOTaD7oM0BuJscuu
 FWvKfxf+XguF23P4RAm+k2Y6x/fjsjKZuDT3+RA9sf2hwu/UFlyAtRonWOJkhK00Hb395Y3Mj
 OR7x2ib
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > diff --git a/builtin/difftool.c b/builtin/difftool.c
> > index 1354d0e4625..a4f1d117ef6 100644
> > --- a/builtin/difftool.c
> > +++ b/builtin/difftool.c
> > @@ -497,6 +498,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
> >  		}
> >  	}
> >  
> > +	fclose(fp);
> 
> The huge loop we see in the pre-context of this hunk has many
> "return"s and "goto finish"es that can leave fp still open; while
> this patch does not hurt, it is probably somewhat insufficient.

You are absolutely correct, and I am somewhat surprised that Coverity did
not complain more loudly.

TBH I really only tried to address these fixes on the cheap, as my main
aim was to get to the critical bugs in the Windows-specific part (I did
not find anything major, though). Therefore, I only looked at what
Coverity labels as the "high impact" issues. The leaks in the loop that
you pointed out may be labeled as minor by Coverity.

I also noticed that a couple of error messages have not been marked as
translateable, I must have forgotten that before submitting the difftool
patch series :-(

In any case, in the next iteration of this patch series, this patch will
convert all returns to `ret = ...; goto finish;` calls, and fclose(fp)
there unless it has been closed already.

Thanks,
Dscho
