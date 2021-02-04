Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D4C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A703C64F4C
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhBDAMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhBDAMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:12:13 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10D8C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 16:11:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so1413542wmd.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GOW2I3mpBfBCYAD52h5UKW6R4yI0escdJG7Vj3yr7Qw=;
        b=P217/4VHsXszglwWwF5g+XsCqmhNr86y5Sbp/IUrIGtieDTUW0yZTdOnL4aPIQldq7
         +2K7KfURSx/60pySPLznEaHi1IB6JhQENICMP8Vg0cwHnRpU64dzgWEM1wO5obFVDX2/
         sF9O8O0qIxDooy5lCbFP2Lir8cVtRgropFkaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GOW2I3mpBfBCYAD52h5UKW6R4yI0escdJG7Vj3yr7Qw=;
        b=K+URb10LdlnNLan0Q6ssmEZCcH/bykdQz/1s0ZE9q3AfIjyZhwRjMWw51ZnpR9riuB
         Owc4pbfRWHLfbaA77FKLpocSewjHJf573WsggIrLQPBAS6c2GwEcf2HqXe8bIDvsbjt0
         px1IWreim53FtpJgYutbZlfbjjVRqLqIfvtw1diW+Z5+Q8XDS3sc9OCWHG6GJ12R8t5n
         FGMgm3/CyK6eJnkVvH44tRxdbZvPbxIps42/t1xvMlg+CZvmk4wXhAIKSEFASla6pICe
         Rof6ADk1GmcKEUBFDOzmnCXztIzyRUasZxNgQP2MZfkIYDZRZSnCqubm4S6NBSyerYG6
         FYnw==
X-Gm-Message-State: AOAM532+lQBQF+Q8+ikSyd1ZvEC5fuC0SM4Uvpw4IxhxnJ0iysHLGdRb
        mP5QQA0XQHxMSD2GGbC/4JRcXR9kWAldDCdEOxrQeA==
X-Google-Smtp-Source: ABdhPJxqEkEARYFfQJkfVxNuLfyAy3E/0+QbIoS3nc/UA9YJQoU44bcwrS0FV2ViapEEVWzkpl45y5DDQPhUnRdxopo=
X-Received: by 2002:a1c:b6c5:: with SMTP id g188mr3729372wmf.27.1612397491550;
 Wed, 03 Feb 2021 16:11:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.864.git.1612371600332.gitgitgadget@gmail.com>
 <xmqqpn1gbzdh.fsf@gitster.c.googlers.com> <BD039BE8-643F-4F61-A0DB-E3581C6B6B10@feiyangxue.com>
In-Reply-To: <BD039BE8-643F-4F61-A0DB-E3581C6B6B10@feiyangxue.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 4 Feb 2021 00:11:20 +0000
Message-ID: <CAE5ih7-F9efsiV5AQmw3ocjiy+BT6ZAT5fA0Lx0OSkVTO8Kqjg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: handle non-unicode characters in p4 cl
To:     Feiyang Xue <me@feiyangxue.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Feiyang via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Feiyang <github@feiyangxue.com>, Ben Keene <seraphire@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Scott Lamb <slamb@slamb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've started getting this quite a lot as we switched to a new P4
server and I suspect that the i18N options are incorrect. So I think
this would be welcome.

A test case would be useful, as debugging these decoding problems is a
bit of a nightmare.

Luke

On Wed, 3 Feb 2021 at 22:42, Feiyang Xue <me@feiyangxue.com> wrote:
>
>
>
> On Feb 3, 2021, at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Feiyang via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> From: Feiynag Xue <fxue@roku.com>
>
> P4 allows non-unicode characters in changelist description body,
> so git-p4 needs to be character encoding aware when reading p4 cl
>
> This change adds 2 config options, one specifies encoding,
> the other specifies erro handling upon unrecognized character.
> Those configs  apply when it reads p4 description text, mostly
> from commands "p4 describe" and "p4 changes".
>
> Signed-off-by: Feiynag Xue <fxue@roku.com>
> ---
>
>
> Adding a few people who had meaningful (read: needs some Perforce
> knowledge) changes to this part of the codebase to Cc: to ask for
> their reviews.
>
>
> Adding Yang Zhao <yang.zhao@skyboxlabs.com>, who had made character
> encodings related changes for paths.
>
> Adding Scott Lamb <slamb@slamb.org>, who had made changes to this
> =E2=80=9Cp4CmdList()=E2=80=9D method.
>
>
>
>    git-p4: handle non-unicode characters in p4 changelist description
>
>    P4 allows non-unicode characters in changelist description body, so
>    git-p4 needs to be character encoding aware when reading p4 cl.
>
>    This change adds 2 config options: one specifies encoding, the other
>    specifies erro handling upon unrecognized character. Those configs app=
ly
>    when it reads p4 description text, mostly from commands "p4 describe"
>    and "p4 changes".
>
>    ----------------------------------------------------------------------=
--
>
>    I have an open question in mind: what might be the best default config
>    to use?
>
>    Currently the python's bytes.decode() is called with default utf-8 and
>    strict error handling, so git-p4 pukes on non-unicode characters. I
>    encountered it when git p4 sync attempts to ingest a certain CL.
>
>    It seems to make sense to default to replace so that it gets rid of
>    non-unicode chars while trying to retain information. However, i am
>    uncertain on if we have use cases where it relies on the
>    stop-on-non-unicode behavior. (Hypothetically say an automation that's
>    expected to return error on non-unicode char in order to stop them fro=
m
>    propagating further?)
>
>    ----------------------------------------------------------------------=
--
>
>    I tested it with git p4 sync to a P4 CL that somehow has non-unicode
>    control character in description. With
>    git-p4.cldescencodingerrhandling=3Dignore, it proceeded without error.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-864%2Ff=
eiyeung%2Fdescription-text-encoding-handling-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-864/feiyeu=
ng/description-text-encoding-handling-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/864
>
> Documentation/git-p4.txt | 13 +++++++++++++
> git-p4.py                | 12 +++++++++++-
> 2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f89e68b424c..01a0e0b1067 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -638,6 +638,19 @@ git-p4.pathEncoding::
> to transcode the paths to UTF-8. As an example, Perforce on Windows
> often uses "cp1252" to encode path names.
>
> +git-p4.clDescEncoding::
> + Perforce allows non-unicode characters in changelist description.
> + Use this config to tell git-p4 what encoding Perforce had used for
> + description text. This encoding is used to transcode the text to
> + UTF-8. Defaults to "utf_8".
>
>
> Would it still work if you replaced "utf_8" here with "UTF-8"?  If
> we can use "UTF-8", this description (and the code that does so)
> would read much less awkward, I would think.
>
>
> I doubt =E2=80=9CUTF-8=E2=80=9D would work; I do believe the lower case =
=E2=80=9Cutf-8=E2=80=9D would.
>
> Looking at Python3 documentation on encodings, UTF-8 is specified as =E2=
=80=9Cutf_8=E2=80=9D.
> It allows aliases of using dash to replace underscore, as pointed out by =
the
> samge page: https://docs.python.org/3/library/codecs.html#standard-encodi=
ngs
> > Notice that spelling alternatives that only differ in case or use a hyp=
hen
> > instead of an underscore are also valid aliases; therefore, e.g. 'utf-8=
=E2=80=99
> > is a valid alias for the 'utf_8' codec.
>
> I used underscore one =E2=80=9Cutf_8=E2=80=9D for consistency reason: thi=
s file already has
> uses of =E2=80=9Cutf_8=E2=80=9D.
>
>
>
> +git-p4.clDescNonUnicodeHandling::
> + Perforce allows non-unicode characters in changelist description.
> + Use this config to tell git-p4 what to do when it does not recognize
> + the character encoding in description body. Defaults to "strict" for
> + stopping upon encounter. "ignore" for skipping unrecognized
> + characters; "replace" for attempting to convert into UTF-8.
> +
> git-p4.largeFileSystem::
> Specify the system that is used for large (binary) files. Please note
> that large file systems do not support the 'git p4 submit' command.
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93ac40..abbeb9156bd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -206,6 +206,13 @@ def decode_path(path):
>                 print('Path with non-ASCII characters detected. Used {} t=
o decode: {}'.format(encoding, path))
>         return path
>
> +def decode_changlist_description(text):
> +    """Decode bytes or bytearray using configured changelist description=
 encoding options
> +    """
> +    encoding =3D gitConfig('git-p4.clDescEncoding') or 'utf_8'
> +    err_handling =3D gitConfig('git-p4.clDescEncodingErrHandling') or 's=
trict'
> +    return text.decode(encoding, err_handling)
> +
> def run_git_hook(cmd, param=3D[]):
>     """Execute a hook if the hook exists."""
>     if verbose:
> @@ -771,7 +778,10 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b',=
 cb=3DNone, skip_info=3DFalse,
>                 for key, value in entry.items():
>                     key =3D key.decode()
>                     if isinstance(value, bytes) and not (key in ('data', =
'path', 'clientFile') or key.startswith('depotFile')):
> -                        value =3D value.decode()
> +                        if key =3D=3D 'desc':
> +                            value =3D decode_changlist_description(value=
)
> +                        else:
> +                            value =3D value.decode()
>                     decoded_entry[key] =3D value
>                 # Parse out data if it's an error response
>                 if decoded_entry.get('code') =3D=3D 'error' and 'data' in=
 decoded_entry:
>
> base-commit: e6362826a0409539642a5738db61827e5978e2e4
>
>
