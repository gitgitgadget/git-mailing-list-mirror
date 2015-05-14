From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] generate-cmdlist: parse common group commands
Date: Thu, 14 May 2015 13:58:26 -0700
Message-ID: <xmqq617ukhal.fsf@gitster.dls.corp.google.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431608351-9413-4-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0DB-0000D7-5q
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934135AbbENU63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 16:58:29 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35234 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583AbbENU62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:58:28 -0400
Received: by igbyr2 with SMTP id yr2so178159275igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Bb5QfqnWj6d40AIME/0cmx2Dg9m7Lqs7cQ9+fezzq9I=;
        b=g6577uj81h1xpbpw295WdcztyeYTSHrkLccDXKu4NGFbbkWv/PkCwzLm2QyilIiDvE
         sHAhQYOdEF1V3iUkH9jO7o088Rl0LoaWWh+sgA3CCPul9pUVnV6yG7zV3gYapUQNgiZV
         wV/QzR7wkZxRu888WeqQMSAcQaXZdF48llDAobYw4cPIhksk2EB7Ob9nfG42MB65kmep
         G/TeMtVFQtOStS2+KCVcHSUe+D54bFP6AQlSzlp/olAlh2HlJ6GLg4g7w9EA70ejDdwV
         eYJfAKL4IRCiDM79C5UZ0mRSfmgqO7mPlhWn1fxyJesdZ3Yce5AbQKAC40rovDNh4s4K
         9D3w==
X-Received: by 10.50.64.147 with SMTP id o19mr8249165igs.33.1431637107854;
        Thu, 14 May 2015 13:58:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id q11sm54236igr.3.2015.05.14.13.58.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 13:58:27 -0700 (PDT)
In-Reply-To: <1431608351-9413-4-git-send-email-sebastien.guimmara@gmail.com>
	(=?utf-8?Q?=22S=C3=A9bastien?= Guimmara"'s message of "Thu, 14 May 2015
 14:59:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269093>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Parse the [common] block to create the array of group descriptions:
>
> static char *common_cmd_groups[] =3D {
>     N_("starting a working area"),
>     N_("working on the current change"),
>     N_("working with others"),
>     N_("examining the history and state"),
>     N_("growing, marking and tweaking your history"),
> };
>
> then map each element of common_cmds[] to a group via its index:
>
> static struct cmdname_help common_cmds[] =3D {
>     {"add", N_("Add file contents to the index"), 1},
>     {"branch", N_("List, create, or delete branches"), 4},
>     {"checkout", N_("Checkout a branch or paths to the ..."), 4},
>     {"clone", N_("Clone a repository into a new directory"), 0},
>     {"commit", N_("Record changes to the repository"), 4},
>     ...
> };
>
> so that 'git help' can print those commands grouped by theme.
>
> Only commands tagged with an attribute from [common] are emitted to
> common_cmds[].
>
> [commit message by S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.=
com>]
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---

I seem to be getting an empty common_cmds[] list after this step
(with GNU Awk 4.0.1, ICIM).
