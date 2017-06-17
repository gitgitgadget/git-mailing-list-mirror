Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D634320282
	for <e@80x24.org>; Sat, 17 Jun 2017 14:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbdFQOMS (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 10:12:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33990 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbdFQOMR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 10:12:17 -0400
Received: by mail-io0-f196.google.com with SMTP id a96so7332699ioj.1
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eA/Dt7DjIqg1onZIQgPvXiC/VHfvGPGRApuMhsvIoUs=;
        b=mupxwPIO2chBdbXUkrXCBBkglyFOMxgvammztty9fk/yUnCixutTpZACu6Gy4shhia
         HRW2sRGiex7UV1kCpigTWBOqKeOzVmalJpFOjWreHvGbMPoTDd1q7Md2Eg0JMRGTik5l
         eZ91VfhXZVGVrWNJ1Eaw6UojuLiYU0S/n/8lFjW9Uo1EO200guRIC41cMCsREoN6CmPT
         t9XLkxM8BiwhSRNaoMsQnnzCSe9SCzW8WplqUy2531SDrXF0NX/NYPZSMuxiBtyjhck0
         KrzW4oEdIUW4RHZHhkoSnuKVMCqs+8iXucZq3G9vFRXY97j4MJnFHPwtrDHjhFSST0GC
         g8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eA/Dt7DjIqg1onZIQgPvXiC/VHfvGPGRApuMhsvIoUs=;
        b=AOXRO8eKMCpBRmBnmNxGBkCP0WmGGbjVuQtB488B4vRIr3HeW4rpoC7CwiH3vTTD/1
         NXye+zLxgGMeuRGQ9t2NNBTzzmjP0AtgbtUexGoASfdAR+3PYCbuPUhwi8g2i0Ay54hG
         Dbpqz7GYOGTHVa0NAEnKuhNUkmjDa2EH4gis7APp8rUxZThPxP3THm0JMU7mxNwAMUgD
         BaQsYiuYrnMwAtxxptQ9gDHtXSBlzg43azuEQ0Kdk8eqIAgNvVIfxSzQJK6pKDIqvRk5
         GNbpkRt12wtMmXG7YJC7JnRagxYZFZ0j0pI3ykqapbBG9zTm7lLjvpVT5FB7JzNLBisC
         Z5yg==
X-Gm-Message-State: AKS2vOx7DG3ABqr3tbNSGeYZ6orQUUfj9P0Q5GWBahTcLFdf4761V5P9
        Gr3mRD+ViDcL0ZEH258rXEscfiCPeoVc
X-Received: by 10.107.150.203 with SMTP id y194mr16282977iod.17.1497708737053;
 Sat, 17 Jun 2017 07:12:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Sat, 17 Jun 2017 07:11:36 -0700 (PDT)
In-Reply-To: <20170617102454.2040-1-davvid@gmail.com>
References: <20170617102454.2040-1-davvid@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sat, 17 Jun 2017 10:11:36 -0400
Message-ID: <CAJZjrdX=8DbRTsdJ+bH5BABJG0m=y2QpT8C4kFviUsxVqVLVLg@mail.gmail.com>
Subject: Re: [PATCH] mergetools/meld: improve backwards-compatibiilty when
 using "--output"
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2017 at 6:24 AM, David Aguilar <davvid@gmail.com> wrote:
> Meld 3.16.0 requires a "=" in the --output argument, as it uses
> a simple hand-rolled command-line parser.
>
> Newer versions of Meld (3.16.4, and possibly earlier) use
> optpaarse, which accepts either "--output <file>" or
> "--output=<file>".

Do older versions also support both?

> Use "--output=<file>" for better compatibility.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  mergetools/meld | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergetools/meld b/mergetools/meld
> index bc178e8882..7a08470f88 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -10,7 +10,7 @@ merge_cmd () {
>
>         if test "$meld_has_output_option" = true
>         then
> -               "$merge_tool_path" --output "$MERGED" \
> +               "$merge_tool_path" --output="$MERGED" \
>                         "$LOCAL" "$BASE" "$REMOTE"
>         else
>                 "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> --
> 2.13.1.453.gc0395165f3
>
