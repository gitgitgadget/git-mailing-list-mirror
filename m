Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F3FC54E8E
	for <git@archiver.kernel.org>; Tue, 12 May 2020 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8253E206F5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgELN1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 09:27:46 -0400
Received: from iodev.co.uk ([193.29.56.124]:45024 "EHLO iodev.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgELN1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 09:27:45 -0400
Date:   Tue, 12 May 2020 15:28:32 +0200
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] git-gui: Handle Ctrl + BS/Del in the commit msg
Message-ID: <20200512132832.GB20813@abuya.home>
References: <20200512102806.GA20813@abuya.home>
 <20200512130235.2vimhqmmzbib3k2s@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512130235.2vimhqmmzbib3k2s@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/May/2020 18:32, Pratyush Yadav wrote:
> Hi Ismael,
> 
> On 12/05/20 12:28PM, Ismael Luceno wrote:
> > From: Ismael Luceno <ismael.luceno@tttech-auto.com>
> > 
> > - Control+BackSpace: Delete word to the left of the cursor.
> > - Control+Delete   : Delete word to the right of the cursor.
> > 
> > Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
> > they were adopted by most CUA-Compliant UIs, including those of: OS/2,
> > Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.
> > 
> > In both cases Tk already implements the functionality bound to other key
> > combination, so we use that.
> > 
> > Graphical examples:
> > 
> > Deleting to the left:
> >         v------ pointer
> > X_WORD____X
> >   ^-----^------ selection
> > 
> > Deleting to the right:
> >   v--------- pointer
> > X_WORD_X
> >   ^--^------ selection
> > 
> > Signed-off-by: Ismael Luceno <ismael.luceno@tttech-auto.com>
> > 
> > ---
> > I'm re-submitting the patch after >1 year.
> > 
> > CC: Junio C Hamano <gitster@pobox.com>
> > CC: "brian m. carlson" <sandals@crustytoothpaste.net>
> > CC: Pat Thoyts <patthoyts@users.sourceforge.net>
> > CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > 
> > Notes:
> >     Changes since v2:
> >     - Reimplemented via existing events, which correctly delete spaces.
> >     - Further improved commit message.
> >     
> >     Changes since v1:
> >     - Improved commit message.
> > 
> >  git-gui/git-gui.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> > index 6de74ce639..c4e0270626 100755
> > --- a/git-gui/git-gui.sh
> > +++ b/git-gui/git-gui.sh
> 
> You based the patch on top of the Git tree. Since Git Gui is maintained 
> separate from Git, patches are expected to be based on top of the Git 
> Gui tree [0]. I fixed it up and applied the patch on my tree.
> 
> > @@ -3812,6 +3812,8 @@ bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_context;break}
> >  bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
> >  bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
> >  bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
> > +bind $ui_comm <Control-Key-BackSpace> {event generate %W <Meta-Delete>;break}
> > +bind $ui_comm <Control-Key-Delete> {event generate %W <Meta-d>;break}
> 
> Don't use "Control" directly to maintain compatibility with MacOS. Use 
> $M1B like the surrounding code does. I fixed it up locally, so no need 
> to send in a new version. You can find the fixed up version here [1]. 
> Test it if you'd like.
> 
> Will merge it in. Thanks.

Thanks.
