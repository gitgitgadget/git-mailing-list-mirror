Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44419C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 03:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F3220705
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 03:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgLBDb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 22:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLBDb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 22:31:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C777AC0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 19:30:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t4so637678wrr.12
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 19:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAP+O5n6lTum63EDJTXqjGpwvnLiwffywSCFy7bFI2w=;
        b=q3VFMp80A7PklpvDbr5YZ8eAKWeD3mfTZb1d56S2gFTM29ZigkBHBeLe3ScpBgMIqK
         dCFRmEgnQBvNYKrIyZvtckfmM42AJlsOeiGRgNVnEu+OTbjJRYJBZM9/CS9FTHpE1yP+
         cKjV7IRLm6hUoUaIhYaZCAJ5oEn+KyJFcNhrDTRo/5W+pB2bPD73SscgoOJWnIhwxRY1
         bMrClKGHABmAT/qlDrcY415jHJbeofGJUHW1T/26kielLAWM2fG4+fGpuQeD0HmerwMV
         kjkfzH0y/3AK3ubvZC030znaPYI67AlKzswRyDXWswS7TNokLuO2zRYahK58NeyUPK+1
         eqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAP+O5n6lTum63EDJTXqjGpwvnLiwffywSCFy7bFI2w=;
        b=JQzMh1QyU9VHUtOZisH6s2OimfC5NAUxMvJkZ2AtuzGNIbO3uoXwyt685CXk6u2i0R
         AaQibPR82VkOk0k1i5xFkVzyfnfOM64tpcQIX1EHpysnL+etJT3ISHPzUfp7y07lylnw
         1H+dFz49wMarSfCRBytXbZsVXUNiajsqKMV2ixYjEME8V05st9WlEx59HnWagE8oOLCm
         BKA2QW3U9r72r0kTmtoqHymKOZxM0Js+Dy4mr9lorXBefumyh2TBFTua5pbZdfELp7zm
         ciQQMxIC0N11DIYPYzK58+gfzt5kNRBcXIPPnDvcb8KMYMf1BbWrLElB1zOx7obGuciM
         YUkg==
X-Gm-Message-State: AOAM533kiKSxrS2kNlrIBGZn2So67ysxXsrRk3jCKIFOoJveZS4MxkOH
        gjW4E3A1QZGJBMxeXaiw0IRFpMhzd65F5Xo2k5o=
X-Google-Smtp-Source: ABdhPJz23AcYBJqfISZU9k5VvlEPlq4W7SS4vTGErk9syejl7ur2hIuBuIAyPZS/8a9cl5/MEEpp2gYRIwiiD+ouR2s=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr479218wrv.255.1606879845131;
 Tue, 01 Dec 2020 19:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-3-felipe.contreras@gmail.com> <xmqqczztqszv.fsf@gitster.c.googlers.com>
 <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
In-Reply-To: <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 21:30:34 -0600
Message-ID: <CAMP44s2kHshVBRaQ=+jMTLvvxo+aQyB_XP8Et=+ZZt8XhpDufQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] .gitignore: remove dangling file
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 8:26 PM Jeff King <peff@peff.net> wrote:

> I was curious how hard it would be to find unused ones, and it is not
> too bad:
>
>   find * -type f |
>   git check-ignore --stdin -v |
>   perl -e '
>     my $ignore_file = shift;
>     while (<>) {
>       /^\Q$ignore_file\E:(\d+)/ and $seen{$1} = 1;
>     }
>     open(my $fh, "<", $ignore_file);
>     while (<$fh>) {
>       print "$. $_" unless $seen{$.};
>     }
>   ' .gitignore

Or to use a more modern language:

find * -type f |
  git check-ignore --stdin -v |
  ruby -e '
    $ignore_file = ARGV.first
    $seen = {}
    $stdin.each do |e|
      e =~ /^#{Regexp.quote($ignore_file)}:(\d+)/ and $seen[$1.to_i - 1] = true
    end
    ARGF.each_with_index do |e, i|
      print "#{i} #{e}" unless $seen[i]
    end
  ' .gitignore

-- 
Felipe Contreras
