Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E6D1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfILT0e (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:26:34 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33880 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfILT0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:26:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id g14so11463092vsp.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ncddy0qnsjP+sb2gYGL72x+CI4p25dDlu6eKdXIBtAA=;
        b=NoU0s/26kqSafhI0NL+wRzhHadF37RM6zX+yFHK6w4H66QjR4h3a8z/rfEx9hQKCAQ
         vNRJoU7K5QQOFeknpNd0aoT19M0yaYktq2pr5tYldQXZgaKyCbioANi0L4yFOSfmYt1j
         rVJQUxQ5sFnXvhZGrDLfdxB2+iUjCvCuTSp/9Wk2zAuOw1sISg+QFusH9ruaY+imom88
         Gf/FIQlHBa3Txr4KbZPv9JllrusKssSH4jK04S86p/Lr5BhZx5CKB5Prn6pV57KbGCcg
         R9odBlyL3yukICI6Jr9mbR9/77JHz+txXeBq7SM63rh+HWxkNGFcyEcb/I1m9n+qgiwb
         ojgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ncddy0qnsjP+sb2gYGL72x+CI4p25dDlu6eKdXIBtAA=;
        b=r61Aoxw4zMfXtQ27z8aiv+2yaYt1F/8E2rxcCGWUY7iVlUYpgpHveDAtam2qjqe3xC
         tp+V8gs72vSsiLQE2o5shdb8/OFK8yVHWx58uSyND539SizA2ecY8n30SEPlo4Max5D5
         H7T5bJAa8Iy8EMdDC7ujogx0/0weF9SSAwVrgk9irtgpgjZgN+tZjyBeyOARgA0hubNw
         StEk0Al1Jk4tEJQBb4B88gfsB9zLifYOpV2rtFEs7xQQqd+MkzF5Aetz19wNBcy0wIx4
         stVGCJ5GLGnyunrpNmYm3Dm0eLMS5sZ2pdCAIadLRLJeZwBPzPiUiIl8ItlLwpZGPgD0
         uMsA==
X-Gm-Message-State: APjAAAWna29LkUYf0prdM0TD6dEYj7Bz6J/1usjYI2HAUf6EIdbRTNp6
        Fn0p2LRlb4uUgGlXfeonrZ2rsKGSYHWBybZLe4M=
X-Google-Smtp-Source: APXvYqyamnj9+PwVIuuNqrPYvACECLnKg0Sp96mwl3K1Eupj2osgo3QdaRW9jLiZ3hWh7UflfSgmZI8EAUQKESIoJ5A=
X-Received: by 2002:a67:2e43:: with SMTP id u64mr24551063vsu.75.1568316393668;
 Thu, 12 Sep 2019 12:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <01e3c41d-af69-f9b3-31e6-12192e566f92@kdbg.org>
In-Reply-To: <01e3c41d-af69-f9b3-31e6-12192e566f92@kdbg.org>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Sep 2019 21:26:22 +0200
Message-ID: <CAKPyHN0gX087_-tn=Q7gt7dJJaFg5idgz-E8zfTfRQxkCZb57A@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 6:50 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.09.19 um 22:10 schrieb Bert Wesarg:
> > The commit message widget does not wrap the next and has a configurable
> > fixed width to avoid creating too wide commit messages. Though this was
> > only enforced in the GUI. Now we also check the commit message at commit
> > time for long lines and ask the author for confirmation if it exceeds the
> > configured line length.
> >
> > Needs Tcl 8.6 because of `lmap`.
> >
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  git-gui.sh     |  4 ++--
> >  lib/commit.tcl | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index 5bc21b8..a491085 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -31,8 +31,8 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
> >  ##
> >  ## Tcl/Tk sanity check
> >
> > -if {[catch {package require Tcl 8.4} err]
> > - || [catch {package require Tk  8.4} err]
> > +if {[catch {package require Tcl 8.6} err]
> > + || [catch {package require Tk  8.6} err]
> >  } {
> >       catch {wm withdraw .}
> >       tk_messageBox \
> > diff --git a/lib/commit.tcl b/lib/commit.tcl
> > index 83620b7..fa9760b 100644
> > --- a/lib/commit.tcl
> > +++ b/lib/commit.tcl
> > @@ -215,6 +215,16 @@ A good commit message has the following format:
> >               unlock_index
> >               return
> >       }
> > +     if {[tcl::mathfunc::max {*}[lmap x [split $msg "\n"] {string length $x}]] >= $repo_config(gui.commitmsgwidth) \
>
> This has an off-by-one error: When I fill the edit box to the limit, but
> not beyond it, I get the warning popup. I guess this should be '>', not
> '>='.

Thanks. As Pratyush wont pull this one, I separated it and keep it in
a branch in my fork:

https://github.com/bertwesarg/git-gui/tree/bw/warn-wide-commit-message

Bert

>
> > +         && [ask_popup "Commit message contains lines longer than $repo_config(gui.commitmsgwidth) characters.
> > +
> > +You may change this limit in the options.
> > +
> > +Continue to commit?
> > +"] ne yes} {
> > +             unlock_index
> > +             return
> > +     }
> >
> >       # -- Build the message file.
> >       #
> >
>
> -- Hannes
