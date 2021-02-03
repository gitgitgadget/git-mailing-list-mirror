Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6FC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4CC64F58
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBCUkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:40:39 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45771 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhBCUki (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:40:38 -0500
X-Originating-IP: 103.82.80.225
Received: from localhost (unknown [103.82.80.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4EB7660005;
        Wed,  3 Feb 2021 20:39:49 +0000 (UTC)
Date:   Thu, 4 Feb 2021 02:09:47 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
Message-ID: <20210203203947.j2ut5p7nhrd6rcmh@yadavpratyush.com>
References: <20210202200301.44282-1-me@yadavpratyush.com>
 <fdfe1661-463b-fc18-02cc-4c6e22ce0463@kdbg.org>
 <CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/21 12:48PM, Eric Sunshine wrote:
> On Wed, Feb 3, 2021 at 12:35 PM Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 02.02.21 um 21:03 schrieb Pratyush Yadav:
> > > The comment character is specified by the config variable
> > > 'core.commentchar'. Any lines starting with this character is considered
> > > a comment and should not be included in the final commit message.
> > >
> > > Teach git-gui to filter out lines in the commit message that start with
> > > the comment character. If the config is not set, '#' is taken as the
> > > default.
> >
> > This is WRONG. Git GUI is that: a GUI, it's all about WYSIWYG. If you do
> > not give sufficient unambiguous visual clue to the user that certain
> > lines will be ignored, you cannot ignore them.
> >
> > Perhaps what you are really only interested in is to remove the list of
> > conflicted files after a merge conflict? Then the correct way to proceed
> > would be to sanitize the contents of .git/MERGE_MSG before it is
> > inserted into the edit box.

While this patch also fixes the merge conflict message case, it was in 
fact prompted by [0], which talks about comments in the commit message 
template. This is likely useful information that we don't want to hide 
from the user.

> 
> This is indeed the case I run into which is annoying because the
> commented-out list of conflicted files does not get removed when
> git-gui performs the actual commit.
> 
> However, although what you propose here seems superficially enticing,
> it doesn't mirror the behavior of git-commit itself when launching an
> editor, in which case the unsanitized file (containing the
> commented-out conflicted file list) is loaded into the editor
> verbatim, and it is only sanitized when the edit session is finished.
> The important difference is that extra text is added to the edit
> buffer telling the user explicitly that "lines beginning with '#' will
> be ignored".

I agree. 
 
> So, perhaps one way forward is for Pratyush to emulate that behavior
> and insert some text into the edit box saying "lines beginning with
> '#' will be ignored", or add a label above or below the edit box
> stating the same. (Of course, the actual displayed comment-character
> should be determined dynamically.)

This would be a nice addition. Will see which approach looks best.

[0] https://github.com/prati0100/git-gui/issues/51

-- 
Regards,
Pratyush Yadav
