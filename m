From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] worktree.c: add is_main_worktree()
Date: Fri, 13 May 2016 12:32:52 -0400
Message-ID: <CAPig+cRFv_dkpEBGOHE-tUPPc82YNugzXAf14rh6fSiTK_6Oyw@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:33:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1G1K-0001xe-2x
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbcEMQcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 12:32:54 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33773 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbcEMQcx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 12:32:53 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so15785906ioi.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=6Czyx8gM1/yDnI9QFJHRwrHRFcO3DT30syLtvf+9xBk=;
        b=yR+PzHIU1Bxna91+j28MxYKwdICqy368pUpoO8/CsDlupM5dI+162Ok8Dx8KUFEu8j
         dou6RfOV7t9cv3GblZr2mqaB7GwHq6YkTj2Q+ZRARVCgUIr2O1Lh4ZbFkwO1AbSKDSwF
         Kf5yQjYMdld7kVhmhXD2Tsv24d9UNfCrwucNHzLQPvYXJaEDRP3yICOut7viu4cpXS5J
         UUbC4GvMmAjN0eHaTFIsiGHQ+JvBEzgJaUehCejLR9N6RGr0KTyJASG4k1wMtSOlOcxp
         oImYi692P2gyX8yFGIiAs3i2c/zLgdm6MoCyG/yoJY1j/lk+7gOvbD1X5rngMXI2QioH
         JOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=6Czyx8gM1/yDnI9QFJHRwrHRFcO3DT30syLtvf+9xBk=;
        b=HsMFZ5g5FFDbUl8YABg7a9kkl7FKM+QwxrDGZmmk0m4WtXNCoyNdNdmU/4o2pwEmES
         gc13DoPcW7ljb07z86OYIvsAIRUm/Bm8MV6oeEs/wyrJYfoNl+sTj7YTlxzd8/KxEpBT
         kCWLO8IMp63G+0+sy25WQkEgWZkmDVgRW+/JDR2k1qjj09wOacbf9lu2DKOrbLyjDOCZ
         S9IrszZyCknzUZaotjGFEJOnTZKpVVTSebaP7KZEkukuB2MpDrzi6chCwfaGsRwPqbiu
         Mw0sBEZliylK5oggEl2rwiUfEpnTvC+3xU7b1lLYHsK3dW7704xoIg5D1vB2uXjG2olq
         ASgA==
X-Gm-Message-State: AOPr4FV1E9KzE5vu4bri8dScqg34ffHvdBArODKPsmvIW5u+Vo8kh0uDR2UNyhAO62UDlgwbDxZE9ZFMUV8LkQ==
X-Received: by 10.107.47.37 with SMTP id j37mr11820277ioo.168.1463157172980;
 Fri, 13 May 2016 09:32:52 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 13 May 2016 09:32:52 -0700 (PDT)
In-Reply-To: <20160510141729.23063-2-pclouds@gmail.com>
X-Google-Sender-Auth: 3UnfZ-Reo_0I2J5r__xBsP-Jci8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294541>

On Tue, May 10, 2016 at 10:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Main worktree _is_ different. You can lock a linked worktree but not =
the
> main one, for example. Provide an API for checking that.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -238,6 +238,11 @@ struct worktree *find_worktree_by_path(struct wo=
rktree **list,
> +int is_main_worktree(const struct worktree *wt)
> +{
> +       return wt && !wt->id;
> +}

Is or will there ever be a case when it is valid for 'wt' to be NULL?
If not, perhaps assert() or die() if given NULL?
