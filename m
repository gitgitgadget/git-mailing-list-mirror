Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2999A2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbcKIXbO (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:31:14 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:57928 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbcKIXbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:31:13 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c4cKj-0006Oj-F8; Wed, 09 Nov 2016 23:31:09 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22563.45501.383303.374430@chiark.greenend.org.uk>
Date:   Wed, 9 Nov 2016 23:31:09 +0000
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate
In-Reply-To: <xmqqeg2k8cwz.fsf@gitster.mtv.corp.google.com>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
        <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
        <22561.44597.59852.574831@chiark.greenend.org.uk>
        <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
        <22562.32428.287354.214659@chiark.greenend.org.uk>
        <xmqqa8d9b3jh.fsf@gitster.mtv.corp.google.com>
        <22562.65461.845411.29907@chiark.greenend.org.uk>
        <xmqqeg2k8cwz.fsf@gitster.mtv.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes ("Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate"):
> Ian Jackson <ijackson@chiark.greenend.org.uk> writes:
> > This is not correct, because as I have explained, this should be a
> > per-tree configuration:
> 
> I do not have fundamental opposition to make it part of .git/config,
> but the name "gitk.something" or if you are enhancing git-gui at the
> time perhaps "gui.something" would be appropriate.  
> 
> But it is still silly to have this kind of information that is very
> specific to Gitk in two places, one that is pretty Gitk specific
> that core-git does not know anything about, the other that are part
> of the configuration storage of the core-git.  In the longer term,
> it is necessary for them to be accessible from gitk's "Edit ->
> Preferences" mechanism somehow, I would think, rather than forcing
> users to sometimes go to GUI to tweak and sometimes run "git config".

I am proposing to set this configuration setting automatically in
dgit.  Other tools that work with particular git tags would do the
same.  There would be no need for users to do anything.

Having this as an option in a menu would be quite wrong, because it
would end up with the user and the tooling fighting.  This is why I
don't want to put this in gitk's existing config file mechanism.

It would be wrong for dgit to edit the user's gitk config file, for
many reasons.

To put it another way, this setting is a way for a tool like dgit to
communicate with gitk (or other programs which have to make guesses
about how prominently to present certain information to the user).
It's not intended to be a way for users, certainly not non-expert
users, to communicate with gitk.

The way I have structured my proposed patches in gitk would make it
easy to provide a gui option to adjust these settings.  Such a gui
option ought to save its value in the gitk config file, and those
values ought to override what comes from `git config'.

But such a system would not obviate the need for a legitimate way for
programs like dgit to communicate with gitk.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
