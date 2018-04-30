Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DD121841
	for <e@80x24.org>; Mon, 30 Apr 2018 08:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeD3I3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 04:29:25 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:46266 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeD3I3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 04:29:24 -0400
Received: by mail-io0-f178.google.com with SMTP id f21-v6so9311757iob.13
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZcB4SUOzecn6nlffqFdMsFlnJx/+aTPmO7+LACNDgcg=;
        b=Vnp97iPvL4kLZzxAVgw5HvNgRNhbrmQY+z50CPq+IkcvwIYc81hCNeN0HDsJzli1o2
         ck2MhfCXimd3sh+EMWx4yNuATa8/iTrsqwYyoKoJFNryT1Twzi9me0SwpL5Mh49d5Gq5
         TZJBCOASRsIgcOaROcVdCcIrO4ymOapbyazhIeG6BQTb596BwmVuUiqJVAEPdqLSBFV+
         2+Uq3ejRwonu00GnlrSlnIp2Y6dSEcoFdZwKaSKZ6tujHwv8ruUAtuNGN9z3PthBTVyc
         Sx7ONsD5yIukopmDjvhCnY3q1r84fj8Rqo4ieLIrYRo+LFAhSYEWGhSk5rqqPAoZ9+ok
         98AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZcB4SUOzecn6nlffqFdMsFlnJx/+aTPmO7+LACNDgcg=;
        b=uNm4/M+udFReU6dRXogBaux35P+3lIMfOuQjKI+/HzonsMMoZcQoblRIMWOIrJtO3s
         drGp+UyhLf97p6JUvC2aO8Td1O2k1XoSHp7psA9bISuRFWMG9QKM+DxOB1aJtvXVp669
         CYjMIoDtvBXt1A6UcER52smahXunGjsbOlZz3uCAs01EBCIRyvVUN3BhQ6Ffw2CdMYI9
         0EongKUpEw38+y///P92S6He3QHUc5MXtjE83n0y5omJ0XVNqHH2ZMSxWKYQHoMjBDmF
         Lyo10eJtv7PaCBmipJ1xwIElFqji2/91xyrFF6G+hOWuQpDk2CYHILDRpaXjBOT+kDs+
         9gjg==
X-Gm-Message-State: ALQs6tBcFdIwRp8oN625C2MKeH12onFe5s/YQzdmTt8G5lQzxJfQF1SD
        QmdQxFrXWmRdesgep2ZW8d4EIUUZaIPy7lUvspS9Vg==
X-Google-Smtp-Source: AB8JxZos9ogURLzaUZIiAMlcJ9oGfNaNvnP6VeE8Y4hfn0zDbKhgZ66z4sMY0Xju/UP4ke1/upcyZMWGHqoezmr3GKQ=
X-Received: by 2002:a6b:9b15:: with SMTP id d21-v6mr12317853ioe.243.1525076963896;
 Mon, 30 Apr 2018 01:29:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 01:29:23
 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Mon, 30 Apr 2018 04:29:23 -0400
Message-ID: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
Subject: git-submodule is missing --dissociate option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems to be a hole in the git feature set. I believe it is fairly
easily worked around, but it would be best to provide the option for
ease of use (and maybe performance?).

git clone has both a --reference feature and a --dissociate option,
with dissociate allowing for a reference to *only* speed up network
transfers rather than have the resulting clone rely upon the reference
always being there (creates an independent repo).
But git submodule only allows for --reference, so there isn't a an
option to make a speedy independent submodule clone in one shot:
https://git-scm.com/docs/git-submodule
I checked the latest online documentation (currently at 2.16.3) and
the documentation in the latest sources (almost 2.18):
https://github.com/git/git/blob/next/Documentation/git-submodule.txt

As far as I am aware this can be worked around with 'git repack -a'
and manual removal of the objects/info/alternates file afterward.
Though I don't know if this results in a less speedy clone than
dissociate would.
