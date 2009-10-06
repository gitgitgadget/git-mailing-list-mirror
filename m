From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "reword"
Date: Mon, 05 Oct 2009 19:34:19 -0700
Message-ID: <4ACAACAB.3020707@gmail.com>
References: <4ACA1BD1.6050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 04:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuzuV-0004Cl-B9
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 04:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbZJFCcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 22:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbZJFCcw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 22:32:52 -0400
Received: from mail-ew0-f217.google.com ([209.85.219.217]:45167 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988AbZJFCcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 22:32:51 -0400
Received: by ewy17 with SMTP id 17so3464809ewy.39
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Wb7BafV9cUBPmQ1DQStLPHa9qqXobf+ZP3LSv+g9Rpg=;
        b=IxhTI6IayPnb/r4rDrzjnNCoFtUXKyj0zKF7dEIoJQo+ukFfw/VGDAEVBh3NHKlAML
         RME2D71wj9ta6zcoR9yU8zJ+/NU1WVuQeEPYgt361Un35laCB67wMyPLVOg+9Qc8u/tO
         3FbcQVKwdkKi/4bC7vfp7I9Fu4tyhOLFeVf6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=B8gO32ANH4wklv9sNgGPIaX/BH76z1v8GK1j4Nr6I5qSY89XQAinCqJiwQGMMKvTrd
         c1JFaqDFfHR43qUedZbAJulwLCDHETAQ5DhHs3uKoV6QnKRMN+Sxg4vQRuAllubGwjqm
         VtgUY6bX9oP28AJ/1Et+IsKpT9g8If8jG32s4=
Received: by 10.210.9.13 with SMTP id 13mr4168674ebi.3.1254796334170;
        Mon, 05 Oct 2009 19:32:14 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 10sm660164eyd.37.2009.10.05.19.32.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 19:32:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <4ACA1BD1.6050905@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129605>

Bj=F6rn Gustavsson wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 0aefc34..52af656 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -368,6 +368,9 @@ By replacing the command "pick" with the command =
"edit", you can tell
>  the files and/or the commit message, amend the commit, and continue
>  rebasing.
> =20
> +If you just want to edit the commit message for a commit, you can re=
place
> +the command "pick" with the command "reword".
> +
Maybe use the imperative here. So instead of "you can replace" just say
"replace".

Also, two paragraphs down we say "In both cases ..." but now there are
three cases right? Maybe we should say

When a "pick" doesn't succeed (because of merge errors) or when "pick"
has been replaced with another command, ...

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23ded48..30c2f62 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
>
> @@ -752,6 +760,7 @@ first and then run 'git rebase --continue' again.=
"
>  #
>  # Commands:
>  #  p, pick =3D use commit
> +#  r, reword =3D use commit, but allow editing of the commit message
How about this?

use commit, but stop to edit (or reword?) the commit message
