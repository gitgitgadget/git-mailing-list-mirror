From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Wed, 6 May 2015 02:57:43 -0400
Message-ID: <CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 08:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YptHC-0003di-9r
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 08:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbEFG5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 02:57:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37518 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbEFG5n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2015 02:57:43 -0400
Received: by igblo3 with SMTP id lo3so8293985igb.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=r7wL0QbLkoTwAmI/9QK8gpgE9AaN0YnENnz8/zH2tSQ=;
        b=ELeyAdtkyrzoB1PYSgQ2pRRt5+zwkIGQRE4N8S2LMpJOI3KPN+UAV4I09Fp/TrCmmg
         clNOv9Bp0wtEZotvg2BgUYNtKpzvHJxbHM+tdYf3FbxUtXmJH01A/a2fEYY+3GX1TxdT
         Ob5JvyBjAHD58zI8GZvPuimzG5gd2JqN6MR2rr0MjJXxc+4A/s7lxDILf2SGsxolwRJF
         FV/IwF+5BUkK/iDNy98Q+v+XUPwOJBj6OYqtyR6SpJVwd8zVY04WYBtEdkMS/nfEB+Iu
         yDNCNS3l8MgXJoqfGdeaqBvEySRX+EGSTKoUQ1YajDBi7U9b0Fs6m6i2DqLRgtwU3KaQ
         CMZw==
X-Received: by 10.42.67.80 with SMTP id s16mr1103725ici.25.1430895463086; Tue,
 05 May 2015 23:57:43 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 5 May 2015 23:57:43 -0700 (PDT)
In-Reply-To: <b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: Z4RAG74iDtv-Ht-s1R1IFzg_A3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268453>

On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> Declare groups for common commands in the [groups] block,
> followed by group names and descriptions:
>
>    [groups]
>    init                   starting a working area
>    worktree               working on the current change
>    remote                 working with others
>    info                   examining the history and state
>    history                growing, marking and tweaking your history
>
> Then, in the [commands] block, map all common commands with a group:
>
>    [commands]
>    git-add        mainporcelain     common-worktree
>    git-branch     mainporcelain     common-history
>    git-checkout   mainporcelain     common-history
>    [...]
>
> command names and groups are then parsed with generate-cmdlist.sh to
> generate common-commands.h.
>
> Those commands are displayed in groups in the output of 'git help'.

It probably also is important to mention that the order of the items
in [groups] is the order in which groups are output by 'git help'

More below.

> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/command-list.txt b/command-list.txt
> index f1eae08..64394ca 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,29 +1,39 @@
>  # List of known git commands.
> -# command name                         category [deprecated] [common=
]
> -git-add                                 mainporcelain common
> +# only add group information for common commands

Perhaps mention also that the order of groups here is the order in
which they are output by 'git help'?

> +[groups]

Thinking on this a bit more, perhaps [groups] is too generic. Maybe
[common] or [commongroups] would be more descriptive?

> +init                   starting a working area
> +worktree               working on the current change
> +remote                 working with others

"collaborating with others" perhaps?

More below.

> +info                   examining the history and state
> +history                growing, marking and tweaking your history
> +
> +# command name         [deprecated]     category                    =
 [group]
> +[commands]
> +git-add                                 mainporcelain               =
 common-worktree
>  [...]
> -git-bisect                              mainporcelain common
> +git-bisect                              mainporcelain
>  [...]
> -git-branch                              mainporcelain common
> +git-branch                              mainporcelain               =
 common-history
>  [...]
> -git-checkout                            mainporcelain common
> +git-checkout                            mainporcelain               =
 common-history
>  [...]
> -git-clone                               mainporcelain common
> +git-clone                               mainporcelain               =
 common-init
>  [...]
> -git-commit                              mainporcelain common
> +git-commit                              mainporcelain               =
 common-history
>  [...]
> -git-diff                                mainporcelain common
> +git-diff                                mainporcelain               =
 common-history
>  [...]
> -git-fast-export                                ancillarymanipulators
> -git-fast-import                                ancillarymanipulators
> -git-fetch                               mainporcelain common
> +git-fast-export                         ancillarymanipulators
> +git-fast-import                         ancillarymanipulators

Unintended whitespace changes for fast-export and fast-import lines? I
wouldn't have expected to see these lines change in this patch.

> +git-fetch                               mainporcelain               =
 common-remote
>  [...]
> -git-fsck                               ancillaryinterrogators
> +git-fsck                                ancillaryinterrogators

Unintended whitespace change?

>  [...]
> -git-grep                                mainporcelain common
> +git-grep                                mainporcelain

This change isn't mentioned anywhere, not even in the cover letter.
Did you intend to drop 'grep' from the common command list?

>  [...]
> -git-help                               ancillaryinterrogators
> +git-help                                ancillaryinterrogators

Whitespace change?

More below.

>  [...]
> -git-init                                mainporcelain common
> +git-init                                mainporcelain               =
 common-init
>  [...]
> -git-log                                 mainporcelain common
> +git-log                                 mainporcelain               =
 common-info
>  [...]
> -git-merge                               mainporcelain common
> +git-merge                               mainporcelain               =
 common-history
>  [...]
> -git-mv                                  mainporcelain common
> +git-mv                                  mainporcelain
>  [...]
> -git-pull                                mainporcelain common
> -git-push                                mainporcelain common
> +git-pull                                mainporcelain               =
 common-remote
> +git-push                                mainporcelain               =
 common-remote
>  [...]
> -git-rebase                              mainporcelain common
> +git-rebase                              mainporcelain
>  [...]
> -git-reset                               mainporcelain common
> +git-reset                               mainporcelain               =
 common-worktree
>  [...]
> -git-rm                                  mainporcelain common
> +git-rm                                  mainporcelain
>  [...]
> -git-show                                mainporcelain common
> +git-show                                mainporcelain
>  [...]
> -git-status                              mainporcelain common
> +git-status                              mainporcelain               =
 common-info
>  [...]
> -git-tag                                 mainporcelain common
> +git-tag                                 mainporcelain

This change also is not mentioned anywhere.

>  [...]
> -git-write-tree                          plumbingmanipulators
> +git-write-tree                          plumbingmanipulators
> \ No newline at end of file

Your editor is perhaps dropping the final newline in the file? This is
an undesirable change. Patch 2/3 exhibits the same problem.

> --
> 2.4.0
