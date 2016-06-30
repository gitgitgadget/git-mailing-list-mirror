Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C121FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbcF3UWz (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 16:22:55 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33629 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcF3UWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 16:22:55 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jun 2016 16:22:54 EDT
Received: by mail-qt0-f181.google.com with SMTP id c34so48727188qte.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 13:22:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H7/pCmU/VxBlyGR1QcETVS0zB6b5JtOrXNYnzDMZWG0=;
        b=Ys9g0PqxQ892hzgb9pGgqDHRJ7HBoAAmTR/zVHbFEgsrbkj2fIHMNdEpB3lZxh+86g
         v4uTrfZwq74tA65armpp+mS5qajaaJMTkl7sJL+CPwdR+7WqSPmUFcM14528v3bSwTJc
         LiQjnNwVldzgsIQT1is6UtbqZi15vNcHryQqJuh2jdYXcA5LT6VZqHaffGNABNepuGBn
         5VkhCDB0kJIvN6UbiNKY/VI/rBfbZhEDyN3LCHCYsX9KzNC+eo4LPGFOQfgVCM0artdh
         kQigZOl1FAEiE2KzLyuoEpdiz88RnzOn8WgzbzSTD8H4CozHzaEXJuiNsrMVFZw/lzn3
         fd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H7/pCmU/VxBlyGR1QcETVS0zB6b5JtOrXNYnzDMZWG0=;
        b=Bx2YnrRB4ChAKc/wDuiDIDwnhQJdd1qSXvXWO3oA0QqHn29C3szPmsIhvwiqi63tRM
         xrToLlx51Qf1xXl2WZqdQuVrOLGRyNnb0s5vHF19jGKBjreRGWrAjftOtkV8EiVPAmYw
         HyW3nfxd0Uq5mW03nxUDgOP5UHqIGVtc7mvPwUCxZZF9p5xEzO/4LeUpW1hW3ZaBuqUJ
         DV1vlLzM7FPNiDDscl9ZAH6ufvkBE4Z6YN+PBzkI90aRmRLbxTA5EORlFrBWSI0zYukq
         MZyMSjJZMTUi3X1a1AGNR0ehvKY7BQ2+IGnRX8vNVlf0l6ndLPilz3vFUKveBR2V8e/y
         arLw==
X-Gm-Message-State: ALyK8tJNEZjwgWEnmSZq9WavWGOYO6uFFbk/v7pz0z16UBt/b+6Z/Gjp/VnnwC+NHkzoE23LoeNlGSLL17fFHtJP
X-Received: by 10.200.38.120 with SMTP id v53mr26365749qtv.90.1467317682305;
 Thu, 30 Jun 2016 13:14:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.179.134 with HTTP; Thu, 30 Jun 2016 13:14:41 -0700 (PDT)
In-Reply-To: <20160630193845.TbelqPPHx%steffen@sdaoden.eu>
References: <20160630193845.TbelqPPHx%steffen@sdaoden.eu>
From:	Bryan Turner <bturner@atlassian.com>
Date:	Thu, 30 Jun 2016 13:14:41 -0700
Message-ID: <CAGyf7-E0VbkCC29y=OuNHL5_KA=qoXEsrChxvXcGmfZ_CjTzqQ@mail.gmail.com>
Subject: Re: --abbrev-commit gives longer hash than necessary
To:	Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:	Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Steffen,

Git commands generally have a 7 character minimum by default when
abbreviating hashes, even if fewer characters are still (currently)
unique. Per the documentation:

   core.abbrev
       Set the length object names are abbreviated to. If unspecified,
       many commands abbreviate to 7 hexdigits, which may not be enough
       for abbreviated object names to stay unique for sufficiently long
       time.

You may be able to set core.abbrev to a smaller value to get even
shorter hashes, but the shorter you go the more likely you are to find
once-unique hashes no longer are, as your repository grows over time.
The default isn't just about what's likely to be unique now; it's
about what's likely to stay unique for a period of time.

Hope this helps!
Bryan Turner

On Thu, Jun 30, 2016 at 12:38 PM, Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
> Hello, for your possible interest.
>
> For some time (currently with 2.9.0) know see that a single commit
> gives a longer hash than necessary, even though there is no
> ambiguity:
>
>   ?0[steffen@wales ]$ git longca|
>   awk 'BEGIN{l7=0;l8=0}\
>     /^[[:alnum:]]{7} /{++l7;next}\
>     /^[[:alnum:]]{8} /{++l8;print}\
>   END{print "L7 " l7 " L8 " l8}'
>   786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
>   L7 3364 L8 1
>
> So it is only this single commit.. but why?
>
>   ?0[steffen@wales ]$ git long1 786d0c9
>   786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
>   ?0[steffen@wales ]$ git long1 786d0c
>   786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
>   ?0[steffen@wales ]$ git long1 786d0
>   786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
>   ?0[steffen@wales ]$ git long1 786d
>   786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
>
> Not really ambiguous:
>
>   ?0[steffen@wales ]$ git long|cut -f1 -d' '|grep ^786
>   786d0c9c
>   786f219
>
> Ciao!
>
> --steffen
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
