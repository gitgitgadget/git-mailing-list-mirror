Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5510C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 10:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F25613F9
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 10:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhD2KBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2KBF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 06:01:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C7C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 03:00:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n25so5729334edr.5
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cb9stFKLzXPQpQUHtTxU8+h4YRCvpcZtbubUmfOuNrA=;
        b=ioxSKuZRRoLc6ingDXjHAZZWp/pEU23R8+IYqS+JSTXgnxG1zmyPQgE1XEeJqx+Ewt
         GetoQ6n3Khm6spkF3aG4EUrvRqtL3yH2TXX8ODqYX4hnaR03E2aPlDa9JMg8ir1YaeY/
         1SO832MI8fE1/TaWPsnb2PnMCFVtHEy+k2ux7MDh6F79KOFo8nh97ko65uJvHJSfqSBe
         6/d1QN9/Hp1Fpjwrg4uWOL/T5Q7SLZYXG67ntcSOz9jmQqp9CvbuZNUjIszS6p+oz/Hj
         DDJmgXZ4TNN81TFSfJ71ppeErFA+9TN2LLoz4cA0dCPV1VKIDObe1S1k0FlDn5CZXru3
         PT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cb9stFKLzXPQpQUHtTxU8+h4YRCvpcZtbubUmfOuNrA=;
        b=MYIreDEJNlKs3dQbTysA2j+Kn4RZCzrl2h4rjpJOfv+zcU3OtoR18Rx/QI7sShKBG6
         C070lO77MN/9tbN2/yuU+K6I1E4thPvfSSCcA2cPXhh3p6NAuJAQzp9MGSLdGUXdoOHZ
         uTuTpcmtpwxko4Eo4oYi+Mu0rbyAkbLdDd6F0XCIkHr+Pl7NNif5NOduSudGFN+kZTos
         XhGox1tVgWmWdtO1GyTLf4Vf2eSK8XQGfmnwrJggqyomJOn+X9+jNzFVcF+HKevtaSqK
         KsBH+pEv1lrLFOJv5kqKuPUtIJFb9NA+xjFFGYMnFXMAB9e8KyZvaZac8BaXFo7TuAvC
         s7Rw==
X-Gm-Message-State: AOAM531I9/5QmP78WdWF4r5wG2d9M+SkU81b+xtvaf7hOAaduKcMOxBW
        NQmqo+h/Gr9c9BPuAygoI7F1VR812B1VKVBICSE=
X-Google-Smtp-Source: ABdhPJwep+bzu1vE84L1FyoIC8GmoYqfIx68XbE3dok6W8b80a2uyP74ihWlgmcoELWgME5TYHm5cZ4zoxi6RbdK5aw=
X-Received: by 2002:a05:6402:b55:: with SMTP id bx21mr17474768edb.281.1619690417676;
 Thu, 29 Apr 2021 03:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085251.51475-1-andrew@adoakley.name> <20210412085251.51475-3-andrew@adoakley.name>
In-Reply-To: <20210412085251.51475-3-andrew@adoakley.name>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Thu, 29 Apr 2021 03:00:06 -0700
Message-ID: <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
To:     Andrew Oakley <andrew@adoakley.name>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Feiyang Xue <me@feiyangxue.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I checked out "seen" and ran the test script from this patch
(t9835-git-p4-message-encoding.sh) on my Windows machine and it fails.

I don't think the solution in this patch will solve the issue of non
UTF-8 descriptions on Windows. The interaction between git-p4.py and
p4 around non-ASCII descriptions is different on Linux and Windows (at
least with the default code page settings).  Unfortunately the CI on
gitlab does not include any Windows test environments that have p4
installed.

As far as I can tell, non-ASCII strings passed to "p4 submit -d" pass
unchanged to the Perforce database on Linux.  As well, such data also
passes unchanged in the other direction, when "p4" output is consumed
by git-p4.py.  Since this patch avoids decoding descriptions, and the
test script uses binary data for descriptions, the tests pass on
Linux.

However, on Windows, UTF-8 strings passed to "p4 submit -d" are
somehow converted to the default Windows code page by the time they
are stored in the Perforce database, probably as part of the process
of passing the command line arguments to the Windows p4 executable.
However, the "code page" data is *not* converted to UTF-8 on the way
back from p4 to git-p4.py.  The only way to get it into UTF-8 is to
call string.decode().  As a result, this patch, which takes out the
call to string.decode() will not work on Windows.
