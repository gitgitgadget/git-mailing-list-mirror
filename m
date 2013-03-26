From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] clone: run check_everything_connected
Date: Tue, 26 Mar 2013 07:53:42 +0700
Message-ID: <CACsJy8CbBeuHmkEJs4FqGJs_kqEcjKi7RJkp9eNorxJAqgiCrg@mail.gmail.com>
References: <20130325201427.GA15798@sigill.intra.peff.net> <20130325202627.GI16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 01:54:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKI9x-0007Xz-LN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 01:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759169Ab3CZAyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 20:54:14 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44085 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819Ab3CZAyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 20:54:13 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so6672554obc.32
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 17:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cgncsu6CjJ/hyGqXxN4JJRkjyaTXr19Cg/znkHsn2F4=;
        b=T2Uye92fxcCF7jcMoRlOFT2+cLEM/u64l9pltN4iaYLYt4Czrgg3SWRkppxA81KDQQ
         RXWV54el2Lqt39rDjbB5EoIl66SazDujmiiC+/S5/o76gDYvhYkmh8RwC/V0rtyQ7dPj
         xuU0G9n4Ly9QaX3jFVFOfw/ni58pqa07Kvh+i8LTu0luMMqOfSejqnHimfybYoKeiWce
         UkbJ2uF8AdX6fIyJfYB+fPgcdoSjab74nq1H8+fw7mgi3pvBJ9kmKVskTWsP+pazcg+l
         SJdhwq9oNGwEWararRR1KGzBpEHcpQUapkUecbpg9gENIdRIj7a8I4IiRhCwk7Mwid+j
         L1hw==
X-Received: by 10.182.8.70 with SMTP id p6mr1320769oba.90.1364259253101; Mon,
 25 Mar 2013 17:54:13 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 25 Mar 2013 17:53:42 -0700 (PDT)
In-Reply-To: <20130325202627.GI16019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219125>

On Tue, Mar 26, 2013 at 3:26 AM, Jeff King <peff@peff.net> wrote:
>  static void update_remote_refs(const struct ref *refs,
>                                const struct ref *mapped_refs,
>                                const struct ref *remote_head_points_at,
>                                const char *branch_top,
>                                const char *msg)
>  {
> +       const struct ref *rm = mapped_refs;
> +
> +       if (check_everything_connected(iterate_ref_map, 0, &rm))
> +               die(_("remote did not send all necessary objects"));
> +
>         if (refs) {
>                 write_remote_refs(mapped_refs);
>                 if (option_single_branch)

Maybe move this after checkout, so that I can switch terminal and
start working while it's verifying? And maybe an option not to
check_everything_connected, instead print a big fat warning telling
the user to fsck later?
-- 
Duy
