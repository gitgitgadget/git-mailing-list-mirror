From: Junio C Hamano <gitster@pobox.com>
Subject: Re: enhanced remote ref namespaces
Date: Wed, 12 Aug 2015 12:49:51 -0700
Message-ID: <xmqqwpx0jnhc.fsf@gitster.dls.corp.google.com>
References: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
	<xmqqegj8l4lw.fsf@gitster.dls.corp.google.com>
	<CA+P7+xq_v+TjqSDC3aR2bdUmCJyj=zLXSE5SbVgOEr+SojOUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:49:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPc2A-0007T3-E6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbbHLTty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:49:54 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35917 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbHLTtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:49:53 -0400
Received: by pacrr5 with SMTP id rr5so20911973pac.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zvXBx+Uq3Exk3hxlsKmFQ6kA4XZxwwFEhMIphDLnv3E=;
        b=krwBsYL2OV+uRVHyvnf+2xwvbOnuJJfQchZN0gU/1AneBKdBuU6X1Ks1PAn+hygYz0
         Y5/ifXKxw2pjW9oRvB8gmGxoqcDkBOdbpuEDGiI7BWFMGBPT+cjBJKmzgm9Wk74oOlcZ
         eiSZldJ98RY7x/M5qijPFA6onWuzn9/DRI6G2zUXctxbDu39pkXjQxeyJ32DbAv87A38
         SS5L0Jw5gSZXStFI4So3CsEUepQ+u8tEwBegriXxJRZda+N4FaPNX5ws0Au2KqB7sGYW
         2DC6xJIgr42PjiWRSQTKDN66QQkiowcBcIB65EldBCMUF5aeuImmlUWdJjYeBwchc3f6
         7APA==
X-Received: by 10.68.241.166 with SMTP id wj6mr70611467pbc.114.1439408993108;
        Wed, 12 Aug 2015 12:49:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id pk8sm3070610pdb.54.2015.08.12.12.49.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:49:52 -0700 (PDT)
In-Reply-To: <CA+P7+xq_v+TjqSDC3aR2bdUmCJyj=zLXSE5SbVgOEr+SojOUQQ@mail.gmail.com>
	(Jacob Keller's message of "Wed, 12 Aug 2015 12:02:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275806>

Jacob Keller <jacob.keller@gmail.com> writes:

> That still hasn't really resolved the question of how to deal with
> tags, but it does solve the question of how to deal with replace and
> notes refs.

I do not think it would be a good change to add a

    [remote "foo"]
        fetch = refs/tags/*:refs/tracking/foo/tags/*

as people do expect to see tags from upstream to appear in their
local tag namespace when cloning from the central meeting point of
their project (e.g. Linus's kernel repository).

I'm willing to believe those who argued that they have both private
tags and public tags in their repository, but I think that would be
something better supported by adding "git tag --local foo" that
creates a local tag in e.g. refs/local-tags/foo, and by teaching
DWIMmery to also look in there when the user says "foo".

Alternatively, they can use their local branch namespace, which is
already private to them.
