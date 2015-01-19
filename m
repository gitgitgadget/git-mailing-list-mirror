From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 15/18] fsck: Document the new receive.fsck.* options.
Date: Mon, 19 Jan 2015 17:44:45 -0500
Message-ID: <CAPig+cSVUAV_6c0Zv36aA++AWCG05yxq-LpPsQ89VoepHGUBRw@mail.gmail.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<41d4880fc48ad39d4798c2f9a0cb38a6a41c41b3.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 23:44:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDL3y-0006Yf-Id
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 23:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbbASWoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 17:44:46 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:58661 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbASWop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 17:44:45 -0500
Received: by mail-yk0-f179.google.com with SMTP id 142so291576ykq.10
        for <git@vger.kernel.org>; Mon, 19 Jan 2015 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7WLA6yyrqx9jxf5rIfiBRigGIAVKQ0+dg7LzEbigkso=;
        b=zzUpo9SS/Jpr3iMptaXv0bjy+wcSrVVNF0r0IEhAaWL6eAzAADQqOnDQ9L/UMXxPvl
         W7gsHp3SFWgpI7MeieEy5FSBDMM+ptpzV2s6BGEHPgTsSbN3YdfVbKQ4Q1B3FexEpcu/
         JzlrPulGAVHL+an8cHFFdDjXIMrZwbRhGnp/N1HVcyei1woC4wexhZwLruHWAQ34+Ugm
         ni+6XVxvkpXT0XpIxVdlXNUStgyg/pWSGDb5FSQdMJvdHEe+wxAEOpfv++NaYJZfrcQP
         KW3XnLTpr3XFQ/nw7F24TZ5m7Wy5oznuKOcq6fPdlXcmR/ZY4K9H9XcdPkOzRgJnVMt2
         eQlg==
X-Received: by 10.170.119.7 with SMTP id l7mr21493671ykb.51.1421707485131;
 Mon, 19 Jan 2015 14:44:45 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 19 Jan 2015 14:44:45 -0800 (PST)
In-Reply-To: <41d4880fc48ad39d4798c2f9a0cb38a6a41c41b3.1421682369.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: uuRX7NUH_xZmQ8uU3mMyextRlzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262645>

On Mon, Jan 19, 2015 at 10:51 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ae6791d..7371a5f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2130,6 +2130,31 @@ receive.fsckObjects::
>         Defaults to false. If not set, the value of `transfer.fsckObjects`
>         is used instead.
>
> +receive.fsck.*::
> +       When `receive.fsckObjects` is set to true, errors can be switched
> +       to warnings and vice versa by configuring the `receive.fsck.*`
> +       settings. These settings contain comma-separated lists of fsck
> +       message IDs. For convenience, fsck prefixes the error/warning with
> +       the message ID, e.g. "missing-email: invalid author/committer line
> +       - missing email" means that setting `receive.fsck.ignore =
> +       missing-email` will hide that issue.
> ++
> +--
> +       error::
> +               a comma-separated list of fsck message IDs that should be
> +               trigger fsck to error out.
> +       warn::
> +               a comma-separated list of fsck message IDs that should be
> +               displayed, but fsck should continue to error out.
> +       ignore::
> +               a comma-separated list of fsck message IDs that should be
> +               ignored completely.
> ++
> +This feature is intended to support working with legacy repositories
> +which would not pass pushing when `receive.fsckObjects = true`, allowing
> +the host to accept repositories certain known issues but still catch

s/certain/with &/

> +other issues.
> +
>  receive.unpackLimit::
>         If the number of objects received in a push is below this
>         limit then the objects will be unpacked into loose object
> --
> 2.0.0.rc3.9669.g840d1f9
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
