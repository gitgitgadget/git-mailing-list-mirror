Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC78C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9BD6135D
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhFIHkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:40:33 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48009 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230233AbhFIHkc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jun 2021 03:40:32 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0FA142455;
        Wed,  9 Jun 2021 03:38:37 -0400 (EDT)
Received: from imap38 ([10.202.2.88])
  by compute5.internal (MEProxy); Wed, 09 Jun 2021 03:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=jdEojv7A8VZ5jTW1wRobNMaffufFhGS
        bdJXqnZzKoh0=; b=Vg/nOp8ZVZO1KyCxBY8/JFjvGGUqN1lcVfZRwQ2DbXuJMpF
        cxaOOexYm3olS+veQTEyYuKxnCXmMs7+tOuPae862HoPUDvgEQEpRqSEDi60iRCr
        BLah52j3I6q6GXbws+80kSkr2I2tzp9h+3BjoGMIbeAUXey3pqrc1Vj792rh2ikK
        wgsC+22pL1kh6kjAlpJzpzZUN++iZBZa7b/0iydzP17ZCLD8hHxVUQQInHNPuIyw
        8T8JTss7arAuGaOZioGRlsmagZPkQfXXt7iBewEjy6hsaM0Vn7YpPa9nRbWrHz2z
        +7nqQ04OSW3nuZG5zJLGIRrJejl5DT+LxyEFqng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jdEojv
        7A8VZ5jTW1wRobNMaffufFhGSbdJXqnZzKoh0=; b=DMDER2ZxcHTLF7XiVVLHCf
        e5DcfQtKW0ikPsmPEUTuVVsZKs3FOcHegrKAleklBiXYhcpXjuP1X/eQgHyx0mx/
        Kb9eECDOoUzn1WcEVK/Zed6Fj0OpnEt3TJH1V7lyxPi3oEFWj3hc0oMsSG4itZ0O
        wxRNBHmpXMiyAOC0UbS7DuvTfipycDfcCQFbxHmY4yLLvIz75LP4aEFlLjFgEb6a
        B9sMdrF6Z7r0MJZIygkm5Fieb2FgfJjurWoWg8rEhxNO9SbEtip3Rl7CcZ39Na1k
        tys1ABTl4blB4/N6F+I7I3N8WvnfACY/Ux+KaSMxGDCOH8WH4XADzJlX9g7HSYhg
        ==
X-ME-Sender: <xms:_W_AYNq5CTWObxVeDUM0M9s8VLthqldk0kqk2GkclFFWgK5KzKFM_w>
    <xme:_W_AYPoZDPuQpHZGrwYpdTjn6ZLd8nc06cLy4R7mzVTDbs6dttNQjDC_TuOdZp_Qd
    PjfbYhXGVbqEwtWzyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedutddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreerjeenucfhrhhomhepfdfirhgvghcujfhurhhrvghllhdfuceoghhrvghgsehh
    uhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpefgtefhjeefgfdvieelvdektd
    evueevleetgfegtdejfffgkeegleeujefhtdfffeenucffohhmrghinhepgedthhhurhhr
    vghllhdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:_W_AYKMDVnn1GAG_lC7AaA0eXLXPEYBg_dwHhLYHJWju_8DgOfz3hA>
    <xmx:_W_AYI5qC-rcwfi2HbFlMDXLUyWVDC71tXh6JWvu0GlQwMTjOyzxFA>
    <xmx:_W_AYM62w4NOwYpmsTQze09X2a-r-YCtX2Suj0vNkW88RfB1ec8Tlw>
    <xmx:_W_AYBXSl1evPV9uDMZj4tE67p78SaYjSxNvQ7NUOnJbTmrDdRye5w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 45D88CA0060; Wed,  9 Jun 2021 03:38:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <26dbf49f-4972-4960-9383-2b69a3e6043c@www.fastmail.com>
In-Reply-To: <xmqqpmwvnbaz.fsf@gitster.g>
References: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
 <20210608211440.37985-1-greg@hurrell.net> <xmqqpmwvnbaz.fsf@gitster.g>
Date:   Wed, 09 Jun 2021 09:38:16 +0200
From:   "Greg Hurrell" <greg@hurrell.net>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[RFC_PATCH]_gitweb:_use_HEAD_as_primary_sort_key_in_git=5F?=
 =?UTF-8?Q?get=5Fheads=5Flist()?=
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 9, 2021, at 2:15 AM, Junio C Hamano wrote:
> Greg Hurrell <greg@hurrell.net <mailto:greg%40hurrell.net>> writes:
> 
> > This seems to be a useful change, because I can't see anywhere else in
> > the gitweb UI where we actually indicate to the user what the "default"
> > branch is (ie. what they'll checkout if they run `git clone`).
> 
> The justification is a bit too weak to convince readers that using
> %(HEAD) as the primary sort key to list the branch first in the list
> view is *the* best way to solve the "it is unclear which one is the
> defaul branch" problem, though.  An obvious alternative would be to
> show '*' next to such a branch just like "git branch --list" does,
> without changing the sort order at all, for example.

Yeah, I'm not 100% convinced either. Displaying a "*" indicator
would be a straightforward change to `git_heads_body()`, but it would be
a break with the visual style of all the other tables in the UI.

On the other hand, boosting `HEAD` to the top like the proposed commit
does feel a bit arbitrary, given that the other list views in the UI
seem mostly to be sorted by recency. (But then again, what `HEAD` is
and what it means is quintessentially arbitrary, so maybe this _is_
appropriate.)

One thing I do notice is that there is already a `current_head` CSS
class applied to the corresponding row, so it would be possible for the
gitweb owner to make tha row stand out however they pleased.

In short, I am happy to amend the commit message but I fear the
rationale for it is a bit weak. If nobody chimes in with a resounding
endorsement, I am inclined to probably drop it.

> Wasn't your motivating example about tiebreaking between 'main' and
> 'master' that always point at the same commit?

Yes indeed, that was the original motivation, although after the fix
in 7c5045fc180ed09ed4cb5 the tie-breaking by refname already has the
equivalent desired effect, albeit coincidentally.

Perhaps the sort keys _should_ be `-committerdate`, then `-HEAD`, then
`refname` (implicit default); ie. `--sort=-HEAD --sort=-committerdate`
(which is the opposite order to what I have in the patch). I would have
prepared the patch in that way in the first place if my testing hadn't
been confounded by the fact that I was running an older version of Git
on the installation where I was trying it out.

I feel the argument for using `HEAD` as a tiebreaker is easier to make
than the case for using it as a primary sort key, because it is a less
invasive change. If there is support for that idea, I'll tweak the
patch.

Cheers,
Greg
