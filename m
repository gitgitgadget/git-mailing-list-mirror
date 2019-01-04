Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6011F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 02:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfADCV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 21:21:27 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:52181 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADCV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 21:21:26 -0500
Received: by mail-it1-f178.google.com with SMTP id w18so48108293ite.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 18:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=RPsTqOu0c+gOqor3aYDDVqHbwHVPRFge3trg589EW1Y=;
        b=OSWBusQm6bL6sDHG2Gg/FObJwgT3hXA4WSEU+qLnvCr4B9jLT+UP/Sco1IgmybVTr3
         IMmBybxiQhD79PTb/Ipo2PmBFMMlzqklTip+I8yyNjO69CEp8s49Lgtsp5vuE7XJ6KMf
         MTxs1SYPJBaQDKN3fNroMtlXXG9QgDiG3MPmx2Ma0txaWI1uxSnD9FWRP+lBETcsknPH
         QHJ6QsxDFPHbn5TFVf2fV8I5ZD41zZ1mJaXrgjNnkBaXnVmwp6FHCApJfub1fPes+YSi
         528zK/wrp4tXJ3duz/yXbafgpjDqGT6i4hboiCTIg2paUys9mupQEO5o2kz/tWM+aaWF
         ED2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RPsTqOu0c+gOqor3aYDDVqHbwHVPRFge3trg589EW1Y=;
        b=M1rZj3LIAU42ifdA/s73wE8x0PNHilBxSYmWV1lqB/VRafR/wjwwDrLgoG1glrINoe
         Y7JL7VjjM2gXlpZOLyYDCqFTcEnQ1Tp5sP6dY06oTdG/WIKqFrTUd76IvPzdhM4TOOl6
         yLahwiKDbQaYYpLYYFIQb0/nvufroADTEB4nc7zAKFDWnMRs6U1RNOMQGmftGf5nSaky
         XYN06bTsXmvaHHZIuWavYAamvBl74tpTXnZAm5mUlpKG6sOO9L/drSxansvTDBVCN/eI
         u1wCRPITCZ8RuLjvgtqYkS/cDRXQy6N3T09A8it5ILinwwTAjxNAN0Abiyfn6MqMwFZn
         UVGA==
X-Gm-Message-State: AA+aEWYgTdj8YaHWbyoTTiEDi2wlu2FSJukJACnZX6SRjmybZ/mpk7Zl
        77aazekXzGGsjWrE34mJTz6NWtf0Ox0BojnALkkyFIZv
X-Google-Smtp-Source: AFSGD/WhdYYG7XuF+yHy7Uv/bkpgHXJTXMNWBAx+H5T8d7Jr7xU4cPdZZVpU4l6eh64wd56c+FLdEzok+h6nUs/UtZo=
X-Received: by 2002:a24:d857:: with SMTP id b84mr31397397itg.149.1546568485716;
 Thu, 03 Jan 2019 18:21:25 -0800 (PST)
MIME-Version: 1.0
From:   Bret Barkelew <bret@corthon.com>
Date:   Thu, 3 Jan 2019 18:21:14 -0800
Message-ID: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com>
Subject: git version 2.20.1.windows.1 throws file name too long in gitk
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I open gitk in a particular repository under this version of Git
for Windows, I now get a dialog box that says "Error: couldn't execute
"git": file name too long". I've noticed that the most pronounced
effect is that I cannot see the file diffs (or sometimes the file name
list) for any of the commits. I don't know the exact repro, but I've
narrowed down the following things:

- This does not happen with the same repo if I use a system that has
git 2.19.0.windows.1 on another machine.
- This does not happen on my current machine in a freshly cloned repo.
However, as soon as the remote updates with any changes on a given
fetch/pull, the repo is put in a bad state permanently.

I've pasted the output from gitk below...

couldn't execute "git": file name too long
couldn't execute "git": file name too long
    while executing
"open $cmd r"
    (procedure "getallcommits" line 48)
    invoked from within
"getallcommits"
    (procedure "readcache" line 80)
    invoked from within
"readcache file827e200"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)

Happy to gather whatever data needed.
Thanks!
- Bret Barkelew
