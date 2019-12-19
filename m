Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED3C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850EC2467B
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R68sqYlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLSVa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:30:27 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:38437 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLSVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:30:27 -0500
Received: by mail-il1-f170.google.com with SMTP id f5so6130485ilq.5
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=suLytnt3c6amtw4OAJBEWFO9BYt9qbsXa61LUxDNwbs=;
        b=R68sqYlGjl6mZU2vqN2IDxNroVe2giauhD7VWrs3NQgccz1gcF0k66A4ttisDo0QHI
         is7/6lOFEzSAiUy2BF2M14PzLDe8G7Mn0ugw6ZYQZMvuKEZheE1oGEpAvn2hoeGgORUX
         TLQlQ+ba1X3sWH1NzBAoSxqF+TiDoCI4QpMdk9RLMvGUob4p4aHmDle79OYu+qcce5n2
         ZDp3HcYEMX2bMu9ia7d+7GLdYN0cqF+swSRt1cYknEj0jhxuG+uG2OoQvRANbrz51IPp
         lgarShUE61OPPfywInlB556zoi32HjMkA22FpTY5m4Wsn+5ewgD1SF3wY7UICvhS+38N
         zEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=suLytnt3c6amtw4OAJBEWFO9BYt9qbsXa61LUxDNwbs=;
        b=osJ3qGAf9/A2lnm/F+qykV7PmKRRFBUFkKB+eaUZlRks1GhExPAUwxUTGDusU9W1hv
         fBt7T1euWdygbcpd7aJtb2aZCpnXuX9eLVbVjWJR5njX3qAkuXzaTrVo1vDsieAfHyTx
         IJGzfLSqVnBXRSGvPvlQK3mXCdhSyA/Ta0pmIwbUgADOpJauBa9VBmag4E4IzieymJ5Z
         5dy9LphJucaGXfQBvYTGyzdGPD6oCC2yqB2CuzBN1V3/OyPQOFKwJq03ZOWL76zRqZ67
         8EatUmijFZR138rdOlFxZx0XJwOAvQSOZHfcYkjVEmIdOefL6MkjWwbwcYln0ylqDiSG
         GhYg==
X-Gm-Message-State: APjAAAXIbp08StmuAWKgnOceNHbaCNIPQ1DIbU0mmCj9MEneUavAS55n
        9r/f6tDjnjjqYH2vVYtZh7dpkZciqopIy3qHle5w13wc3a7M7w==
X-Google-Smtp-Source: APXvYqzi2eptc2TShTldbsdy8fOlQWxAn9WXgI2yy1qj0gghfMRRq113TxqOXw9sS3xqx45Qw2wqwbubr780Rghcn+4=
X-Received: by 2002:a92:da44:: with SMTP id p4mr9560344ilq.168.1576791026428;
 Thu, 19 Dec 2019 13:30:26 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= 
        <christopher.diaz.riv@gmail.com>
Date:   Thu, 19 Dec 2019 15:30:15 -0600
Message-ID: <CAHCo6soNwee3hN4i6v0KtxphKHa96v--e41KRqfHKV5i45OqcA@mail.gmail.com>
Subject: IaC monitoring with Git
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm trying to figure out a git based solution for a use case we have
at my work place. We use IaC for our infrastructure, when we want to
create new instances/accounts/etc we add a certain set of tags in our
files to indicate some key aspects of the instances/accounts.

There is one specific tag, owner, which we use to set a contact point
in case we need someone to make a change. The main issue with this is
that you can set the tag to anything, valid or not, or it could become
invalid over time.

Would a valid approach for first issue be to set a pre-receive hook in
our repositories so that before the PR is merged, we check validity of
the contact email, a.k.a. owner tag (we assume validity means that
email exist), maybe via ldapsearch or another command like this?

For the second case, I'd assume git does not by default monitor
contents of files on a regular basis, does anybody have faced this
issue and successfully found a way to periodically check contents and
trigger alerts on repositories based on same case (email becomes
invalid, then trigger alert)?

Thanks a lot for your help!
