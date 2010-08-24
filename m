From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH v3] shell: Rewrite documentation and improve error message
Date: Tue, 24 Aug 2010 11:22:07 -0400
Message-ID: <AANLkTikqoELMOxjdtzvrFTgyHK0dLCZLrwt2NhCSUDL5@mail.gmail.com>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
	<AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
	<20100822080359.GB15561@kytes>
	<AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
	<20100824053647.GA2037@kytes>
	<AANLkTikeZTF5zZyRDtLfnPrtCYFH0WayXrJeCj8_VuC1@mail.gmail.com>
	<20100824123525.GA18641@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 17:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnvKS-00083c-Sa
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 17:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab0HXPWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 11:22:12 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:58791 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752185Ab0HXPWL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 11:22:11 -0400
X-AuditID: 12074425-b7cccae000005f17-6b-4c73e39ba537
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 1F.EE.24343.B93E37C4; Tue, 24 Aug 2010 11:22:03 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o7OFMAEU021778
	for <git@vger.kernel.org>; Tue, 24 Aug 2010 11:22:10 -0400
Received: from mail-px0-f174.google.com (mail-px0-f174.google.com [209.85.212.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7OFM8pr026679
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Aug 2010 11:22:10 -0400 (EDT)
Received: by pxi10 with SMTP id 10so2680248pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 08:22:08 -0700 (PDT)
Received: by 10.114.123.9 with SMTP id v9mr301932wac.130.1282663327923; Tue,
 24 Aug 2010 08:22:07 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Tue, 24 Aug 2010 08:22:07 -0700 (PDT)
In-Reply-To: <20100824123525.GA18641@kytes>
X-Brightmail-Tracker: AAAABBWs/CYVrZJ9Fa3IeBWt44Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154317>

>> > =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hint: ~/$=
COMMAND_DIR should exist "
>> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hint: ~/"=
 $COMMAND_DIR " should exist "
>> There's still a floating $. =A0(Recall, you're in C land here, not s=
hell.)
>
> Ugh. So sorry about this- I've been suffering from insomnia over the
> last few days.
No worries :).

> -- 8< --
> diff --git a/shell.c b/shell.c
> index 6aade3d..b539cdf 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -154,7 +154,7 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd_to_homedir();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (access(COMMAND_DIR, R_OK | X_OK) =3D=
=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Interactive git s=
hell is not enabled.\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hint: ~/" $COM=
MAND_DIR " should exist "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hint: ~/" COMM=
AND_DIR " should exist "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"and have read=
 and execute access.");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0run_shell();
LGTM.

Reviewed-by: Greg Brockman <gdb@mit.edu>
