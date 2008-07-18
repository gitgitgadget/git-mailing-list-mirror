From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 19:05:05 +0200
Message-ID: <200807181905.07123.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtPW-0000SQ-RC
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbYGRRF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756307AbYGRRF2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:05:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:13916 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbYGRRF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:05:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so288984fkq.5
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Nyqvzcw+ZBG8uMsywCLMiqBlSc0IAO1c3dTOJFeoguo=;
        b=OS66EH8v7Cw76MhsEvUDMXGyb46pMCu0p53SP2u4oHqVhwr0RB7ZWQiTDf59JhCDg+
         mKH6F9WPr+SX7HEiflVh/YCZKiaXYpMdkWzTs9H5nc3MKXsPw0D+ZQe1mpelcs1Q0k/+
         3pSYgMzWCS42etnxlI0HHMC5nstGpff6Pt/4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qiABHnjhchdI6mNQk3rupDpXsI523CdIvVzsHsSb0DLw3r2HvKwqomfR0kRWu53Nkb
         M4z5ScEc2iVcRukwR+82PO2a//xyms4zbLYisPqVGhvDJU7DQfjF2VG7lYDNygLAEk4/
         WZ3JtbFzk4rut49W56X5Po/0CNrZ/F79nA4jc=
Received: by 10.180.208.5 with SMTP id f5mr267676bkg.42.1216400724012;
        Fri, 18 Jul 2008 10:05:24 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.220.24])
        by mx.google.com with ESMTPS id 28sm3822818fkx.1.2008.07.18.10.05.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 10:05:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080718164828.GT10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89058>

Dnia pi=B1tek 18. lipca 2008 18:48, Petr Baudis napisa=B3:
> On Tue, Jul 15, 2008 at 12:19:31AM +0200, Lea Wiemann wrote:

> > No, you should never pass in an invalid SHA1 in the first place.  T=
he
> > above piece of documentation is just a warning that bugs will show =
up
> > delayed.  IOW, this is not the right place to have your error handl=
ing.
> >=20
> > If you're getting a SHA1 through the user-interface, check its exis=
tence
> > with get_sha1 before passing it to the constructor.
>=20
> But that's an expensive operation, you need extra Git exec for this,
> while all the Git commands can do the checks for you, if you give the=
m
> the chance.
>=20
> I was doing pretty much this thing in Cogito (initially out of
> necessity) and it made it ungodly slow for any kind of batch operatio=
ns.

Lea probably would point out that thanks to '--batch-check' option
to git-cat-file, and "reuse =3D> 1" option to ->get_bidi_pipe you would
need only one extra Git exec...  BUT it is one extra Git exec per
entire Perl script (one per request, for example, for gitweb).
And it wouldn't help batching Perl script commands.

--=20
Jakub Narebski
Poland
