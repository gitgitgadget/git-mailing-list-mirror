From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: 65c042d4 broke `remote update' without named group
Date: Fri, 1 Jan 2010 17:00:25 +0800
Message-ID: <be6fef0d1001010100u7ebf25beydd2ff11ef71a9d66@mail.gmail.com>
References: <20091229234959.GA94644@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: YONETANI Tomokazu <qhwt+git@les.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jan 01 10:08:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQdUP-0005Ny-Di
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 10:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab0AAJA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jan 2010 04:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852Ab0AAJA1
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 04:00:27 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:54377 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0AAJA1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jan 2010 04:00:27 -0500
Received: by iwn1 with SMTP id 1so9513575iwn.33
        for <git@vger.kernel.org>; Fri, 01 Jan 2010 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yCqJVa8LywBSIUiArxxI5ivk4C1sikZ+q0kECtmlwsc=;
        b=xU1ywBLhV3XR21phqdvpvH3yvu37HC+sWm13vQX+BSC/XXyAdx0UTY/+KCsGkuT4hY
         8AWYLEBfOOphkKlOGRV0/ZJ7TK3U/frdqr1AC9x+grhp11YIvcuGL1UmcECaqMUVCs4E
         SSwSfMoPvJ92dKd4ulfBk7Uto4OsSniZfDeqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HX0Wfs9Orl44d3tr2EMhDDjNyTxevH687e59/DOAZkJ70wQoLHJfCXqbvUMBr7RbLv
         1pWHxZJk9SeAoF1w65Hji/f+c4Ua4mlSrk4on8plSSxf05CE91GH8VVF1ZTnPgBuWXC3
         HfJT47OlSXSTWB93tjtAgI9bbHR73NBiSEZg8=
Received: by 10.231.146.2 with SMTP id f2mr2879105ibv.23.1262336425387; Fri, 
	01 Jan 2010 01:00:25 -0800 (PST)
In-Reply-To: <20091229234959.GA94644@les.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136005>

Hi,

On Wed, Dec 30, 2009 at 7:49 AM, YONETANI Tomokazu <qhwt+git@les.ath.cx=
> wrote:
> Hello.
> It seems that with 65c042d4 (and v1.6.6), git-remote update without
> specifying a group on the command line ends up with the following err=
or
> message if you define remotes.default in the config file:
> =A0$ git remote update
> =A0fatal: 'default' does not appear to be a git repository
> =A0fatal: The remote end hung up unexpectedly
>
> The document still says that when you don't specify the named group,
> remotes.default in the configuration will get used, so this should wo=
rk
> (and it used to work with v1.6.4).
>
> After the commit 65c042d4, the commands are translated as follows:
> =A0$ git remote update
> =A0=3D=3D> git-fetch default =A0 =A0 =A0 =A0 (with remotes.default de=
fined) =A0 =A0 =A0 =A0 =A0NG
> =A0=3D=3D> git-fetch --all =A0 =A0 =A0 =A0 =A0 (without remotes.defau=
lt defined) =A0 =A0 =A0 OK
>
> =A0$ git remote update default
> =A0=3D=3D> git-fetch --multiple default =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OK
>
> So just adding "--multiple" in front of "default" in the first case
> above should fix it.

Bj=F6rn (added to Cc list), you seem to have been the main author of
'bg/fetch-multi', do you have any idea on this?

--=20
Cheers,
Ray Chuan
