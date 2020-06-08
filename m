Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7775C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6F920760
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgFHVlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:41:46 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62046 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:41:46 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 058LfiJH071227
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 8 Jun 2020 17:41:45 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Possible Bug] Use of write on size-limited platforms
Date:   Mon, 8 Jun 2020 17:41:34 -0400
Message-ID: <015c01d63ddd$97d65080$c782f180$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdY93ZRoaCTDw1iGSPW/ahw9j1aXEg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just wanted to check the following calls to make sure that it does not
fwrite or write should be xread/xwrite or are guaranteed not to exceed
MAX_IO_SIZE:

strbuf.c: strbuf_write, strbuf_write_fd, the size is not specified.

The other uses of read/write appear to be safe.

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


