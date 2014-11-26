From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v4] git-new-workdir: Don't fail if the target directory
 is empty
Date: Wed, 26 Nov 2014 17:31:55 -0500
Organization: GNU's Not UNIX!
Message-ID: <1417041115.23650.69.camel@homebase>
References: <1417034308.23650.51.camel@homebase>
	 <xmqq8uixpqyx.fsf@gitster.dls.corp.google.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 23:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtl7w-00020e-2G
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 23:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbaKZWb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2014 17:31:56 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:39950 "HELO
	gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751005AbaKZWb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2014 17:31:56 -0500
Received: (qmail 19069 invoked by uid 0); 26 Nov 2014 22:31:55 -0000
Received: from unknown (HELO cmgw2) (10.0.90.83)
  by gproxy1.mail.unifiedlayer.com with SMTP; 26 Nov 2014 22:31:55 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw2 with 
	id LNXs1p0022qhmhE01NXvZu; Wed, 26 Nov 2014 15:31:55 -0700
X-Authority-Analysis: v=2.1 cv=Hd2HEE08 c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=5y4faFyK3SkA:10 a=P52Ka_IkfV2ik7CSbUAA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID; bh=FiVudI28I6S1g9RSA0z1JnBbK9cuMJQ/hgCqWJP8GDY=;
	b=BC8TmRNwPFOL/QIpCi1IVIM5TDDrcRnK1Piy5za5TdubVuG1m0RXZOeK+ryO8KfBxxZN+qeqwuy2wbC5opt5Tfd6cDOgBbyE2yuNQyIfy/FvuHUitozho7FLNPx1HLVx;
Received: from [72.74.248.26] (port=40238 helo=homebase.home)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1Xtl7n-0002LQ-Pa; Wed, 26 Nov 2014 15:31:51 -0700
In-Reply-To: <xmqq8uixpqyx.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260316>

On Wed, 2014-11-26 at 13:55 -0800, Junio C Hamano wrote:
> The comment in the original is somewhat misleading, but "test -e"
> was "test -e" and not "test -d" to stop when an existing file was
> given by mistake as $new_workdir, I think.  I do not know what
> happens in the new code in that case.

I did test that.  I have a little set of tests with a no directory,
empty directory, non-empty directory, plus various permissions issues
(existing directory without write privs, no write privs to the parent
directory), and also if the new directory name is a file, a symlink
pointing to something, a symlink pointing to nothing, etc.

This is what happens for a file:

$ rm -f foo

$ touch foo

$ ./src/git/contrib/workdir/git-new-workdir src/git foo master
mkdir: cannot create directory =E2=80=98foo=E2=80=99: Not a directory
unable to create new workdir "foo"!
