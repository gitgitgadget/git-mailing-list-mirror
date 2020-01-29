Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73CC35240
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA16320720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="MdOkInwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgA2KNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:13:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2KNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:13:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so19512528wru.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 02:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg79JxiRKoD6Bh7korOv94x790Dc9eZvXXnWDGU6ACY=;
        b=MdOkInwbeYZeZ/NybLCzzhBk6SOfKNdTagBSMmXV9BAsVVT4EvOeblAVykAWJpBgXX
         g4oJ+Ozgz1853MhmFhBE81krwgD9E3pdFRIYlY6UXGkyJyQelDOMATehrVlMT8tJBaGS
         cu6Hw5oAa6MEeffZI1aPHItULJFINHsolKhvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg79JxiRKoD6Bh7korOv94x790Dc9eZvXXnWDGU6ACY=;
        b=uDTjBTKY7nIvkc4ybNabDZ/WJi3qIgfP5zaXdx1fGzpsxOovArEuDQrm7iwq5CrCE4
         pY0Rc8tYme6xfyEiXXRN8nOWRs0tE4kBLdICixSyuTT8faNibkSqQZ9j3yx/Gs0Xp2Ky
         U1IR2KEACTJdak3oU5HbOappKUKoVchBMtYxZ/KiuBZKkdH7AxijxAXmOnZIGEUzeXZ7
         DJjn+b93yxy+gUPxm7sytSfWeC7hMpjBsaeC2bH0vGf9u3n9da8CXzhfOnK//aH0/uHP
         27H36HFQ1oLV7ax/ChfheNb/cWtATuiu0cVj8nR8JzCUDkd+q9zsfJ2FkXXyHgpszd/N
         MZBw==
X-Gm-Message-State: APjAAAUb4qr50pkuUSiINldG1ZPjPahMHqbJEW7hhtNWASqc7uIgZrCb
        0nsIo5pWjv5bMhFTBnW8mnPjaUjkXq7fxM5wsmDy0Q==
X-Google-Smtp-Source: APXvYqx0wRJsbZpv1Y67JOaz9KsvipFyNEdqBhtRu/bmiagER9eImGsDH/dHqQjS3NK+stD78fdnTIzAz8kF+BBhvMY=
X-Received: by 2002:a5d:5044:: with SMTP id h4mr32769339wrt.4.1580292818526;
 Wed, 29 Jan 2020 02:13:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com> <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 29 Jan 2020 10:13:27 +0000
Message-ID: <CAE5ih79a4SeiAnC_c+XHXAiibeNBg-h1ZjMsv2pHMNtHGmqX1w@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrey Mazo <ahippo@yandex.com>, Git Users <git@vger.kernel.org>,
        Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Jan 2020 at 23:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> [jc] asking for help from those who made non-trivial changes to "git
> p4" in the past 18 months or so for reviewing.

This looks fine to me. I've not actually tested it.

Ack.

Luke


>
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Ben Keene <seraphire@gmail.com>
> > Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
>
> "git shortlog --no-merges" would show that the convention is to
> downcase "Add".
>
> With two consecutive non-words (i.e. 'pre' and "pedit'), it really
> feels an unpronounceable mouthful to a non-perforce person like me.
>
> On the core Git side, "git commit", which is the primary command
> that is used to create a new commit, has two hooks that helps to
> enforce consistency to the commit log messages:
>
>  - The "prepare-commit-msg" hook prepares the message to be further
>    edited by the end-user in the editor
>
>  - The "commit-msg" hook takes what the end-user edited in the
>    editor, and can audit and/or tweaks it.
>
> Having a matching pair of hooks and making sure the new hooks have
> similar names to these existing ones may help experienced Git users
> adopt the new hooks "git p4" learns here.
>
> What makes "p4-pre-pedit-changelist" a good name for this hook?  "In
> pure Perforce without Git, there is 'pre-pedit-changelist' hook that
> Perforce users are already familiar with" would be a good answer but
> not being P4 user myself, I do not know if that is true.
>
> Also, "git commit" has a mechanism (i.e. "--no-verify") to suppress
> the "auditing" hook, and it serves as an escape hatch.  The new hook
> "git p4" learns may want to have a similar mechanism, to keep its
> users productive even when they have broken/stale/bogus hook rejects
> their legitimate log message, by allowing them to bypass the
> offending hook(s).
>
>
> > Add an additional hook to the git-p4 command to allow a hook to modify
> > the text of the changelist prior to displaying the p4editor command.
> >
> > This hook will be called prior to checking for the flag
> > "--prepare-p4-only".
> >
> > The hook is optional, if it does not exist, it will be skipped.
> >
> > The hook takes a single parameter, the filename of the temporary file
> > that contains the P4 submit text.
> >
> > The hook should return a zero exit code on success or a non-zero exit
> > code on failure.  If the hook returns a non-zero exit code, git-p4
> > will revert the P4 edits by calling p4_revert(f) on each file that was
> > flagged as edited and then it will return False so the calling method
> > may continue as it does in existing failure cases.
>
> The githooks(5) page should talk about some of these, I would think.
>
> >  git-p4.py | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index 40d9e7c594..1f8c7383df 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
> >          tmpFile.write(submitTemplate)
> >          tmpFile.close()
> >
> > +        # Run the pre-edit hook to allow programmatic update to the changelist
> > +        hooks_path = gitConfig("core.hooksPath")
> > +        if len(hooks_path) <= 0:
> > +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> > +
> > +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
> > +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
> > +            for f in editedFiles:
> > +                p4_revert(f)
> > +            return False
> > +
> >          if self.prepare_p4_only:
> >              #
> >              # Leave the p4 tree prepared, and the submit template around
> >
> > base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
