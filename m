Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521CF1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 15:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfHBP6S (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 11:58:18 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:34923 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388260AbfHBP6S (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 2 Aug 2019 11:58:18 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 11:58:16 EDT
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id BFE8C1C81A13
        for <git@vger.kernel.org>; Fri,  2 Aug 2019 18:52:57 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id g0Zgli1ZkW-qvCqjHr7;
        Fri, 02 Aug 2019 18:52:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564761177;
        bh=sKLBztrSTw+w1GuEL1LOodPEKEG1qxRSOET+VIOFsWc=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID;
        b=Ep/JUNfRzp1Z3Jycc23sAnT1a5kW0yjWB5O3RgKn6sfJZpJhUpagI/eOB1ziPuOzF
         TdQG82GSfFhbW2sKk8aVwzCeiP1Q4XZm9umKRhshwvoMCXuQkmj538ktDz44UV5VhG
         dKO9qDYPf9Z9x+z5KSIkP2pz6pY9U0GDb7W7uBAM=
Authentication-Results: mxback10o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id TkJc6usTWA-qus0cmI8;
        Fri, 02 Aug 2019 18:52:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Fri, 2 Aug 2019 18:52:56 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <56155941.20190802185256@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: bad patch created when I use  --ignore-blank-lines option
In-Reply-To: <1543205721.20190802183954@yandex.ru>
References: <1543205721.20190802183954@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eugen,

sorry, everything is OK. rafasc suggested me what is the problem.
I should use --full-history 


Friday, August 2, 2019, 6:39:54 PM, you wrote:

> Hello Git,

> I add and remove only blank lines at my file:

> $ git log -p t/29-cmd_l.t

> --- a/t/29-cmd_l.t
> +++ b/t/29-cmd_l.t
> @@ -218,7 +218,6 @@ __DATA__
>  @@ list
>  -e:0005  1;    
>  -e:0002    2;
> -
>  -e
>      0: use Devel::DbBatch split(/,/,q{list.conf;b 2;a 2 1;s 2;l .;q});;
>      1: sub t {
> @@ -226,26 +225,26 @@ ab>>2:     2;
>      3: }
>      4:
>     x5: 1;
> +
>  @@ list from first
>  -e:0010  t2();
> -
>  -e
>      0: use Devel::DbBatch split(/,/,q{list.conf;l 0;q});;
>      1: sub t0 {
>     x2:     1;
>      3: }
> +
>  @@ list from last
>  -e:0010  t2();
> -
>  -e
>      14:
>      15:
>      16:
>      17: # Perl implicitly adds one new line after this one
>      18:
> +
>  @@ list middle
>  -e:0010  t2();
> -
>  -e
>     x5:     t0();
>      6: }



> But  when I use --ignore-blank-lines option I see broken patch. I have
> not added '-e' line, but it is displayed as it was added. Notice '+-e'

> $ git log -p --ignore-blank-lines t/29-cmd_l.t

> diff --git a/t/29-cmd_l.t b/t/29-cmd_l.t
> index 4b77279..d7739d2 100755
> --- a/t/29-cmd_l.t
> +++ b/t/29-cmd_l.t
> @@ -219,6 +219,7 @@ __DATA__
>  -e:0005  1;    
>  -e:0002    2;
>  
> +-e
>      0: use Devel::DbBatch split(/,/,q{list.conf;b 2;a 2 1;s 2;l .;q});;
>      1: sub t {
 ab>>>2:     2;
> @@ -228,6 +229,7 @@ ab>>2:     2;
>  @@ list from first
>  -e:0010  t2();
>  
> +-e
>      0: use Devel::DbBatch split(/,/,q{list.conf;l 0;q});;
>      1: sub t0 {
>     x2:     1;
> @@ -235,6 +237,7 @@ ab>>2:     2;
>  @@ list from last
>  -e:0010  t2();
>  
> +-e
>      14:
>      15:
>      16:
> @@ -243,6 +246,7 @@ ab>>2:     2;
>  @@ list middle
>  -e:0010  t2();
>  
> +-e
>     x5:     t0();
>      6: }
>      7: sub t2 {


> $ git --version
> git version 2.22.0





-- 
Best regards,
Eugen Konkov

