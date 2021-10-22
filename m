Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E6C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 01:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5D16135F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 01:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhJVBSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 21:18:35 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:55388
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232068AbhJVBSf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Oct 2021 21:18:35 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2021 21:18:34 EDT
Received: from a2plcpnl0855.prod.iad2.secureserver.net ([107.180.109.50])
        by : HOSTING RELAY : with ESMTP
        id dj2BmWbYBIXfLdj2BmGX3F; Thu, 21 Oct 2021 18:07:47 -0700
X-CMAE-Analysis: v=2.4 cv=C+osdSD+ c=1 sm=1 tr=0 ts=61720ee3
 a=TnFZWvihntyBY5k9PECvpg==:117 a=BlSdDew1iayyegN3dI8xCA==:17
 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10
 a=zDQT-SbddxT7VuDer4cA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: justus@opentransactions.org
Received: from [173.44.55.155] (port=56824 helo=mailserver)
        by a2plcpnl0855.prod.iad2.secureserver.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <justus@opentransactions.org>)
        id 1mdj2B-00G5Vj-Ad; Thu, 21 Oct 2021 18:07:47 -0700
Received: from [10.137.0.14] (helium.fuckthenavy.net [192.168.199.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mailserver (Postfix) with ESMTPSA id 3A82F8608B7;
        Thu, 21 Oct 2021 20:07:45 -0500 (CDT)
Message-ID: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
Date:   Thu, 21 Oct 2021 17:07:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Justus Ranvier <justus@opentransactions.org>
Subject: gitignore as symbolic link
Organization: Open-Transactions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2plcpnl0855.prod.iad2.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - opentransactions.org
X-Get-Message-Sender-Via: a2plcpnl0855.prod.iad2.secureserver.net: authenticated_id: justus@opentransactions.org
X-Authenticated-Sender: a2plcpnl0855.prod.iad2.secureserver.net: justus@opentransactions.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4xfEeYGSY3wUU5RDKLdBKHBu6N076CACJVhlcXGfUEnfz9pXpwRIkVmi6O2ZeOBRu7X1not+NMPSS/hwdRJgfdv/xhtLFGRySFFcKIuFdaEkUJhpZDrXDd
 Z46CP3xYvzt+tuGa4sfaqGaZ6vCbWMy/LTWyq7nOygHE5Gt3NRUDLynY0EEzeVn9Mvz2DxXl7jBBsNli/bqX8G21aos8ePaUmeCSNxBazcXU3unFzXtsae/d
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have several repositories where the top level .gitignore file is a 
symbolic link to the actual file which is contained in a submodule which 
all the repositories share.

This worked fine up to and including version 2.31.1 but as of 2.32.0 
running any command which would cause .gitignore to be read results in a 
"too many levels of symbolic links error" and git behaves as if 
.gitignore is not present.
