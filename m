Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D15C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC09A208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZcB1rpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgBTXNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:13:46 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34201 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBTXNp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:13:45 -0500
Received: by mail-oi1-f175.google.com with SMTP id l136so171621oig.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rj+4cd86AsZyJDsUk73bMPWXV2ZR/Srtw1AuI271Cwc=;
        b=iZcB1rpP8JxQwKW2m+SyK1leM4K1ZTjXR2Tqvn1o4TNdoKsABz1dUxUx9130NORR21
         mZ7RtOntU3RLDKiccYwhewlr0ojqPy0pDHCu8yXSiuJnNa4lSn6seF2wXxOTn7LbtNfR
         h9WODzTzyxiAvTULqbaHJ62iDTk3eXt51eCRxxFYEeA60xsYNGENnhZ+jtP5JHPAD36a
         K5Q4z3WBdk9gsEqNU+t3soJMVyAOBv3Y63ARPk99PT6Yl39HfS+30w5ALlKz9ZoPomtS
         dGg1qhqNyjWn0j0RXdEIspPL1pY6ne0iIVjs7HywASW02G/uDrQCMAJ5u+feY0caXs3y
         hEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rj+4cd86AsZyJDsUk73bMPWXV2ZR/Srtw1AuI271Cwc=;
        b=Mq2Fe+yknGvWrRE5J7thh5hw7Vq+D1SpUED1eFLh8XSGzsgqvt/6ikjlSWkkd5ETN7
         9/NACZRlBddGnh7ygh7coeCz9RaDWrTmQgQpHFmM3qyx4SSUCj4y/voNcCHSXhj430o6
         0IkYOjndgSgx823i+4NEzikj+m6PgbeouBE5+V7fPx4ARjnKhzgfH4cOG+5US6iQMkDC
         XT6MAqTv8LYmXLFQ0DHpT3cRDAwWvDIxTHBDFPYkjFCbTHtTyvTgajpJ/GO0jJ9+g+Jk
         kT6pMC/3kydRh8SDOKfLt7/YhGwAjU8YsSTwpVH424r7E1/WWPlYSKmG8Mpu2Ir/a0Sy
         7jMQ==
X-Gm-Message-State: APjAAAUB4MWRxmWrd7Br+Oo3lEJ/3aUqSGWBECoS75+w/cNSVMaKZ+FB
        VATyfNFCMuj4p/Sjw82pFZicPrCyEiGoCVLm1llc+9Ju
X-Google-Smtp-Source: APXvYqxpEZwkd2umKNV+x5E/XF+837bweGxbJD1uE27nVb/ogOXc4h+gtuqvGWSIeeQVPdI5JOY1POIG5iVUqq21s+g=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr4011353oig.39.1582240424530;
 Thu, 20 Feb 2020 15:13:44 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com> <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 Feb 2020 15:13:33 -0800
Message-ID: <CABPp-BFwNMTRUUonbt3Di8yWDjyF7n2cNQVoLDfHEsk3RVEchQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 12:05 PM Adam Milazzo
<Adam.Milazzo@microsoft.com> wrote:
>
> > Tying permission override to e.g -ffd would be a really bad idea. Peopl=
e would start adopting that for the permission override reason, then someon=
e is going to accidentally nuke a git submodule with unpushed changes.
>
> Fair enough. I'm not arguing that it must necessarily be any kind of over=
loading of -f. It could just as well be a separate option. (Personally I'd =
say overloading -f to make "-f -f" mean "also delete untracked git reposito=
ries" was the bad idea, since that is not the obvious and intuitive meaning=
 of "--force", whereas "try harder to delete files you would normally delet=
e" _is_ the intuitive meaning, but the history can't be changed.)

Yeah, arguing to change existing behavior (as you started with by
labelling the thread with "BUG") will probably get you a lot of
pushback, but let me address your new angle of suggesting a new
option...

> > Also, another way to look at this; currently 'git clean -fd' behaves th=
e same on untracked directories as 'rm -rf' does and I think that's a good =
model for how to behave.  Why should they be different?
>
> I would ask "why should they be the same?",

I think it matches user expectation of how the filesystem works.  But
if we did want to implement a new flag, there's a question of what it
should be and what it should do.  Your "put the repository back to a
pristine state" isn't enough to really go on from an implementation.
Clearly you don't mean that it should also do a 'reset --hard' --
despite the fact that running a reset fits this definition, but even
in terms of untracked files you've still left out the "slippery slope"
angle from my previous response in what you've addressed here.  Let's
say we did implement a new flag that said we should override standard
permissions.  In such a case, shouldn't ACLs also be overridden?  Can
we handle that in any semi-portable fashion?  Assuming we do attempt
to override ACLs, do we destroy portability of git (I don't know a
whole lot about ACLs, so I don't know, but I thought they varied a lot
between systems) -- and initiate a never-ending treadmill of needs to
handle more kinds of ACLs?  If we don't try to overrule ACLs, doesn't
that defeat your whole argument that "git clean" (with various levels
of forcing) is about trying to do as much as possible to put the
repository in a clean state?  Ignoring ACLs for a minute, what if we
attempt to override the permissions by marking directories as
writable, but find out the user isn't the owner of the directory and
thus can't change its permissions?  Do we try harder by attempting to
invoke chmod under sudo to see if we can override the permissions?  At
what point do we give up?  What's the clear line...and why does that
line not just get drawn at not changing permissions at all?

>  because there's no obvious reason why behavior of "git clean", whose pur=
pose is to put a repository back to a pristine state, should always behave =
the same way as "rm", whose purpose is to delete a specified set of files, =
and more to the point there is no reason why they should have no option to =
behave differently. I am not arguing for the default behavior of "git clean=
" to change, since that could be seen as a breaking change. Also, they are =
already different. "git clean" will remove a read-only file. "rm" will not =
(without confirmation), although "rm -f" will.

Here you've changed the goalposts slightly.  I didn't compare "git
clean" to "rm", I compared "git clean -fd" to "rm -rf" on untracked
directories.

However, you are right that even those two aren't the same; "rm -rf"
will recurse into a git submodule and delete it while "git clean -fd"
won't.  In other words, "git clean -fd" avoids bringing the repository
back to a pristine state in a certain circumstance; it's actually more
cautious than rm.


I'm sympathetic to "golang does a dumb thing I don't like" (the exact
situation you hilight has bothered me before too), but it's not clear
at all to me where or how git might help you cope with that.  To me,
golang did a dumb and you have to manually undo the dumb.  If you want
something smarter on the git side instead of the golang side, all the
stuff I mentioned above are things that would need to be addressed in
any possible solution that I'm just not seeing.


Hope that helps,
Elijah
