From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: serving git with both "git:" and "http:" and submodules
Date: Wed, 14 Jul 2010 10:39:00 -0500
Message-ID: <20100714153900.GB1583@burratino>
References: <4C3DD7EF.6010805@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 17:40:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ449-0002Tj-CM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 17:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab0GNPj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 11:39:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45816 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab0GNPjz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 11:39:55 -0400
Received: by wyb42 with SMTP id 42so1105654wyb.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9aTWO1qhBrU1ZNKpzkJATVRZnpmTlg/YJpOBiA1pM2A=;
        b=W3oMyI+IRCE0fwkqDJQB387u3TxyuYNHmy9QPgzHkCCzkbcLVKti/iwvYW/WIHFjxN
         3ww5Li4w5FJbbehVtF5yC+cufYngsBZC/vfoavXJdcGDGJHNmJGZQEOrYQLMsZ7bVEnk
         lxD8RG7p/AZtxIZlnCLq2cdgM32KRcAuwVKEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EQf4l0kBEZHxqaa9kZesBJoDDGyfmZA9Gf6/TJG34zFB3ZUN3qWJIq4X5SmZUrWPfF
         590Iwd9FgtNIlPLHx12nw29/eI7fl0yoZvbNU6cmBriZcTobqrA/PX6uvHdyOnMI44N3
         Mvx1asXXNFR7JsODaRK6GdUO90ZbJC+TZnP0c=
Received: by 10.227.129.12 with SMTP id m12mr11408970wbs.102.1279121990170;
        Wed, 14 Jul 2010 08:39:50 -0700 (PDT)
Received: from burratino ([98.212.3.231])
        by mx.google.com with ESMTPS id g37sm48425380wbg.21.2010.07.14.08.39.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 08:39:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C3DD7EF.6010805@panasas.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150998>

Boaz Harrosh wrote:

> So smart people using git will just do:
> 1. $ git clone git://my-domain.org/my-tree/.git
> 2. $ git submodule init
> 3. $ git submodule update
>=20
> And all is well... But smart ass corporate people would not use "git:=
"
> protocol because of fire-walls and for them I have a dumb "http:" exp=
ort
> as:
> 1. $ git clone http://my-domain.org/trees/my-tree/.git
[...]
> So my question is: Can I automate this so people with "http:"
> clones are not forced to manually edit their config files?
> (Some users are just not up to it)

Sure.  For example, you can ship an update-submodules.sh script
to take care of checking =E2=80=9Cgit config remote.origin.url=E2=80=9D=
 and
updating the =E2=80=98[submodule "sub"] url=E2=80=99 configuration to m=
atch.

Of course, even this would not make
'git clone --recursive http://my-domain.org/trees/my-tree/.git'
work.  If you can get git-http-backend working, I=E2=80=99d suggest usi=
ng
that so you only have to deal with one url.

Hope that helps,
Jonathan
