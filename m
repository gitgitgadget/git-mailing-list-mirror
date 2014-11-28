From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v4] git-new-workdir: Don't fail if the target directory
 is empty
Date: Fri, 28 Nov 2014 13:34:05 -0500
Organization: GNU's Not UNIX!
Message-ID: <1417199645.3562.6.camel@homebase>
References: <1417034308.23650.51.camel@homebase>
	 <xmqq8uixpqyx.fsf@gitster.dls.corp.google.com>
	 <1417041115.23650.69.camel@homebase>
	 <xmqqk32ho8mc.fsf@gitster.dls.corp.google.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 19:40:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuQTM-00051o-TW
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 19:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbaK1Skt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2014 13:40:49 -0500
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:51784 "HELO
	gproxy6-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750938AbaK1Sks (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 13:40:48 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Nov 2014 13:40:48 EST
Received: (qmail 30788 invoked by uid 0); 28 Nov 2014 18:34:07 -0000
Received: from unknown (HELO cmgw3) (10.0.90.84)
  by gproxy6.mail.unifiedlayer.com with SMTP; 28 Nov 2014 18:34:07 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw3 with 
	id M6a41p00r2qhmhE016a792; Fri, 28 Nov 2014 11:34:07 -0700
X-Authority-Analysis: v=2.1 cv=W++rC3mk c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=5y4faFyK3SkA:10 a=e-pWQmaM9HotdluOBcQA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID; bh=XxhSHzNi7YZoyhTzWjqPDsIwnusfGPIL5QFVfumaQcA=;
	b=MYYLViHgA5X4fNryRbF0DN9ke+7ivAJjnY0HhdZ1HmAVAK8TrpcRY5gTjqzwwSU6Yla+yjDpJDcIOzdt8LVBz0Kw4h3FfvN79IOVte1C1Z7dTh/7NllOdhPvmRC0zrxh;
Received: from [72.74.248.26] (port=60440 helo=homebase.home)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XuQMm-0005Jq-AM; Fri, 28 Nov 2014 11:34:04 -0700
In-Reply-To: <xmqqk32ho8mc.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260375>

On Wed, 2014-11-26 at 15:16 -0800, Junio C Hamano wrote:
> > $ ./src/git/contrib/workdir/git-new-workdir src/git foo master
> > mkdir: cannot create directory =E2=80=98foo=E2=80=99: Not a directo=
ry
> > unable to create new workdir "foo"!
>=20
> ;-)  That comes from mkdir || fail which is indeed sufficient.

Right.  Often I find it simpler/clearer to let the underlying commands
give the errors: they use perror() and can often provide more specific
error messages than my script can, unless I spend a lot of effort tryin=
g
to determine exactly what the problem is (permissions, disk space, bad
symlink, existing file, whatever).

Should I respin this with the \"$new_workdir\" -> '$new_workdir' change
(I actually prefer the latter myself but the former was used somewhere
so I kept it)?
