From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/32] nd/multiple-work-trees cleanup
Date: Sat, 30 Aug 2014 07:11:08 -0400
Message-ID: <CAPig+cT6J-qts-KqYK-quy+zLmWOfk6eeMfuoXBPKN4he=bncg@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 13:11:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNgYu-0003QP-8G
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 13:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbaH3LLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 07:11:10 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33801 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaH3LLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 07:11:09 -0400
Received: by mail-yk0-f171.google.com with SMTP id 9so2135283ykp.30
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2tmJzPqDTQxQTXhQVVUeG2GW6Dx+y2Q/qVqhJgjONXg=;
        b=0tOe+KoLm5uaN118B2wmzg6CgCnm5ZYt0dOuQTEDxGaLHejbRzN1RA9WSg2clyBFuu
         L6DCMxw8zDeu4MTVn2MSoeH0hlPZVYcrATe93U0qz6QLH21mXKDFDPD3OUG+oACN/Pj4
         7qFltabW5KCFe4Lxu5i7ikXSdl6q+OuWpyqyDITHCMo7BDuyveBmlOXQhyl8NrpWrf2y
         YwqlgrjkUpjbiPV+0QQYlO+Pc5oppQIrNY5dKROtxobKxPFcj3d2X6W0BCy0/WeZ4Wif
         o8JrTe6g+xsje/pj6++PdbM1ToOZQ8BCJplrEmONFBK6L/kwG3Ouf5C/WZFHIprgtV+B
         x2DQ==
X-Received: by 10.236.222.138 with SMTP id t10mr24250639yhp.10.1409397068865;
 Sat, 30 Aug 2014 04:11:08 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sat, 30 Aug 2014 04:11:08 -0700 (PDT)
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: T1W9VsKlHyJL7de9yGQpxYdLFnk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256246>

On Sat, Aug 30, 2014 at 4:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This collapes some bug fix patches into the main ones, adds a few mor=
e
> tests to cover recent changes, and removes advice.checkoutLocked (whe=
n
> things are controversal, probably best to go without them until they
> are settled). Diff against current version in 'pu'
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/g=
itrepository-layout.txt
> index 6bd82af..c9a7d1a 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -218,11 +218,10 @@ remotes::
>         "$GIT_COMMON_DIR/remotes" will be used instead.
>
>  logs::
> -       Records of changes made to refs are stored in this
> -       directory.  See linkgit:git-update-ref[1]
> -       for more information. This directory is ignored if
> -       $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/logs" will be use=
d
> -       instead.
> +       Records of changes made to refs are stored in this directory.
> +       See linkgit:git-update-ref[1] for more information. This
> +       directory is ignored $GIT_COMMON_DIR is set and

The 'if' got lost again: s/ignored/ignored if/

> +       "$GIT_COMMON_DIR/logs" will be used instead.
>
>  logs/refs/heads/`name`::
>         Records all changes made to the branch tip named `name`.
