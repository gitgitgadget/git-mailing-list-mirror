Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632BDC4332F
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 12:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbhLAMWd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 1 Dec 2021 07:22:33 -0500
Received: from elephants.elehost.com ([216.66.27.132]:49987 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbhLAMW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 07:22:26 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B1CJ3j0014773
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Dec 2021 07:19:03 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Loic Fouray'" <loic@yeplaa.net>, <git@vger.kernel.org>
References: <A5C94370-A9D0-43B2-9B32-0935703BCC94@yeplaa.net>
In-Reply-To: <A5C94370-A9D0-43B2-9B32-0935703BCC94@yeplaa.net>
Subject: RE: Merge conflict when lines next to each other are changed
Date:   Wed, 1 Dec 2021 07:18:58 -0500
Organization: Nexbridge Inc.
Message-ID: <008001d7e6ad$a155e290$e401a7b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMd+pvAhtsvccQJtEWmJUXvoIKU86mRY+Xg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 1, 2021 4:30 AM, Loic Fouray wrote:
> In a file, I have this 2 lines one below the other:
> 
> Repository: myvalue
> Tag: 8.2.10
> 
> On my local branch i have updated repository myvalue.
> On the upstream repo, they updated often the tag value (not updated of my
> side).
> 
> When i perform a merge from upstream to local branch, i have a conflit.
> It seems that it’s related to neighboring lines.
> Could you confirm that it ‘s a normal git operation?
> 
> Also, i need to automate this merge. Is It possible with git tools to avoid this
> conflict or to resolve this conflict automatically?

I try to keep version-specific identifying information, which is already contained in git, out of my code. This includes change logs/history in each source file because git is good at keeping that information - it is redundant in the code. However, for organizations that need to do that, I suggest using clean/smudge filters so that the code inside the repository is clean, while things like the repo name and tag get injected into the code as git puts it into the working directory. The code is then cleaned up while being staged. This removes the possibility of the conflict on these lines by removing the differing lines. You can script this using a combination of sed and git commands. My own git front end does this all the time but it is not generally applicable to all platforms (only NonStop and MVS) so I have not contributed it.

Regards,
Randall

