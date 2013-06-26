From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Wed, 26 Jun 2013 18:02:19 +0200
Message-ID: <20130626160219.GC9141@paksenarrion.iveqy.com>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
 <20130624224925.GC32270@paksenarrion.iveqy.com>
 <20130625221132.GB4161@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	gitster@pobox.com, Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 26 18:02:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrsB7-00066m-7A
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 18:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab3FZQCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 12:02:37 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:65189 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3FZQCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 12:02:35 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so1571063lbh.10
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KN0GOmlDTJhCw+OcN46UPM/T0ryjY6sYWzkIjG+pfB0=;
        b=b3MSSy0Fdj3pQvpj/SrI7zQyhCu4qzdC/IWvBD6hp7nUXCGvogmXOIM7MHscTIpY7B
         jcdbi9FUDNlD8WkWKp3kN6nLCffh6RRQSLBmvC2c/Qth/PfOpbm9Y43O1WwPinx+FWZl
         3ST3sgShknCxUmBZ2qI35BXU+G8s40SSxNkjz2CnDO1dK41CWmcNR4odVgrL08HJ+4+u
         G1o2WPTC/dWrBEFTyCHdvi0zQXqp8N4kwH4syRJR5uYi03YSjMibqWrhi/4ikW/OIhEa
         3IPwEyl9c2lYgJ1iL6aPXb2HVUxeZC5tRuC1HE3AsbCEFOZ6RsNTqAqIF7QMwy/xsoYL
         zCDQ==
X-Received: by 10.152.87.43 with SMTP id u11mr2162040laz.71.1372262554070;
        Wed, 26 Jun 2013 09:02:34 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id x8sm11048700lae.10.2013.06.26.09.02.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 09:02:33 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UrsAl-00079L-6z; Wed, 26 Jun 2013 18:02:19 +0200
Content-Disposition: inline
In-Reply-To: <20130625221132.GB4161@sandbox-ub>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229044>

On Wed, Jun 26, 2013 at 12:11:32AM +0200, Heiko Voigt wrote:
> On Tue, Jun 25, 2013 at 12:49:25AM +0200, Fredrik Gustafsson wrote:
> > Used only when a clone is initialized. This is useful when the subm=
odule(s)
> > are huge and you're not really interested in anything but the lates=
t commit.
> >=20
> > Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
>=20
> I this is a valid use case. But this option only makes sense when a
> submodule is newly cloned so I am not sure whether submodule update i=
s
> the correct place. Let me think about this a little more. Since we do
> not have any extra command that initiates the clone this is probably =
the
> only place we can put this option. But at the moment it does not feel
> completely right.
>=20
> Apart from that the code looks good. If the user does a checkout of a
> revision that was not fetched submodule update will error out the sam=
e
> way as if someone forgot to push his submodule changes. So that shoul=
d
> not be a problem.
>=20

I agree and would love to say that I've a more beautiful solution, but
I haven't.

The only other solution I can think about is to add a git submodule
clone that will do only clones of non-cloned submodules.

I'm no UI expert so I don't know what's best. Maybe that's more
intuitive.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
