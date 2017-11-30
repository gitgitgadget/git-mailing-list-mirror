Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD4620C11
	for <e@80x24.org>; Thu, 30 Nov 2017 17:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdK3RFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 12:05:10 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:37879 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdK3RFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 12:05:09 -0500
Received: from homiemail-a11.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 30BDF935F8
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:05:09 -0800 (PST)
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id B5FA3314C06D
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=W8qY+ShhqVFajM80Y4J
        5lKzA+uc=; b=bEWQiBGQPCtEn4H3gWDLuKgrBqwtq9o6VP1x+yJrYec5pid/Run
        1ZDKCG1RhQeL0FWv3E8gVYsUTuuMIT7D4oNx9KSagtND3JYf4q7SZwGf2DmHol9v
        eGU6mnATlrwN9byetMLDDZO2TMy405W3rG5y1opBA0PUchc3rwBPOFpY=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 78BEB314C066
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:05:08 -0800 (PST)
Message-ID: <1512061507.9882.374.camel@novalis.org>
Subject: git reset <tree-ish> <paths> of addition of a submodule?
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Date:   Thu, 30 Nov 2017 12:05:07 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git submodule add https://my-git-repo blort
git commit -m 'add a submodule'
git reset HEAD^ blort

The reset deletes the gitlink, but does not delete the entry in
.gitmodules.  On one hand, this is exactly what the user asked for --
they wanted the path 'blort' to be changed in the index, and that's
what they got.  On the other hand, the behavior differs from git rm,
and seems confusing: most folks don't want an entry in .gitmodules
which doesn't correspond to a gitlink.  

If reset isn't the right thing for me to do when I want to say "oops"
about adding a submodule, then what is?  I could do:
git reset HEAD^ blort .gitmodules
but what if I added two submodules and only wanted to undo the addition
of one?


