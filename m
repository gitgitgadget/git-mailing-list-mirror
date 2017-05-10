Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F41020188
	for <e@80x24.org>; Wed, 10 May 2017 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbdEJRAm (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 13:00:42 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33276 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdEJRAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 13:00:42 -0400
Received: by mail-wr0-f174.google.com with SMTP id w50so1502165wrc.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=8WKvsACUzD+UxBQgKc7ZpP1rsamtm6xGqb/UsfmMKjI=;
        b=lSAVITGaOeGqER+QodTQLaoUDp35tDvMVfJfS1q4xOAsHbOU/Si+fem6FZ/bMzFykC
         m2n60QAFTpyIj/Z31jidcP8drZUOQcaqCnnvIamxa0b6edaEGImBXtPRRaEZ77nfh9PF
         MbOYV9wARmw+CmhNI93x18OF/HAU0vaP93rGyRXcXyRt6PpvIgN0A05PFRVL4Qj5+gvx
         adYgFdSOkmd0GhvvgRKhXA/IFWnFb63JxqdHRSMclD/Hg0EbMobOO6rMfEB5b1sbjpJi
         JMH7hCARlcZ1r3S8Htl10EJ+Ewra2/eoivctMN2baAahwjUMUlqx4SfD/skREVzMtNRo
         FwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=8WKvsACUzD+UxBQgKc7ZpP1rsamtm6xGqb/UsfmMKjI=;
        b=aAJzip3VB9l2+plspDvtSMSzSEyZM5IpAVFeJacqbECI9bdpsh1ABGWG94tZmcNtvS
         K2ySJsK4D91BWwSPBY47Z/vBPB47vqOFs2R2v8gZir4KR0fPZePTO7j1WEHW8E18Cquy
         zjyi+LjICYpAZcDU4QVOJYlQJEbpVXD7dNZB4j8b5LDmIuodz9ETY+Tdb/3UZOkIgkS1
         xXPxguf/MWtiSfS4xYbrKa0aJcPQxfHaDqjWbzjHz3L3pcc7Bq209kMcijuCQAsE792B
         wQ5jQkJjpWkdg/eUnJboGbT1Oq0UbFOJkMInhou+/9R+h6kQGMEnEfXVg8VtPl9mjIF8
         oIsg==
X-Gm-Message-State: AODbwcAWEnHAWxtKMvNEMIUV8QBB6yM1iKkUrKBy7ZXGAQd+Eza1MUQg
        Fm1mSfIWWQ4x74DWtio=
X-Received: by 10.223.169.78 with SMTP id u72mr4262792wrc.193.1494435640627;
        Wed, 10 May 2017 10:00:40 -0700 (PDT)
Received: from p2003005d8f6320c3152afe578a56de09.dip0.t-ipconnect.de (p2003005D8F6320C3152AFE578A56DE09.dip0.t-ipconnect.de. [2003:5d:8f63:20c3:152a:fe57:8a56:de09])
        by smtp.gmail.com with ESMTPSA id 202sm292686wmy.25.2017.05.10.10.00.39
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 10:00:40 -0700 (PDT)
From:   raphael.stolt@gmail.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Possible bug in includeIf / conditional includes
Message-Id: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
Date:   Wed, 10 May 2017 19:00:39 +0200
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I might have stumbled over a bug in includeIf / conditional includes or =
maybe it's just as intended.

Current configuration which finds the conditional configuration.

~/.gitconfig
[includeIf "gitdir:~/Work/git-repos/oss/"]
  path =3D ~/Work/git-repos/oss/.oss-gitconfig

Expected configuration which doesn't find the conditional configuration:

~/.gitconfig
[includeIf "gitdir:~/Work/git-repos/oss/"]
  path =3D .oss-gitconfig

Best regards,

Raphael Stolt=
