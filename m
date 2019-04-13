Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B3220248
	for <e@80x24.org>; Sat, 13 Apr 2019 20:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDMU1w convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 13 Apr 2019 16:27:52 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21264 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDMU1w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 16:27:52 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x3DKRn2i042982
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 16:27:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] GIT_SSH_COMMAND is not being decomposed
Date:   Sat, 13 Apr 2019 16:27:44 -0400
Message-ID: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0003_01D4F215.30AFA740";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQC3GS3pUTVWeV9PAQCC41Aun5SSNg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am encountering a problem on one of our NonStop platform variants where
the GIT_SSH_COMMAND string is not being broken into constituent parts. This
is causing SSH to not run properly. As background, SSH is not in a standard
location and has non-standard required arguments. This also occurs with
core.sshCommand. The situation is:

git config --global core.sshCommand '/G/system/zssh/sshossz5 -Q'

which correctly sets .gitconfig as:

[core]
        sshCommand = /G/system/zssh/sshossz5 -Q

When git is run with GIT_TRACE=true GIT_PACKET_TRACE=true git fetch

We get the partial trace:
14:19:56.027088 trace: built-in: git fetch
14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5 -Q' -G
user@host

The same trace on our systems that actually do work results in:
14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5' '-Q' -G
user@host

I need help resolving why this is happening (as in where to look and debug
the situation).

Urgently,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



