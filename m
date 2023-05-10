Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BCEC7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 08:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjEJIPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEJIPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 04:15:11 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58310D8
        for <git@vger.kernel.org>; Wed, 10 May 2023 01:15:07 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba5e37f60f0so2294621276.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683706507; x=1686298507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blbbkMgn/tT9RLuBkweS1Ami+1C6zM5PuN6tNzUROAA=;
        b=pjzNbNuQ6cnYBPIYoqspLc5QR0aEyfToR28CoBMHuUURl8WDE0L5j74bRxLHDIzi2U
         FMiGGvuu/3/LZdyEl9RxNfGJiPcWtCaaWV016Id56nmsM0w+ZYYEi/bIj9QgCh822ZCe
         zeHSDVW25m7CLPYBl97XI6eql6F5yeWoCs+wcDwIBphnIzJgWOWR3TYOVvz+dywR5nfm
         ngfyzn4VNrNBidCs0RSAHQbJl68C6WVIxbaV7tqUX4Jec+UND8g8epbAHfDSXEpV4Ybg
         9AeyQ/9vyZ1aejTAxbQhynQWz62pPBe/KPclfltc7+GAuM33KCedkh4ylf1ThXsIGDYs
         00og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706507; x=1686298507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blbbkMgn/tT9RLuBkweS1Ami+1C6zM5PuN6tNzUROAA=;
        b=dYI+LnITbR4Nos8GjqOn81Xi5/CXJ34OpH8bXbNxXX6EbwSrFw5GKHhi7Nsm4iG+Cr
         h+71yect6oyYr3HI6jeNgDbewaYDR5uCVkazFaMeTbFaQFqt6eGToYkfveAvnEhbnDQU
         3XGE88Fpr6kq3qX3pjbTpFN5ZmiheDkj/CCCknJkav7C1aX6KRUdsZNf1D4qPn1ueUEc
         i/3Gn8jw27RreFcw+mhxUA/xfKadKLl7byNrDW63Eeu/F0Wwd2z+JipnoSttmuGjMy+u
         Avk8xw0UKbEqSQUA8fnUm/OTlrz9iIq3wY1JRsCVPNBZpI+5Wdl/LgJSsLfx28zDJHH5
         Llsw==
X-Gm-Message-State: AC+VfDwtMWeDsfrA2jyzW2UCQL1upAVurc87J+PsRZjMcTEO29hmDXjB
        /uvauOJCx1mZQmFBNrtqxegWUmApmQDe+BBoOrc=
X-Google-Smtp-Source: ACHHUZ7H+ixH+EeUol1bCHzBXGWUDBstHvvrImSBYc0h6en2gWiuliIfZ4CK8YROsTcgp5Rnq2Y6egfMDW6Mv5pNtXc=
X-Received: by 2002:a25:7413:0:b0:ba1:9d86:8df with SMTP id
 p19-20020a257413000000b00ba19d8608dfmr18684477ybc.8.1683706506615; Wed, 10
 May 2023 01:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1523.git.1682342241825.gitgitgadget@gmail.com> <pull.1523.v2.git.1683214104399.gitgitgadget@gmail.com>
In-Reply-To: <pull.1523.v2.git.1683214104399.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 10 May 2023 16:15:58 +0800
Message-ID: <CAOLTT8SA9MvGTJojYFzD=LtPG=WMdEwK-ufgTyHwhCEDRFG=yQ@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] transport: add --show-service option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        adlternaitve@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just ping for this patch...

ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=B9=B4=
5=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 23:28=E5=86=99=E9=81=93=EF=BC=9A
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Without using protocol v2, the git server needs to send a pktline
> "#service=3D$servicename" to the git client first. The servername
> here can only be selected in "git-receive-pack and "git-upload-pack",
> neither the git client nor the server depends on this servername to
> perform any functions. Howerver, , implementing this capability
> independently can be cumbersome for the git server, as seen in [1].
>
> To simplify this process, the `--show-service` option was added to
> git-receive-pack and git-upload-pack. This option can be used to
> send the '#service=3D$servicename' pktline, making the logic of the
> git server more concise. Note that this option can only be used
> together with --http-backend-info-refs and is not applicable when
> using protocol v2.
>
> [1]: https://gitlab.com/gitlab-org/gitaly/-/blob/master/internal/gitaly/s=
ervice/smarthttp/inforefs.go#L82
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [RFC] transport: add --show-service option
>
>     When the protocol is not v2, the git client requires that the first
>     pktline reply for info refs be "# service=3Dservicename", which requi=
res
>     the git server to implement pktline capability, e.g. [1] , which may =
be
>     a bit cumbersome.
>
>     Delegating this feature to git upload-pack and git receive-pack via
>     "--show-service" can simplify server implementation.
>
>     v1. add --show-service to git upload-pack and git receive-pack. v2.
>     amend the git commit message to explain the reason for adding the
>     option.
>
>     [1]:
>     https://gitlab.com/gitlab-org/gitaly/-/blob/master/internal/gitaly/se=
rvice/smarthttp/inforefs.go#L82
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1523%2F=
adlternative%2Fzh%2Finfo-ref-service-output-opt-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1523/adlte=
rnative/zh/info-ref-service-output-opt-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1523
>
> Range-diff vs v1:
>
>  1:  a2d33d6857a ! 1:  b8aa0e7e053 [RFC] transport: add --show-service op=
tion
>      @@ Commit message
>           [RFC] transport: add --show-service option
>
>           Without using protocol v2, the git server needs to send a pktli=
ne
>      -    "# service=3D$servicename" to the git client first. This often
>      -    requires the git server to implement it independently, but it c=
an
>      -    be delegated to the `git receive-pack` and `git upload-pack` to=
 complete
>      -    the work proactively. Therefore, the `--show-service` option is=
 added
>      -    to `git receive-pack` and `git upload-pack`, which can be used =
to send
>      -    the "# service=3D$servicename" pktline, making the logic of the=
 git
>      -    server more concise.
>      +    "#service=3D$servicename" to the git client first. The serverna=
me
>      +    here can only be selected in "git-receive-pack and "git-upload-=
pack",
>      +    neither the git client nor the server depends on this servernam=
e to
>      +    perform any functions. Howerver, , implementing this capability
>      +    independently can be cumbersome for the git server, as seen in =
[1].
>
>      -    Note that this `--show-service` option can only be used togethe=
r with
>      -    `--http-backend-info-refs` and it is not applicable when using =
protocol v2.
>      +    To simplify this process, the `--show-service` option was added=
 to
>      +    git-receive-pack and git-upload-pack. This option can be used t=
o
>      +    send the '#service=3D$servicename' pktline, making the logic of=
 the
>      +    git server more concise. Note that this option can only be used
>      +    together with --http-backend-info-refs and is not applicable wh=
en
>      +    using protocol v2.
>      +
>      +    [1]: https://gitlab.com/gitlab-org/gitaly/-/blob/master/interna=
l/gitaly/service/smarthttp/inforefs.go#L82
>
>           Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
>
>
>  Documentation/git-receive-pack.txt |  10 +++
>  Documentation/git-upload-pack.txt  |  13 +++-
>  builtin/receive-pack.c             |  14 +++-
>  builtin/upload-pack.c              |  17 +++-
>  http-backend.c                     |   7 +-
>  t/t5555-http-smart-common.sh       | 120 +++++++++++++++++++++++++++++
>  6 files changed, 171 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-recei=
ve-pack.txt
> index 65ff518ccff..e16d364f394 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -46,6 +46,16 @@ OPTIONS
>         `$GIT_URL/info/refs?service=3Dgit-receive-pack` requests. See
>         `--http-backend-info-refs` in linkgit:git-upload-pack[1].
>
> +--show-service::
> +       Output the "# service=3Dgit-receive-pack" pktline and the
> +       "0000" flush pktline firstly. Since the git client needs
> +       the git server to send the first pktline
> +       "# service=3D$servicename", this option allows the git
> +       server to delegate the functionality of sending this pktline
> +       to `git-receive-pack`.
> +       Note that this option can only be used together with
> +       `--http-backend-info-refs`.
> +
>  PRE-RECEIVE HOOK
>  ----------------
>  Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
> diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload=
-pack.txt
> index b656b475675..7052708d03e 100644
> --- a/Documentation/git-upload-pack.txt
> +++ b/Documentation/git-upload-pack.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git-upload-pack' [--[no-]strict] [--timeout=3D<n>] [--stateless-rpc]
> -                 [--advertise-refs] <directory>
> +                 [--advertise-refs] [--show-service] <directory>
>
>  DESCRIPTION
>  -----------
> @@ -44,6 +44,17 @@ OPTIONS
>         documentation. Also understood by
>         linkgit:git-receive-pack[1].
>
> +--show-service::
> +       Output the "# service=3Dgit-upload-pack" pktline and the
> +       "0000" flush pktline firstly. Since the git client needs
> +       the git server to send the first pktline
> +       "# service=3D$servicename", this option allows the git
> +       server to delegate the functionality of sending this pktline
> +       to `git-upload-pack`.
> +       Note that this option can only be used together with
> +       `--http-backend-info-refs` and it is not applicable when
> +       using protocol v2.
> +
>  <directory>::
>         The repository to sync from.
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9109552533d..eb45c1f72af 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2485,6 +2485,7 @@ static int delete_only(struct command *commands)
>  int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  {
>         int advertise_refs =3D 0;
> +       int show_service =3D 0;
>         struct command *commands;
>         struct oid_array shallow =3D OID_ARRAY_INIT;
>         struct oid_array ref =3D OID_ARRAY_INIT;
> @@ -2497,8 +2498,10 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
>                 OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_r=
efs, NULL),
>                 OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
>                 OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &rejec=
t_thin, NULL),
> +               OPT_BOOL(0, "show-service", &show_service, N_("show servi=
ce information")),
>                 OPT_END()
>         };
> +       enum protocol_version version =3D determine_protocol_version_serv=
er();
>
>         packet_trace_identity("receive-pack");
>
> @@ -2525,7 +2528,16 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
>         else if (0 <=3D receive_unpack_limit)
>                 unpack_limit =3D receive_unpack_limit;
>
> -       switch (determine_protocol_version_server()) {
> +       if (show_service) {
> +               if (!advertise_refs)
> +                       die(_("options '%s' and '%s' should be used toget=
her"), "--show-service", "--http-backend-info-refs");
> +               if (version !=3D protocol_v2) {
> +                       packet_write_fmt(1, "# service=3Dgit-receive-pack=
\n");
> +                       packet_flush(1);
> +               }
> +       }
> +
> +       switch (version) {
>         case protocol_v2:
>                 /*
>                  * push support for protocol v2 has not been implemented =
yet,
> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index beb9dd08610..e84eb3735b4 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -11,7 +11,7 @@
>
>  static const char * const upload_pack_usage[] =3D {
>         N_("git-upload-pack [--[no-]strict] [--timeout=3D<n>] [--stateles=
s-rpc]\n"
> -          "                [--advertise-refs] <directory>"),
> +          "                [--advertise-refs] [--show-service] <director=
y>"),
>         NULL
>  };
>
> @@ -22,6 +22,7 @@ int cmd_upload_pack(int argc, const char **argv, const =
char *prefix)
>         int advertise_refs =3D 0;
>         int stateless_rpc =3D 0;
>         int timeout =3D 0;
> +       int show_service =3D 0;
>         struct option options[] =3D {
>                 OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
>                          N_("quit after a single request/response exchang=
e")),
> @@ -32,8 +33,10 @@ int cmd_upload_pack(int argc, const char **argv, const=
 char *prefix)
>                          N_("do not try <directory>/.git/ if <directory> =
is no Git directory")),
>                 OPT_INTEGER(0, "timeout", &timeout,
>                             N_("interrupt transfer after <n> seconds of i=
nactivity")),
> +               OPT_BOOL(0, "show-service", &show_service, N_("show servi=
ce information")),
>                 OPT_END()
>         };
> +       enum protocol_version version =3D determine_protocol_version_serv=
er();
>
>         packet_trace_identity("upload-pack");
>         read_replace_refs =3D 0;
> @@ -50,7 +53,17 @@ int cmd_upload_pack(int argc, const char **argv, const=
 char *prefix)
>         if (!enter_repo(dir, strict))
>                 die("'%s' does not appear to be a git repository", dir);
>
> -       switch (determine_protocol_version_server()) {
> +
> +       if (show_service) {
> +               if (!advertise_refs)
> +                       die(_("options '%s' and '%s' should be used toget=
her"), "--show-service", "--http-backend-info-refs");
> +               if (version !=3D protocol_v2) {
> +                       packet_write_fmt(1, "# service=3Dgit-upload-pack\=
n");
> +                       packet_flush(1);
> +               }
> +       }
> +
> +       switch (version) {
>         case protocol_v2:
>                 if (advertise_refs)
>                         protocol_v2_advertise_capabilities();
> diff --git a/http-backend.c b/http-backend.c
> index 89aad1b42c7..74c2c7bb606 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -539,6 +539,7 @@ static void get_info_refs(struct strbuf *hdr, char *a=
rg UNUSED)
>         if (service_name) {
>                 const char *argv[] =3D {NULL /* service name */,
>                         "--http-backend-info-refs",
> +                       "--show-service",
>                         ".", NULL};
>                 struct rpc_service *svc =3D select_service(hdr, service_n=
ame);
>
> @@ -547,12 +548,6 @@ static void get_info_refs(struct strbuf *hdr, char *=
arg UNUSED)
>                 hdr_str(hdr, content_type, buf.buf);
>                 end_headers(hdr);
>
> -
> -               if (determine_protocol_version_server() !=3D protocol_v2)=
 {
> -                       packet_write_fmt(1, "# service=3Dgit-%s\n", svc->=
name);
> -                       packet_flush(1);
> -               }
> -
>                 argv[0] =3D svc->name;
>                 run_service(argv, 0);
>
> diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
> index b1cfe8b7dba..32431266eb9 100755
> --- a/t/t5555-http-smart-common.sh
> +++ b/t/t5555-http-smart-common.sh
> @@ -159,4 +159,124 @@ test_expect_success 'git receive-pack --advertise-r=
efs: v2' '
>         test_cmp actual expect
>  '
>
> +test_expect_success 'git upload-pack --advertise-refs --show-service: v0=
' '
> +       # With no specified protocol
> +       cat >expect <<-EOF &&
> +       # service=3Dgit-upload-pack
> +       0000
> +       $(git rev-parse HEAD) HEAD
> +       $(git rev-parse HEAD) $(git symbolic-ref HEAD)
> +       0000
> +       EOF
> +
> +       git upload-pack --advertise-refs --show-service . >out 2>err &&
> +       test-tool pkt-line unpack <out >actual &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect &&
> +
> +       # With explicit v0
> +       GIT_PROTOCOL=3Dversion=3D0 \
> +       git upload-pack --advertise-refs --show-service . >out 2>err &&
> +       test-tool pkt-line unpack <out >actual 2>err &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect
> +
> +'
> +
> +test_expect_success 'git receive-pack --advertise-refs --show-service: v=
0' '
> +       # With no specified protocol
> +       cat >expect <<-EOF &&
> +       # service=3Dgit-receive-pack
> +       0000
> +       $(git rev-parse HEAD) $(git symbolic-ref HEAD)
> +       0000
> +       EOF
> +
> +       git receive-pack --advertise-refs --show-service . >out 2>err &&
> +       test-tool pkt-line unpack <out >actual &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect &&
> +
> +       # With explicit v0
> +       GIT_PROTOCOL=3Dversion=3D0 \
> +       git receive-pack --advertise-refs --show-service . >out 2>err &&
> +       test-tool pkt-line unpack <out >actual 2>err &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect
> +
> +'
> +
> +test_expect_success 'git upload-pack --advertise-refs --show-service: v1=
' '
> +       # With no specified protocol
> +       cat >expect <<-EOF &&
> +       # service=3Dgit-upload-pack
> +       0000
> +       version 1
> +       $(git rev-parse HEAD) HEAD
> +       $(git rev-parse HEAD) $(git symbolic-ref HEAD)
> +       0000
> +       EOF
> +
> +       GIT_PROTOCOL=3Dversion=3D1 \
> +       git upload-pack --advertise-refs --show-service . >out &&
> +
> +       test-tool pkt-line unpack <out >actual 2>err &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect
> +'
> +
> +test_expect_success 'git receive-pack --advertise-refs --show-service: v=
1' '
> +       # With no specified protocol
> +       cat >expect <<-EOF &&
> +       # service=3Dgit-receive-pack
> +       0000
> +       version 1
> +       $(git rev-parse HEAD) $(git symbolic-ref HEAD)
> +       0000
> +       EOF
> +
> +       GIT_PROTOCOL=3Dversion=3D1 \
> +       git receive-pack --advertise-refs --show-service . >out &&
> +
> +       test-tool pkt-line unpack <out >actual 2>err &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect
> +'
> +
> +test_expect_success 'git upload-pack --advertise-refs --show-service: v2=
' '
> +       cat >expect <<-EOF &&
> +       version 2
> +       agent=3DFAKE
> +       ls-refs=3Dunborn
> +       fetch=3Dshallow wait-for-done
> +       server-option
> +       object-format=3D$(test_oid algo)
> +       object-info
> +       0000
> +       EOF
> +
> +       GIT_PROTOCOL=3Dversion=3D2 \
> +       GIT_USER_AGENT=3DFAKE \
> +       git upload-pack --advertise-refs --show-service . >out 2>err &&
> +
> +       test-tool pkt-line unpack <out >actual &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect
> +'
> +
> +test_expect_success 'git receive-pack --advertise-refs --show-service: v=
2' '
> +       # There is no v2 yet for receive-pack, implicit v0
> +       cat >expect <<-EOF &&
> +       $(git rev-parse HEAD) $(git symbolic-ref HEAD)
> +       0000
> +       EOF
> +
> +       GIT_PROTOCOL=3Dversion=3D2 \
> +       git receive-pack --advertise-refs --show-service . >out 2>err &&
> +
> +       test-tool pkt-line unpack <out >actual &&
> +       test_must_be_empty err &&
> +       test_cmp actual expect
> +'
> +
>  test_done
>
> base-commit: 7580f92ffa970b9484ac214f7b53cec5e26ca4bc
> --
> gitgitgadget
