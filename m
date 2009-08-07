From: Tim Harper <timcharper@gmail.com>
Subject: Re: [PATCH] clarify error message when an abbreviated non-existent 
	commit was specified
Date: Thu, 6 Aug 2009 23:17:48 -0600
Message-ID: <e1a5e9a00908062217q4bd1ecafm5fd5e060aecfa467@mail.gmail.com>
References: <20090806193413.GJ1033@spearce.org> <1249588435-23400-1-git-send-email-timcharper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 07:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZHqU-0008AS-08
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 07:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbZHGFSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2009 01:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbZHGFSI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 01:18:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:18504 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZHGFSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Aug 2009 01:18:07 -0400
Received: by wf-out-1314.google.com with SMTP id 26so548357wfd.4
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 22:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=R2YPBGmOpDFLGPe31Rb3ewZNldpxD5dSKzhWSiFVO1I=;
        b=C4aiF4B1V/fogAFfvj2AmRtxHPOofpOJMld7Do56a3seQr3PSFDDFBNvgBJl+WEq+q
         uF2QxdgO/sFd7GsGsnER0CU0azT1vY3IPdlZphmkVmcYRQzidJguyZ7plL7OIbhep0U0
         ezTwY1b0t4sjCN3DICJfg3kfABVk69CbGF3AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=X2QvfHhXVjS9Dd5/8+83joLD9y/SVxnSebD9EioCZX+UuwsA1ZqRJyrAKpW0PHmb9S
         6QDS/pkNYWftjlPsGM8+ecjpFJ1hi9FORFwX6FrL2G21TcOX46bqnQnoQCX6VdH7PEU/
         f4/Cc+3I0FPaB+UsQ7HopL+BIohxZVr5z9NXk=
Received: by 10.141.49.20 with SMTP id b20mr170731rvk.1.1249622288106; Thu, 06 
	Aug 2009 22:18:08 -0700 (PDT)
In-Reply-To: <1249588435-23400-1-git-send-email-timcharper@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125178>

On Thu, Aug 6, 2009 at 1:53 PM, Tim Harper<timcharper@gmail.com> wrote:
> When running the command 'git branch --contains efabdfb' on a reposit=
ory that doesn't yet have efabdfb, git reports: "malformed object name =
efabdfb". To the uninitiated, this makes little sense (as far as they a=
re concerned, efabdfb is perfectly formed).
>
> This commit changes the message to "malformed object name or no such =
commit: efabdfb"
> ---
> =C2=A0parse-options.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 3b71fbb..95eb1c4 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -615,7 +615,7 @@ int parse_opt_with_commit(const struct option *op=
t, const char *arg, int unset)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!arg)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_sha1(arg, sha1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("malf=
ormed object name %s", arg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("malf=
ormed object name or no such commit: %s", arg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit =3D lookup_commit_reference(sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!commit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("=
no such commit %s", arg);
> --
> 1.6.4
>
>

Does nobody think this is a good idea?
