Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC5320984
	for <e@80x24.org>; Tue, 13 Sep 2016 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbcIMOn3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 10:43:29 -0400
Received: from mout.web.de ([212.227.17.12]:57344 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932245AbcIMOn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 10:43:28 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Mg7I1-1bPFlc11UL-00NUGQ; Tue, 13 Sep 2016 16:43:05
 +0200
Subject: Re: [RFC/PATCH 01/17] diff: move line ending check into
 emit_hunk_header
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        peff@peff.net, chriscool@tuxfamily.org
References: <20160913044613.1037-1-sbeller@google.com>
 <20160913044613.1037-2-sbeller@google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <848f36c9-4ac9-5316-1143-c47b48790847@web.de>
Date:   Tue, 13 Sep 2016 16:42:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160913044613.1037-2-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ohYQCBLHSNGYQ2gSZgz6N3p0ZAvl/1skePsbbqgy4VtC4g7jqfR
 SGs68by+6sWy3vw+sTOCglG1fDRtDMHQscDxl7LT4/DeIhjwjZE8hv/mLw8dJJCKMvJ1wtP
 063YsQNMFL7pkrMD2/FaRNBxP85IirIFMj+REOykZX+QqT0nYAhWO/aXCJ2YRgNrmn0CvvT
 oaW3h21dLiRCc3zf+Gctw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pb4lOwfCpdU=:BDGbw1FPO6+CqO6IHQG805
 m/Wuf4GQIRiMHGG/HfL48QSTgQYEfoqxEDLc9wvqVV9yI++/HpY3q4l0OzrxlhgVJBZyeWeS5
 xFIzG5/aH2ovdCUU0lLYpOCdcr4rkW1dgPnB83G9L9QZxs8jH85otV42VByEfNmS3i/dERpB7
 H7rWiSQLnpWsKymqX10UQ605SeyIZEZnSioPQrX7cmCls141IFlKFOek2qsmAh5TDEcXqWmrb
 KPw4C3OjXIP09SzRanggOJIX/GKuuR8NGzMATNQyUtADq+bcXe+YBYhv2DuMgdkubXLSuj/P+
 a9h7DjkUN+LlZuVWcqtrmN6GJXkS8Z+WB2YXsL8bv9tNYVkMqvU7XkglL4sS9NuyBf6QWaaSM
 pwTj+CsuuhezkgF/YTyvUSlkSeC4GJXNaNNzffcNFkdAlge6LrLotpWD3iDsKbsRKcISZGPuz
 FEu0wborZqJg3aZNOLoukjmePqr3tgnMjFkaDb+XyinDUWsdbqJxy7QFpg/ghVm18ba5kxpFh
 p01NCOpMUoaN7e+qXSjL1WQIN7qgDwEJ4Tq2XDTNPyb+SynaKWm/FY6t4DObpnzHMx6NkE63Q
 8UugZnQSMtM2lbNq97HgkI9FsUSZqgd79rTshibNC+hq93XwJ+5DTWs1x9tgpYrTjB3X7oPDN
 bLfyujYozEcZCBFBmCDx35j/HcFmPJ+pqsaB+hD/zhbD1hQ82n8vs2PxZkBaX5aqV/s4mu3Lw
 Ry1FCv4SnhlEs7S8CFeg0/IBZqgzHDNzkD0z69J9QOHjOdpALDAywEOxa3LcfbEfAYvRneET8
 toHMXcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.09.2016 um 06:45 schrieb Stefan Beller:
> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This patch moves code that is conceptually part of
> emit_hunk_header, but was using output in fn_out_consume,
> back to emit_hunk_header.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index cc8e812..aa50b2d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -610,6 +610,9 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
>  	}
>
>  	strbuf_add(&msgbuf, line + len, org_len - len);
> +	if (line[org_len - 1] != '\n')
> +		strbuf_addch(&msgbuf, '\n');
> +

Using strbuf_complete_line() would be nicer.

>  	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
>  	strbuf_release(&msgbuf);
>  }
> @@ -1247,8 +1250,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  		len = sane_truncate_line(ecbdata, line, len);
>  		find_lno(line, ecbdata);
>  		emit_hunk_header(ecbdata, line, len);
> -		if (line[len-1] != '\n')
> -			putc('\n', o->file);
>  		return;
>  	}
>
>

