Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE6BC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 18:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D9520789
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 18:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="EaFv8Ta1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRSqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 14:46:54 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317DC061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 11:46:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u126so22111036iod.12
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=9UGfkOD1fuUyMSMzKrm4FTCz/TPzwwmEtg4CWgN7X0o=;
        b=EaFv8Ta15AJaCMGItVNSH0HbU29/X4JLvmojFKyOecjJsxcTUAVCFmJbAIQauL+8Ge
         ziBHhR1nQwsd+MAX5CXzMrUHsZ3DUAGjiBojaBoh+UbuBRw0VmHZRSSJot6WPzlPDXsi
         BXVPeBsjQiUc9RkKyzluKmS/Chg2sh9QKPnCDdpEj/l1Ok819wBK5NPaRFM/6kQFm908
         bn304Aj0x2sKwjSZoezV686i9XO5XCD05/8txjnrwoyjzXZGarBHWbI16tHLgdyyh23J
         Vli7PcugXHgIC9a2YpSOIEkM72VqohauIuLOvFpE8vOrsPrwpy6AmzaOh+RZ+Sns5V40
         kcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=9UGfkOD1fuUyMSMzKrm4FTCz/TPzwwmEtg4CWgN7X0o=;
        b=QfTjsaJRaERMZL5Xj+8y879SdvCUDQ1qxFU0RD5eDENgKsQm/mv0nk7qs294ZTLmMW
         KtBbzybAXSqqhd1xeIYH+GfvtbyIaqgZplQIdjnfkOkj1v680PeKNUglDZTEkidwTPu6
         MfZ1fPCEwWODfTxSr5LwX32oCuA8IlCjHAkMyVzIMXsjfGRS/G6gax8IYc9Q+IEE5seb
         PD2eADHHLCcGBKXlQGN4DmLefBpCKZcuTA2eReshq9uCnAfZDMfnXUcfgbTNW5gpPNnn
         AeLmNISvzlWNjqBgTGcKzgBTYoI66dqFFwEH29SDgse4xBOhFwKkiP45DI53oUgqiaf8
         csXw==
X-Gm-Message-State: AOAM531dO9ucqjknfPZ8cg/gshN9F9T4j7ZYyPjISYGgVROFyPIOZS9U
        EDGPhVSW1hG3QYtM1NTmHd7F3MBcF2pu2w==
X-Google-Smtp-Source: ABdhPJxcJM1qT/q3Z2k3xTZ9OWMGGNTGYi5peFvvIcWwMCXFG+7zYzVZBY4vUKP9jM8sSwYuqhDE7g==
X-Received: by 2002:a5e:9507:: with SMTP id r7mr17608189ioj.151.1597776413114;
        Tue, 18 Aug 2020 11:46:53 -0700 (PDT)
Received: from [10.180.91.227] (host-110-23.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.23])
        by smtp.gmail.com with ESMTPSA id c12sm11735058ilq.79.2020.08.18.11.46.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 11:46:52 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: GPG Commit Signing Project
Message-Id: <43C81FDC-611D-45A1-9525-24640FEB2E1A@rams.colostate.edu>
Date:   Tue, 18 Aug 2020 12:43:45 -0600
Cc:     David Huseby <dhuseby@linuxfoundation.org>, git@vger.kernel.org
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

I am Jimit Bhalavat, and as you know I have been selected by The Linux =
Foundation to work on the GPG Commit Signing Project. My mentor is David =
Huseby. I have spent the last few weeks working on a Technical Design =
Document which specifies how the commit signing works in git and what =
functions are called. I have done the same for verifying signatures, =
commit tags, and verifying tags. The aim of this project is that we want =
to focus entirely on refactoring the signing infrastructure to make it =
easy for users to support their choice of signing tool while preserving =
full backwards compatibility with the way things work today. We are NOT =
at all trying to inject any "emerging technology" into Git, just merely =
loosening the binding between Git and GPG enough so that users have more =
choice with signing tools.

The detailed technical design proposal is below:=20

What changes did patches make last summer?: The project=E2=80=99s goal =
was to abstract the current GPG interface into a more =E2=80=98generic=E2=80=
=99 API that supports the existing OpenPGP and X.509 functionality while =
creating the ability to write additional signature drivers. Currently =
git supports signing/verifying commits and tags using GPG only. The goal =
of the project was to make the git signing interface compatible with =
external signing tools. The main sections of the project were updating =
the user configuration and the command handling when a signing or =
verifying operation occurs. The prototype of Ibrahim=E2=80=99s patches =
has already implemented configuration aliases to ensure that the new =
approach is backwards compatible with previous configuration. The =
patches also worked towards improving the documentation for clear =
transition, along with maintaining backward compatibility.=20

Why were the patches from last summer rejected?: The patches from last =
summer opted for a config based approach and a tool-agnostic signing =
interface. The main goal of the project was to abstract the current GPG =
interface into a more =E2=80=98generic=E2=80=99 API that supports the =
existing OpenPGP and X.509 functionality while creating the ability to =
write additional signature drivers. The project proposal had already =
implemented configuration aliases to ensure that the new approach is =
backwards compatible with previous configuration. The other reasons =
include: the drivers for external signing tools were still written in C =
and the patches were not more for a configuration based interface. The =
patches implement updated user configuration to define signing tools and =
implement a tool-agnostic signing interface in C code. It also added the =
possibility to use bash helper scripts to drive additional tools in case =
the default interface doesn't work as intended.

Where are we going next?/What we are trying to achieve?: The main goal =
of this year=E2=80=99s project is instead of having C code for each new =
signing tool, we will try define a new  standardized pipe forking =
interface that takes the values from the config file. The config file =
will contain the following values: which executable to run, what =
parameters to pass, what regular expressions to use for detecting =
signature type and pulling the signature out of commits and tags. Part =
of the patches from last summer update the config format to support any =
number of different signing tools. If the config file does not have any =
values using the new signing section format, it defaults to the GPG =
executable, GPG regular expressions, and the GPG parameters. This =
ensures that we maintain backward compatibility and preserve existing =
behaviour for users who have not adopted the new config values. We are =
going to deprecate things, but old options will not stop working.

The proposal:

	1. We aim to achieve that instead of having C code that calls =
all the signing tools, we will try to achieve that only one piece of =
code will do the standardized pipe forking and take the values from the =
config file. The config file will contain the following values: which =
executable to run, what parameters to pass, what regular expressions to =
use for detecting signature type and pulling the signature out of =
commits and tags.
	2. The current patch uses a set of function pointers, but this =
project aims to use a struct with the configuration data for the =
detected signature type such as PGP, x509, minisig, etc.
		a. When signing, the signature type either comes from =
the command-line switch or from the signing default as specified in the =
config file. The config file has different parameters: which executable =
to run, what parameters to pass, what regular expressions to use for =
detecting signature type and pulling the signature out of commits and =
tags. The goal is to try and call the signing tools from one piece of =
code instead multiple C code. If the config file does not have any =
values, it defaults to the GPG executable, GPG regular expressions, and =
the GPG parameters.
		b. During the verification process, the signature type =
is detected by using regular expressions from the config file. The =
regular expression searches for metadata for a matching signature, and =
the first one that matches, that format is returned and used for the =
verification. This design also opens up the possibility of having =
multiple signatures on a commit/tag.
		c. Once format is determined, a signing_tool struct is =
initialized for the given format. The struct contains all of the config =
data for the given tool (e.g. program to run, regex=E2=80=99s, command =
line switches, etc).
	3. The project also aims to improve the signing-interface.c file =
to work from the signing_tool struct which we created above which =
contains all of the configuration data for the given tool such as what =
program to run, regular expressions, and command line switches. The flow =
of the code should look like this:
		a. Pass in a signing tool struct to sign commit
		b. Instead of calling function pointers to the =
signing-tool-specific =E2=80=9Cdrivers=E2=80=9D, it will instead do what =
the existing code does; however the executable and command line switches =
all come from the config/defaults instead of being hard coded..
	4. Create a struct for signer_identity:
		a. This struct will be helpful to load signer_identity =
from config (e.g. the existing signingkey config item) or command line.
		b. It stores the signing-tool-specific signer identity =
string/identifier, so that it can be passed to the signing tool.
	5. All of these changes will make sure that we maintain =
backwards compatibility. We are aiming to deprecate things a little but =
old options will not stop working. We will preserve existing behavior. =
The goal is to try and call the signing tools from one piece of code =
instead multiple C code.=20

Thank you for your time and we appreciate you looking into it. We are =
open to having conversations and work with you to make a final proposal =
which we can use to move forward.=20

Thank you once again.

Best,
Jimit Bhalavat.=
