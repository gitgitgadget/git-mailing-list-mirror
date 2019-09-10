Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EA61F463
	for <e@80x24.org>; Tue, 10 Sep 2019 19:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfIJTmH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 15:42:07 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46185 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJTmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 15:42:07 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 69530E0007;
        Tue, 10 Sep 2019 19:42:04 +0000 (UTC)
Date:   Wed, 11 Sep 2019 01:12:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
Message-ID: <20190910194202.weior75tzpd7iapg@yadavpratyush.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
 <20190904224821.mgh4srhc22grkraz@yadavpratyush.com>
 <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
 <CAKPyHN1VeK4bR3Dn5yjrs2UwT5XGKOPU_FHaMBsP+riM-bjeWA@mail.gmail.com>
 <CAGr--=JpsgESv8W90-iT11VCAD3xQYipN3+Tt7cNyeZrsvhP_Q@mail.gmail.com>
 <ed572a47-b3d1-028f-0576-aac6c922671e@iee.email>
 <20190910080408.GA32239@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910080408.GA32239@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/19 01:04AM, David Aguilar wrote:
> On Fri, Sep 06, 2019 at 09:07:15PM +0100, Philip Oakley wrote:
> > 
> > Not sure if I parsed this correctly, but I'd want a WYSIWYG approach that if
> > we wrap on the display it will be wrapped (newline char) in the commit. It
> > sounded as if you were proposing a soft wrap visually, but not doing the
> > same for the commit.
> > 
> > Personally, I've had both feelings with the gui. I like that the 'hard'
> > visual char limit is there that encourages me to wrap my messages.
> > But at the same time if I'm typing on a flow then it's annoying that there
> > wasn't any auto wrap.
> > 
> > The other problem is if one is amending a commit and I need to add a few
> > word mid paragraph, the manual re-flowing and manual wrapping can be
> > annoying.
> > 
> > I suspect there is a moderately happy medium between the two, perhaps with
> > an autowrap key (per paragraph) being available.
> > 
> > I also had it in my head that some parts of Git do allow more than a single
> > line headers, or at least can cope with a run-on second line before the
> > blank line that flags the start of the message proper. (I may be wrong...)
> 
> 
> Correct, you're thinking about the subject line -- it has that
> multi-line behavior.
> 
> In git-cola we use a separate LineEdit for the "Commit summary" line,
> which has improved the commit messages users write and is good because
> the user doesn't need to worry about the "blank line between subject and
> body" Git commit message convention.
> 
> When the user presses "enter" in the subject line it jumps to the
> "Extended description" TextEdit, so it still "feels" like a single
> widget.  Likewise, up-arrow from the first line of the Extended
> description also jumps to the summary LineEdit.  We also have a "Ctrl-L"
> global hotkey to jump back to the subject line (same hotkey as Web
> browsers for the "hot" action of focusing the URL).

I'm not sure how good this idea is. I feel like we should keep it simple 
and trust the user to know what they are doing. Two textboxes seems like 
a lot of clutter for not that much benefit. I've not seen many people 
complain about hitting the extra "enter". Plus, we get to keep our 
message buffer the same as when a user would use a plain text editor.

One idea I have for dealing with users wanting a longer subject line is 
to do something like git-format-patch's subject line is formatted (this 
could be an mbox thing, and not send-email specific). When the subject 
is too long, the subject is broken in multiple lines, but the first 
character on the next line is a space, so it signifies a continued 
subject.

Something like:
Subject: foo bar baz
 abcd  

Which gets converted to "foo bar baz abcd" in the commit message.

> 
> Using two widgets is a bigger rework for git-gui, but should be
> considered for future enhancement.
> 
> We also deal with the "Amend a commit" issue through the word-wrap
> approach.  It's actually a paragraph reflow (not a line-by-line wrap) so
> adding words is fine and easy and does the natural expected thing --
> when amending it'll still feel like a long flow line and when committed
> it'll wrap with newlines at the configured column.

Yes, a paragraph reflow is what I had in mind. Without it editing 
already written lines is a pain.

> > > But then again, the user might get frustrated when the resulting
> > > commit message looks different than what it appeared in git-gui.
> > > 
> > > Honestly I'd prefer just wrap the first line as well. If the user gets
> > > frustrated that the first line gets wrapped there are two options:
> > > - Refrain from writing such a long line
> > > - Disable word wrapping (it should be configurable, like you said)
> > Configurable wrapping point - yes, would be nice (a feeling of control, that
> > I'd probably never change ;-).
> > > 
> > > Thoughts?
> 
> 
> Those are the same controls git-cola has.
> - Commit message word-wrap can be turned on/off.  Defaults to on.
> - The line length is configurable.  Defaults to 72.
> 
> Regarding, "the user might get frusted when the resulting commit message
> looks different" -- I don't think that's really a concern in practice
> but that might be we have a dedicated LineEdit for the subject line.

The aim is to have the commit message be exactly what the user sees. But 
I'm not sure how feasible that is considering the tools/APIs we have to 
work with.
 
> For git-gui, it seems fine since Git already has conventions about how
> the subject line gets wrapped, so tools will still see the wrapped
> subject line as a logical "single line".
> 
> The "Extended description" commit message editor is WYSWIYG, but if the
> widget is smaller than the configured value then we still wrap the
> committed message using the configured value, which is what the user
> would likely expect even though the visual wrapping is smaller.
> 
> We also special-case trailers like "Signed-off-by:" and other common
> trailers since user names can get long, and users sometimes use things
> like "See-also:" and paste a long URL that we don't want to wrap.

Nice catch! Didn't think of that.

> Lastly, we have a convenient session-only checkbox to temporarily 
> disable
> wrapping for a commit that does not persist across restarts.  The idea
> is that sometimes you might use the GUI for a one-off commit where you
> want to disable the wrapping for whatever reason, but don't want to
> change your configuration.

Sounds like a good idea, but I wonder how we can fit it into git-gui's 
current UI layout.

-- 
Regards,
Pratyush Yadav
