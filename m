Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42471F462
	for <e@80x24.org>; Thu, 21 Feb 2019 09:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfBUJbH (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 04:31:07 -0500
Received: from [193.29.56.124] ([193.29.56.124]:44998 "EHLO iodev.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfBUJbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 04:31:07 -0500
Date:   Thu, 21 Feb 2019 10:31:00 +0100
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v2] git-gui: Handle Ctrl + BS/Del in the commit msg
Message-ID: <20190221093059.GA6594@kiki>
References: <20190216031051.8859-1-ismael@iodev.co.uk>
 <xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/Feb/2019 12:05, Junio C Hamano wrote:
> Ismael Luceno <ismael@iodev.co.uk> writes:
> 
> > - Control+BackSpace: Delete word to the left of the cursor.
> > - Control+Delete   : Delete word to the right of the cursor.
> >
> > Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
> > they were adopted by most CUA-Compliant UIs, including those of: OS/2,
> > Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.
> >
> > Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> > ---
> >
> > Notes:
> >     Changes since v1:
> >     - Improved commit message.
> 
> I do not use git-gui, but as a bystander, the intent of the change
> sounds sane.  deleting from the insertion cursor to the end of the
> word where the insertion cursor is looks like the right way to
> delete the word to the right of the cursor.  I am not sure if going
> back by one character from where the current insertion cursor is and
> further go back to the wordstart would give the beginning of the
> word to the left of the cursor, though.

Graphical explanation:

Deleting to the left:
      v----- pointer
X_WORD_X
  ^--^------ selection

Deleting to the right:
  v--------- pointer
X_WORD_X
  ^--^------ selection


Current implementation doesn't behave correctly when there's multiple
spaces:

Deleting to the left:
        v--- pointer
X_WORD____X
       ^---- selection

Deleting to the right:
  v--------- pointer
X____WORD_X
  ^--------- selection


> A larger issue is that we haven't heard from Pat, who has been
> helping git-gui.sh maintenance, for quite a while, so we'd need to
> find a volunteer to act as a replacement maintainer.  If you are
> willing to, that would be great ;-)

Sure.
