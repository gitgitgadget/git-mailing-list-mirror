From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 0/2] remote-hg: shared repo upgrade fix
Date: Sat, 10 Aug 2013 17:18:11 +0200
Message-ID: <CALWbr2zKhvM_scRCER2GeBtRDF2=bvrDQWc+GZjDGExHeKRnQg@mail.gmail.com>
References: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 17:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Avo-0001Yw-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 17:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804Ab3HJPSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 11:18:12 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:41729 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934153Ab3HJPSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 11:18:12 -0400
Received: by mail-qe0-f49.google.com with SMTP id 1so2834448qec.8
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fiGW4ctZqWx7tQyMIoWy/NXskIp9Nz6UauvuF3yP35o=;
        b=QF7Vcr1bFfoaqk/cB+vN0QZZyKChysJ5MZox+XMS+RueN/+Tmc4NT7a0kdtmtChv1f
         qLL+u/jUc4wFHaPyMIEoZfIIf5zonXPQo19HdvIgbb5nPf0hOr3u1CZZYbc3CpX1X5Ni
         wqi2XjAQMd+oosGpDXjJtIXGjA3D3qDQl4lWwR+QLTRt88lYm/NCrWwl7sA9BaCuwnIZ
         WSHQGVxTEb8B0WOj2JMdyUy0wboOev7ndC9AdC13yPtSP3LPSFnSGZN1TP5sozLSVVe/
         zef32qp54NYaffOCVq/CGqKobW95fiEmdKElxlpI7/V+nS9Xm4f0uB/GH5lQgtBA4XTj
         j9Vg==
X-Received: by 10.224.166.129 with SMTP id m1mr15586083qay.46.1376147891423;
 Sat, 10 Aug 2013 08:18:11 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Sat, 10 Aug 2013 08:18:11 -0700 (PDT)
In-Reply-To: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232101>

On Sat, Aug 10, 2013 at 12:38 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> Same as before, except with commit messages updated, and improved the second
> patch:
>
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -400,8 +400,9 @@ def get_repo(url, alias):
>                  local_hg = os.path.join(shared_path, x, 'clone', '.hg')
>                  if not os.path.exists(local_hg):
>                      continue
> -                shutil.copytree(local_hg, hg_path)
> -                break
> +                if not os.path.exists(hg_path):
> +                    shutil.move(local_hg, hg_path)
> +                shutil.rmtree(os.path.join(shared_path, x, 'clone'))
>
>          # setup shared repo (if not there)
>          try:

FWIW,
Reviewed-by: Antoine Pelisse <apelisse@gmail.com>

Cheers,
