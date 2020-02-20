Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F46C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B901206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl/KSR/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgBTTpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:45:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38941 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgBTTpY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 14:45:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so4811940oty.6
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ydEnWKjDDEE5YwUUXOCc9fE2UVU+REBNzJQka7zE5dc=;
        b=Jl/KSR/nuFcbUiLOobAf1M5qUeo9fruBkCNC9WGRqIq0Tg4k4pYmbJ6Nozi1l78QBB
         UdSRQmdXeSn+CBt/x08joGaurJDWsNG2DJy0FNbMISw/cevCIwjsP37QmxGo0wcIqozM
         tdtOLmgp61A3MFaC4WuUvXeRGxcnDKUGRdESH45BRb19dvQdZWTwD7v7fWMKNJwTeizi
         mPb+DT8fJWcOhADToP8+yRJEuFV2aYmkwglQ4tbJRJT6XHIneX6rpSYxts8NLkr38VjX
         KqZN1trw02u4CmH+haLAYYXRPXfY1NRv0CTdL8nfogaNHqUqfY8i0AOpFRcpQW/fafL6
         nXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ydEnWKjDDEE5YwUUXOCc9fE2UVU+REBNzJQka7zE5dc=;
        b=gVLLLSYkJEAlhwDp09A9W0ayCckn/r+ZLf6MKkGLFgbqpv1MBqR4F/HJgxHgQ+VWtl
         vK5i8PCQIodWAtPW4hgzmi7dKAVZT3i/Bl20hNnyaM+Tu87K/1MlM1p37bi9uHkARm6c
         V3WHDYddJ/s8JghRnes5ehOb4sQfjzmE711RxdN0JAKMr3IkK5TcZAgfd7fIYwb7RvvD
         FL9g3aV9hgkJfPUcfv/zL7YOuFrSx1w25UpEyUs71prc3AtRAcgi4ksGkRdM/h26LB5M
         6IVgAeP298zXMDya0fLogT6PhhoMGnI5D6pysgpmsfPFhMcoiJvWMHFK/XR4GePHoFQs
         q5Pw==
X-Gm-Message-State: APjAAAXHj2eXwUxZgu2n6G1G28Trx8mfmIA4V2f/mRdxqUV/My0nlScr
        yIPUpdK762/T7qXSbMgWwh2EasJyyo02ulmONtQ=
X-Google-Smtp-Source: APXvYqxmkQ77WUUB8TPMUo/Jdpr/qIGQdbRZi6Oat+pk6TJn1tu5TCTc3NYuJDwQlw1XXi7V0YAVdVBIeu3l0UKjd5w=
X-Received: by 2002:a9d:7c81:: with SMTP id q1mr6773855otn.112.1582227923540;
 Thu, 20 Feb 2020 11:45:23 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 Feb 2020 11:45:12 -0800
Message-ID: <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 10:58 AM Adam Milazzo
<Adam.Milazzo@microsoft.com> wrote:
>
> > It is how UNIX-like filesystem works, isn't it?
>
> Sure, but it doesn't have to be how "git clean -d" works. In particular, =
"git clean -ffd" could be more forceful, or there could be another option o=
r a third level of force beyond the current two levels.
>
> It really comes back to this question: "How can I avoid the failure, give=
n that I am running 'git clean' from a script and not interactively?" The o=
nly answer I could find that's not unreasonable is to parse the text output=
 of 'git status -s' to find the untracked directories and then run 'chmod -=
R u+w' on each of those directories before running 'git clean -d'." I can d=
o that, but I still think a "force" (or other) flag that really forces the =
cleanup would be preferable, especially given that this isn't a completely =
idiosyncratic scenario but one that will happen more and more as go modules=
 are adopted (unless go is changed to stop putting them in read-only direct=
ories).


Tying permission override to e.g -ffd would be a really bad idea.
People would start adopting that for the permission override reason,
then someone is going to accidentally nuke a git submodule with
unpushed changes.

Tying it to -fd doesn't have that particular problem, but I'm worried
a bit about a slippery slope if we do it.  If we say that "git clean
-fd" should check and modify directory permission bits, should it also
check and modify any necessary ACLs?  What if the user in question
doesn't have perms, but the user in question is in sudoers -- should
git try to see if they can run chown or chattr under sudo too?

Also, another way to look at this; currently 'git clean -fd' behaves
the same on untracked directories as 'rm -rf' does and I think that's
a good model for how to behave.  Why should they be different?

$ git clean -fd unwritable-dir/
warning: failed to remove unwritable-dir/a: Permission denied
warning: failed to remove unwritable-dir/b: Permission denied
warning: failed to remove unwritable-dir/c: Permission denied
$ rm -rf unwritable-dir/
rm: cannot remove 'unwritable-dir/a': Permission denied
rm: cannot remove 'unwritable-dir/b': Permission denied
rm: cannot remove 'unwritable-dir/c': Permission denied
