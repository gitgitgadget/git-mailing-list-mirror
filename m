From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 22/26] clone: define shallow clone boundary with --shallow-exclude
Date: Sun, 5 Jun 2016 01:05:48 -0400
Message-ID: <CAPig+cTrC_Y9zYVqy_gDp+HgJ8SFUUV45y83er_V-KkHmrYv7w@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com> <1460552110-5554-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 07:06:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9QG8-0003wW-0q
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 07:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbcFEFFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 01:05:50 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35790 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcFEFFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 01:05:49 -0400
Received: by mail-it0-f47.google.com with SMTP id z189so19762025itg.0
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WiL6iG3cWnA7RjDVJEromVaj+qDDpYZ6S3g+uszSmXg=;
        b=S6xncWfiwSZ+OAJOqBbqOkoWpOuHa3RfVi17i2X1Hcspb0evvbDOpsUdrtOrCv7hX0
         XeLdob5jq6///zAuxdZQEEuEWaZGwAzk/OOodzCvyyy3ceZLNEcxvFc8sWSkJ/6cSpgP
         bTYCfCdQuFBUmsIv5f/SaXMzCWFJJaGEXGJwFVWIC1UfeCgciUKKUSN9Ho6z4M8WDPl6
         lnjzaPUknVpiw3Q/JOCcZtbC93ZaaONAd5xsB8+qHl/dEoV+nCpw12q1R7tCwhPk6sl9
         C4Vj3D1UhPtcL6DSJj4IJNSTHQrEetDsQLqJDW+YfPvd07OVIkeAJWodYqoDkPLomGus
         9alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WiL6iG3cWnA7RjDVJEromVaj+qDDpYZ6S3g+uszSmXg=;
        b=DA8yljeq6omGvqhZE7FckSnUlSKZ/t9kiRQ4VxaI+dCO3ZLMX+Ku5+a7YU7d0Z1M7y
         Ke2InQt5ATPCxjrMSpZj0n7qhyyZQ8fOEBKuj1dEgG24C0uDL6onnAxsadMZAmPCOs91
         LgyVzimQEiAvWjfwWzhmZ4ltGlOUpQ1oWOiqfFIXncSBqDXL4X7qLPHXYuAJF0x+RLhZ
         25k9soxNQCTajYWW4brZDNGstHXsB7LEGvcWR6M490qRk4QT8wcpCp/9pv+4cpDJiMTY
         AKnVh9IA2hVFEZ8/JErg17Lw8SygDAPxv3oSPGW9A6OuCFrjhqk/sTQX6g7FazLNBA66
         jexA==
X-Gm-Message-State: ALyK8tLh9N0TbcIFaBlw2SqnZlVlPVNM+0t8J0oJkJqO5ebyRCvOjMzLGW4jBTHqDl1r6gF32gEQaMzCPp9F1Q==
X-Received: by 10.36.98.136 with SMTP id d130mr8459655itc.84.1465103148736;
 Sat, 04 Jun 2016 22:05:48 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sat, 4 Jun 2016 22:05:48 -0700 (PDT)
In-Reply-To: <1460552110-5554-23-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 1EU7noV_spJcg14HDRBcHc2S-aE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296465>

On Wed, Apr 13, 2016 at 8:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> @@ -44,6 +44,7 @@ static int deepen;
> +static struct string_list option_not =3D STRING_LIST_INIT_NODUP;
> @@ -52,6 +53,13 @@ static struct string_list option_config;
> +static int option_parse_deepen_not(const struct option *opt,
> +                                  const char *arg, int unset)
> +{
> +       string_list_append(&option_not, arg);
> +       return 0;
> +}
> +
> @@ -89,6 +97,9 @@ static struct option builtin_clone_options[] =3D {
>                     N_("create a shallow clone of that depth")),
>         OPT_STRING(0, "shallow-since", &option_since, N_("time"),
>                     N_("create a shallow clone since a specific time"=
)),
> +       { OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision")=
,
> +                   N_("deepen history of shallow clone by excluding =
rev"),
> +                   PARSE_OPT_NONEG, option_parse_deepen_not },

OPT_STRING_LIST()?

>         OPT_BOOL(0, "single-branch", &option_single_branch,
>                     N_("clone only one branch, HEAD or --branch")),
>         OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir")=
,
